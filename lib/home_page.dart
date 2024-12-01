// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:authenticator/add_new_task.dart';
// import 'package:authenticator/utils.dart';
// import 'package:authenticator/widgets/dateselector.dart';
// import 'package:authenticator/widgets/task_card.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   DateTime selectedDate = DateTime.now(); // Selected date for filtering tasks

//   // Function to update the selected date when user selects a date
//   void updateSelectedDate(DateTime newDate) {
//     setState(() {
//       selectedDate = newDate;
//     });
//   }

//   // Function to compare date parts (ignoring the time)
//   bool isSameDate(DateTime taskDate, DateTime selectedDate) {
//     return taskDate.year == selectedDate.year &&
//         taskDate.month == selectedDate.month &&
//         taskDate.day == selectedDate.day;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Tasks'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const AddNewTask(),
//                 ),
//               );
//             },
//             icon: const Icon(
//               CupertinoIcons.add,
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             DateSelector(
//               onDateSelected: updateSelectedDate, // Pass the function here
//             ),
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("tasks")
//                   .where('creator',
//                       isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Text('No tasks for this date.');
//                 }

//                 // Filter tasks based on the selected date (ignoring time)
//                 final filteredTasks = snapshot.data!.docs.where((taskDoc) {
//                   // Convert the Firestore timestamp to DateTime
//                   Timestamp taskTimestamp = taskDoc['date'];
//                   DateTime taskDate = taskTimestamp.toDate();

//                   // Check if the task date is the same as the selected date
//                   return isSameDate(taskDate, selectedDate);
//                 }).toList();

//                 if (filteredTasks.isEmpty) {
//                   return const Text('No tasks for this date.');
//                 }

//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: filteredTasks.length,
//                     itemBuilder: (context, index) {
//                       final taskDoc = filteredTasks[index];
//                       return Dismissible(
//                         key: Key(taskDoc.id),
//                         onDismissed: (direction) async {
//                           // Delete the task from Firestore when swiped away
//                           await FirebaseFirestore.instance
//                               .collection('tasks')
//                               .doc(taskDoc.id)
//                               .delete();
//                           // ignore: use_build_context_synchronously
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('Task deleted successfully'),
//                             ),
//                           );
//                         },
//                         direction: DismissDirection.endToStart,
//                         background: Container(
//                           color: Colors.red,
//                           child: const Icon(Icons.delete, color: Colors.white),
//                         ),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TaskCard(
//                                 color: hexToColor(taskDoc['color']),
//                                 headerText: taskDoc['title'],
//                                 descriptionText: taskDoc['description'],
//                                 scheduledDate: taskDoc['date'].toString(),
//                                 taskId: taskDoc.id, // Pass taskId here
//                                 isCompleted: taskDoc[
//                                     'completed'], // Pass isCompleted here
//                                 onMarkAsDone: () async {
//                                   // Toggle the "completed" field for this task
//                                   await FirebaseFirestore.instance
//                                       .collection('tasks')
//                                       .doc(taskDoc.id)
//                                       .update({
//                                     'completed': !taskDoc['completed'],
//                                   });
//                                 },
//                                 onDelete: () {},
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: Text(
//                                 '10:00AM', // You can replace with actual task time
//                                 style: TextStyle(fontSize: 17),
//                               ),
//                             )
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:authenticator/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:authenticator/add_new_task.dart';
import 'package:authenticator/utils.dart';
import 'package:authenticator/widgets/dateselector.dart';
import 'package:authenticator/widgets/task_card.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now(); // Selected date for filtering tasks

  // Function to update the selected date when user selects a date
  void updateSelectedDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  // Function to compare date parts (ignoring the time)
  bool isSameDate(DateTime taskDate, DateTime selectedDate) {
    return taskDate.year == selectedDate.year &&
        taskDate.month == selectedDate.month &&
        taskDate.day == selectedDate.day;
  }

  // Function to logout the user
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    // After logging out, navigate to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          // Logout Button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout, // Logout function
          ),
          // Add New Task Button
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNewTask(),
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.add,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            DateSelector(
              onDateSelected: updateSelectedDate, // Pass the function here
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("tasks")
                  .where('creator',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No tasks for this date.');
                }

                // Filter tasks based on the selected date (ignoring time)
                final filteredTasks = snapshot.data!.docs.where((taskDoc) {
                  // Convert the Firestore timestamp to DateTime
                  Timestamp taskTimestamp = taskDoc['date'];
                  DateTime taskDate = taskTimestamp.toDate();

                  // Check if the task date is the same as the selected date
                  return isSameDate(taskDate, selectedDate);
                }).toList();

                if (filteredTasks.isEmpty) {
                  return const Text('No tasks for this date.');
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final taskDoc = filteredTasks[index];
                      // Get the task's postedAt timestamp and format it
                      Timestamp postedAtTimestamp = taskDoc['postedAt'];
                      DateTime postedAtDate = postedAtTimestamp.toDate();
                      String formattedTime =
                          DateFormat('h:mm a').format(postedAtDate);

                      return Dismissible(
                        key: Key(taskDoc.id),
                        onDismissed: (direction) async {
                          // Delete the task from Firestore when swiped away
                          await FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(taskDoc.id)
                              .delete();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Task deleted successfully'),
                            ),
                          );
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TaskCard(
                                color: hexToColor(taskDoc['color']),
                                headerText: taskDoc['title'],
                                descriptionText: taskDoc['description'],
                                scheduledDate: taskDoc['date'].toString(),
                                taskId: taskDoc.id, // Pass taskId here
                                isCompleted: taskDoc[
                                    'completed'], // Pass isCompleted here
                                onMarkAsDone: () async {
                                  // Toggle the "completed" field for this task
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc(taskDoc.id)
                                      .update({
                                    'completed': !taskDoc['completed'],
                                  });
                                },
                                onDelete: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                formattedTime, // Display the formatted time here
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
