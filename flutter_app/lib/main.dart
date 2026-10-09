import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CareApp());
}

class CareApp extends StatelessWidget {
  const CareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Care App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF08766D),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAF9),
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int index = 0;

  final List<Widget> pages = const [
    HomePage(),
    VisitsPage(),
    ShopPage(),
    RewardsPage(),
    LearnPage(),
  ];

  void openTab(int tabIndex) {
    setState(() {
      index = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Care',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() => index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Visits',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.stars_outlined),
            selectedIcon: Icon(Icons.stars),
            label: 'Rewards',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Learn',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color teal = Color(0xFF00897B);
  static const Color darkTeal = Color(0xFF183B3A);
  static const Color paleTeal = Color(0xFFE0F2F1);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        // Welcome header
        const Text(
          'Your care, connected.',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: darkTeal,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Your health journey starts here.',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF71817F),
          ),
        ),

        const SizedBox(height: 22),

        // Main welcome banner
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF26A69A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: teal.withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.health_and_safety_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Care that fits your life',
                style: TextStyle(
                  fontSize: 23,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 9),
              const Text(
                'Book a consultation, explore health resources, '
                'and keep your care organised in one place.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
                  label: const Text('Book a visit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: teal,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Quick actions
        const Text(
          'Quick access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: darkTeal,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Everything you need, just a tap away.',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF71817F),
          ),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _HomeActionTile(
                title: 'Clinic essentials',
                subtitle: 'Care products',
                icon: Icons.shopping_bag_rounded,
                background: const Color(0xFFE0F2F1),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ShopPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _HomeActionTile(
                title: 'My care',
                subtitle: 'Your records',
                icon: Icons.folder_shared_rounded,
                background: const Color(0xFFE8EAF6),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CareRecordsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _HomeActionTile(
                title: 'Learn & FAQ',
                subtitle: 'Health guidance',
                icon: Icons.menu_book_rounded,
                background: const Color(0xFFFFF3E0),
                onTap: () {
                  final shellState =
                      context.findAncestorStateOfType<_AppShellState>();

                  if (shellState != null) {
                    shellState.openTab(4);
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _HomeActionTile(
                title: 'My visits',
                subtitle: 'Appointments',
                icon: Icons.event_available_rounded,
                background: const Color(0xFFF3E5F5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VisitsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 26),

        // Care reminder / informational section
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3EEEB)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: paleTeal,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: teal,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make time for your health',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: darkTeal,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Explore trusted clinic information and '
                      'keep track of your appointments.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xFF71817F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Synthetic environment notice
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F4F3),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF71817F),
                size: 19,
              ),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Demo environment: live clinical and payment '
                  'providers are not connected.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: Color(0xFF71817F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color background;
  final VoidCallback onTap;

  const _HomeActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(minHeight: 142),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE3EEEB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF00897B),
                  size: 25,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF183B3A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF71817F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VISITS
// ============================================================

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  static const String baseUrl = 'http://10.0.2.2:8081';

  bool isLoading = true;
  String? error;
  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    loadBookings();
  }

  Future<void> loadBookings() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/bookings'),
      );

      debugPrint('BOOKINGS RESPONSE: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception('Invalid bookings response');
      }

      final loaded = <Map<String, dynamic>>[];

      for (final item in decoded) {
        if (item is Map) {
          loaded.add(Map<String, dynamic>.from(item));
        }
      }

      if (!mounted) return;

      setState(() {
        bookings = loaded;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('VISITS ERROR: $e');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        error = 'Unable to load visits.';
      });
    }
  }

  String _doctorName(String doctorID) {
    switch (doctorID) {
      case 'doc_001':
        return 'Dr. Meera';
      case 'doc_002':
        return 'Dr. Arjun';
      case 'doc_003':
        return 'Dr. Kavya';
      default:
        return 'Doctor';
    }
  }

  String _specialty(String doctorID) {
    switch (doctorID) {
      case 'doc_001':
      case 'doc_003':
        return 'General Medicine';
      case 'doc_002':
        return 'Dermatology';
      default:
        return 'Medical consultation';
    }
  }

  String _branchName(String branchID) {
    switch (branchID) {
      case 'br_001':
        return 'Chennai Central';
      case 'br_002':
        return 'Adyar';
      case 'br_003':
        return 'Velachery';
      default:
        return 'Branch';
    }
  }

  String _formatDate(dynamic value) {
    if (value == null) return '-';

    try {
      final date = DateTime.parse(value.toString()).toLocal();

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return value.toString();
    }
  }

  String _formatTime(dynamic value) {
    if (value == null) return '-';

    try {
      final date = DateTime.parse(value.toString()).toLocal();

      final hour = date.hour == 0
          ? 12
          : date.hour > 12
              ? date.hour - 12
              : date.hour;

      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';

      return '$hour:$minute $period';
    } catch (_) {
      return value.toString();
    }
  }

  
