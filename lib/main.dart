import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? startupError;
  if (FirebaseConfig.hasPartialConfiguration && !FirebaseConfig.isConfigured) {
    startupError =
        'Firebase configuration is incomplete. Set FIREBASE_API_KEY, '
        'FIREBASE_PROJECT_ID, FIREBASE_MESSAGING_SENDER_ID, and the app ID '
        'for this platform in firebase.env.json.';
  }
  if (FirebaseConfig.isConfigured && startupError == null) {
    try {
      await Firebase.initializeApp(options: FirebaseConfig.options);
    } catch (error) {
      startupError = 'Firebase could not initialize: $error';
    }
  }
  runApp(
    InterneeLmsApp(
      firebaseConfigured: Firebase.apps.isNotEmpty,
      startupError: startupError,
    ),
  );
}

const _ink = Color(0xFF14212B);
const _muted = Color(0xFF718096);
const _green = Color(0xFF16A36A);
const _paleGreen = Color(0xFFE7F7EF);

void _showActionError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    required this.videoId,
  });

  final String id;
  final String title;
  final String duration;
  final String videoId;
}

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.explanation,
  });

  final String question;
  final List<String> options;
  final int answerIndex;
  final String explanation;
}

class Course {
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.instructor,
    required this.description,
    required this.icon,
    required this.color,
    required this.rating,
    required this.students,
    required this.lessons,
    required this.questions,
    this.level = 'Beginner',
  });

  final String id;
  final String title;
  final String category;
  final String instructor;
  final String description;
  final IconData icon;
  final Color color;
  final double rating;
  final String students;
  final String level;
  final List<Lesson> lessons;
  final List<QuizQuestion> questions;
}

