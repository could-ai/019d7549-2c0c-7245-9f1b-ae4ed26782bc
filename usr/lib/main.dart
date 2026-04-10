import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Highlight Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB), // Royal Blue
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HighlightGeneratorScreen(),
      },
    );
  }
}

class HighlightGeneratorScreen extends StatefulWidget {
  const HighlightGeneratorScreen({super.key});

  @override
  State<HighlightGeneratorScreen> createState() => _HighlightGeneratorScreenState();
}

class _HighlightGeneratorScreenState extends State<HighlightGeneratorScreen> {
  final TextEditingController _topicController = TextEditingController();
  String? _highlightSentence;
  bool _isGenerating = false;

  // Mock templates for generating highlight sentences
  final List<String> _templates = [
    "Discover the future of '{topic}' and how it will transform our world.",
    "Unlocking the hidden potential of '{topic}' for unprecedented growth.",
    "The ultimate guide to mastering '{topic}' in today's fast-paced environment.",
    "Rethinking '{topic}': Strategies for success, innovation, and beyond.",
    "Why '{topic}' is the key to unlocking your next big breakthrough.",
    "A deep dive into '{topic}': Navigating challenges and seizing opportunities."
  ];

  void _generateHighlight() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a topic first!')),
      );
      return;
    }

    setState(() {
      _isGenerating = true;
      _highlightSentence = null;
    });

    // Simulate network/AI generation delay
    await Future.delayed(const Duration(milliseconds: 800));

    final random = Random();
    final template = _templates[random.nextInt(_templates.length)];
    
    setState(() {
      _highlightSentence = template.replaceAll('{topic}', topic);
      _isGenerating = false;
    });
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presentation Highlight Maker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.campaign_rounded,
                size: 64,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(height: 16),
              Text(
                'Create a Catchy Hook',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your presentation topic below to generate a compelling highlight sentence that will grab your audience\'s attention.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _topicController,
                decoration: InputDecoration(
                  labelText: 'Presentation Topic',
                  hintText: 'e.g., Artificial Intelligence in Healthcare',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.topic),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                ),
                onSubmitted: (_) => _generateHighlight(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isGenerating ? null : _generateHighlight,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: _isGenerating
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'Generate Highlight',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              const SizedBox(height: 32),
              if (_highlightSentence != null) ...[
                const Text(
                  'Your Highlight Sentence:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.secondaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.format_quote_rounded, size: 40, color: Colors.black54),
                      const SizedBox(height: 8),
                      Text(
                        _highlightSentence!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.format_quote_rounded, size: 40, color: Colors.black54),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}