import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/send_message.dart';
import '../bloc/chat_bloc.dart';

import 'modal_tile.dart';

class ChatControls extends StatefulWidget {
  @override
  _ChatControlsState createState() => _ChatControlsState();
}

class _ChatControlsState extends State<ChatControls> {
  bool isWriting = false;
  TextEditingController textFieldController = TextEditingController();
  FocusNode textFieldFocus = FocusNode();
  SendMessage sendMessageUseCase = SendMessage(GetIt.instance.get());

  @override
  Widget build(BuildContext context) {
    setWritingTo(bool val) {
      setState(() {
        isWriting = val;
      });
    }

    addMediaModal(context) {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: Color(0xff19191b),
          builder: (context) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[
                      ElevatedButton(
                        child: Icon(
                          Icons.close,
                        ),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Content and tools",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      ModalTile(
                          title: "Media",
                          subtitle: "Share Photos and Video",
                          icon: Icons.image,
                          onTap: () =>
                              {} //pickImage(source: ImageSource.gallery),
                          ),
                      ModalTile(
                        title: "File",
                        subtitle: "Share files",
                        icon: Icons.tab,
                      ),
                      ModalTile(
                        title: "Contact",
                        subtitle: "Share contacts",
                        icon: Icons.contacts,
                      ),
                      ModalTile(
                        title: "Location",
                        subtitle: "Share a location",
                        icon: Icons.add_location,
                      ),
                      ModalTile(
                        title: "Schedule Call",
                        subtitle: "Arrange a skype call and get reminders",
                        icon: Icons.schedule,
                      ),
                      ModalTile(
                        title: "Create Poll",
                        subtitle: "Share polls",
                        icon: Icons.poll,
                      )
                    ],
                  ),
                ),
              ],
            );
          });
    }

    sendMessage() {
      var text = textFieldController.text;

      Message _message = Message(
          receiverUID: "2",
          senderUID: "1",
          text: text,
          date: Timestamp.now(),
          type: 'text',
          photoURL: "");

      setState(() {
        isWriting = false;
      });

      textFieldController.text = "";

      sendMessageUseCase(
          SendMessageParams(conversationID: "21", message: _message));

      // dispatchSendMessageEvent(
      //     context: context, conversationID: "21", message: _message);
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => addMediaModal(context),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff00b6f3), Color(0xff0184dc)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: textFieldController,
                  focusNode: textFieldFocus,
                  onTap: () => {}, //hideEmojiContainer(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != "")
                        ? setWritingTo(true)
                        : setWritingTo(false);
                  },
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(
                      color: Color(0xff8f8f8f),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(50.0),
                        ),
                        borderSide: BorderSide.none),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    filled: true,
                    fillColor: Color(0xff272c35),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    /*
                  if (!showEmojiPicker) {
                    // keyboard is visible
                    //  hideKeyboard();
                    //  showEmojiContainer();
                  } else {
                    //keyboard is hidden
                    // showKeyboard();
                    // hideEmojiContainer();
                  }
                  */
                  },
                  icon: Icon(Icons.face),
                ),
              ],
            ),
          ),
          isWriting
              ? Container()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.record_voice_over),
                ),
          isWriting
              ? Container()
              : GestureDetector(
                  child: Icon(Icons.camera_alt),
                  onTap: () => {} // pickImage(source: ImageSource.camera),
                  ),
          isWriting
              ? Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xff00b6f3), Color(0xff0184dc)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 15,
                    ),
                    onPressed: () => sendMessage(),
                  ))
              : Container()
        ],
      ),
    );
  }
}

/*
void pickImage({@required ImageSource source}) async {
  File selectedImage = await Utils.pickImage(source: source);
  _storageMethods.uploadImage(
      image: selectedImage,
      receiverId: widget.receiver.uid,
      senderId: _currentUserId,
      imageUploadProvider: _imageUploadProvider);
}
*/
