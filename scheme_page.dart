import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/common_widgets.dart';
import '../models/models.dart';
import 'scheme_detail_page.dart';

class SchemePage extends StatefulWidget {
  const SchemePage({super.key});

  @override
  State<SchemePage> createState() => _SchemePageState();
}

class _SchemePageState extends State<SchemePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String _landSize = '2';
  String _cropType = 'Wheat';
  String _state = 'Maharashtra';
  String _district = 'Pune';
  final _incomeController = TextEditingController(text: '1,50,000');
  bool _isChecking = false;
  bool _showResults = false;
  final List<SchemeModel> _eligibleSchemes = SchemeModel.sampleSchemes();

  final List<String> _crops = ['Wheat', 'Rice', 'Sugarcane', 'Cotton', 'Soybean'];
  final List<String> _states = ['Maharashtra', 'Punjab', 'Haryana', 'UP', 'MP'];
  final List<String> _districts = ['Pune', 'Nashik', 'Aurangabad', 'Nagpur'];
  final List<String> _landOptions = ['1', '2', '3', '4', '5', '10+'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _checkEligibility() async {
    setState(() => _isChecking = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      _isChecking = false;
      _showResults = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: const KrishiAppBar(title: 'Check Scheme Eligibility', showBack: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Info Banner ───────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.tagGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: AppColors.primaryGreen, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Enter your details to check which government schemes you are eligible for.',
                      style:
                          AppTextStyles.caption.copyWith(color: AppColors.primaryGreen),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // ─── Form Card ─────────────────────────────────────────────
            InfoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Details',
                      style: AppTextStyles.heading3
                          .copyWith(color: AppColors.primaryGreen)),
                  const SizedBox(height: 16),

                  // Land Size with arrows
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Land Size (Acres)',
                          style:
                              AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                child: Text(_landSize, style: AppTextStyles.body),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right,
                                  color: AppColors.textMedium),
                              onPressed: () {
                                final idx = _landOptions.indexOf(_landSize);
                                if (idx < _landOptions.length - 1) {
                                  setState(() => _landSize = _landOptions[idx + 1]);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  KrishiDropdown(
                    label: 'Crop Type',
                    value: _cropType,
                    items: _crops,
                    onChanged: (v) => setState(() => _cropType = v!),
                  ),
                  const SizedBox(height: 14),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Annual Income',
                          style:
                              AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _incomeController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.primaryGreen, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  KrishiDropdown(
                    label: 'State',
                    value: _state,
                    items: _states,
                    onChanged: (v) => setState(() => _state = v!),
                  ),
                  const SizedBox(height: 14),

                  KrishiDropdown(
                    label: 'District',
                    value: _district,
                    items: _districts,
                    onChanged: (v) => setState(() => _district = v!),
                  ),
                  const SizedBox(height: 20),

                  KrishiButton(
                    label: 'Check Eligible Schemes',
                    onPressed: _checkEligibility,
                    isLoading: _isChecking,
                  ),
                ],
              ),
            ),

            // ─── Results ───────────────────────────────────────────────
            if (_showResults) ...[
              const SizedBox(height: 20),
              Text('Eligible Schemes', style: AppTextStyles.heading3),
              const SizedBox(height: 10),
              ..._eligibleSchemes
                  .map((s) => _SchemeCard(scheme: s))
                  .toList(),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ─── Scheme Card ──────────────────────────────────────────────────────────
class _SchemeCard extends StatelessWidget {
  final SchemeModel scheme;

  const _SchemeCard({required this.scheme});

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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.tagGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.article_rounded,
                color: AppColors.primaryGreen, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(scheme.name,
                    style: AppTextStyles.heading3.copyWith(fontSize: 15)),
                const SizedBox(height: 2),
                Text(scheme.description, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.tagGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    scheme.benefit,
                    style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(
                    builder: (_) => SchemeDetailPage(scheme: scheme))),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGreen,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('View Details',
                style: TextStyle(fontSize: 12, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
