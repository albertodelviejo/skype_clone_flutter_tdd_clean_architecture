import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/data/datasources/chat_data_source.dart';
import 'package:skype_clone_flutter_tdd_clean_architecture/features/chat/domain/entities/message.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  MockFirebaseFirestore mockFirebaseFirestore;
  ChatDataSourceImpl dataSource;
  DocumentReference docRef;
  Message message;

  setUp(() {
    mockFirebaseFirestore = FirebaseFirestore.instance;
    dataSource = ChatDataSourceImpl(firebase: mockFirebaseFirestore);
    message = Message(
        date: Timestamp.now(),
        text: "test",
        senderUID: "test",
        receiverUID: "test",
        type: "text",
        photoURL: "asdafasf");
  });

  group('GetConversation', () {
    test('''should perform a request to Firestore succesfully''', () {
      when(mockFirebaseFirestore
              .collection("conversations")
              .doc("vqBeHp4tY5YnLgenlBkD"))
          .thenAnswer((_) => docRef);
    });
  });

  group('SendMessage', () {
    test('''should perform a request to Firestore succesfully''', () {
      when(mockFirebaseFirestore
              .collection("conversations")
              .doc("vqBeHp4tY5YnLgenlBkD"))
          .thenAnswer((_) => docRef);
    });

    test("should return true if the Message is added correctly to Firebase",
        () async {
      when(mockFirebaseFirestore
              .collection("conversations")
              .doc("vqBeHp4tY5YnLgenlBkD"))
          .thenAnswer((_) => docRef);

      final result = await dataSource.sendMessage(
          "vqBeHp4tY5YnLgenlBkD", "1", "2", message);

      expect(result, equals(true));
    });
  });
}
