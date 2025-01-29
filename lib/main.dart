// // import 'package:flutter/material.dart';
// // import 'package:qr_flutter/qr_flutter.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Retail ID WhatsApp Integration',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: WhatsAppIntegrationScreen(),
// //     );
// //   }
// // }

// // class WhatsAppIntegrationScreen extends StatefulWidget {
// //   @override
// //   _WhatsAppIntegrationScreenState createState() =>
// //       _WhatsAppIntegrationScreenState();
// // }

// // class _WhatsAppIntegrationScreenState extends State<WhatsAppIntegrationScreen> {
// //   final String qrCodeData = "https://web.whatsapp.com"; // QR Code data for WhatsApp
// //   final String customerPhone = "+919995451324"; // Replace with the customer's phone number
// //   final String invoiceMessage =
// //       "Dear Customer, here is your invoice: \nInvoice Number: 12345 \nAmount: 100"; // Replace with dynamic invoice details

// //   Future<void> sendWhatsAppMessage() async {
// //     final whatsappUrl =
// //         "https://wa.me/$customerPhone?text=${Uri.encodeComponent(invoiceMessage)}";

// //     if (await canLaunch(whatsappUrl)) {
// //       await launch(whatsappUrl);
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Could not open WhatsApp')),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('WhatsApp Invoice Integration'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Scan this QR code with your WhatsApp to link your device:',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 20),
// //             QrImageView(
// //               data: qrCodeData,
// //               size: 200,
// //               version: QrVersions.auto,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () => sendWhatsAppMessage(),
// //               child: Text('Send Invoice via WhatsApp'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'dart:convert'; // For JSON encoding
// import 'package:http/http.dart' as http; // For API requests

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Retail ID WhatsApp Integration',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: WhatsAppIntegrationScreen(),
//     );
//   }
// }

// class WhatsAppIntegrationScreen extends StatefulWidget {
//   @override
//   _WhatsAppIntegrationScreenState createState() =>
//       _WhatsAppIntegrationScreenState();
// }

// class _WhatsAppIntegrationScreenState extends State<WhatsAppIntegrationScreen> {
//   final String customerPhone = "+919995451324"; // Replace with the customer's phone number
//   final String invoiceMessage =
//       "Dear Customer, here is your invoice: \nInvoice Number: 12345 \nAmount: 100"; // Replace with dynamic invoice details

//   final String apiUrl = "https://your-whatsapp-business-api-endpoint/messages"; // Replace with your API endpoint
//   final String bearerToken = "your-bearer-token"; // Replace with your API token

//   Future<void> sendWhatsAppMessage() async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $bearerToken",
//         },
//         body: jsonEncode({
//           "to": customerPhone,
//           "type": "text",
//           "text": {"body": invoiceMessage},
//         }),
//       );

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Message sent successfully!')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to send message: ${response.body}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WhatsApp Invoice Integration'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Click the button below to send an invoice via WhatsApp.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => sendWhatsAppMessage(),
//               child: Text('Send Invoice via WhatsApp'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> users = [];
//   bool isOffline = false;
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//     _getCurrentLocation();
//   }

