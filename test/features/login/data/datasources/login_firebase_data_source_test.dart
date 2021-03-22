import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/data/datasources/firebase_auth_remote_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/auth/domain/entities/user_app.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockAuthResult extends Mock implements UserCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebaseAuthRemoteDataSourceImpl dataSource;

  MockFirebaseUser firebaseUser;
  MockAuthResult mockAuthResult;
  MockFirebaseAuth mockFirebaseAuth;

  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication gSA;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  setUp(() async {
    await Firebase.initializeApp();
    googleSignInAccount = await googleSignIn.signIn();
    gSA = await googleSignInAccount.authentication;

    firebaseUser = MockFirebaseUser();
    mockFirebaseAuth = MockFirebaseAuth();
    mockAuthResult = MockAuthResult();

    dataSource = FirebaseAuthRemoteDataSourceImpl(auth: mockFirebaseAuth);
  });

  group('Login in repository', () {
    test('should return user when login on Firebase', () async {
      when(mockFirebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
              idToken: gSA.idToken, accessToken: gSA.accessToken)))
          .thenAnswer((_) async => Future.value(mockAuthResult));

      UserApp userResult = await dataSource.loginUserInFirebase();

      expect(userResult, mockAuthResult.user);
    });
  });

  group('Logout from repository', () {
    test('should return true when logout succesfully', () async {
      when(mockFirebaseAuth.signOut())
          .thenAnswer((_) async => Future.value(true));

      final result = await dataSource.logoutUserInFirebase();

      expect(result, true);
    });
  });
}
