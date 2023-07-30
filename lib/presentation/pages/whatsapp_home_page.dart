import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhatsAppHomePage extends StatefulWidget {
  final String userId;

  WhatsAppHomePage({required this.userId});
  @override
  _WhatsAppHomePageState createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  IconData fabIcon = Icons.group_rounded; // Default FAB icon
  late MenuController _menuController; // Use the MenuController

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(_updateFabIcon);
    _menuController = MenuController(); // Initialize the MenuController
  }

  @override
  void dispose() {
    tabController.removeListener(_updateFabIcon);
    tabController.dispose();
    super.dispose();
  }

  void _updateFabIcon() {
    setState(() {
      switch (tabController.index) {
        case 0:
          fabIcon = Icons.group_rounded;
          break;
        case 1:
          fabIcon = Icons.message;
          break;
        case 2:
          fabIcon = Icons.camera_enhance;
          break;
        case 3:
          fabIcon = Icons.add_ic_call_rounded;
          break;
      }
    });
  }

  void _toggleMenuVisibility() {
    _menuController.toggleMenu(); // Use the _menuController to toggle the menu visibility
  }

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<String>> groupOptions = [
      PopupMenuItem<String>(
        value: 'settings',
        child: Text('Settings'),
      ),
    ];

    List<PopupMenuEntry<String>> chatOptions = [
      PopupMenuItem<String>(
        value: 'new_chat',
        child: Text('New Chat'),
      ),
      PopupMenuItem<String>(
        value: 'new_broadcast',
        child: Text('New Broadcast'),
      ),
      PopupMenuItem<String>(
        value: 'linked_devices',
        child: Text('Linked Devices'),
      ),
      PopupMenuItem<String>(
        value: 'starred_messages',
        child: Text('Starred Messages'),
      ),
      PopupMenuItem<String>(
        value: 'settings',
        child: Text('Settings'),
      ),
    ];

    List<PopupMenuEntry<String>> statusOptions = [
      PopupMenuItem<String>(
        value: 'status_privacy',
        child: Text('Status Privacy'),
      ),
      PopupMenuItem<String>(
        value: 'settings',
        child: Text('Settings'),
      ),
    ];

    List<PopupMenuEntry<String>> callsOptions = [
      PopupMenuItem<String>(
        value: 'clear_call_log',
        child: Text('Clear Call Log'),
      ),
      PopupMenuItem<String>(
        value: 'settings',
        child: Text('Settings'),
      ),
    ];

    return ChangeNotifierProvider<MenuController>(
      create: (_) => _menuController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF075e54),
          title: Row(
            children: [
              Text(
                'WhatsApp',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: _openCamera,
                icon: Icon(Icons.camera_alt_outlined),
              ),
              IconButton(
                onPressed: () {
                  // Add your desired functionality here
                },
                icon: Icon(Icons.search),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  _menuController.toggleMenu(); // Close the menu when an item is selected
                  // Perform the desired action based on the selected value
                  switch (value) {
                    case 'settings':
                    // Add your functionality for "Settings" based on the current tab index
                      switch (tabController.index) {
                        case 0:
                        // Code for "Settings" in the "Groups" tab
                          print('Settings in Groups');
                          break;
                        case 1:
                        // Code for "Settings" in the "Chats" tab
                          print('Settings in Chats');
                          break;
                        case 2:
                        // Code for "Settings" in the "Status" tab
                          print('Settings in Status');
                          break;
                        case 3:
                        // Code for "Settings" in the "Calls" tab
                          print('Settings in Calls');
                          break;
                      }
                      break;
                    case 'new_chat':
                    // Code for "New Chat" option
                      break;
                    case 'new_broadcast':
                    // Code for "New Broadcast" option
                      break;
                    case 'linked_devices':
                    // Code for "Linked Devices" option
                      break;
                    case 'starred_messages':
                    // Code for "Starred Messages" option
                      break;
                    case 'status_privacy':
                    // Code for "Status Privacy" option
                      break;
                    case 'clear_call_log':
                    // Code for "Clear Call Log" option
                      break;
                  }
                },
                itemBuilder: (context) {
                  // Build the menu based on the current tab index
                  switch (tabController.index) {
                    case 0:
                      return groupOptions;
                    case 1:
                      return chatOptions;
                    case 2:
                      return statusOptions;
                    case 3:
                      return callsOptions;
                    default:
                      return [];
                  }
                },
              ),
            ],
          ),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(text: 'Groups'),
              Tab(text: 'Chats'),
              Tab(text: 'Status'),
              Tab(text: 'Calls'),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Center(child: Text('Groups')),
            Center(child: Text('Chats')),
            Center(
              child: WhatsAppStatusTab(),
            ),
            Center(child: Text('Calls')),
          ],
        ),
        floatingActionButton: Consumer<MenuController>(
          // Use Consumer to listen to changes in MenuController
          builder: (context, menuController, _) => FloatingActionButton(
            onPressed: _toggleMenuVisibility,
            child: menuController.isMenuOpen
                ? Icon(Icons.close)
                : Icon(fabIcon),
            backgroundColor: menuController.isMenuOpen ? Colors.red : null,
          ),
        ),
      ),
    );
  }

  void _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      _uploadStatus(image.path);
    }
  }

  void _uploadStatus(String imagePath) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Status Updated'),
        content: Image.file(File(imagePath)),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> statuses = prefs.getStringList('statuses') ?? [];
              statuses.add(imagePath);
              prefs.setStringList('statuses', statuses);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class MenuController extends ChangeNotifier {
  bool _isMenuOpen = false;

  bool get isMenuOpen => _isMenuOpen;

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }
}

class WhatsAppStatusTab extends StatefulWidget {
  @override
  _WhatsAppStatusTabState createState() => _WhatsAppStatusTabState();
}

class _WhatsAppStatusTabState extends State<WhatsAppStatusTab> {
  List<String> _statuses = [];

  @override
  void initState() {
    super.initState();
    _loadStatuses();
  }

  void _loadStatuses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _statuses = prefs.getStringList('statuses') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _statuses.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // Status update field
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.camera_alt, color: Colors.white),
            ),
            title: Text(
              'My Status',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Tap to add status update'),
            onTap: _openCamera,
          );
        } else {
          // Status list items
          final statusIndex = index - 1;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(_statuses[statusIndex])),
            ),
            title: Text('Contact Name ${statusIndex + 1}'),
            subtitle: Text('Today, 10:30 AM'),
            onTap: () {
              _viewStatus(_statuses[statusIndex]);
            },
          );
        }
      },
    );
  }

  void _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      _uploadStatus(image.path);
    }
  }

  void _uploadStatus(String imagePath) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Status Updated'),
        content: Image.file(File(imagePath)),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              List<String> statuses = prefs.getStringList('statuses') ?? [];
              statuses.add(imagePath);
              prefs.setStringList('statuses', statuses);
              Navigator.pop(context);
              setState(() {});
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _viewStatus(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusViewPage(imagePath: imagePath),
      ),
    );
  }
}

class StatusViewPage extends StatelessWidget {
  final String imagePath;

  StatusViewPage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status View'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
