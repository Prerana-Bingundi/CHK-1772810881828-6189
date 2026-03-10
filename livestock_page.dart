import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/common_widgets.dart';
import '../models/models.dart';

class LivestockPage extends StatefulWidget {
  const LivestockPage({super.key});

  @override
  State<LivestockPage> createState() => _LivestockPageState();
}

class _LivestockPageState extends State<LivestockPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<LivestockModel> _animals = LivestockModel.sampleAnimals();
  final List<VaccinationRecord> _vaccinations = VaccinationRecord.sampleRecords();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title: const Text('Livestock Management',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(text: 'My Animals'),
            Tab(text: 'Vaccination'),
            Tab(text: 'Vet Locator'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MyAnimalsTab(animals: _animals),
          _VaccinationTab(records: _vaccinations),
          const _VetLocatorTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAnimalDialog(context),
        backgroundColor: AppColors.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddAnimalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Animal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            KrishiTextField(label: 'Animal Name', hint: 'e.g. Gouri'),
            const SizedBox(height: 10),
            KrishiDropdown(
              label: 'Animal Type',
              value: 'Cow',
              items: const ['Cow', 'Buffalo', 'Goat', 'Sheep', 'Ox'],
              onChanged: (_) {},
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonGreen),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

// ─── My Animals Tab ───────────────────────────────────────────────────────
class _MyAnimalsTab extends StatelessWidget {
  final List<LivestockModel> animals;

  const _MyAnimalsTab({required this.animals});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // AI Disease Detection Banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('AI Disease Detection',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    const SizedBox(height: 2),
                    Text('Upload photo to detect diseases',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85), fontSize: 12)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1565C0),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Scan', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Text('My Animals (${animals.length})', style: AppTextStyles.heading3),
        const SizedBox(height: 10),

        ...animals.map((a) => _AnimalCard(animal: a)),
      ],
    );
  }
}

class _AnimalCard extends StatelessWidget {
  final LivestockModel animal;

  const _AnimalCard({required this.animal});

  @override
  Widget build(BuildContext context) {
    final iconMap = {
      'Cow': '🐄',
      'Buffalo': '🐃',
      'Goat': '🐐',
      'Sheep': '🐑',
      'Ox': '🐂',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.tagGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(iconMap[animal.type] ?? '🐄', style: const TextStyle(fontSize: 28)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(animal.name, style: AppTextStyles.heading3),
                Text('${animal.type} • ${animal.breed}', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text('Age: ${animal.age} years', style: AppTextStyles.caption),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.tagGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              animal.healthStatus,
              style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Vaccination Tab ──────────────────────────────────────────────────────
class _VaccinationTab extends StatelessWidget {
  final List<VaccinationRecord> records;

  const _VaccinationTab({required this.records});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Vaccination Schedule', style: AppTextStyles.heading3),
        const SizedBox(height: 4),
        Text('Keep your livestock healthy with timely vaccinations',
            style: AppTextStyles.caption),
        const SizedBox(height: 14),
        ...records.map((r) => _VaccinationCard(record: r)),
        const SizedBox(height: 16),
        KrishiButton(
          label: 'Schedule Next Vaccination',
          onPressed: () {},
          icon: Icons.calendar_today,
        ),
      ],
    );
  }
}

class _VaccinationCard extends StatelessWidget {
  final VaccinationRecord record;

  const _VaccinationCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final isOverdue = !record.isCompleted &&
        record.nextDate.isBefore(DateTime.now());

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOverdue
              ? Colors.red.withOpacity(0.3)
              : record.isCompleted
                  ? AppColors.primaryGreen.withOpacity(0.3)
                  : AppColors.borderColor,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Icon(
            record.isCompleted
                ? Icons.check_circle
                : isOverdue
                    ? Icons.error
                    : Icons.circle_outlined,
            color: record.isCompleted
                ? AppColors.primaryGreen
                : isOverdue
                    ? Colors.red
                    : Colors.grey,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.disease,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                Text(record.vaccineName, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(
                  'Next: ${_formatDate(record.nextDate)}',
                  style: AppTextStyles.caption.copyWith(
                    color: isOverdue ? Colors.red : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          if (isOverdue)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('Overdue',
                  style: TextStyle(
                      color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// ─── Vet Locator Tab ──────────────────────────────────────────────────────
class _VetLocatorTab extends StatelessWidget {
  const _VetLocatorTab();

  @override
  Widget build(BuildContext context) {
    final vets = [
      {
        'name': 'Dr. Suresh Patil',
        'clinic': 'Patil Animal Hospital',
        'distance': '1.2 km',
        'phone': '9876543210',
        'available': true,
      },
      {
        'name': 'Dr. Meena Sharma',
        'clinic': 'Govt. Veterinary Hospital',
        'distance': '3.4 km',
        'phone': '9876543211',
        'available': true,
      },
      {
        'name': 'Dr. Rajesh Kumar',
        'clinic': 'Rural Animal Care',
        'distance': '5.1 km',
        'phone': '9876543212',
        'available': false,
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Map placeholder
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFFD4E8C2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map, color: AppColors.primaryGreen, size: 40),
                SizedBox(height: 8),
                Text('Nearby Veterinary Centers',
                    style: TextStyle(
                        color: AppColors.primaryGreen, fontWeight: FontWeight.w600)),
                Text('Pune, Maharashtra',
                    style: TextStyle(color: AppColors.textMedium, fontSize: 12)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Nearby Vets', style: AppTextStyles.heading3),
        const SizedBox(height: 10),
        ...vets.map((v) => _VetCard(vet: v)),
      ],
    );
  }
}

class _VetCard extends StatelessWidget {
  final Map<String, dynamic> vet;

  const _VetCard({required this.vet});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.tagGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_hospital,
                color: AppColors.primaryGreen, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vet['name'] as String, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                Text(vet['clinic'] as String, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: AppColors.textLight),
                    Text(vet['distance'] as String, style: AppTextStyles.caption),
                    const SizedBox(width: 10),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: vet['available'] as bool ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      vet['available'] as bool ? 'Available' : 'Unavailable',
                      style: TextStyle(
                          fontSize: 11,
                          color: vet['available'] as bool ? Colors.green : Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.primaryGreen),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