const courses = <Course>[
  Course(
    id: 'flutter',
    title: 'Flutter App Development',
    category: 'Mobile',
    instructor: 'Internee.pk Learning Team',
    description: 'Build beautiful cross-platform apps with Flutter. Learn Dart fundamentals, reusable widgets, navigation, and how to bring your app to life.',
    icon: Icons.phone_android_rounded,
    color: Color(0xFF3276D2),
    rating: 4.9,
    students: '2.4k',
    lessons: [
      Lesson(
        id: 'flutter-1',
        title: 'Welcome to Flutter',
        duration: '08:24',
        videoId: '92h2XcvZ-vM',
      ),
      Lesson(
        id: 'flutter-2',
        title: 'Dart fundamentals',
        duration: '14:10',
        videoId: 'JZukfxvc7Mc',
      ),
      Lesson(
        id: 'flutter-3',
        title: 'Your first widgets',
        duration: '18:32',
        videoId: 'WOvj84xq_fc',
      ),
      Lesson(
        id: 'flutter-4',
        title: 'Build and run your app',
        duration: '12:45',
        videoId: 'jU2D31WMOdA',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'Which language is used to build Flutter applications?',
        options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
        answerIndex: 1,
        explanation: 'Flutter apps are written in Dart.',
      ),
      QuizQuestion(
        question: 'What is a widget in Flutter?',
        options: [
          'A database table',
          'A UI building block',
          'A network protocol',
          'A testing device',
        ],
        answerIndex: 1,
        explanation: 'Widgets describe the user interface and its behavior.',
      ),
      QuizQuestion(
        question: 'Which widget arranges its children vertically?',
        options: ['Row', 'Stack', 'Column', 'Wrap'],
        answerIndex: 2,
        explanation: 'Column lays out its children in a vertical direction.',
      ),
    ],
  ),
  Course(
    id: 'web',
    title: 'Modern Web Development',
    category: 'Web',
    instructor: 'Ayesha Malik',
    description: 'Learn the essentials of modern web development, from semantic HTML and responsive CSS to interactive JavaScript.',
    icon: Icons.language_rounded,
    color: Color(0xFFEC8B42),
    rating: 4.8,
    students: '1.8k',
    lessons: [
      Lesson(
        id: 'web-1',
        title: 'How the web works',
        duration: '09:15',
        videoId: 'hJHvdBlSxug',
      ),
      Lesson(
        id: 'web-2',
        title: 'HTML and accessible structure',
        duration: '16:40',
        videoId: 'l89I-em1Lnc',
      ),
      Lesson(
        id: 'web-3',
        title: 'CSS layouts and responsive design',
        duration: '20:05',
        videoId: 'lyvbZJ12DmE',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'What does HTML primarily define?',
        options: [
          'Page structure',
          'Database storage',
          'Server security',
          'Image editing',
        ],
        answerIndex: 0,
        explanation: 'HTML gives web content its structure and meaning.',
      ),
      QuizQuestion(
        question: 'Which CSS feature is designed for one-dimensional layouts?',
        options: ['Flexbox', 'SQL', 'DOM', 'Dart'],
        answerIndex: 0,
        explanation:
            'Flexbox is a CSS layout model for one-dimensional layouts.',
      ),
    ],
  ),
  Course(
    id: 'ai',
    title: 'AI & Machine Learning',
    category: 'AI',
    instructor: 'Hamza Raza',
    description: 'Explore core machine learning ideas, practical data preparation, and the building blocks behind intelligent applications.',
    icon: Icons.auto_awesome_rounded,
    color: Color(0xFF8764CB),
    rating: 4.7,
    students: '3.1k',
    lessons: [
      Lesson(
        id: 'ai-1',
        title: 'What is machine learning?',
        duration: '11:20',
        videoId: 'i_LwzRVP7bg',
      ),
      Lesson(
        id: 'ai-2',
        title: 'Preparing your data',
        duration: '17:08',
        videoId: 'GP-2634exqA',
      ),
      Lesson(
        id: 'ai-3',
        title: 'Training your first model',
        duration: '21:36',
        videoId: 'Hr06nSA-qww',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'What does a supervised model learn from?',
        options: [
          'Labeled examples',
          'Random guesses only',
          'Screen brightness',
          'Unrelated files',
        ],
        answerIndex: 0,
        explanation:
            'Supervised learning uses examples paired with known labels.',
      ),
      QuizQuestion(
        question: 'Why do we keep a test dataset?',
        options: [
          'To make training slower',
          'To measure performance on unseen data',
          'To replace the training data',
          'To store application settings',
        ],
        answerIndex: 1,
        explanation:
            'A held-out test set helps evaluate how well a model generalizes.',
      ),
    ],
  ),
  Course(
    id: 'design',
    title: 'UI/UX Design Essentials',
    category: 'Design',
    instructor: 'Sara Ahmed',
    description: 'Create thoughtful digital experiences with user research, wireframing, visual hierarchy, and accessible design foundations.',
    icon: Icons.draw_rounded,
    color: Color(0xFFE46F8C),
    rating: 4.9,
    students: '980',
    lessons: [
      Lesson(
        id: 'design-1',
        title: 'Designing for people',
        duration: '10:14',
        videoId: 'bAARmsv1tms',
      ),
      Lesson(
        id: 'design-2',
        title: 'From idea to wireframe',
        duration: '15:42',
        videoId: 'iyrEStiTZh0',
      ),
      Lesson(
        id: 'design-3',
        title: 'Color, type, and hierarchy',
        duration: '19:17',
        videoId: 'kg76CMOO__Y',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'What is the main purpose of a wireframe?',
        options: [
          'Finalize every color',
          'Plan a screen’s structure',
          'Write application logic',
          'Measure internet speed',
        ],
        answerIndex: 1,
        explanation: 'A wireframe maps the structure and content of a screen.',
      ),
      QuizQuestion(
        question: 'What should accessible color combinations support?',
        options: [
          'Readable contrast',
          'More animations',
          'Smaller tap targets',
          'Hidden labels',
        ],
        answerIndex: 0,
        explanation:
            'Sufficient contrast helps people read and distinguish content.',
      ),
    ],
  ),
  Course(
    id: 'data',
    title: 'Data Science with Python',
    category: 'Data',
    instructor: 'Bilal Hussain',
    description: 'Turn raw data into useful insights. Get started with Python, explore datasets, and communicate findings with clear visualizations.',
    icon: Icons.query_stats_rounded,
    color: Color(0xFF2D9B91),
    rating: 4.8,
    students: '1.2k',
    lessons: [
      Lesson(
        id: 'data-1',
        title: 'A first look at data science',
        duration: '08:56',
        videoId: '-Rf4fZDQ0yw',
      ),
      Lesson(
        id: 'data-2',
        title: 'Working with datasets',
        duration: '16:24',
        videoId: 'EXIgjIBu4EU',
      ),
      Lesson(
        id: 'data-3',
        title: 'Tell a story with charts',
        duration: '13:47',
        videoId: 'DAQNHzOcO5A',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'What is a common first step in data analysis?',
        options: [
          'Inspect and clean the data',
          'Delete every row',
          'Build a mobile screen',
          'Publish a model immediately',
        ],
        answerIndex: 0,
        explanation:
            'Inspecting and cleaning data helps make analysis reliable.',
      ),
      QuizQuestion(
        question: 'What makes a chart easier to understand?',
        options: [
          'Clear labels',
          'More decorative effects',
          'No title or context',
          'Unexplained abbreviations',
        ],
        answerIndex: 0,
        explanation: 'Labels help readers interpret the information shown.',
      ),
    ],
  ),
  Course(
    id: 'cloud',
    title: 'Cloud & DevOps Foundations',
    category: 'Cloud',
    instructor: 'Usman Tariq',
    description: 'Understand cloud computing, version control, continuous integration, and the practices that help teams ship software reliably.',
    icon: Icons.cloud_outlined,
    color: Color(0xFF458FAE),
    rating: 4.6,
    students: '740',
    lessons: [
      Lesson(
        id: 'cloud-1',
        title: 'Cloud computing explained',
        duration: '12:06',
        videoId: '8C_kHJ5YEiA',
      ),
      Lesson(
        id: 'cloud-2',
        title: 'Git and team workflows',
        duration: '18:50',
        videoId: 'jhtbhSpV5YA',
      ),
      Lesson(
        id: 'cloud-3',
        title: 'Your first CI pipeline',
        duration: '17:32',
        videoId: 'YLtlz88zrLg',
      ),
    ],
    questions: [
      QuizQuestion(
        question: 'What is a key goal of continuous integration?',
        options: [
          'Integrate and validate changes frequently',
          'Avoid testing changes',
          'Store passwords in source code',
          'Replace collaboration',
        ],
        answerIndex: 0,
        explanation:
            'CI automates checks as changes are integrated frequently.',
      ),
      QuizQuestion(
        question: 'Which tool commonly tracks source code changes?',
        options: ['Git', 'Figma', 'Photoshop', 'Excel'],
        answerIndex: 0,
        explanation: 'Git is a distributed version control system.',
      ),
    ],
  ),
];

