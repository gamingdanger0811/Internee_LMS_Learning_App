import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  const FirebaseConfig._();

  static const apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const webAppId = String.fromEnvironment('FIREBASE_WEB_APP_ID');
  static const androidAppId = String.fromEnvironment('FIREBASE_ANDROID_APP_ID');
  static const iosAppId = String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static const messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const authDomain = String.fromEnvironment('FIREBASE_AUTH_DOMAIN');
  static const storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );

  static String get _currentAppId {
    if (kIsWeb) return webAppId;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => androidAppId,
      TargetPlatform.iOS => iosAppId,
      _ => '',
    };
  }

  static bool get isConfigured =>
      apiKey.isNotEmpty &&
      projectId.isNotEmpty &&
      messagingSenderId.isNotEmpty &&
      _currentAppId.isNotEmpty;

  static bool get hasPartialConfiguration =>
      apiKey.isNotEmpty ||
      projectId.isNotEmpty ||
      webAppId.isNotEmpty ||
      androidAppId.isNotEmpty ||
      iosAppId.isNotEmpty ||
      messagingSenderId.isNotEmpty;

  static FirebaseOptions get options {
    if (!isConfigured) {
      throw StateError('Firebase configuration is incomplete.');
    }
    if (_currentAppId.isEmpty) {
      throw UnsupportedError(
        'Firebase is configured here for Android, iOS, and web only.',
      );
    }

    return FirebaseOptions(
      apiKey: apiKey,
      appId: _currentAppId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      authDomain: authDomain.isEmpty
          ? '$projectId.firebaseapp.com'
          : authDomain,
      storageBucket: storageBucket.isEmpty
          ? '$projectId.firebasestorage.app'
          : storageBucket,
    );
  }
}

class FirebaseProgressRepository {
  FirebaseProgressRepository(this.userId)
    : _progress = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('courseProgress');

  final String userId;
  final CollectionReference<Map<String, dynamic>> _progress;

  Future<Map<String, Map<String, Object>>> loadAll() async {
    final snapshot = await _progress.get();
    return {
      for (final document in snapshot.docs)
        document.id: _parseProgress(document.data()),
    };
  }

  Future<void> enroll(String courseId) async {
    final reference = _progress.doc(courseId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      final data = snapshot.data();
      transaction.set(reference, {
        'enrolled': true,
        'completedLessonIds': _completedIds(data?['completedLessonIds']),
        'bestQuizScore': _score(data?['bestQuizScore']),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> completeLesson(String courseId, String lessonId) async {
    final reference = _progress.doc(courseId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      final data = snapshot.data();
      final lessonIds = _completedIds(data?['completedLessonIds']);
      if (!lessonIds.contains(lessonId)) lessonIds.add(lessonId);
      transaction.set(reference, {
        'enrolled': true,
        'completedLessonIds': lessonIds,
        'bestQuizScore': _score(data?['bestQuizScore']),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> saveQuizScore(String courseId, int score) async {
    final reference = _progress.doc(courseId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      final data = snapshot.data();
      final existing = _score(data?['bestQuizScore']);
      final bestScore = existing > score ? existing : score;
      transaction.set(reference, {
        'enrolled': true,
        'completedLessonIds': _completedIds(data?['completedLessonIds']),
        'bestQuizScore': bestScore,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  Map<String, Object> _parseProgress(Map<String, dynamic> data) {
    return {
      'enrolled': data['enrolled'] == true,
      'completedLessonIds': _completedIds(data['completedLessonIds']),
      'bestQuizScore': _score(data['bestQuizScore']),
    };
  }

  List<String> _completedIds(Object? value) {
    if (value == null) return <String>[];
    if (value is! List || value.any((item) => item is! String)) {
      throw const FormatException(
        'A saved course progress record has invalid lesson data.',
      );
    }
    return value.cast<String>().toSet().toList();
  }

  int _score(Object? value) {
    if (value == null) return 0;
    if (value is! int || value < 0 || value > 100) {
      throw const FormatException(
        'A saved course progress record has an invalid quiz score.',
      );
    }
    return value;
  }
}
