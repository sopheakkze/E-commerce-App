
import 'package:app/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingScreen extends StatelessWidget {
const SettingScreen({super.key});



  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut(); // Supabase logout method
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully')),
      );

      // Navigate back to the Sign-in Screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SigninScreen()),
        (route) => false, // Remove all previous routes
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $error')),
      );
    }
  }

  // Show confirmation dialog before logging out
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // title: const Text("Confirm Logout"),
        content: const Text(
          "Log out of your account?",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel logout
            child: const Text(
              "CANCEL",
              style: TextStyle(fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _logout(context); // Proceed with logout
            },
            child: const Text("LOG OUT", style: TextStyle(color: Colors.red, fontSize: 15),),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        // centerTitle: true,
          automaticallyImplyLeading: false, 
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/pk.jpg"),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lao Kong",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("thelaokong12@mail.com",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Account Settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildListTile("My Addresses", "Set shopping delivery address",
                  Icons.location_on),
              _buildListTile(
                  "My Cart",
                  "Add, remove products and move to checkout",
                  Icons.shopping_cart),
              _buildListTile("My Orders", "In progress and completed orders",
                  Icons.list_alt),
              _buildListTile("Bank Account", "Withdraw balance to bank account",
                  Icons.account_balance),
              _buildListTile("My Coupons", "List of discounted coupons",
                  Icons.local_offer),
              _buildListTile("Notifications",
                  "Set any kind of notification message", Icons.notifications),
              _buildListTile(
                  "Account Privacy",
                  "Manage data usage and commercial messages",
              Icons.privacy_tip),

              // const Text("App Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
  
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showLogoutConfirmation(context), // Show confirmation dialog
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black45),
                  child: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