//   // Request current GPS location
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Handle error if location services are not enabled
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       // Handle case where permission is permanently denied
//       return;
//     }

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     if (permission == LocationPermission.granted) {
//       _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     }
//   }

//   Future<void> fetchUsers() async {
//     try {
//       final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

//       if (response.statusCode == 200) {
//         final List<dynamic> onlineUsers = jsonDecode(response.body);

//         setState(() {
//           users = onlineUsers.map((user) {
//             return {
//               'name': user['name'],
//               'email': user['email'],
//               'latitude': user['address']['geo']['lat'],
//               'longitude': user['address']['geo']['lng'],
//               'phone': user['phone'],
//             };
//           }).toList();
//           isOffline = false;
//         });

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('users', jsonEncode(users));
//       }
//     } catch (e) {
//       // Fetch from local storage if offline
//       final prefs = await SharedPreferences.getInstance();
//       final storedUsers = prefs.getString('users');

//       if (storedUsers != null) {
//         setState(() {
//           users = List<Map<String, dynamic>>.from(jsonDecode(storedUsers));
//           isOffline = true;
//         });
//       }
//     }
//   }

//   double _calculateDistance(double lat1, double lon1) {
//     if (_currentPosition == null) return 0.0;

//     return Geolocator.distanceBetween(
//       lat1,
//       lon1,
//       _currentPosition!.latitude,
//       _currentPosition!.longitude,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//       ),
//       body: users.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 double distance = _calculateDistance(user['latitude'], user['longitude']);
//                 return Card(
//                   child: ListTile(
//                     title: Text(user['name']),
//                     subtitle: Text(user['email']),
//                     trailing: Text('${user['latitude']}, ${user['longitude']} \nDistance: ${distance.toStringAsFixed(2)} m'),
//                     onTap: () async {
//                       final todos = await fetchTodos(user['name']);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UserDetailsScreen(
//                             user: user,
//                             todos: todos,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   // Fetch to-dos based on user name
//   Future<List<Map<String, dynamic>>> fetchTodos(String userName) async {
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
//     final List<dynamic> todos = jsonDecode(response.body);
//     final filteredTodos = todos.where((todo) {
//       return todo['title'].contains(userName); // Filter to-dos by userId or name (mocked as name here)
//     }).toList();

//     return filteredTodos.map((todo) {
//       return {
//         'title': todo['title'],
//         'completed': todo['completed'],
//       };
//     }).toList();
//   }
// }

// class UserDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> user;
//   final List<Map<String, dynamic>> todos;

//   const UserDetailsScreen({Key? key, required this.user, required this.todos}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${user['name']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text('Email: ${user['email']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text('Phone: ${user['phone']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             const Text('To-Dos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             if (todos.isEmpty)
//               const Text('No To-Dos available.')
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: todos.length,
//                 itemBuilder: (context, index) {
//                   final todo = todos[index];
//                   return ListTile(
//                     title: Text(todo['title']),
//                     trailing: Icon(
//                       todo['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
//                       color: todo['completed'] ? Colors.green : Colors.red,
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> users = [];
  bool isOffline = false;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _requestPermissionAndGetLocation();
  }

  // Request location permission and get current GPS location
  Future<void> _requestPermissionAndGetLocation() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("Location services are disabled.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Location permission denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Location permission permanently denied.");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> onlineUsers = jsonDecode(response.body);

        setState(() {
          users = onlineUsers.map((user) {
            return {
              'id': user['id'],
              'name': user['name'],
              'email': user['email'],
              'latitude':
                  double.tryParse(user['address']['geo']['lat'].toString()) ??
                      0.0,
              'longitude':
                  double.tryParse(user['address']['geo']['lng'].toString()) ??
                      0.0,
              'phone': user['phone'],
            };
          }).toList();
          isOffline = false;
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('users', jsonEncode(users));
      }
    } catch (e) {
      print("Error fetching users: $e");

      // Fetch from local storage if offline
      final prefs = await SharedPreferences.getInstance();
      final storedUsers = prefs.getString('users');

      if (storedUsers != null) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(storedUsers));
          isOffline = true;
        });
      }
    }
  }

  double _calculateDistance(double lat1, double lon1) {
    if (_currentPosition == null) return 0.0;

    return Geolocator.distanceBetween(
      lat1,
      lon1,
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                double distance =
                    _calculateDistance(user['latitude'], user['longitude']);
                return Card(
                  child: ListTile(
                    title: Text(user['name']),
                    subtitle: Text(user['email']),
                    trailing: Text(
                        '${user['latitude']}, ${user['longitude']} \nDistance: ${distance.toStringAsFixed(2)} m'),
                    onTap: () async {
                      final todos = await fetchTodos(user['id']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(
                            user: user,
                            todos: todos,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  // Fetch to-dos based on user ID
  Future<List<Map<String, dynamic>>> fetchTodos(int userId) async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
      if (response.statusCode == 200) {
        final List<dynamic> todos = jsonDecode(response.body);
        final filteredTodos = todos.where((todo) {
          return todo['userId'] == userId; // Filter by userId
        }).toList();

        return filteredTodos.map((todo) {
          return {
            'title': todo['title'],
            'completed': todo['completed'],
          };
        }).toList();
      }
    } catch (e) {
      print("Error fetching todos: $e");
    }
    return [];
  }
}

// class UserDetailsScreen extends StatelessWidget {
//   final Map<String, dynamic> user;
//   final List<Map<String, dynamic>> todos;

//   const UserDetailsScreen({Key? key, required this.user, required this.todos}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${user['name']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text('Email: ${user['email']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 8),
//             Text('Phone: ${user['phone']}', style: const TextStyle(fontSize: 18)),
//             const SizedBox(height: 16),
//             const Text('To-Dos:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             if (todos.isEmpty)
//               const Text('No To-Dos available.')
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: todos.length,
//                 itemBuilder: (context, index) {
//                   final todo = todos[index];
//                   return ListTile(
//                     title: Text(todo['title']),
//                     trailing: Icon(
//                       todo['completed'] ? Icons.check_box : Icons.check_box_outline_blank,
//                       color: todo['completed'] ? Colors.green : Colors.red,
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final List<Map<String, dynamic>> todos;

  const UserDetailsScreen({Key? key, required this.user, required this.todos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user['name']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${user['email']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Phone: ${user['phone']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            const Text('To-Dos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text('No To-Dos available.'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(todo['title']),
                            trailing: Icon(
                              todo['completed']
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color:
                                  todo['completed'] ? Colors.green : Colors.red,
                            ),
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
