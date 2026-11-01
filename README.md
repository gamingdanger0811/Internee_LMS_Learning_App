# Internee.pk LMS Learning App

Flutter learning app with a sample course catalog, lesson video player, quizzes, learner progress, Firebase Authentication, and Cloud Firestore progress sync.

## What works

- Search and browse courses by topic.
- Create an account, sign in, reset a password, and sign out with Firebase email/password authentication.
- Enroll and track completed lessons and best quiz scores in a private Firestore record for the signed-in user.
- Watch topic-matched public YouTube lessons in the embedded player, take quizzes, and view progress. Video playback requires an internet connection.
- Run in guest demo mode without Firebase configuration.

The existing Firebase project has Android, iOS, and web app registrations, and Email/Password sign-in is enabled. Its Firestore database is provisioned in Mumbai (`asia-south1`) with the checked-in per-user security rules published. The local, git-ignored `firebase.env.json` contains the public Firebase client configuration for those apps.

The course catalog, course descriptions, lessons, and quiz questions are still sample content. Lesson videos link to public YouTube tutorials selected for the demo topics; they are not Internee.pk course videos and require network access. Firebase saves learner accounts and course progress; it does not connect to Internee.pk's LMS API. The LMS API base URL, authentication contract, and response schemas are required to replace the sample catalog and quiz content with live platform data.

## Connect your Firebase project

1. Select the existing Firebase project in the [Firebase Console](https://console.firebase.google.com/). Its Firestore database and security rules are already configured.
2. To publish rule changes later, install and sign in to the Firebase CLI if needed (`npm install -g firebase-tools`, then `firebase login`), and run:

   ```powershell
   firebase deploy --only firestore:rules --project internee-80c85
   ```

3. Run the app with its already-created local config file:

   ```powershell
   flutter pub get
   flutter run -d chrome --dart-define-from-file=firebase.env.json
   ```

   For Android, replace `chrome` with your connected device ID. Firebase is configured in this app for Android, iOS, and web.

The app writes progress to `users/{uid}/courseProgress/{courseId}`. The checked-in [firestore.rules](./firestore.rules) limits each signed-in learner to their own progress documents and is published to the configured project.

## Run and verify without Firebase

With no Firebase define values, the app opens in guest demo mode:

```powershell
flutter pub get
flutter run
flutter analyze
flutter test
```

In demo mode, progress is only held in memory and resets when the app restarts.
