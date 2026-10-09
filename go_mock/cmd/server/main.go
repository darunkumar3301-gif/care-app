package main

import (
	"encoding/json"
	"log"
	"net/http"
	"sync"
	"time"
)

type Branch struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	Timezone string `json:"timezone"`
}

type Doctor struct {
	ID        string `json:"id"`
	Name      string `json:"name"`
	Specialty string `json:"specialty"`
	BranchID  string `json:"branch_id"`
}

type Slot struct {
	ID       string `json:"id"`
	DoctorID string `json:"doctor_id"`
	BranchID string `json:"branch_id"`
	StartUTC string `json:"start_utc"`
	EndUTC   string `json:"end_utc"`
}

type Booking struct {
	ID             string `json:"id"`
	Reference      string `json:"reference"`
	DoctorID       string `json:"doctor_id"`
	BranchID       string `json:"branch_id"`
	SlotID         string `json:"slot_id"`
	Status         string `json:"status"`
	StartUTC       string `json:"start_utc"`
	EndUTC         string `json:"end_utc"`
	BranchTimezone string `json:"branch_timezone"`
}

type Product struct {
	ID       string    `json:"id"`
	Name     string    `json:"name"`
	Price    float64   `json:"price"`
	Currency string    `json:"currency"`
	Stock    int       `json:"stock"`
	Variants []Variant `json:"variants"`
}

type Variant struct {
	ID    string  `json:"id"`
	Name  string  `json:"name"`
	Price float64 `json:"price"`
	Stock int     `json:"stock"`
}

type CartItem struct {
	ProductID string `json:"product_id"`
	VariantID string `json:"variant_id"`
	Quantity  int    `json:"quantity"`
}

type Cart struct {
	ID    string     `json:"id"`
	Items []CartItem `json:"items"`
}

type Order struct {
	ID        string     `json:"id"`
	Reference string     `json:"reference"`
	Status    string     `json:"status"`
	Total     float64    `json:"total"`
	Currency  string     `json:"currency"`
	Items     []CartItem `json:"items"`
}

type Store struct {
	sync.Mutex

	bookings map[string]Booking
	carts    map[string]Cart
	orders   map[string]Order
}

func seed(s *Store) {
	s.bookings = map[string]Booking{}
	s.carts = map[string]Cart{}
	s.orders = map[string]Order{}
}

func write(w http.ResponseWriter, code int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)

	_ = json.NewEncoder(w).Encode(v)
}

