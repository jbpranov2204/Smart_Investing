import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  String _selectedCurrency = 'INR';
  double _refreshInterval = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2E3192), // Deep Blue
                Color(0xFF1BFFFF), // Cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text('Settings'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF5F5F5)],
          ),
        ),
        child: ListView(
          children: [
            _buildSectionHeader('App Settings'),
            SwitchListTile(
              title: Text('Push Notifications'),
              subtitle: Text('Receive alerts for price changes'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('Dark Mode'),
              subtitle: Text('Enable dark theme'),
              value: _darkMode,
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
            ),
            _buildSectionHeader('Market Preferences'),
            ListTile(
              title: Text('Currency'),
              subtitle: Text('Select your preferred currency'),
              trailing: DropdownButton<String>(
                value: _selectedCurrency,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCurrency = newValue;
                    });
                  }
                },
                items: <String>['INR', 'USD', 'EUR', 'GBP']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            ListTile(
              title: Text('Refresh Interval'),
              subtitle: Text('${_refreshInterval.toStringAsFixed(1)} seconds'),
              trailing: Container(
                width: 200,
                child: Slider(
                  value: _refreshInterval,
                  min: 1.0,
                  max: 10.0,
                  divisions: 18,
                  label: _refreshInterval.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      _refreshInterval = value;
                    });
                  },
                ),
              ),
            ),
            _buildSectionHeader('Account'),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to security settings
              },
            ),
            _buildSectionHeader('About'),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('App Version'),
              subtitle: Text('1.0.0'),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms of Service'),
              onTap: () {
                // Show terms of service
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Show privacy policy
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF2E3192),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}