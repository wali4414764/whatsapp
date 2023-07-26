import 'package:flutter/material.dart';

class WhatsAppHomePage extends StatefulWidget {
  final String? userId;

  WhatsAppHomePage({required this.userId});

  @override
  State<WhatsAppHomePage> createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  IconData fabIcon = Icons.group_rounded; // Default FAB icon
  final MenuController _menuController = MenuController();

  bool _isMenuVisible = false; // Add this line to define the _isMenuVisible variable

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(_updateFabIcon); // Listen for tab changes
  }

  @override
  void dispose() {
    tabController.removeListener(_updateFabIcon); // Remove listener to avoid memory leaks
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
    setState(() {
      _isMenuVisible = !_isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the lists of options for each tab
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
      // Add more options for the "Chats" tab as needed
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

    return Scaffold(
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
              onPressed: () {
                // Add your desired functionality here
              },
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
                _toggleMenuVisibility(); // Close the menu when an item is selected
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
          // Add your tab views here
          Center(child: Text('Groups')),
          Center(child: Text('Chats')),
          Center(child: Text('Status')),
          Center(child: Text('Calls')),
        ],
      ),
      floatingActionButton: _isMenuVisible
          ? FloatingActionButton(
        onPressed: _toggleMenuVisibility,
        child: Icon(Icons.close),
        backgroundColor: Colors.red, // Change the color of the FAB
      )
          : FloatingActionButton(
        onPressed: _toggleMenuVisibility,
        child: Icon(fabIcon),
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
