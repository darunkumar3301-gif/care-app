# Care App — Flutter + Go mock build

This is a synthetic/mock implementation based on the supplied Care App UX & mock-build guide. Names, dates, balances and clinical data are test fixtures only.

## Structure
- `flutter_app/` — Flutter Android UI shell and navigation.
- `go_mock/` — deterministic HTTP mock for scheduling and commerce.

## Run Go mock
```bash
cd go_mock
go run ./cmd/server
```

Endpoints initially included:
- `GET /health`
- `POST /v1/mock/reset`
- `GET /v1/branches`
- `GET /v1/doctors`
- `GET /v1/availability`
- `GET|POST /v1/bookings`
- `GET /v1/products`
- `POST /v1/orders/checkout`

Checkout `outcome`: `paid`, `declined`, or `abandoned`.

## Flutter
```bash
cd flutter_app
flutter pub get
flutter run
```

The first pass deliberately keeps networking/state contracts separate from the widgets; the UI currently uses fixtures while the Go contract is wired in incrementally.

## Required test scenarios
- Android Back and signed-out state
- loading / empty / error / retry
- large text and screen-reader labels
- protected patient data / access isolation
- slot conflict and idempotent booking
- stock changes and quantity limits
- paid / declined / abandoned checkout
- deterministic reset behavior
