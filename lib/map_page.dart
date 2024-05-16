// // import 'dart:io';
// // import 'dart:typed_data';

// // import 'package:dash_chat_2/dash_chat_2.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_gemini/flutter_gemini.dart';
// // import 'package:image_picker/image_picker.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({super.key});

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final Gemini gemini = Gemini.instance;

// //   List<ChatMessage> messages = [];

// //   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
// //   ChatUser geminiUser = ChatUser(
// //     id: "1",
// //     firstName: "Gemini",
// //     profileImage: NetworkImage(
// //       "https://bulksignature.com/wp-content/uploads/2024/02/Frame-876-1024x569.png",
// //       scale: 1.0,

// //     ).toString(),
        
// //   );
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: const Text(
// //           "Gemini Chat",
// //         ),
// //       ),
// //       body: _buildUI(),
// //     );
// //   }

// //   Widget _buildUI() {
// //     return DashChat(
// //       inputOptions: InputOptions(trailing: [
// //         IconButton(
// //           onPressed: _sendMediaMessage,
// //           icon: const Icon(
// //             Icons.image,
// //           ),
// //         )
// //       ]),
// //       currentUser: currentUser,
// //       onSend: _sendMessage,
// //       messages: messages,
// //     );
// //   }

// //   void _sendMessage(ChatMessage chatMessage) {
// //     setState(() {
// //       messages = [chatMessage, ...messages];
// //     });
// //     try {
// //       String question = chatMessage.text;
// //       List<Uint8List>? images;
// //       if (chatMessage.medias?.isNotEmpty ?? false) {
// //         images = [
// //           File(chatMessage.medias!.first.url).readAsBytesSync(),
// //         ];
// //       }
// //       gemini
// //           .streamGenerateContent(
// //         question,
// //         images: images,
// //       )
// //           .listen((event) {
// //         ChatMessage? lastMessage = messages.firstOrNull;
// //         if (lastMessage != null && lastMessage.user == geminiUser) {
// //           lastMessage = messages.removeAt(0);
// //           String response = event.content?.parts?.fold(
// //                   "", (previous, current) => "$previous ${current.text}") ??
// //               "";
// //           lastMessage.text += response;
// //           setState(
// //             () {
// //               messages = [lastMessage!, ...messages];
// //             },
// //           );
// //         } else {
// //           String response = event.content?.parts?.fold(
// //                   "", (previous, current) => "$previous ${current.text}") ??
// //               "";
// //           ChatMessage message = ChatMessage(
// //             user: geminiUser,
// //             createdAt: DateTime.now(),
// //             text: response,
// //           );
// //           setState(() {
// //             messages = [message, ...messages];
// //           });
// //         }
// //       });
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   void _sendMediaMessage() async {
// //     ImagePicker picker = ImagePicker();
// //     XFile? file = await picker.pickImage(
// //       source: ImageSource.gallery,
// //     );
// //     if (file != null) {
// //       ChatMessage chatMessage = ChatMessage(
// //         user: currentUser,
// //         createdAt: DateTime.now(),
// //         text: "Describe this picture?",
// //         medias: [
// //           ChatMedia(
// //             url: file.path,
// //             fileName: "",
// //             type: MediaType.image,
// //           )
// //         ],
// //       );
// //       _sendMessage(chatMessage);
// //     }
// //   }
// // }



// //=======================================WORKING================================================================================




// import 'dart:io';
// import 'dart:typed_data';

// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final Gemini gemini = Gemini.instance;

//   List<ChatMessage> messages = [];

//   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage: NetworkImage(
//       "https://bulksignature.com/wp-content/uploads/2024/02/Frame-876-1024x569.png",
//       scale: 1.0,
//     ).toString(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "Tiny Pulse",
//         ),
//       ),
//       body: _buildUI(),
//     );
//   }

//   Widget _buildUI() {
//     return DashChat(
//       inputOptions: InputOptions(trailing: [
//         IconButton(
//           onPressed: _sendMediaMessage,
//           icon: const Icon(
//             Icons.image,
//           ),
//         )
//       ]),
//       currentUser: currentUser,
//       onSend: _sendMessage,
//       messages: messages,
//     );
//   }

//   void _sendMessage(ChatMessage chatMessage) async {
//     setState(() {
//       messages = [chatMessage, ...messages];
//     });
//     try {
//       String question = chatMessage.text;
//       List<Uint8List>? images;
//       if (chatMessage.medias?.isNotEmpty ?? false) {
//         images = [
//           File(chatMessage.medias!.first.url).readAsBytesSync(),
//         ];
//       }

//       // Check if the user's message is "show nearby doctors"
//       if (question.toLowerCase().contains('nearme')|| question.toLowerCase().contains('nearby')) {
//         print("HI");

//         // Fetch the current location
//         Position position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high);
//         double currentLatitude = position.latitude;
//         double currentLongitude = position.longitude;
//         print("currentLatitude: $currentLatitude, currentLongitude: $currentLongitude");


//         // Append current location to the user's message
//         question +=
//             ' My current latitude is $currentLatitude and longitude is $currentLongitude';
//       }

//       gemini.streamGenerateContent(
//         question,
//         images: images,
//       ).listen((event) {
//         // Handle Gemini response
//         String response = event.content?.parts?.fold(
//                 "", (previous, current) => "$previous ${current.text}") ??
//             "";
//         ChatMessage message = ChatMessage(
//           user: geminiUser,
//           createdAt: DateTime.now(),
//           text: response,
//         );
//         setState(() {
//           messages = [message, ...messages];
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _sendMediaMessage() async {
//     ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (file != null) {
//       ChatMessage chatMessage = ChatMessage(
//         user: currentUser,
//         createdAt: DateTime.now(),
//         text: "Describe this picture?",
//         medias: [
//           ChatMedia(
//             url: file.path,
//             fileName: "",
//             type: MediaType.image,
//           )
//         ],
//       );
//       _sendMessage(chatMessage);
//     }
//   }
// }


// //=====================================================PRE FINAL====================================================

// // import 'dart:typed_data';

// // import 'package:dash_chat_2/dash_chat_2.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_gemini/flutter_gemini.dart';
// // import 'package:image_picker/image_picker.dart';

// // class HomePage extends StatefulWidget {
// //   const HomePage({Key? key}) : super(key: key);

// //   @override
// //   State<HomePage> createState() => _HomePageState();
// // }

// // class _HomePageState extends State<HomePage> {
// //   final Gemini gemini = Gemini.instance;

// //   List<ChatMessage> messages = [];

// //   ChatUser currentUser = ChatUser(id: "0", firstName: "User");
// //   ChatUser geminiUser = ChatUser(
// //     id: "1",
// //     firstName: "Kiddo Care",
// //     profileImage: NetworkImage(
// //       "https://www.shutterstock.com/image-vector/chat-bot-logo-design-concept-600nw-1938811039.jpg",
// //       scale: 1.0,
// //     ).toString(),
// //   );

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Add initial message to the list
// //     ChatMessage initialMessage = ChatMessage(
// //       user: geminiUser,
// //       createdAt: DateTime.now(),
// //       text: "Hi, I'm your Tiny Pulse, your baby's Care bot. How is your child's health?",
// //     );
// //     messages.add(initialMessage);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: const Text(
// //           "T  I  N  Y        P  U   L   S   E",
// //         ),
// //       ),
// //       body: _buildUI(),
// //       backgroundColor: Colors.black, 
      
// //     );
// //   }

// //   Widget _buildUI() {
// //     return DashChat(
// //       inputOptions: InputOptions(trailing: [
// //         IconButton(
// //           onPressed: _sendMediaMessage,
// //           icon: const Icon(
// //             Icons.image,
// //           ),
// //         )
// //       ]),
// //       currentUser: currentUser,
// //       onSend: _sendMessage,
// //       messages: messages,
// //     );
// //   }

// //   void _sendMessage(ChatMessage chatMessage) async {
// //     setState(() {
// //       messages = [chatMessage, ...messages];
// //     });
// //     try {
// //       String question = chatMessage.text;
// //       List<Uint8List>? images = [];

// //       gemini.streamGenerateContent(
// //         question,
// //         images: images,
// //       ).listen((event) {
// //         String response = event.content?.parts?.fold(
// //                 "", (previous, current) => "$previous ${current.text}") ??
// //             "";
// //         ChatMessage message = ChatMessage(
// //           user: geminiUser,
// //           createdAt: DateTime.now(),
// //           text: response,
// //         );
// //         setState(() {
// //           messages = [message, ...messages];
// //         });
// //       });
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   Future<void> _sendMediaMessage() async {
// //     ImagePicker picker = ImagePicker();
// //     XFile? file = await picker.pickImage(
// //       source: ImageSource.gallery,
// //     );
// //     if (file != null) {
// //       // Prompt user for text input
// //       String? messageText = await _promptForMessage();

// //       if (messageText != null && messageText.isNotEmpty) {
// //         try {
// //           // Read the bytes of the image file
// //           Uint8List imageBytes = await file.readAsBytes();

// //           // Send image and text to Gemini
// //           gemini.streamGenerateContent(
// //             messageText,
// //             images: [imageBytes],
// //           ).listen((event) {
// //             // Handle Gemini response
// //             String response = event.content?.parts?.fold(
// //                     "", (previous, current) => "$previous ${current.text}") ??
// //                 "";
// //             ChatMessage message = ChatMessage(
// //               user: geminiUser,
// //               createdAt: DateTime.now(),
// //               text: response,
// //             );
// //             setState(() {
// //               messages = [message, ...messages];
// //             });
// //           });
// //         } catch (e) {
// //           print(e);
// //         }
// //       }
// //     }
// //   }

// //   Future<String?> _promptForMessage() {
// //     TextEditingController messageController = TextEditingController();
// //     return showDialog<String>(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Wanna describe this?"),
// //           content: TextField(
// //             controller: messageController,
// //             decoration: InputDecoration(hintText: "Enter your message..."),
// //           ),
// //           actions: <Widget>[
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(messageController.text);
// //               },
// //               child: Text("Send"),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop(null); // Return null if canceled
// //               },
// //               child: Text("Cancel"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }


import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final String geminiApiKey = 'AIzaSyDv_W1mC1CnvmNuUnPoynVCZw9bNLjcXqM'; // Your Gemini API key

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage: NetworkImage(
      "https://bulksignature.com/wp-content/uploads/2024/02/Frame-876-1024x569.png",
      scale: 1.0,
    ).toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tiny Pulse"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  void _sendMessage(ChatMessage chatMessage) async {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;

      if (question.toLowerCase().contains('nearme') ||
          question.toLowerCase().contains('nearby')) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double currentLatitude = position.latitude;
        double currentLongitude = position.longitude;

        question +=
            ' My current latitude is $currentLatitude and longitude is $currentLongitude';
      }

      final gemini = Gemini.instance;
      await gemini.init(geminiApiKey); // Initialize Gemini with the API key
      gemini.streamGenerateContent(
        question,
        images: images,
      ).listen((event) {
        String response = event.content?.parts?.fold(
                "", (previous, current) => "$previous ${current.text}") ??
            "";
        ChatMessage message = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );
        setState(() {
          messages = [message, ...messages];
        });
      });
    } catch (e) {
      print(e);
    }
  }
}