class InterneeLmsApp extends StatelessWidget {
  const InterneeLmsApp({
    super.key,
    this.firebaseConfigured = false,
    this.startupError,
  });

  final bool firebaseConfigured;
  final String? startupError;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Internee.pk LMS',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF7F9F8),
      colorScheme: ColorScheme.fromSeed(
        seedColor: _green,
        primary: _green,
        surface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF7F9F8),
        foregroundColor: _ink,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: _paleGreen,
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
    ),
    home: startupError != null
        ? _StartupErrorPage(message: startupError!)
        : firebaseConfigured
        ? const _FirebaseAuthGate()
        : const HomeShell(),
  );
}

class _FirebaseAuthGate extends StatelessWidget {
  const _FirebaseAuthGate();

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return _StartupErrorPage(message: snapshot.error.toString());
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const _StartupLoadingPage();
      }
      final user = snapshot.data;
      return user == null
          ? const _AuthPage()
          : HomeShell(key: ValueKey(user.uid), user: user);
    },
  );
}

class _StartupLoadingPage extends StatelessWidget {
  const _StartupLoadingPage();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class _StartupErrorPage extends StatelessWidget {
  const _StartupErrorPage({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'Firebase could not start.\n$message',
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

class _AuthPage extends StatefulWidget {
  const _AuthPage();

  @override
  State<_AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<_AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  bool _isSignUp = false;
  bool _isBusy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isBusy = true;
      _error = null;
    });
    try {
      final auth = FirebaseAuth.instance;
      if (_isSignUp) {
        final credential = await auth.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text,
        );
        final displayName = _name.text.trim();
        if (displayName.isNotEmpty) {
          await credential.user?.updateDisplayName(displayName);
        }
      } else {
        await auth.signInWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) setState(() => _error = _authErrorMessage(error.code));
    } catch (error) {
      if (mounted) setState(() => _error = 'Sign-in failed: $error');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _sendPasswordReset() async {
    final email = _email.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => _error = 'Enter your email address first.');
      return;
    }
    setState(() {
      _isBusy = true;
      _error = null;
    });
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent.')),
        );
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) setState(() => _error = _authErrorMessage(error.code));
    } catch (error) {
      if (mounted) {
        setState(() => _error = 'Could not send reset email: $error');
      }
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  String _authErrorMessage(String code) => switch (code) {
    'email-already-in-use' => 'An account already uses this email.',
    'invalid-email' => 'Enter a valid email address.',
    'weak-password' => 'Choose a password with at least 6 characters.',
    'user-disabled' => 'This account has been disabled.',
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => 'Email or password is incorrect.',
    'network-request-failed' =>
      'Network error. Check your connection and retry.',
    'too-many-requests' => 'Too many attempts. Please wait and try again.',
    _ =>
      'Authentication failed ($code). Check Firebase Authentication settings.',
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: _paleGreen,
                    child: Icon(Icons.school_rounded, color: _green, size: 34),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Internee.pk LMS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _ink,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _isSignUp
                        ? 'Create your learner account'
                        : 'Sign in to continue learning',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _muted),
                  ),
                  const SizedBox(height: 24),
                  if (_isSignUp) ...[
                    TextFormField(
                      controller: _name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Name (optional)',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (email.isEmpty || !email.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    autofillHints: [
                      _isSignUp
                          ? AutofillHints.newPassword
                          : AutofillHints.password,
                    ],
                    onFieldSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if ((value ?? '').length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  if (!_isSignUp)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _isBusy ? null : _sendPasswordReset,
                        child: const Text('Forgot password?'),
                      ),
                    ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFFB3261E)),
                    ),
                  ],
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: _isBusy ? null : _submit,
                      child: _isBusy
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(_isSignUp ? 'Create account' : 'Sign in'),
                    ),
                  ),
                  TextButton(
                    onPressed: _isBusy
                        ? null
                        : () => setState(() {
                            _isSignUp = !_isSignUp;
                            _error = null;
                          }),
                    child: Text(
                      _isSignUp
                          ? 'Already have an account? Sign in'
                          : 'New to Internee.pk? Create an account',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, this.user});

  final User? user;

  @override
  State<HomeShell> createState() => HomeShellState();
}

