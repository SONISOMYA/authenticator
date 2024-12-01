// // ignore_for_file: avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flex_color_picker/flex_color_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:authenticator/utils.dart';
// import 'package:intl/intl.dart';
// import 'package:uuid/uuid.dart';

// class AddNewTask extends StatefulWidget {
//   const AddNewTask({super.key});

//   @override
//   State<AddNewTask> createState() => _AddNewTaskState();
// }

// class _AddNewTaskState extends State<AddNewTask> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//   Color _selectedColor = Colors.blue;

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   Future<void> uploadTaskToDb() async {
//     try {
//       final id = const Uuid().v4();

//       await FirebaseFirestore.instance.collection("tasks").doc(id).set({
//         "title": titleController.text.trim(),
//         "description": descriptionController.text.trim(),
//         "date": selectedDate,
//         "creator": FirebaseAuth.instance.currentUser!.uid,
//         "postedAt": FieldValue.serverTimestamp(),
//         "color": rgbToHex(_selectedColor),
//         "completed": false, // Set completed field to false by default
//       });
//       print("Task created with ID: $id");
//     } catch (e) {
//       print("Error uploading task: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add New Task'),
//         actions: [
//           GestureDetector(
//             onTap: () async {
//               final selDate = await showDatePicker(
//                 context: context,
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime.now().add(
//                   const Duration(days: 90),
//                 ),
//               );
//               if (selDate != null) {
//                 setState(() {
//                   selectedDate = selDate;
//                 });
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 DateFormat('MM-d-y').format(selectedDate),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: titleController,
//                 decoration: const InputDecoration(
//                   hintText: 'Title',
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(
//                   hintText: 'Description',
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 10),
//               ColorPicker(
//                 pickersEnabled: const {
//                   ColorPickerType.wheel: true,
//                 },
//                 color: _selectedColor,
//                 onColorChanged: (Color color) {
//                   setState(() {
//                     _selectedColor = color;
//                   });
//                 },
//                 heading: const Text('Select color'),
//                 subheading: const Text('Select a different shade'),
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () async {
//                   await uploadTaskToDb();
//                   // ignore: use_build_context_synchronously
//                   Navigator.pop(context); // Return to the previous screen
//                 },
//                 child: const Text(
//                   'SUBMIT',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authenticator/utils.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Color _selectedColor = Colors.blue;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> uploadTaskToDb() async {
    try {
      // Check if title and description are not empty
      if (titleController.text.trim().isEmpty ||
          descriptionController.text.trim().isEmpty) {
        print("Error: Title or Description cannot be empty");
        // Show an error message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Title or Description cannot be empty'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Prevent task from being added if fields are empty
      }

      // Ensure a valid date is selected (not today's date or earlier)

      final id = const Uuid().v4();

      await FirebaseFirestore.instance.collection("tasks").doc(id).set({
        "title": titleController.text.trim(),
        "description": descriptionController.text.trim(),
        "date": selectedDate,
        "creator": FirebaseAuth.instance.currentUser!.uid,
        "postedAt": FieldValue.serverTimestamp(),
        "color": rgbToHex(_selectedColor),
        "completed": false, // Set completed field to false by default
      });
      print("Task created with ID: $id");
      // Show a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Task added successfully!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Return to the previous screen
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error uploading task: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        actions: [
          GestureDetector(
            onTap: () async {
              final selDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  const Duration(days: 90),
                ),
              );
              if (selDate != null) {
                setState(() {
                  selectedDate = selDate;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('MM-d-y').format(selectedDate),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ColorPicker(
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                },
                color: _selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                heading: const Text('Select color'),
                subheading: const Text('Select a different shade'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await uploadTaskToDb();
                },
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