@override
Widget build(BuildContext context) {
  final confirmedCount = bookings.where((booking) {
    final status = booking['status']?.toString().toLowerCase();
    return status == 'confirmed';
  }).length;

  return Scaffold(
    backgroundColor: const Color(0xFFF5F9F8),
    appBar: AppBar(
      backgroundColor: const Color(0xFFF5F9F8),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'My Visits',
        style: TextStyle(
          color: Color(0xFF183B3A),
          fontSize: 23,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Refresh visits',
          onPressed: loadBookings,
          icon: const Icon(
            Icons.refresh_rounded,
            color: Color(0xFF00897B),
          ),
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF00897B),
            ),
          )
        : error != null
            ? _buildErrorState()
            : RefreshIndicator(
                color: const Color(0xFF00897B),
                onRefresh: loadBookings,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
                  children: [
                    // Welcome header
                    const Text(
                      'Your care, all in one place.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF71817F),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Summary banner
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00796B),
                            Color(0xFF26A69A),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00897B)
                                .withOpacity(0.16),
                            blurRadius: 16,
                            offset: const Offset(0, 7),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Your appointments',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${bookings.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 38,
                                    height: 1.1,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '$confirmedCount confirmed',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 76,
                            height: 76,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.16),
                              borderRadius: BorderRadius.circular(23),
                            ),
                            child: const Icon(
                              Icons.calendar_month_rounded,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Section heading
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Visit history',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF183B3A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2F1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${bookings.length} visits',
                            style: const TextStyle(
                              color: Color(0xFF00796B),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Select an appointment to view its details.',
                      style: TextStyle(
                        color: Color(0xFF71817F),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 18),

                    if (bookings.isEmpty)
                      _buildEmptyState()
                    else
                      ...bookings.map(_buildVisitCard),
                  ],
                ),
              ),
  );
}

  Widget _buildVisitCard(Map<String, dynamic> booking) {
    final doctorID =
        booking['doctor_id']?.toString() ??
        booking['doctorID']?.toString() ??
        '';

    final branchID =
        booking['branch_id']?.toString() ??
        booking['branchID']?.toString() ??
        '';

    final doctorName = _doctorName(doctorID);
    final specialty = _specialty(doctorID);
    final branchName = _branchName(branchID);

    final status =
        booking['status']?.toString().toLowerCase() ?? 'confirmed';

    final reference =
        booking['reference']?.toString() ??
        booking['id']?.toString() ??
        '-';

    final startUTC =
        booking['start_utc'] ??
        booking['startUTC'];

    final isConfirmed = status == 'confirmed';

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE5E8EB),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF183B3A).withOpacity(0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VisitDetailsPage(
                booking: booking,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isConfirmed
                          ? const Color(0xFFE7F7EF)
                          : const Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isConfirmed
                              ? Icons.check_circle_rounded
                              : Icons.info_outline_rounded,
                          size: 15,
                          color: isConfirmed
                              ? const Color(0xFF1F9D68)
                              : const Color(0xFF68737D),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          status.isEmpty
                              ? 'Confirmed'
                              : _capitalize(status),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isConfirmed
                                ? const Color(0xFF1F9D68)
                                : const Color(0xFF68737D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9AA3AA),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Doctor
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F4F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 28,
                      color: Color(0xFF1F9D68),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctorName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF17202A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          specialty,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF68737D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              const Divider(
                height: 1,
                color: Color(0xFFEAECEF),
              ),

              const SizedBox(height: 18),

              // Date and time
              Row(
                children: [
                  Expanded(
                    child: _infoItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: _formatDate(startUTC),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _infoItem(
                      icon: Icons.access_time_rounded,
                      label: 'Time',
                      value: _formatTime(startUTC),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _infoItem(
                icon: Icons.location_on_outlined,
                label: 'Branch',
                value: branchName,
              ),

              const SizedBox(height: 18),

              // Reference
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.confirmation_number_outlined,
                      size: 19,
                      color: Color(0xFF68737D),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        reference,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4E5962),
                        ),
                      ),
                    ),
                    const Text(
                      'View details',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F9D68),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 19,
          color: const Color(0xFF68737D),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8A949D),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF17202A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF5F1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 38,
                color: Color(0xFF1F9D68),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No visits yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF17202A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your upcoming appointments will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Color(0xFF68737D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off_outlined,
              size: 48,
              color: Color(0xFF8A949D),
            ),
            const SizedBox(height: 16),
            Text(
              error!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF68737D),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: loadBookings,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}

// ============================================================
// VISIT DETAILS
// ============================================================

class VisitDetailsPage extends StatelessWidget {
  final Map<String, dynamic> booking;