class HomeShellState extends State<HomeShell> {
  int _tab = 0;
  final Set<String> _enrolled = {};
  final Map<String, Set<String>> _completedLessons = {};
  final Map<String, int> _bestScores = {};
  bool _isLoadingProgress = false;
  String? _progressError;

  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      _enrolled.addAll(['flutter', 'design']);
    } else {
      _loadProgress();
    }
  }

  bool isEnrolled(Course course) => _enrolled.contains(course.id);

  int completedCount(Course course) =>
      _completedLessons[course.id]?.length ?? 0;

  double progressFor(Course course) => course.lessons.isEmpty
      ? 0
      : completedCount(course) / course.lessons.length;

  int? bestScore(Course course) => _bestScores[course.id];

  Future<void> enroll(Course course) async {
    final user = widget.user;
    if (user != null) {
      await FirebaseProgressRepository(user.uid).enroll(course.id);
    }
    if (mounted) setState(() => _enrolled.add(course.id));
  }

  Future<void> markLessonComplete(Course course, Lesson lesson) async {
    final user = widget.user;
    if (user != null) {
      await FirebaseProgressRepository(user.uid)
          .completeLesson(course.id, lesson.id);
    }
    if (!mounted) return;
    setState(() {
      _enrolled.add(course.id);
      _completedLessons.putIfAbsent(course.id, () => <String>{}).add(lesson.id);
    });
  }

  Future<void> saveQuizScore(Course course, int score) async {
    final user = widget.user;
    if (user != null) {
      await FirebaseProgressRepository(user.uid)
          .saveQuizScore(course.id, score);
    }
    if (!mounted) return;
    setState(() {
      final previous = _bestScores[course.id];
      if (previous == null || score > previous) _bestScores[course.id] = score;
    });
  }

  Future<void> _loadProgress() async {
    setState(() {
      _isLoadingProgress = true;
      _progressError = null;
    });
    try {
      final records = await FirebaseProgressRepository(widget.user!.uid)
          .loadAll();
      if (!mounted) return;
      setState(() {
        for (final entry in records.entries) {
          final data = entry.value;
          if (data['enrolled'] == true) _enrolled.add(entry.key);
          _completedLessons[entry.key] = Set<String>.from(
            data['completedLessonIds']! as List<String>,
          );
          _bestScores[entry.key] = data['bestQuizScore']! as int;
        }
        _isLoadingProgress = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _progressError = 'Could not load your saved progress: $error';
        _isLoadingProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomePage(
        enrolledCourses: courses.where(isEnrolled).toList(),
        progressFor: progressFor,
        onExplore: () => setState(() => _tab = 1),
        onOpenCourse: _openCourse,
      ),
      _ExplorePage(
        onOpenCourse: _openCourse,
        isEnrolled: isEnrolled,
        progressFor: progressFor,
      ),
      _ProgressPage(
        enrolledCourses: courses.where(isEnrolled).toList(),
        completedCount: completedCount,
        progressFor: progressFor,
        bestScore: bestScore,
        onOpenCourse: _openCourse,
      ),
      _ProfilePage(
        user: widget.user,
        onSignOut: widget.user == null
            ? null
            : () => FirebaseAuth.instance.signOut(),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: _isLoadingProgress
            ? const Center(child: CircularProgressIndicator())
            : _progressError != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_progressError!, textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: _loadProgress,
                        child: const Text('Try again'),
                      ),
                    ],
                  ),
                ),
              )
            : IndexedStack(index: _tab, children: pages),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _openCourse(Course course) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CourseDetailsPage(
          course: course,
          enrolled: isEnrolled(course),
          completedCount: completedCount(course),
          completedLessonIds: Set<String>.of(
            _completedLessons[course.id] ?? const <String>{},
          ),
          progress: progressFor(course),
          bestScore: bestScore(course),
          onEnroll: () => enroll(course),
          onLessonComplete: (lesson) => markLessonComplete(course, lesson),
          onQuizComplete: (score) => saveQuizScore(course, score),
        ),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({
    required this.enrolledCourses,
    required this.progressFor,
    required this.onExplore,
    required this.onOpenCourse,
  });

  final List<Course> enrolledCourses;
  final double Function(Course) progressFor;
  final VoidCallback onExplore;
  final ValueChanged<Course> onOpenCourse;

  @override
  Widget build(BuildContext context) {
    final featured = enrolledCourses.isNotEmpty
        ? enrolledCourses.first
        : courses.first;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Internee.pk',
                    style: TextStyle(
                      color: _green,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .3,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Good morning, learner 👋',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 23,
              backgroundColor: _paleGreen,
              child: const Text(
                'L',
                style: TextStyle(color: _green, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        _HeroCard(onTap: () => onOpenCourse(featured)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _SectionTitle('Your learning'),
            TextButton(onPressed: onExplore, child: const Text('See all')),
          ],
        ),
        const SizedBox(height: 4),
        if (enrolledCourses.isEmpty)
          _EmptyCourses(onExplore: onExplore)
        else
          ...enrolledCourses
              .take(3)
              .map(
                (course) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ContinueCourseCard(
                    course: course,
                    progress: progressFor(course),
                    onTap: () => onOpenCourse(course),
                  ),
                ),
              ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _SectionTitle('Explore topics'),
            TextButton(onPressed: onExplore, child: const Text('Browse')),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: const [
            _TopicPill(icon: Icons.phone_android, label: 'Mobile'),
            _TopicPill(icon: Icons.language, label: 'Web'),
            _TopicPill(icon: Icons.auto_awesome, label: 'AI'),
            _TopicPill(icon: Icons.draw, label: 'Design'),
          ],
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: _ink,
    borderRadius: BorderRadius.circular(24),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'YOUR NEXT SKILL STARTS HERE',
                    style: TextStyle(
                      color: Color(0xFFB7F4D3),
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: .9,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.auto_awesome, color: Color(0xFFB7F4D3)),
              ],
            ),
            const SizedBox(height: 17),
            const Text(
              'Learn something\nthat moves you forward.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 1.16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Expert-led courses. Real-world skills. Your pace.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 18),
            FilledButton(
              onPressed: onTap,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB7F4D3),
                foregroundColor: _ink,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continue learning'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 17),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _EmptyCourses extends StatelessWidget {
  const _EmptyCourses({required this.onExplore});
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        const Icon(Icons.menu_book_rounded, color: _green, size: 28),
        const SizedBox(width: 12),
        const Expanded(child: Text('Pick a course and start learning today.')),
        TextButton(onPressed: onExplore, child: const Text('Explore')),
      ],
    ),
  );
}

