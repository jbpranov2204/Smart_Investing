import 'package:flutter/material.dart';
import 'package:smart_investing/HomePage/settings_page.dart';

class StockMarketPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Define gradient colors
  final List<Color> gradientColors = [
    Color(0xFF2E3192), // Deep Blue
    Color(0xFF1BFFFF), // Cyan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFF5F5F5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/1816958428771749888/f49y3HRM_400x400.png',
                    ),
                  ),
                  accountName: Text(
                    'Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text('xyz@gmail.com'),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildDrawerItem(Icons.person, 'Profile', context),
                      _buildDrawerItem(Icons.dashboard, 'Dashboard', context),
                      _buildDrawerItem(
                        Icons.help,
                        'Help (contact us)',
                        context,
                      ),
                      _buildDrawerItem(Icons.history, 'History', context),
                      _buildDrawerItem(Icons.info, 'About Us', context),
                      Divider(),
                      _buildDrawerItem(
                        Icons.logout,
                        'Logout',
                        context,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 16.0),
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SettingsPage()));
              },
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.show_chart, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'InvestMate',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF5F5F5)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(),
              SizedBox(height: 20),
              _buildStockSection('Based On Stock Action'),
              SizedBox(height: 20),
              _buildQGMVSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    BuildContext context, {
    Color color = Colors.black87,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      onTap: () {
        Navigator.pop(context);
        // Add navigation logic here
      },
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVEST SMART',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Curated stock collections or screeners are predefined lists of stocks that have been carefully selected based on specific criteria or themes.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: StockCard(
                title: 'Top Gainers',
                stocks: [
                  Stock(
                    name: 'Valor Estate Ltd.',
                    price: '₹151.61',
                    change: '+19.38%',
                  ),
                  Stock(
                    name: 'Mangalore Refinery',
                    price: '₹135.53',
                    change: '+14.97%',
                  ),
                  Stock(
                    name: 'Alembic Pharma',
                    price: '₹952.60',
                    change: '+12.33%',
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: StockCard(
                title: 'Top Losers',
                stocks: [
                  Stock(
                    name: 'Amber Enterprises',
                    price: '₹6,890.55',
                    change: '-4.94%',
                  ),
                  Stock(
                    name: 'TBO Tek Ltd.',
                    price: '₹1,207.25',
                    change: '-4.92%',
                  ),
                  Stock(
                    name: 'Jindal Stainless',
                    price: '₹625.70',
                    change: '-4.33%',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQGMVSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: 'QGMV Rated Stocks'),
        SizedBox(height: 10),
        StockCard(
          title: 'QGMV Rated Stocks',
          stocks: [
            Stock(name: 'Axis Bank Ltd.', price: '₹1,234.50', change: '+2.45%'),
            Stock(name: 'HDFC Ltd.', price: '₹2,345.60', change: '+1.78%'),
            Stock(
              name: 'Reliance Industries',
              price: '₹2,100.00',
              change: '+1.23%',
            ),
          ],
        ),
      ],
    );
  }
}

// Update StockCard with gradient styling
class StockCard extends StatelessWidget {
  final String title;
  final List<Stock> stocks;

  StockCard({required this.title, required this.stocks});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Color(0xFFF8F9FA)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E3192),
                ),
              ),
              Divider(color: Color(0xFF2E3192).withOpacity(0.2)),
              Column(
                children:
                    stocks
                        .map(
                          (stock) => ListTile(
                            title: Text(
                              stock.name,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              stock.price,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: Text(
                              stock.change,
                              style: TextStyle(
                                color:
                                    stock.change.startsWith('+')
                                        ? Colors.green[600]
                                        : Colors.red[600],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add these classes at the bottom of the file

class Stock {
  final String name;
  final String price;
  final String change;

  Stock({required this.name, required this.price, required this.change});
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E3192),
      ),
    );
  }
}
