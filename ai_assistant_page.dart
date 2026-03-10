import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../widgets/common_widgets.dart';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({super.key});

  @override
  State<AiAssistantPage> createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'role': 'bot',
      'text': 'Namaste! 🙏 I am your AI Farming Assistant. I can help you with:\n\n• Crop advice & pest control\n• Government scheme eligibility\n• Market price information\n• Livestock health guidance\n\nHow can I help you today?',
    },
  ];

  final List<String> _suggestions = [
    'Best fertilizer for Wheat?',
    'PM-Kisan eligibility?',
    'When to irrigate Rabi crops?',
    'Wheat price in Pune?',
    'Symptoms of FMD in cattle?',
  ];

  void _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isTyping = true;
    });
    _scrollToBottom();

    await Future.delayed(const Duration(seconds: 1));

    final response = _generateResponse(text);
    setState(() {
      _isTyping = false;
      _messages.add({'role': 'bot', 'text': response});
    });
    _scrollToBottom();
  }

  String _generateResponse(String query) {
    final q = query.toLowerCase();
    if (q.contains('wheat') && (q.contains('fertilizer') || q.contains('fertiliser'))) {
      return '🌾 **Wheat Fertilizer Advice:**\n\nFor Wheat in Maharashtra (Rabi season):\n\n• **Basal dose**: DAP 50 kg/acre + Urea 25 kg/acre at sowing\n• **Top dressing**: Urea 25 kg/acre at 21 days after sowing\n• **Micronutrients**: Zinc Sulphate 10 kg/acre if soil is deficient\n\n💡 Tip: Get soil tested before applying fertilizers for best results.';
    } else if (q.contains('pm-kisan') || q.contains('pm kisan')) {
      return '📋 **PM-Kisan Yojana Eligibility:**\n\n✅ You are eligible if:\n• You own agricultural land\n• Annual income < ₹2 Lakh\n• Not a government employee\n• Not an income tax payer\n\n💰 **Benefit**: ₹6,000/year in 3 installments\n\n📱 Apply at: pmkisan.gov.in or nearest CSC center';
    } else if (q.contains('irrigat') || q.contains('water')) {
      return '💧 **Irrigation Advisory:**\n\nFor Wheat (Rabi):\n\n1. **Crown Root Initiation** (20-25 days): Critical stage\n2. **Tillering** (40-45 days): Important\n3. **Jointing** (65-70 days): Important  \n4. **Flowering** (90-95 days): Critical\n5. **Grain Filling** (105-110 days): Important\n\n⚠️ Current forecast shows rain in 3 days - delay next irrigation.';
    } else if (q.contains('price') || q.contains('market')) {
      return '📊 **Today\'s Market Prices (Pune APMC):**\n\n🌾 Wheat: ₹2,400/Quintal ↑ ₹100\n🌾 Rice: ₹3,200/Quintal ↑ ₹80\n🌱 Soybean: ₹4,500/Quintal ↑ ₹120\n🧅 Onion: ₹1,800/Quintal ↓ ₹50\n\n💡 Wheat prices are high this week. Good time to sell!';
    } else if (q.contains('fmd') || q.contains('cattle') || q.contains('cow')) {
      return '🐄 **FMD (Foot & Mouth Disease) Symptoms:**\n\n⚠️ Watch for:\n• Excessive saliva / drooling\n• Blisters on tongue & feet\n• Limping or lameness\n• Loss of appetite\n• High fever (40-41°C)\n\n🚨 **Immediate Action:**\n1. Isolate the affected animal\n2. Contact veterinarian immediately\n3. Ensure clean water and shade\n\n📞 **Emergency Vet**: 1962 (Animal Helpline)';
    } else {
      return '🤖 Thank you for your question about "$query".\n\nI can help you with:\n• 🌾 Crop guidance & fertilizer advice\n• 📋 Government scheme eligibility\n• 📊 Market price information\n• 🐄 Livestock health & disease\n• 💧 Irrigation scheduling\n\nPlease ask a specific question and I\'ll provide detailed advice!';
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgCream,
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Farmer Assistant',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                Text('Online • Kisan Mitra',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 11)),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // ─── Messages ────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (i == _messages.length && _isTyping) {
                  return _TypingIndicator();
                }
                final msg = _messages[i];
                return _MessageBubble(
                  text: msg['text'] as String,
                  isUser: msg['role'] == 'user',
                );
              },
            ),
          ),

          // ─── Suggestions ──────────────────────────────────────────────
          if (_messages.length == 1) ...[
            SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _suggestions.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (ctx, i) => GestureDetector(
                  onTap: () => _sendMessage(_suggestions[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.tagGreen,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primaryGreen.withOpacity(0.3)),
                    ),
                    child: Text(
                      _suggestions[i],
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],

          // ─── Input Bar ────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask your farming question...',
                      hintStyle: AppTextStyles.caption,
                      filled: true,
                      fillColor: AppColors.bgCream,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: _sendMessage,
                    maxLines: null,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _sendMessage(_controller.text),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
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

class _MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const _MessageBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? AppColors.primaryGreen : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : AppColors.textDark,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 6,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(0),
            const SizedBox(width: 4),
            _dot(100),
            const SizedBox(width: 4),
            _dot(200),
          ],
        ),
      ),
    );
  }

  Widget _dot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (ctx, val, _) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.primaryGreen.withOpacity(0.3 + val * 0.7),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