class _ExplorePage extends StatefulWidget {
  const _ExplorePage({
    required this.onOpenCourse,
    required this.isEnrolled,
    required this.progressFor,
  });

  final ValueChanged<Course> onOpenCourse;
  final bool Function(Course) isEnrolled;
  final double Function(Course) progressFor;

  @override
  State<_ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<_ExplorePage> {
  final _search = TextEditingController();
  String _category = 'All';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      'All',
      ...courses.map((course) => course.category).toSet(),
    ];
    final query = _search.text.trim().toLowerCase();
    final visible = courses.where((course) {
      final matchesCategory =
          _category == 'All' || course.category == _category;
      final matchesQuery =
          query.isEmpty ||
          course.title.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query) ||
          course.category.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        const Text(
          'Explore courses',
          style: TextStyle(
            color: _ink,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Find your next skill and learn at your own pace.',
          style: TextStyle(color: _muted, fontSize: 13),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _search,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Search courses or instructors',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ChoiceChip(
                label: Text(category),
                selected: category == _category,
                onSelected: (_) => setState(() => _category = category),
                selectedColor: _paleGreen,
                labelStyle: TextStyle(
                  color: category == _category ? _green : _muted,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
                side: BorderSide.none,
              );
            },
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '${visible.length} courses',
          style: const TextStyle(color: _muted, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        if (visible.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 42),
            child: Center(child: Text('No courses match your search.')),
          )
        else
          ...visible.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 13),
              child: _CourseCard(
                course: course,
                enrolled: widget.isEnrolled(course),
                progress: widget.progressFor(course),
                onTap: () => widget.onOpenCourse(course),
              ),
            ),
          ),
      ],
    );
  }
}

class _CourseCard extends StatelessWidget {
  const _CourseCard({
    required this.course,
    required this.enrolled,
    required this.progress,
    required this.onTap,
  });

