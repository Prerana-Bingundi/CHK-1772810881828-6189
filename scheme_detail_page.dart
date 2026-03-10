import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/common_widgets.dart';
import '../models/models.dart';

class SchemeDetailPage extends StatelessWidget {
  final SchemeModel scheme;

  const SchemeDetailPage({super.key, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: KrishiAppBar(title: scheme.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header Card ─────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryGreen, AppColors.mediumGreen],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      scheme.category,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    scheme.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    scheme.description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.85), fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.monetization_on,
                            color: Colors.white, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          scheme.benefit,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ─── Eligibility ──────────────────────────────────────────
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: AppColors.primaryGreen, size: 20),
                      const SizedBox(width: 8),
                      Text('Eligibility Criteria', style: AppTextStyles.heading3),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _criteriaItem('Farmer Category', scheme.eligibility),
                  _criteriaItem('Land Holding', 'Up to 5 Acres'),
                  _criteriaItem('Annual Income', 'Below ₹2 Lakh'),
                  _criteriaItem('Aadhaar Required', 'Yes'),
                  _criteriaItem('Bank Account', 'Must be linked with Aadhaar'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── How to Apply ─────────────────────────────────────────
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.assignment_outlined,
                          color: AppColors.primaryGreen, size: 20),
                      const SizedBox(width: 8),
                      Text('How to Apply', style: AppTextStyles.heading3),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _stepItem('1', 'Visit pmkisan.gov.in or nearest CSC center'),
                  _stepItem('2', 'Fill the application form with Aadhaar number'),
                  _stepItem('3', 'Provide bank account details'),
                  _stepItem('4', 'Submit land ownership documents'),
                  _stepItem('5', 'Verification and approval by state government'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Documents ────────────────────────────────────────────
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.folder_outlined,
                          color: AppColors.primaryGreen, size: 20),
                      const SizedBox(width: 8),
                      Text('Required Documents', style: AppTextStyles.heading3),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _docItem('Aadhaar Card'),
                  _docItem('Land Records (7/12)'),
                  _docItem('Bank Passbook'),
                  _docItem('Passport-size Photo'),
                  _docItem('Mobile Number linked to Aadhaar'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            KrishiButton(
              label: 'Apply for this Scheme',
              onPressed: () {},
              icon: Icons.send,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border, color: AppColors.primaryGreen),
              label: const Text('Save Scheme',
                  style: TextStyle(color: AppColors.primaryGreen)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: const BorderSide(color: AppColors.primaryGreen),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _criteriaItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label,
                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: AppTextStyles.body),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String step, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Text(step,
                style: const TextStyle(
                    color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }

  Widget _docItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline,
              color: AppColors.primaryGreen, size: 16),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