func main() {
	s := &Store{}

	seed(s)

	mux := http.NewServeMux()

	mux.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			write(w, http.StatusMethodNotAllowed, map[string]string{
				"error": "method_not_allowed",
			})
			return
		}

		write(w, http.StatusOK, map[string]any{
			"ok":   true,
			"mock": true,
		})
	})

	mux.HandleFunc("/v1/mock/reset", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodPost {
			write(w, http.StatusMethodNotAllowed, map[string]string{
				"error": "method_not_allowed",
			})
			return
		}

		s.Lock()
		seed(s)
		s.Unlock()

		write(w, http.StatusOK, map[string]string{
			"status": "reset",
		})
	})

	mux.HandleFunc("/v1/branches", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			write(w, http.StatusMethodNotAllowed, map[string]string{
				"error": "method_not_allowed",
			})
			return
		}

		branches := []Branch{
			{
				ID:       "br_001",
				Name:     "Chennai Central",
				Timezone: "Asia/Kolkata",
			},
			{
				ID:       "br_002",
				Name:     "Adyar",
				Timezone: "Asia/Kolkata",
			},
			{
				ID:       "br_003",
				Name:     "Velachery",
				Timezone: "Asia/Kolkata",
			},
		}

		write(w, http.StatusOK, branches)
	})

	mux.HandleFunc("/v1/doctors", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			write(w, http.StatusMethodNotAllowed, map[string]string{
				"error": "method_not_allowed",
			})
			return
		}

		doctors := []Doctor{
			{
				ID:        "doc_001",
				Name:      "Dr. Meera",
				Specialty: "General Medicine",
				BranchID:  "br_001",
			},
			{
				ID:        "doc_002",
				Name:      "Dr. Arjun",
				Specialty: "Dermatology",
				BranchID:  "br_002",
			},
			{
				ID:        "doc_003",
				Name:      "Dr. Kavya",
				Specialty: "General Medicine",
				BranchID:  "br_002",
			},
		}

		write(w, http.StatusOK, doctors)
	})

	mux.HandleFunc("/v1/availability", availability)

	mux.HandleFunc("/v1/bookings", func(w http.ResponseWriter, r *http.Request) {

		if r.Method == http.MethodGet {
			s.Lock()

			out := make([]Booking, 0, len(s.bookings))

			for _, booking := range s.bookings {
				out = append(out, booking)
			}

			s.Unlock()

			write(w, http.StatusOK, out)
			return
		}

		if r.Method == http.MethodPost {

			var input struct {
				IdempotencyKey string `json:"idempotencyKey"`
				DoctorID       string `json:"doctorID"`
				BranchID       string `json:"branchID"`
				SlotID         string `json:"slotID"`
			}

			if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
				write(w, http.StatusBadRequest, map[string]string{
					"error": "invalid_json",
				})
				return
			}

			if input.IdempotencyKey == "" {
				write(w, http.StatusBadRequest, map[string]string{
					"error": "idempotency_key_required",
				})
				return
			}

			if input.DoctorID == "" {
				write(w, http.StatusBadRequest, map[string]string{
					"error": "doctor_id_required",
				})
				return
			}

			if input.BranchID == "" {
				write(w, http.StatusBadRequest, map[string]string{
					"error": "branch_id_required",
				})
				return
			}

			if input.SlotID == "" {
				write(w, http.StatusBadRequest, map[string]string{
					"error": "slot_id_required",
				})
				return
			}

			s.Lock()
			defer s.Unlock()

			for _, booking := range s.bookings {
				if booking.ID == input.IdempotencyKey {
					write(w, http.StatusOK, booking)
					return
				}
			}

			slot := slotByID(input.SlotID)

			if slot.ID == "" {
				write(w, http.StatusNotFound, map[string]string{
					"error": "slot_not_found",
				})
				return
			}

			if input.DoctorID != slot.DoctorID {
				write(w, http.StatusConflict, map[string]string{
					"error": "doctor_slot_mismatch",
				})
				return
			}

			if input.BranchID != slot.BranchID {
				write(w, http.StatusConflict, map[string]string{
					"error": "branch_slot_mismatch",
				})
				return
			}

			for _, booking := range s.bookings {
				if booking.SlotID == input.SlotID &&
					booking.Status == "confirmed" {

					write(w, http.StatusConflict, map[string]string{
						"error": "slot_taken",
					})
					return
				}
			}

			booking := Booking{
				ID:             input.IdempotencyKey,
				Reference:      "CARE-" + input.SlotID,
				DoctorID:       input.DoctorID,
				BranchID:       input.BranchID,
				SlotID:         input.SlotID,
				Status:         "confirmed",
				StartUTC:       slot.StartUTC,
				EndUTC:         slot.EndUTC,
				BranchTimezone: "Asia/Kolkata",
			}

			s.bookings[booking.ID] = booking

			log.Printf(
				"Booking created: %s (%s) doctor=%s branch=%s slot=%s",
				booking.ID,
				booking.Reference,
				booking.DoctorID,
				booking.BranchID,
				booking.SlotID,
			)

			write(w, http.StatusCreated, booking)
			return
		}

		write(w, http.StatusMethodNotAllowed, map[string]string{
			"error": "method_not_allowed",
		})
	})

	mux.HandleFunc("/v1/products", func(w http.ResponseWriter, r *http.Request) {
		if r.Method != http.MethodGet {
			write(w, http.StatusMethodNotAllowed, map[string]string{
				"error": "method_not_allowed",
			})
			return
		}

		products := []Product{
			{
				ID:       "prd_001",
				Name:     "Gentle Cleanser",
				Price:    350,
				Currency: "INR",
				Stock:    12,
				Variants: []Variant{
					{
						ID:    "var_001",
						Name:  "100 ml",
						Price: 350,
						Stock: 7,
					},
					{
						ID:    "var_002",
						Name:  "200 ml",
						Price: 550,
						Stock: 5,
					},
				},
			},
			{
				ID:       "prd_002",
				Name:     "Daily Moisturiser",
				Price:    490,
				Currency: "INR",
				Stock:    4,
				Variants: []Variant{
					{
						ID:    "var_003",
						Name:  "50 ml",
						Price: 490,
						Stock: 4,
					},
				},
			},
			{
				ID:       "prd_003",
				Name:     "Sun Care",
				Price:    650,
				Currency: "INR",
				Stock:    0,
				Variants: nil,
			},
		}

		write(w, http.StatusOK, products)
	})

	mux.HandleFunc("/v1/orders/checkout", checkout)

	log.Println("Care mock listening on :8081")

	log.Fatal(
		http.ListenAndServe(
			":8081",
			cors(mux),
		),
	)
}