  final Course course;
  final bool enrolled;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _CourseIcon(course: course, size: 54),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.category.toUpperCase(),
                        style: TextStyle(
                          color: course.color,
                          fontSize: 9,
                          letterSpacing: .8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: _muted),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              course.instructor,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFF3B33D),
                  size: 16,
                ),
                const SizedBox(width: 3),
                Text(
                  course.rating.toString(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: _ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.play_circle_outline, color: _muted, size: 15),
                const SizedBox(width: 4),
                Text(
                  '${course.lessons.length} lessons',
                  style: const TextStyle(color: _muted, fontSize: 11),
                ),
                const Spacer(),
                if (enrolled)
                  Text(
                    '${(progress * 100).round()}% complete',
                    style: const TextStyle(
                      color: _green,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else
                  Text(
                    '${course.students} learners',
                    style: const TextStyle(color: _muted, fontSize: 10),
                  ),
              ],
            ),
            if (enrolled) ...[
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                borderRadius: BorderRadius.circular(4),
                backgroundColor: const Color(0xFFEDF1EF),
                color: _green,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

class _ContinueCourseCard extends StatelessWidget {
  const _ContinueCourseCard({
    required this.course,
    required this.progress,
    required this.onTap,
  });

  final Course course;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            _CourseIcon(course: course, size: 52),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(4),
                    backgroundColor: const Color(0xFFEDF1EF),
                    color: _green,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    progress == 0
                        ? 'Ready when you are'
                        : '${(progress * 100).round()}% complete',
                    style: const TextStyle(color: _muted, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.play_circle_fill_rounded, color: _green, size: 28),
          ],
        ),
      ),
    ),
  );
}

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({
    super.key,
    required this.course,
    required this.enrolled,
    required this.completedCount,
    required this.completedLessonIds,
    required this.progress,
    required this.bestScore,
    required this.onEnroll,
    required this.onLessonComplete,
    required this.onQuizComplete,
  });

  final Course course;
  final bool enrolled;
  final int completedCount;
  final Set<String> completedLessonIds;
  final double progress;
  final int? bestScore;
  final Future<void> Function() onEnroll;
  final Future<void> Function(Lesson) onLessonComplete;
  final Future<void> Function(int) onQuizComplete;

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  late bool _enrolled;
  late Set<String> _completedLessonIds;
  late int? _bestScore;

  Course get course => widget.course;
  bool get enrolled => _enrolled;
  int get completedCount => _completedLessonIds.length;
  double get progress =>
      course.lessons.isEmpty ? 0 : completedCount / course.lessons.length;
  int? get bestScore => _bestScore;

  @override
  void initState() {
    super.initState();
    _enrolled = widget.enrolled;
    _completedLessonIds = Set<String>.of(widget.completedLessonIds);
    _bestScore = widget.bestScore;
  }

  Future<void> onEnroll() async {
    try {
      await widget.onEnroll();
      if (mounted) setState(() => _enrolled = true);
    } catch (error) {
      if (mounted) _showActionError(context, 'Could not enroll: $error');
    }
  }

  Future<void> onLessonComplete(Lesson lesson) async {
    await widget.onLessonComplete(lesson);
    if (mounted) setState(() => _completedLessonIds.add(lesson.id));
  }

  Future<void> onQuizComplete(int score) async {
    await widget.onQuizComplete(score);
    if (!mounted) return;
    if (_bestScore == null || score > _bestScore!) {
      setState(() => _bestScore = score);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Course details')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: course.color.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CourseIcon(course: course, size: 60),
              const SizedBox(height: 16),
              Text(
                course.category.toUpperCase(),
                style: TextStyle(
                  color: course.color,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                course.title,
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'By ${course.instructor}',
                style: const TextStyle(color: _muted, fontSize: 12),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _MiniStat(
                    icon: Icons.star_rounded,
                    text: '${course.rating} rating',
                  ),
                  const SizedBox(width: 15),
                  _MiniStat(
                    icon: Icons.play_lesson_outlined,
                    text: '${course.lessons.length} lessons',
                  ),
                  const SizedBox(width: 15),
                  _MiniStat(
                    icon: Icons.signal_cellular_alt,
                    text: course.level,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const _SectionTitle('About this course'),
        const SizedBox(height: 8),
        Text(
          course.description,
          style: const TextStyle(color: _muted, height: 1.55, fontSize: 13),
        ),
        const SizedBox(height: 20),
        if (!enrolled)
          SizedBox(
            height: 50,
            child: FilledButton(
              onPressed: onEnroll,
              child: const Text('Enroll for free'),
            ),
          )
        else ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SectionTitle('Your progress'),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: _green,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 7,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: const Color(0xFFEDF1EF),
            color: _green,
          ),
          const SizedBox(height: 8),
          Text(
            '$completedCount of ${course.lessons.length} lessons completed',
            style: const TextStyle(color: _muted, fontSize: 11),
          ),
        ],
        const SizedBox(height: 22),
        const _SectionTitle('Course lessons'),
        const SizedBox(height: 10),
        ...course.lessons.asMap().entries.map((entry) {
          final lesson = entry.value;
          final isComplete = _completedLessonIds.contains(lesson.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: _LessonTile(
              lesson: lesson,
              number: entry.key + 1,
              complete: isComplete,
              enabled: enrolled,
              onTap: enrolled
                  ? () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => LessonPlayerPage(
                          course: course,
                          lesson: lesson,
                          complete: isComplete,
                          onComplete: () => onLessonComplete(lesson),
                        ),
                      ),
                    )
                  : null,
            ),
          );
        }),
        const SizedBox(height: 12),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3DB),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(Icons.quiz_outlined, color: Color(0xFFE2A22B)),
            ),
            title: const Text(
              'Knowledge check',
              style: TextStyle(color: _ink, fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              bestScore == null
                  ? '${course.questions.length} questions · Check what you learned'
                  : 'Best score: $bestScore/${course.questions.length}',
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15),
            onTap: enrolled
                ? () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          QuizPage(course: course, onComplete: onQuizComplete),
                    ),
                  )
                : null,
          ),
        ),
        if (!enrolled)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Enroll in this course to unlock lessons and quizzes.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, fontSize: 11),
            ),
          ),
      ],
    ),
  );
}

class LessonPlayerPage extends StatefulWidget {
  const LessonPlayerPage({
    super.key,
    required this.course,
    required this.lesson,
    required this.complete,
    required this.onComplete,
  });

  final Course course;
  final Lesson lesson;
  final bool complete;
  final Future<void> Function() onComplete;

  @override
  State<LessonPlayerPage> createState() => _LessonPlayerPageState();
}

class _LessonPlayerPageState extends State<LessonPlayerPage> {
  late YoutubePlayerController _controller;
  StreamSubscription<YoutubePlayerValue>? _playerSubscription;
  bool _videoUnavailable = false;
  bool _completed = false;
  bool _savingCompletion = false;

  @override
  void initState() {
    super.initState();
    _completed = widget.complete;
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.lesson.videoId,
      params: const YoutubePlayerParams(
        enableCaption: true,
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
    _playerSubscription = _controller.stream.listen((value) {
      if (value.hasError && mounted) {
        setState(() => _videoUnavailable = true);
      }
    });
  }

  @override
  void dispose() {
    _playerSubscription?.cancel();
    unawaited(_controller.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Lesson')),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(aspectRatio: 16 / 9, child: _videoContent()),
        ),
        const SizedBox(height: 20),
        Text(
          'LESSON ${widget.course.lessons.indexOf(widget.lesson) + 1}',
          style: const TextStyle(
            color: _green,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.lesson.title,
          style: const TextStyle(
            color: _ink,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${widget.course.title} · ${widget.lesson.duration}',
          style: const TextStyle(color: _muted, fontSize: 12),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: FilledButton.icon(
            onPressed: _completed || _savingCompletion ? null : _completeLesson,
            icon: Icon(_completed ? Icons.check_circle : Icons.check_rounded),
            label: Text(
              _completed
                  ? 'Lesson completed'
                  : _savingCompletion
                  ? 'Saving progress…'
                  : 'Mark lesson complete',
            ),
          ),
        ),
      ],
    ),
  );

  Widget _videoContent() {
    if (_videoUnavailable) {
      return Container(
        color: _ink,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This video is unavailable. Check your connection or try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () {
                _playerSubscription?.cancel();
                unawaited(_controller.close());
                setState(() => _videoUnavailable = false);
                _initializePlayer();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    return YoutubePlayer(
      controller: _controller,
      backgroundColor: _ink,
      autoFullScreen: true,
    );
  }

  Future<void> _completeLesson() async {
    setState(() => _savingCompletion = true);
    try {
      await widget.onComplete();
      if (!mounted) return;
      setState(() => _completed = true);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lesson marked as complete')),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save lesson progress: $error')),
      );
    } finally {
      if (mounted) setState(() => _savingCompletion = false);
    }
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.course, required this.onComplete});
  final Course course;
  final Future<void> Function(int) onComplete;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _checked = false;
  bool _finished = false;
  bool _savingResult = false;

