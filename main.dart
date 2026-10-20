import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinyin Remember 💖',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC407A)),
        useMaterial3: true,
      ),
      home: const AppState(),
    );
  }
}


class AppState extends StatefulWidget {
  const AppState({super.key});

  @override
  State<AppState> createState() => _AppStateState();
}

class _AppStateState extends State<AppState> {

  String? _userName;
  bool _isLoggedIn = false;


  void setUser(String name) {
    setState(() {
      _userName = name;
      _isLoggedIn = true;
    });
  }

  void logout() {
    setState(() {
      _userName = null;
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return _isLoggedIn && _userName != null
        ? HomeScreen(
            userName: _userName!,
            onLogout: logout,
          )
        : SignUpScreen(onUserRegistered: setUser);
  }
}

class SignUpScreen extends StatefulWidget {
  final void Function(String) onUserRegistered;

  const SignUpScreen({super.key, required this.onUserRegistered});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  late final TextEditingController _nameController;
  late final TextEditingController _classController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;


  @override
  void initState() {
    super.initState();
    debugPrint('✅ SignUpScreen: initState() called — initializing controllers');

    _nameController = TextEditingController();
    _classController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    debugPrint('✅ SignUpScreen: dispose() called — cleaning up controllers');

    _nameController.dispose();
    _classController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F7),
      appBar: AppBar(
        title: const Text('Join Pinyin Remember 💖', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFEC407A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Learner Registration',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFAD1457)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Create your account to start learning Pinyin!',
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 28),


                  const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. Li Mei',
                      prefixIcon: Icon(Icons.person_outline, color: Color(0xFFEC407A)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Full name is required';
                      if (value.trim().length < 3) return 'Name must be at least 3 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),


                  const Text('Class / Student ID', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _classController,
                    decoration: const InputDecoration(
                      hintText: 'e.g. 10-A',
                      prefixIcon: Icon(Icons.school_outlined, color: Color(0xFFEC407A)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) =>
                        value == null || value.trim().isEmpty ? 'Class / ID is required' : null,
                  ),
                  const SizedBox(height: 18),


                  const Text('Password', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Min 6 characters',
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFFEC407A)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFFEC407A),
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Min 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),


                  const Text('Confirm Password', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscurePassword,
                    decoration: const InputDecoration(
                      hintText: 'Re-enter password',
                      prefixIcon: Icon(Icons.lock_reset_outlined, color: Color(0xFFEC407A)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),


                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEC407A),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final name = _nameController.text.trim();
                          widget.onUserRegistered(name); // ✅ Update LIFTED STATE
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Welcome, $name! 🎉'), backgroundColor: const Color(0xFFEC407A)),
                          );
                        }
                      },
                      child: const Text('✨ Sign Up Now', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String userName;
  final VoidCallback onLogout;

  const HomeScreen({super.key, required this.userName, required this.onLogout});

  static const List<Map<String, String>> _characters = [
    {'hanzi': '你', 'pinyin': 'nǐ', 'meaning': 'You / Your', 'tone': '3rd Tone'},
    {'hanzi': '好', 'pinyin': 'hǎo', 'meaning': 'Good / Well', 'tone': '3rd Tone'},
    {'hanzi': '谢', 'pinyin': 'xiè', 'meaning': 'Thank / Thanks', 'tone': '4th Tone'},
    {'hanzi': '再', 'pinyin': 'zài', 'meaning': 'Again / Once more', 'tone': '4th Tone'},
    {'hanzi': '见', 'pinyin': 'jiàn', 'meaning': 'See / Meet', 'tone': '4th Tone'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F7),
      appBar: AppBar(
        title: Text('Welcome, $userName 💖', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFEC407A),
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: onLogout),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📚 Pick a character to learn:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFAD1457)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _characters.length,
                itemBuilder: (context, index) {
                  final char = _characters[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFFCE4EC),
                        child: Text(char['hanzi']!, style: const TextStyle(fontSize: 20, color: Color(0xFFEC407A))),
                      ),
                      title: Text('${char['hanzi']} — ${char['pinyin']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('${char['meaning']} • ${char['tone']}'),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFFEC407A)),
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(
                              hanzi: char['hanzi']!,
                              pinyin: char['pinyin']!,
                              meaning: char['meaning']!,
                              tone: char['tone']!,
                            ),
                          ),
                        );
                        if (context.mounted && result == 'saved') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('💖 Saved to collection!'), backgroundColor: Color(0xFFEC407A)),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String hanzi;
  final String pinyin;
  final String meaning;
  final String tone;

  const DetailScreen({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.meaning,
    required this.tone,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F7),
      appBar: AppBar(
        title: Text('${widget.hanzi} ${widget.pinyin} 💖', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFEC407A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8)],
              ),
              child: Column(
                children: [
                  Text(widget.hanzi, style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFFEC407A))),
                  const SizedBox(height: 8),
                  Text(widget.pinyin, style: const TextStyle(fontSize: 36, color: Color(0xFFAD1457))),
                  const SizedBox(height: 12),
                  Text(widget.meaning, style: const TextStyle(fontSize: 20, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Chip(label: Text(widget.tone), backgroundColor: const Color(0xFFFCE4EC)),
                ],
              ),
            ),
            const SizedBox(height: 24),


            const Text('💡 Pronunciation Tip', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Practice saying it slowly, focusing on the tone!',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            const Spacer(),


            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSaved ? Colors.green : const Color(0xFFEC407A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: Icon(_isSaved ? Icons.check : Icons.bookmark_border),
                label: Text(_isSaved ? '✓ Saved' : 'Save to Collection 💖', style: const TextStyle(fontSize: 16)),
                onPressed: () {
                  setState(() {
                    _isSaved = true;
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (mounted) Navigator.pop(context, 'saved');
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
