import 'package:flutter/material.dart';
import 'package:whatsapp/chat_item_model.dart';

void main() => runApp(WhatsAppHomePage());

class WhatsAppHomePage extends StatefulWidget {
  @override
  State<WhatsAppHomePage> createState() => _WhatsAppHomePageState();
}

class _WhatsAppHomePageState extends State<WhatsAppHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  IconData fabIcon = Icons.group_rounded; // Default FAB icon

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(_updateFabIcon); // Listen for tab changes
  }

  @override
  void dispose() {
    tabController.removeListener(
        _updateFabIcon); // Remove listener to avoid memory leaks
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              IconButton(
                onPressed: () {
                  // Add your desired functionality here
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.group_rounded)),
              Tab(text: "Chats"),
              Tab(text: "Status"),
              Tab(text: "Calls"),
            ],
            indicatorColor: Colors.white,
            controller: tabController,
            onTap: (index) {
              // Trigger the icon change when a new tab is selected
              _updateFabIcon();
            },
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            // Display different content on each tab here
            Center(
              child: Icon(Icons.group_rounded),
            ),
            ChatList(),
            StatusScreen(), // Status Screen with two FABs
            Center(
              child: Text("Call Screen"),
            ),
          ],
        ),
        floatingActionButton: tabController.index == 2 // Check if on the Status tab
            ? StatusScreenFABs() // Display two FABs on the Status tab
            : FloatingActionButton(
          onPressed: () {
            // Add your desired functionality for the FloatingActionButton here
          },
          child: Icon(fabIcon),
          backgroundColor: Color(0xFF075e54),
        ),
      ),
    );
  }
}

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Status Screen"),
    );
  }
}

class StatusScreenFABs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            // Add your desired functionality for the first FAB here
            print("First FAB pressed");
          },
          child: Icon(Icons.edit, color: Colors.white),
          backgroundColor: Colors.blueGrey, // Adjust the color as needed
        ),
        SizedBox(height: 16),
        FloatingActionButton(
          onPressed: () {
            // Add your desired functionality for the second FAB here
            print("Second FAB pressed");
          },
          child: Icon(Icons.camera_alt),
          backgroundColor: Color(0xFF075e54), // Adjust the color as needed
        ),
      ],
    );
  }
}