  QuizQuestion get _question => widget.course.questions[_index];

  void _checkAnswer() {
    if (_selected == null) return;
    setState(() {
      _checked = true;
      if (_selected == _question.answerIndex) _score++;
    });
  }

  Future<void> _nextQuestion() async {
    if (_index == widget.course.questions.length - 1) {
      setState(() => _savingResult = true);
      try {
        await widget.onComplete(_score);
        if (mounted) setState(() => _finished = true);
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not save quiz result: $error')),
          );
        }
      } finally {
        if (mounted) setState(() => _savingResult = false);
      }
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _checked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.course.questions.length;
    return Scaffold(
      appBar: AppBar(
        title: Text(_finished ? 'Quiz result' : 'Knowledge check'),
      ),
      body: _finished ? _result(total) : _questionBody(total),
    );
  }

  Widget _questionBody(int total) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'QUESTION ${_index + 1} OF $total',
            style: const TextStyle(
              color: _green,
              fontSize: 11,
              letterSpacing: .8,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Score: $_score',
            style: const TextStyle(color: _ink, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      const SizedBox(height: 10),
      LinearProgressIndicator(
        value: (_index + 1) / total,
        minHeight: 6,
        borderRadius: BorderRadius.circular(5),
        backgroundColor: const Color(0xFFEDF1EF),
        color: _green,
      ),
      const SizedBox(height: 25),
      Text(
        _question.question,
        style: const TextStyle(
          color: _ink,
          fontSize: 22,
          height: 1.3,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 18),
      ..._question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final correct = index == _question.answerIndex;
        final selected = _selected == index;
        var color = Colors.white;
        var borderColor = const Color(0xFFE9EFEC);
        if (_checked && correct) {
          color = _paleGreen;
          borderColor = _green;
        } else if (_checked && selected) {
          color = const Color(0xFFFFEBEA);
          borderColor = const Color(0xFFD95950);
        } else if (selected) {
          color = _paleGreen;
          borderColor = _green;
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: _checked ? null : () => setState(() => _selected = index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                constraints: const BoxConstraints(minHeight: 58),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(color: _ink),
                      ),
                    ),
                    if (_checked && correct)
                      const Icon(Icons.check_circle, color: _green)
                    else if (_checked && selected)
                      const Icon(Icons.cancel, color: Color(0xFFD95950))
                    else if (selected)
                      const Icon(Icons.radio_button_checked, color: _green)
                    else
                      const Icon(Icons.radio_button_off, color: _muted),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      if (_checked) ...[
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _selected == _question.answerIndex
                ? _paleGreen
                : const Color(0xFFFFF3E2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            '${_selected == _question.answerIndex ? 'That’s right!' : 'Not quite.'} ${_question.explanation}',
            style: const TextStyle(color: _ink, height: 1.4, fontSize: 12),
          ),
        ),
      ],
      const SizedBox(height: 18),
      SizedBox(
        height: 50,
        child: FilledButton(
          onPressed: _savingResult
              ? null
              : _checked
              ? _nextQuestion
              : (_selected == null ? null : _checkAnswer),
          child: Text(
            _savingResult
                ? 'Saving result…'
                : _checked
                ? (_index == total - 1 ? 'See my results' : 'Next question')
                : 'Check answer',
          ),
        ),
      ),
    ],
  );

  Widget _result(int total) {
    final percent = (_score / total * 100).round();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(
                color: _paleGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                color: _green,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Great effort!',
              style: TextStyle(
                color: _ink,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You scored $_score out of $total ($percent%).',
              style: const TextStyle(color: _muted),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to course'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressPage extends StatelessWidget {
  const _ProgressPage({
    required this.enrolledCourses,
    required this.completedCount,
    required this.progressFor,
    required this.bestScore,
    required this.onOpenCourse,
  });

  final List<Course> enrolledCourses;
  final int Function(Course) completedCount;
  final double Function(Course) progressFor;
  final int? Function(Course) bestScore;
  final ValueChanged<Course> onOpenCourse;

  @override
  Widget build(BuildContext context) {
    final lessonCount = enrolledCourses.fold<int>(
      0,
      (sum, course) => sum + completedCount(course),
    );
    final completedCourses = enrolledCourses
        .where((course) => progressFor(course) >= 1)
        .length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        const Text(
          'Your progress',
          style: TextStyle(
            color: _ink,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Every lesson is a step forward. Keep it up!',
          style: TextStyle(color: _muted, fontSize: 13),
        ),
        const SizedBox(height: 19),
        Row(
          children: [
            Expanded(
              child: _ProgressStat(
                icon: Icons.menu_book_rounded,
                value: '${enrolledCourses.length}',
                label: 'Enrolled',
                color: const Color(0xFF3276D2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ProgressStat(
                icon: Icons.check_circle_outline,
                value: '$lessonCount',
                label: 'Lessons done',
                color: _green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _ProgressStat(
                icon: Icons.emoji_events_outlined,
                value: '$completedCourses',
                label: 'Completed',
                color: const Color(0xFFE2A22B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('My courses'),
        const SizedBox(height: 12),
        if (enrolledCourses.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(28),
              child: Text('Enroll in a course to see your progress here.'),
            ),
          )
        else
          ...enrolledCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  onTap: () => onOpenCourse(course),
                  borderRadius: BorderRadius.circular(18),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _CourseIcon(course: course, size: 48),
                            const SizedBox(width: 11),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.title,
                                    style: const TextStyle(
                                      color: _ink,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${completedCount(course)} of ${course.lessons.length} lessons',
                                    style: const TextStyle(
                                      color: _muted,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${(progressFor(course) * 100).round()}%',
                              style: const TextStyle(
                                color: _green,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: progressFor(course),
                          minHeight: 5,
                          borderRadius: BorderRadius.circular(5),
                          backgroundColor: const Color(0xFFEDF1EF),
                          color: _green,
                        ),
                        if (bestScore(course) != null) ...[
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Best quiz score: ${bestScore(course)}/${course.questions.length}',
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({this.user, this.onSignOut});

  final User? user;
  final Future<void> Function()? onSignOut;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
    children: [
      const Text(
        'My profile',
        style: TextStyle(
          color: _ink,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 36,
              backgroundColor: _paleGreen,
              child: Icon(Icons.person_rounded, color: _green, size: 38),
            ),
            const SizedBox(height: 12),
            Text(
              user?.displayName?.isNotEmpty == true
                  ? user!.displayName!
                  : user?.email ?? 'Guest Learner',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _ink,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? 'Learning with Internee.pk',
              style: const TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      const _SectionTitle('About the app'),
      const SizedBox(height: 10),
      const _ProfileItem(
        icon: Icons.school_outlined,
        title: 'Internee.pk Learning',
        subtitle: 'Learn practical skills, one lesson at a time.',
      ),
      const SizedBox(height: 9),
      const _ProfileItem(
        icon: Icons.cloud_outlined,
        title: 'Firebase progress sync',
        subtitle: 'Your course enrollment, completed lessons, and best quiz scores are saved to your private account.',
      ),
      if (user == null)
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            'Guest demo mode is active. Configure Firebase to enable email sign-in and cloud progress sync.',
            style: TextStyle(color: _muted, fontSize: 11, height: 1.5),
          ),
        )
      else
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: OutlinedButton.icon(
            onPressed: () async {
              try {
                await onSignOut?.call();
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not sign out: $error')),
                  );
                }
              }
            },
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Sign out'),
          ),
        ),
      const SizedBox(height: 18),
      const Text(
        'Version 1.0.0',
        textAlign: TextAlign.center,
        style: TextStyle(color: _muted, fontSize: 11),
      ),
    ],
  );
}

class _ProgressStat extends StatelessWidget {
  const _ProgressStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            color: _ink,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: _muted, fontSize: 9),
        ),
      ],
    ),
  );
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Row(
      children: [
        Icon(icon, color: _green),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _LessonTile extends StatelessWidget {
  const _LessonTile({
    required this.lesson,
    required this.number,
    required this.complete,
    required this.enabled,
    required this.onTap,
  });

  final Lesson lesson;
  final int number;
  final bool complete;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    child: ListTile(
      onTap: onTap,
      enabled: enabled,
      contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
      leading: Container(
        width: 38,
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: complete ? _paleGreen : const Color(0xFFF2F5F3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: complete
            ? const Icon(Icons.check_rounded, color: _green, size: 19)
            : Text(
                number.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: _muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
      ),
      title: Text(
        lesson.title,
        style: const TextStyle(
          color: _ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        lesson.duration,
        style: const TextStyle(color: _muted, fontSize: 10),
      ),
      trailing: Icon(
        enabled
            ? Icons.play_circle_outline_rounded
            : Icons.lock_outline_rounded,
        color: enabled ? _green : _muted,
      ),
    ),
  );
}

class _CourseIcon extends StatelessWidget {
  const _CourseIcon({required this.course, required this.size});

  final Course course;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: course.color.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(size * .28),
    ),
    child: Icon(course.icon, color: course.color, size: size * .5),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Text(
    title,
    style: const TextStyle(
      color: _ink,
      fontSize: 17,
      fontWeight: FontWeight.w800,
    ),
  );
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: _muted, size: 14),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(color: _muted, fontSize: 9)),
    ],
  );
}

class _TopicPill extends StatelessWidget {
  const _TopicPill({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _green, size: 15),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _ink,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