func cors(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		w.Header().Set(
			"Access-Control-Allow-Origin",
			"*",
		)

		w.Header().Set(
			"Access-Control-Allow-Headers",
			"Content-Type,Idempotency-Key",
		)

		w.Header().Set(
			"Access-Control-Allow-Methods",
			"GET,POST,PUT,DELETE,OPTIONS",
		)

		if r.Method == http.MethodOptions {
			w.WriteHeader(http.StatusNoContent)
			return
		}

		next.ServeHTTP(w, r)
	})
}

func slotByID(id string) Slot {

	now := time.Now().UTC()

	slots := map[string]Slot{

		"slot_001": {
			ID:       "slot_001",
			DoctorID: "doc_001",
			BranchID: "br_001",
			StartUTC: now.Add(1 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(90 * time.Minute).Format(time.RFC3339),
		},

		"slot_002": {
			ID:       "slot_002",
			DoctorID: "doc_002",
			BranchID: "br_002",
			StartUTC: now.Add(2 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(150 * time.Minute).Format(time.RFC3339),
		},

		"slot_003": {
			ID:       "slot_003",
			DoctorID: "doc_003",
			BranchID: "br_002",
			StartUTC: now.Add(3 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(210 * time.Minute).Format(time.RFC3339),
		},
	}

	if slot, ok := slots[id]; ok {
		return slot
	}

	return Slot{}
}

func availability(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodGet {
		write(w, http.StatusMethodNotAllowed, map[string]string{
			"error": "method_not_allowed",
		})
		return
	}

	doctorID := r.URL.Query().Get("doctorID")
	branchID := r.URL.Query().Get("branchID")

	now := time.Now().UTC()

	allSlots := []Slot{

		{
			ID:       "slot_001",
			DoctorID: "doc_001",
			BranchID: "br_001",
			StartUTC: now.Add(1 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(90 * time.Minute).Format(time.RFC3339),
		},

		{
			ID:       "slot_002",
			DoctorID: "doc_002",
			BranchID: "br_002",
			StartUTC: now.Add(2 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(150 * time.Minute).Format(time.RFC3339),
		},

		{
			ID:       "slot_003",
			DoctorID: "doc_003",
			BranchID: "br_002",
			StartUTC: now.Add(3 * time.Hour).Format(time.RFC3339),
			EndUTC:   now.Add(210 * time.Minute).Format(time.RFC3339),
		},
	}

	slots := []Slot{}

	for _, slot := range allSlots {

		if doctorID != "" &&
			slot.DoctorID != doctorID {
			continue
		}

		if branchID != "" &&
			slot.BranchID != branchID {
			continue
		}

		slots = append(slots, slot)
	}

	write(w, http.StatusOK, map[string]any{
		"slots":           slots,
		"branch_timezone": "Asia/Kolkata",
	})
}

// -----------------------------
// Checkout
// -----------------------------

func checkout(w http.ResponseWriter, r *http.Request) {

	if r.Method != http.MethodPost {
		write(w, http.StatusMethodNotAllowed, map[string]string{
			"error": "method_not_allowed",
		})
		return
	}

	var input struct {
		CartID         string     `json:"cartID"`
		Outcome        string     `json:"outcome"`
		IdempotencyKey string     `json:"idempotencyKey"`
		Items          []CartItem `json:"items"`
	}

	if err := json.NewDecoder(r.Body).Decode(&input); err != nil {
		write(w, http.StatusBadRequest, map[string]string{
			"error": "invalid_json",
		})
		return
	}

	outcome := input.Outcome

	if outcome == "" {
		outcome = "paid"
	}

	// -----------------------------
	// Payment declined
	// -----------------------------

	if outcome == "declined" {
		write(w, http.StatusPaymentRequired, map[string]string{
			"error": "payment_declined",
		})
		return
	}

	// -----------------------------
	// Payment abandoned
	// -----------------------------

	if outcome == "abandoned" {
		write(w, http.StatusOK, map[string]string{
			"status": "abandoned",
		})
		return
	}

	// -----------------------------
	// Successful order
	// -----------------------------

	order := Order{
		ID:        "ord_001",
		Reference: "ORDER-001",
		Status:    "paid",
		Total:     0,
		Currency:  "INR",
		Items:     input.Items,
	}

	write(w, http.StatusCreated, order)
}