  const VisitDetailsPage({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    final reference =
        booking['reference']?.toString() ?? 'Unknown';
    final doctorID =
        booking['doctor_id']?.toString() ?? '';
    final branchID =
        booking['branch_id']?.toString() ?? '';
    final status =
        booking['status']?.toString() ?? 'Unknown';
    final startUTC =
        booking['start_utc']?.toString() ?? '';
    final endUTC =
        booking['end_utc']?.toString() ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Visit details')),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          const Text(
            'Visit details',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _doctorName(doctorID),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('General Medicine'),
                  const SizedBox(height: 20),
                  Text(_branchName(branchID)),
                  const SizedBox(height: 12),
                  Text('Reference: $reference'),
                  const SizedBox(height: 8),
                  Text('Status: $status'),
                  const SizedBox(height: 8),
                  Text('Start: $startUTC'),
                  const SizedBox(height: 8),
                  Text('End: $endUTC'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SHOP
// ============================================================


class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final products = [
      {
        'name': 'Gentle Cleanser',
        'description': 'A gentle daily cleansing essential',
        'price': '₹350',
        'icon': Icons.water_drop_outlined,
        'available': true,
        'tag': 'DAILY CARE',
      },
      {
        'name': 'Daily Moisturiser',
        'description': 'Everyday hydration for your skin',
        'price': '₹490',
        'icon': Icons.spa_outlined,
        'available': true,
        'tag': 'HYDRATION',
      },
      {
        'name': 'Sun Care',
        'description': 'Sun protection for daily routines',
        'price': '₹650',
        'icon': Icons.wb_sunny_outlined,
        'available': false,
        'tag': 'SUN PROTECTION',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clinic essentials'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.primaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Care for yourself',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: color.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Everyday essentials selected for your care routine.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: color.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 42,
                  color: color.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Our products',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Clinic essentials for your daily routine',
            style: TextStyle(
              fontSize: 14,
              color: color.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          ...products.map((product) {
            final available = product['available'] as bool;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: color.outlineVariant,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProductPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 76,
                          height: 88,
                          decoration: BoxDecoration(
                            color: color.primaryContainer,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            product['icon'] as IconData,
                            size: 34,
                            color: color.primary,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['tag'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w800,
                                  color: color.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product['description'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.35,
                                  color: color.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    product['price'] as String,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (available)
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                      color: color.primary,
                                    )
                                  else
                                    Text(
                                      'Sold out',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: color.error,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                size: 18,
                color: color.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Product availability is subject to stock.',
                  style: TextStyle(
                    fontSize: 12,
                    color: color.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REWARDS
// ============================================================


class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  static const Color teal = Color(0xFF00897B);
  static const Color lightTeal = Color(0xFFE0F2F1);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        const Text(
          'Rewards',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Color(0xFF183B3A),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Your health deserves to be rewarded.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 22),

        // Rewards balance card
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00897B), Color(0xFF26A69A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: teal.withOpacity(0.22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.stars_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Available points',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.card_giftcard_rounded,
                    color: Colors.white70,
                    size: 26,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                '2,400',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Points ready to use',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 22),
              Container(
                height: 1,
                color: Colors.white.withOpacity(0.25),
              ),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Every healthy step counts!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        // Progress toward next reward
        const Text(
          'Your next reward',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Color(0xFF183B3A),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE5EEEC)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: lightTeal,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_offer_rounded,
                      color: teal,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹250 clinic reward',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Redeem at 3,000 points',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '80%',
                    style: TextStyle(
                      color: teal,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: 0.8,
                  minHeight: 9,
                  backgroundColor: Color(0xFFE5EEEC),
                  valueColor: AlwaysStoppedAnimation<Color>(teal),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '600 more points to reach your next reward',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        // Points activity
        const Text(
          'How you earn points',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: Color(0xFF183B3A),
          ),
        ),
        const SizedBox(height: 12),

        _rewardActivity(
          icon: Icons.medical_services_rounded,
          title: 'Regular consultation',
          subtitle: 'Earn points from clinic visits',
          points: '+40 points',
        ),
        const SizedBox(height: 10),
        _rewardActivity(
          icon: Icons.health_and_safety_rounded,
          title: 'Clinic activity',
          subtitle: 'Stay active with your care plan',
          points: '+50 points',
        ),

        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF5FAF9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: teal,
                size: 21,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Your points and reward progress are sample UI data. '
                  'Connect them to your backend when the rewards API is ready.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _rewardActivity({
    required IconData icon,
    required String title,
    required String subtitle,
    required String points,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EEEC)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: lightTeal,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: teal, size: 24),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            points,
            style: const TextStyle(
              color: teal,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
// ============================================================
// LEARN
// ============================================================


class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  static const Color teal = Color(0xFF00897B);
  static const Color darkTeal = Color(0xFF183B3A);
  static const Color paleTeal = Color(0xFFE0F2F1);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        const Text(
          'Learn & Explore',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: darkTeal,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Simple knowledge for a healthier you.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 22),

        // Featured learning card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00796B), Color(0xFF26A69A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'FEATURED TOPIC',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Icon(
                Icons.health_and_safety_rounded,
                size: 46,
                color: Colors.white,
              ),
              const SizedBox(height: 14),
              const Text(
                'Take charge of your health',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore helpful information about appointments, '
                'treatments, and everyday wellness.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 26),

        const Text(
          'Explore topics',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: darkTeal,
          ),
        ),
        const SizedBox(height: 14),

        // Topic categories
        Row(
          children: [
            Expanded(
              child: _LearnCategory(
                icon: Icons.medical_services_rounded,
                title: 'Doctors',
                color: const Color(0xFFE0F2F1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _LearnCategory(
                icon: Icons.menu_book_rounded,
                title: 'Treatments',
                color: const Color(0xFFE8EAF6),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _LearnCategory(
                icon: Icons.favorite_rounded,
                title: 'Wellness',
                color: const Color(0xFFFFF3E0),
              ),
            ),
          ],
        ),

        const SizedBox(height: 26),

        const Text(
          'Discover more',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: darkTeal,
          ),
        ),
        const SizedBox(height: 14),

        _LearnArticle(
          icon: Icons.person_search_rounded,
          iconColor: teal,
          backgroundColor: const Color(0xFFE0F2F1),
          category: 'YOUR CARE TEAM',
          title: 'Meet your doctor',
          description:
              'Learn about your doctor and how to prepare for a visit.',
        ),
        const SizedBox(height: 12),
        _LearnArticle(
          icon: Icons.biotech_rounded,
          iconColor: const Color(0xFF5C6BC0),
          backgroundColor: const Color(0xFFE8EAF6),
          category: 'TREATMENT GUIDE',
          title: 'Treatment explanations',
          description:
              'Understand treatment information shared by your clinic.',
        ),
        const SizedBox(height: 12),
        _LearnArticle(
          icon: Icons.campaign_rounded,
          iconColor: const Color(0xFFEF8C32),
          backgroundColor: const Color(0xFFFFF3E0),
          category: 'LATEST NEWS',
          title: 'Clinic updates',
          description:
              'Keep up with announcements and important clinic news.',
        ),
        const SizedBox(height: 12),
        _LearnArticle(
          icon: Icons.question_answer_rounded,
          iconColor: const Color(0xFF8E5AA7),
          backgroundColor: const Color(0xFFF3E5F5),
          category: 'HELP CENTRE',
          title: 'Questions, answered',
          description:
              'Find answers to common questions about your care.',
        ),

        const SizedBox(height: 18),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF5FAF9),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: teal,
                size: 22,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Learning content is currently a UI preview. '
                  'Article pages and clinic content can be connected later.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LearnCategory extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _LearnCategory({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5EEEC)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF00897B),
              size: 24,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LearnArticle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String category;
  final String title;
  final String description;

  const _LearnArticle({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.category,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5EEEC)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 68,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.7,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF183B3A),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Color(0xFF00897B),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My profile')),
      body: _ListPage(
        title: 'Account',
        items: const [
          'My appointments',
          'Prescriptions',
          'Bills & receipts',
          'Communication preferences',
        ],
        icon: Icons.person,
      ),
    );
  }
}

// ============================================================
// BOOKING — STEP 1
// ============================================================

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  static const String baseUrl = 'http://10.0.2.2:8081';

  String? selectedBranch;
  String? selectedDoctor;

  bool isLoadingBranches = true;
  String? branchError;

  List<Map<String, dynamic>> branches = [];

  @override
  void initState() {
    super.initState();
    loadBranches();
  }

  Future<void> loadBranches() async {
    if (!mounted) return;

    setState(() {
      isLoadingBranches = true;
      branchError = null;
    });

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/v1/branches'),
      );

      if (response.statusCode != 200) {
        throw Exception('Server returned ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception('Invalid branches response');
      }

      final loadedBranches = <Map<String, dynamic>>[];
      final seenIds = <String>{};

      for (final item in decoded) {
        if (item is! Map) continue;

        final id =
            (item['ID'] ?? item['id'])?.toString().trim() ?? '';
        final name =
            (item['Name'] ?? item['name'])?.toString().trim() ?? '';

        if (id.isEmpty || name.isEmpty) continue;
        if (seenIds.contains(id)) continue;

        seenIds.add(id);
        loadedBranches.add({
          'id': id,
          'name': name,
        });
      }

      if (!mounted) return;

      setState(() {
        branches = loadedBranches;
        isLoadingBranches = false;

        if (branches.isNotEmpty) {
          selectedBranch = branches.first['id']?.toString();
        }
      });
    } catch (e) {
      debugPrint('BRANCH ERROR: $e');

      if (!mounted) return;

      setState(() {
        isLoadingBranches = false;
        branchError = 'Unable to load branches.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Book a visit')),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          const _BookingProgress(activeStep: 1),
          const SizedBox(height: 28),
          const Text(
            'Choose your visit',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select how and where you would like to see your doctor.',
            style: TextStyle(
              fontSize: 15,
              color: color.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Visit type',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _visitTypeCard(
                  icon: Icons.location_on_outlined,
                  title: 'In-clinic',
                  subtitle: 'Visit the clinic',
                  selected: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _visitTypeCard(
                  icon: Icons.videocam_outlined,
                  title: 'Video',
                  subtitle: 'Online consultation',
                  selected: false,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Choose a branch',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (isLoadingBranches)
            const Card(
              child: SizedBox(
                height: 86,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          else if (branchError != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.location_off_outlined,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Could not load branches.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(branchError!),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: loadBranches,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (branches.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text('No branches available.'),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      onPressed: loadBranches,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else
            DropdownButtonFormField<String>(
              initialValue: branches.any(
                (branch) =>
                    branch['id']?.toString() == selectedBranch,
              )
                  ? selectedBranch
                  : null,
              decoration: InputDecoration(
                labelText: 'Clinic branch',
                hintText: 'Select a branch',
                prefixIcon:
                    const Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: branches.map((branch) {
                final id = branch['id']?.toString() ?? '';
                final name =
                    branch['name']?.toString() ?? id;

                return DropdownMenuItem<String>(
                  value: id,
                  child: Text(name),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedBranch = value;

                  if (value == 'br_001') {
                    selectedDoctor = 'doc_001';
                  } else if (value == 'br_002') {
                    selectedDoctor = 'doc_002';
                  } else {
                    selectedDoctor = null;
                  }
                });
              },
            ),
          const SizedBox(height: 28),
          const Text(
            'Choose a doctor',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (selectedBranch == 'br_001')
            _doctorCard(
              id: 'doc_001',
              name: 'Dr. Meera',
              specialty: 'General Medicine',
            )
          else if (selectedBranch == 'br_002') ...[
            _doctorCard(
              id: 'doc_002',
              name: 'Dr. Arjun',
              specialty: 'Dermatology',
            ),
            const SizedBox(height: 10),
            _doctorCard(
              id: 'doc_003',
              name: 'Dr. Kavya',
              specialty: 'General Medicine',
            ),
          ]
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'No doctors available for this branch.',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 28),
          SizedBox(
            height: 54,
            child: FilledButton(
              onPressed: selectedBranch == null || selectedDoctor == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DateTimePage(
                            branch: selectedBranch!,
                            doctor: selectedDoctor!,
                          ),
                        ),
                      );
                    },
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _visitTypeCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
  }) {
    final color = Theme.of(context).colorScheme;

    return SizedBox(
      height: 132,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? color.primary
                : color.outlineVariant,
            width: selected ? 2 : 1,
          ),
          color: selected
              ? color.primaryContainer
              : color.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 28,
              color: selected
                  ? color.primary
                  : color.onSurfaceVariant,
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: color.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _doctorCard({
    required String id,
    required String name,
    required String specialty,
  }) {
    final selected = selectedDoctor == id;
    final color = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() => selectedDoctor = id);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? color.primary
                  : color.outlineVariant,
              width: selected ? 2 : 1,
            ),
            color: selected
                ? color.primaryContainer
                : color.surface,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                child: Text(
                  name.replaceAll('Dr. ', '').substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: TextStyle(
                        color: color.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected
                    ? color.primary
                    : color.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DATE & TIME — STEP 2
// ============================================================


class DateTimePage extends StatefulWidget {
  final String? branch;
  final String doctor;

  const DateTimePage({
    super.key,
    required this.branch,
    required this.doctor,
  });

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  DateTime selectedDate = DateUtils.dateOnly(DateTime.now());
  String? selectedTime;

  final List<String> times = const [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
  ];

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void goToPatientDetails() {
    if (selectedTime == null || widget.branch == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PatientDetailsPage(
          patientName: '',
          branch: widget.branch,
          doctor: widget.doctor,
          selectedDate: selectedDate,
          selectedTime: selectedTime!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose date & time'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 36),
                children: [
                  const _BookingProgress(activeStep: 2),
                  const SizedBox(height: 28),

                  const Text(
                    'Schedule your visit',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose a date and time that works best for you.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: color.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Appointment details
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: color.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: color.outlineVariant,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: color.primaryContainer,
                            child: Icon(
                              Icons.medical_services_outlined,
                              color: color.onPrimaryContainer,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _doctorName(widget.doctor),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _branchName(widget.branch ?? ''),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: color.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.verified_outlined,
                            color: color.primary,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Select a date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        'Next 7 days',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Choose your preferred appointment day.',
                    style: TextStyle(
                      fontSize: 13,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 14),

                  SizedBox(
                    height: 104,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 7,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final date = DateUtils.dateOnly(
                          DateTime.now().add(Duration(days: index)),
                        );

                        return _DateCard(
                          date: date,
                          selected: _isSameDay(date, selectedDate),
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                              selectedTime = null;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Available times',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.access_time_rounded,
                        size: 17,
                        color: color.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${times.length} slots',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Times for ${_formatDate(selectedDate)}',
                    style: TextStyle(
                      fontSize: 13,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 14),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: times.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (context, index) {
                      final time = times[index];

                      return _TimeSlotCard(
                        time: time,
                        selected: selectedTime == time,
                        onTap: () {
                          setState(() => selectedTime = time);
                        },
                      );
                    },
                  ),

                  if (selectedTime != null) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event_available_outlined,
                            color: color.onPrimaryContainer,
                            size: 25,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your selected appointment',
                                  style: TextStyle(
                                    color: color.onPrimaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_formatDate(selectedDate)} · $selectedTime',
                                  style: TextStyle(
                                    color: color.onPrimaryContainer,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Fixed bottom action
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              decoration: BoxDecoration(
                color: color.surface,
                border: Border(
                  top: BorderSide(color: color.outlineVariant),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (selectedTime == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Select a date and time to continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 54,
                    child: FilledButton(
                      onPressed: selectedTime == null ||
                              widget.branch == null
                          ? null
                          : goToPatientDetails,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDay(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}



// ============================================================
// PATIENT DETAILS — STEP 3
// ============================================================

class PatientDetailsPage extends StatefulWidget {
  final String patientName;
  final String? branch;
  final String doctor;
  final DateTime selectedDate;
  final String selectedTime;

  const PatientDetailsPage({
    super.key,
    required this.patientName,
    required this.branch,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  State<PatientDetailsPage> createState() =>
      _PatientDetailsPageState();
}

class _PatientDetailsPageState extends State<PatientDetailsPage> {
  late final TextEditingController nameController;
  final TextEditingController phoneController =
      TextEditingController();
  final TextEditingController emailController =
      TextEditingController();
  final TextEditingController purposeController =
      TextEditingController();

  String messagePreference = 'SMS';
  bool consent = false;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.patientName);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    purposeController.dispose();
    super.dispose();
  }

  void continueToReview() {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty) {
      _showError('Please enter your name.');
      return;
    }

    if (phone.isEmpty) {
      _showError('Please enter your phone number.');
      return;
    }

    if (phone.length < 10) {
      _showError('Please enter a valid phone number.');
      return;
    }

    if (!consent) {
      _showError(
        'Please provide consent to continue.',
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewPage(
          patientName: name,
          phone: phone,
          email: emailController.text.trim(),
          purpose: purposeController.text.trim(),
          messagePreference: messagePreference,
          consent: consent,
          branch: widget.branch,
          doctor: widget.doctor,
          selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime,
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient details'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  24,
                ),
                children: [
                  const _BookingProgress(activeStep: 3),
                  const SizedBox(height: 28),
                  const Text(
                    'Patient details',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the details needed for your visit.',
                    style: TextStyle(
                      fontSize: 15,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _FieldLabel(
                    label: 'Full name',
                    requiredField: true,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(
                      'Enter your full name',
                      Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _FieldLabel(
                    label: 'Phone number',
                    requiredField: true,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(
                      'Enter your phone number',
                      Icons.phone_outlined,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel(label: 'Email'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _inputDecoration(
                      'Enter your email',
                      Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const _FieldLabel(label: 'Visit purpose'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: purposeController,
                    maxLines: 3,
                    decoration: _inputDecoration(
                      'What would you like help with?',
                      Icons.notes_outlined,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Message preference',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          value: 'SMS',
                          groupValue: messagePreference,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(
                              () => messagePreference = value,
                            );
                          },
                          title: const Text('SMS'),
                          subtitle:
                              const Text('Appointment reminders'),
                        ),
                        RadioListTile<String>(
                          value: 'Email',
                          groupValue: messagePreference,
                          onChanged: (value) {
                            if (value == null) return;
                            setState(
                              () => messagePreference = value,
                            );
                          },
                          title: const Text('Email'),
                          subtitle:
                              const Text('Appointment reminders'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.zero,
                    child: CheckboxListTile(
                      value: consent,
                      onChanged: (value) {
                        setState(() {
                          consent = value ?? false;
                        });
                      },
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      title: const Text(
                        'I consent to the use of my information for this appointment.',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: color.surface,
                border: Border(
                  top: BorderSide(
                    color: color.outlineVariant,
                  ),
                ),
              ),
              child: SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: continueToReview,
                  child: const Text(
                    'Review appointment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

// ============================================================
// REVIEW — STEP 4
// ============================================================

class ReviewPage extends StatefulWidget {
  final String patientName;
  final String phone;
  final String email;
  final String purpose;
  final String messagePreference;
  final bool consent;
  final String? branch;
  final String doctor;
  final DateTime selectedDate;
  final String selectedTime;

  const ReviewPage({
    super.key,
    required this.patientName,
    required this.phone,
    required this.email,
    required this.purpose,
    required this.messagePreference,
    required this.consent,
    required this.branch,
    required this.doctor,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  static const String baseUrl = 'http://10.0.2.2:8081';

  bool isSubmitting = false;

  Future<void> confirmBooking() async {
    if (isSubmitting) return;

    if (widget.branch == null || widget.branch!.isEmpty) {
      _showError('Please select a clinic branch.');
      return;
    }

    if (!widget.consent) {
      _showError('Consent is required.');
      return;
    }

    setState(() => isSubmitting = true);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/v1/bookings'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idempotencyKey':
              'booking_${DateTime.now().millisecondsSinceEpoch}',
          'doctorID': widget.doctor,
          'branchID': widget.branch,
          'slotID': widget.doctor == 'doc_002'
              ? 'slot_002'
              : widget.doctor == 'doc_003'
                  ? 'slot_003'
                  : 'slot_001',
        }),
      );
      debugPrint(
        'BOOKING REQUEST: '
        'doctor=${widget.doctor}, '
        'branch=${widget.branch}, '
        'slot=${widget.doctor == 'doc_002'
            ? 'slot_002'
            : widget.doctor == 'doc_003'
                ? 'slot_003'
                : 'slot_001'}',
      );

      debugPrint('BOOKING RESPONSE: ${response.body}');

      if (response.statusCode != 201 &&
          response.statusCode != 200) {
        throw Exception(
          'Booking failed: ${response.statusCode} - ${response.body}',
        );
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! Map) {
        throw Exception('Invalid booking response');
      }

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BookingConfirmationPage(
            booking: Map<String, dynamic>.from(decoded),
          ),
        ),
      );
    } catch (e) {
        debugPrint('BOOKING ERROR: $e');

        if (!mounted) return;

        setState(() => isSubmitting = false);

        _showError(
          e.toString().replaceFirst('Exception: ', ''),
        );
      }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _dateText(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Review appointment'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  24,
                ),
                children: [
                  const _BookingProgress(activeStep: 4),
                  const SizedBox(height: 28),
                  const Text(
                    'Review your appointment',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check the details before confirming your visit.',
                    style: TextStyle(
                      fontSize: 15,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _ReviewSection(
                    title: 'Appointment',
                    icon: Icons.calendar_month_outlined,
                    children: [
                      _ReviewRow(
                        label: 'Doctor',
                        value: _doctorName(widget.doctor),
                      ),
                      _ReviewRow(
                        label: 'Specialty',
                        value: widget.doctor == 'doc_002'
                            ? 'Dermatology'
                            : 'General Medicine',
                      ),
                      _ReviewRow(
                        label: 'Branch',
                        value: _branchName(
                          widget.branch ?? '',
                        ),
                      ),
                      _ReviewRow(
                        label: 'Date',
                        value: _dateText(widget.selectedDate),
                      ),
                      _ReviewRow(
                        label: 'Time',
                        value: widget.selectedTime,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ReviewSection(
                    title: 'Patient',
                    icon: Icons.person_outline,
                    children: [
                      _ReviewRow(
                        label: 'Name',
                        value: widget.patientName,
                      ),
                      _ReviewRow(
                        label: 'Phone',
                        value: widget.phone,
                      ),
                      if (widget.email.isNotEmpty)
                        _ReviewRow(
                          label: 'Email',
                          value: widget.email,
                        ),
                      if (widget.purpose.isNotEmpty)
                        _ReviewRow(
                          label: 'Purpose',
                          value: widget.purpose,
                        ),
                      _ReviewRow(
                        label: 'Messages',
                        value: widget.messagePreference,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            color: color.primary,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Your information will be used to support this appointment.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              decoration: BoxDecoration(
                color: color.surface,
                border: Border(
                  top: BorderSide(
                    color: color.outlineVariant,
                  ),
                ),
              ),
              child: SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed:
                      isSubmitting ? null : confirmBooking,
                  child: isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Confirm appointment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BOOKING CONFIRMATION
// ============================================================

class BookingConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingConfirmationPage({
    super.key,
    required this.booking,
  });

  String _value(String key) {
    return booking[key]?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final reference = _value('reference').isNotEmpty
        ? _value('reference')
        : _value('id');

    final doctor = _value('doctorName').isNotEmpty
        ? _value('doctorName')
        : 'Doctor';

    final specialty = _value('specialty').isNotEmpty
        ? _value('specialty')
        : 'General Medicine';

    final branch = _value('branchName').isNotEmpty
        ? _value('branchName')
        : 'Branch';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Booking confirmed',
          style: TextStyle(
            color: Color(0xFF17202A),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF17202A),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Success icon
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F7EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 42,
                    color: Color(0xFF1F9D68),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Your appointment is confirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF17202A),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your appointment has been successfully booked.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Color(0xFF68737D),
                ),
              ),

              const SizedBox(height: 28),

              // Appointment card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE7E9EC),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Appointment details',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF17202A),
                      ),
                    ),

                    const SizedBox(height: 20),

                    _detailRow(
                      icon: Icons.person_outline_rounded,
                      label: 'Doctor',
                      value: doctor,
                    ),

                    const SizedBox(height: 18),

                    _detailRow(
                      icon: Icons.medical_services_outlined,
                      label: 'Specialty',
                      value: specialty,
                    ),

                    const SizedBox(height: 18),

                    _detailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Branch',
                      value: branch,
                    ),

                    const SizedBox(height: 18),

                    _detailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: _formatDate(booking['startUTC']),
                    ),

                    const SizedBox(height: 18),

                    _detailRow(
                      icon: Icons.access_time_rounded,
                      label: 'Time',
                      value: _formatTime(booking['startUTC']),
                    ),

                    const SizedBox(height: 22),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.confirmation_number_outlined,
                            size: 22,
                            color: Color(0xFF68737D),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Booking reference',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF68737D),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  reference,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF17202A),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Primary action
              SizedBox(
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const VisitsPage(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F9D68),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'View my visits',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Secondary action
              SizedBox(
                height: 54,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF17202A),
                    side: const BorderSide(
                      color: Color(0xFFD9DDE1),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Back to home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 21,
            color: const Color(0xFF1F9D68),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF68737D),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value.isEmpty ? '-' : value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF17202A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(dynamic value) {
    if (value == null) return '-';

    try {
      final date = DateTime.parse(value.toString()).toLocal();

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return value.toString();
    }
  }

  String _formatTime(dynamic value) {
    if (value == null) return '-';

    try {
      final date = DateTime.parse(value.toString()).toLocal();

      final hour = date.hour == 0
          ? 12
          : date.hour > 12
              ? date.hour - 12
              : date.hour;

      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';

      return '$hour:$minute $period';
    } catch (_) {
      return value.toString();
    }
  }
}

// ============================================================
// PRODUCT
// ============================================================

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gentle Cleanser')),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          const Text(
            'Gentle Cleanser',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '₹350 · 100 ml',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Synthetic product fixture. Inventory and checkout are supplied by the Go mock.',
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: () {},
              child: const Text('Add to bag'),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CARE RECORDS
// ============================================================


class CareRecordsPage extends StatelessWidget {
  const CareRecordsPage({super.key});

  static const Color teal = Color(0xFF00897B);
  static const Color darkTeal = Color(0xFF183B3A);
  static const Color background = Color(0xFFF5F9F8);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'Consultation documents',
        'subtitle': 'Documents related to your consultations',
        'icon': Icons.description_rounded,
        'color': const Color(0xFFE0F2F1),
      },
      {
        'title': 'Prescription',
        'subtitle': 'Your prescribed medicines and instructions',
        'icon': Icons.medication_rounded,
        'color': const Color(0xFFE8EAF6),
      },
      {
        'title': 'Visit summary',
        'subtitle': 'Review information from your visits',
        'icon': Icons.receipt_long_rounded,
        'color': const Color(0xFFFFF3E0),
      },
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkTeal),
        title: const Text(
          'My Care',
          style: TextStyle(
            color: darkTeal,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00796B), Color(0xFF26A69A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.folder_shared_rounded,
                  color: Colors.white,
                  size: 38,
                ),
                SizedBox(height: 16),
                Text(
                  'Your health records',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Access your care information and keep '
                  'your health documents organised.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Your documents',
            style: TextStyle(
              color: darkTeal,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${item['title']} is not connected yet.',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE3EEEB),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: item['color'] as Color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: teal,
                            size: 27,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: darkTeal,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                item['subtitle'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: Color(0xFF71817F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: teal,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: teal,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'This demo currently displays sample sections. '
                    'Real documents and prescriptions are not connected.',
                    style: TextStyle(
                      color: darkTeal,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REUSABLE LIST
// ============================================================


class _ListPage extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;
  final VoidCallback? onTap;

  const _ListPage({
    required this.title,
    required this.items,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF183B3A);
    const teal = Color(0xFF00897B);
    const background = Color(0xFFF5F9F8);

    return Theme(
      data: Theme.of(context).copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: darkTeal,
          displayColor: darkTeal,
          decoration: TextDecoration.none,
        ),
      ),
      child: Container(
        color: background,
        child: DefaultTextStyle(
          style: const TextStyle(
            color: darkTeal,
            decoration: TextDecoration.none,
          ),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: darkTeal,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 16),
              ...items.map(
                (item) => Card(
                  color: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(
                      color: Color(0xFFE3EEEB),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.folder_outlined,
                        color: teal,
                      ),
                    ),
                    title: Text(
                      item,
                      style: const TextStyle(
                        color: darkTeal,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: teal,
                    ),
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME CARD
// ============================================================

class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(icon, size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================
// DATE CARD
// ============================================================


class _DateCard extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  const _DateCard({
    required this.date,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
    ];

    final weekday = weekdays[date.weekday - 1];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 68,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: selected
                ? color.primary
                : color.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? color.primary
                  : color.outlineVariant,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.primary.withValues(alpha: 0.16),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                weekday,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? color.onPrimary
                      : color.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: selected
                      ? color.onPrimary
                      : color.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${date.month}'.padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 10,
                  color: selected
                      ? color.onPrimary.withValues(alpha: 0.85)
                      : color.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// ============================================================
// TIME SLOT CARD
// ============================================================


class _TimeSlotCard extends StatelessWidget {
  final String time;
  final bool selected;
  final VoidCallback onTap;

  const _TimeSlotCard({
    required this.time,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: selected
                ? color.primaryContainer
                : color.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? color.primary
                  : color.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selected
                    ? Icons.check_circle
                    : Icons.access_time_rounded,
                size: 17,
                color: selected
                    ? color.primary
                    : color.onSurfaceVariant,
              ),
              const SizedBox(width: 7),
              Flexible(
                child: Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: selected
                        ? color.onPrimaryContainer
                        : color.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ============================================================
// BOOKING PROGRESS
// ============================================================

class _BookingProgress extends StatelessWidget {
  final int activeStep;

  const _BookingProgress({
    required this.activeStep,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      children: [
        _stepCircle(context, '1', activeStep >= 1),
        Expanded(
          child: Container(
            height: 2,
            color: activeStep >= 2
                ? color.primary
                : color.outlineVariant,
          ),
        ),
        _stepCircle(context, '2', activeStep >= 2),
        Expanded(
          child: Container(
            height: 2,
            color: activeStep >= 3
                ? color.primary
                : color.outlineVariant,
          ),
        ),
        _stepCircle(context, '3', activeStep >= 3),
        Expanded(
          child: Container(
            height: 2,
            color: activeStep >= 4
                ? color.primary
                : color.outlineVariant,
          ),
        ),
        _stepCircle(context, '4', activeStep >= 4),
      ],
    );
  }

  Widget _stepCircle(
    BuildContext context,
    String number,
    bool active,
  ) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active
            ? color.primary
            : color.surfaceContainerHighest,
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: active
              ? color.onPrimary
              : color.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ============================================================
// FIELD LABEL
// ============================================================

class _FieldLabel extends StatelessWidget {
  final String label;
  final bool requiredField;

  const _FieldLabel({
    required this.label,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (requiredField)
          const Text(
            ' *',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}

// ============================================================
// REVIEW SECTION
// ============================================================

class _ReviewSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _ReviewSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ...children,
          ],
        ),
      ),
    );
  }
}

// ============================================================
// REVIEW ROW
// ============================================================

class _ReviewRow extends StatelessWidget {
  final String label;
  final String value;

  const _ReviewRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HELPERS
// ============================================================

String _doctorName(String doctorID) {
  switch (doctorID) {
    case 'doc_001':
      return 'Dr. Meera';
    case 'doc_002':
      return 'Dr. Arjun';
    case 'doc_003':
      return 'Dr. Kavya';
    default:
      return doctorID.isEmpty ? 'Doctor' : doctorID;
  }
}

String _branchName(String branchID) {
  switch (branchID) {
    case 'br_001':
      return 'Chennai Central';
    case 'br_002':
      return 'Adyar';
    case 'br_003':
      return 'Velachery';
    default:
      return branchID.isEmpty ? 'Clinic branch' : branchID;
  }
}
