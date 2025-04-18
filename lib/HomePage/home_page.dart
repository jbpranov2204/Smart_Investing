import 'package:flutter/material.dart';
import 'package:smart_investing/HomePage/chatbot_page.dart';
import 'package:smart_investing/HomePage/settings_page.dart';

class HomePage extends StatelessWidget {
  final List<Color> gradientColors = [
    Color(0xFF1E3C72).withOpacity(0.9), // Vibrant Blue
    Color(0xFF2A5298).withOpacity(0.8), // Deep Sky Blue
  ];

  final List<List<Color>> containerGradients = [
    [
      Color(0xFF1E3C72).withOpacity(0.9),
      Color(0xFF2A5298).withOpacity(0.8),
    ], // Vibrant Blue
    [
      Color(0xFF6A11CB).withOpacity(0.9),
      Color(0xFF2575FC).withOpacity(0.8),
    ], // Purple to Blue
    [
      Color(0xFF0F9B0F).withOpacity(0.9),
      Color(0xFF00F260).withOpacity(0.8),
    ], // Bright Green
    [
      Color(0xFFFF512F).withOpacity(0.9),
      Color(0xFFDD2476).withOpacity(0.8),
    ], // Red to Pink
    [
      Color(0xFFFC466B).withOpacity(0.9),
      Color(0xFF3F5EFB).withOpacity(0.8),
    ], // Pink to Blue
    [
      Color(0xFF1A2980).withOpacity(0.9),
      Color(0xFF26D0CE).withOpacity(0.8),
    ], // Blue to Cyan
    [
      Color(0xFFFFA17F).withOpacity(0.9),
      Color(0xFFFF7E5F).withOpacity(0.8),
    ], // Orange to Peach
    [
      Color(0xFF56CCF2).withOpacity(0.9),
      Color(0xFF2F80ED).withOpacity(0.8),
    ], // Light Blue to Dark Blue
    [
      Color(0xFF1E3C72).withOpacity(0.9),
      Color(0xFF2A5298).withOpacity(0.8),
    ], // Vibrant Blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if it's a desktop view (width > 900)
          final isDesktop = constraints.maxWidth > 900;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFFF5F5F5).withOpacity(0.5)],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (isDesktop)
                    _buildDesktopView(context)
                  else
                    _buildMobileView(context),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ), // Ensure ChatScreen exists
          );
        },
        backgroundColor: Color(0xFF2E3192), // Matching app theme color
        child: Icon(Icons.chat, color: Colors.white),
      ),
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Top row with market overview and grid items
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Market overview taking 30% of the width
              Expanded(flex: 30, child: _buildMarketOverview()),
              SizedBox(width: 16),
              // Grid taking 70% of the width
              Expanded(flex: 70, child: _buildDesktopGrid()),
            ],
          ),
          SizedBox(height: 16),
          // Bottom row with stocks and resources
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stock lists taking 60% of the width
              Expanded(flex: 60, child: _buildCombinedStockList()),
              SizedBox(width: 16),
              // Resources taking 40% of the width
              Expanded(flex: 40, child: _buildInvestmentResources()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 5, // 5 items per row for desktop
      childAspectRatio: 1.2, // Wider aspect ratio for desktop
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: List.generate(9, (index) {
        final items = [
          ('Stocks', Icons.trending_up),
          ('Watchlist', Icons.visibility),
          ('News', Icons.newspaper),
          ('Portfolio', Icons.account_balance_wallet),
          ('IPO', Icons.rocket_launch),
          ('Mutual Funds', Icons.pie_chart),
          ('Crypto', Icons.currency_bitcoin),
          ('Learn', Icons.school),
          ('More', Icons.more_horiz),
        ];
        return _buildInfoContainer(
          items[index].$1,
          items[index].$2,
          containerGradients[index],
        );
      }),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return Column(
      children: [
        _buildMarketOverview(),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 0.95, // Slightly taller containers
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          mainAxisSpacing: 8, // Reduced spacing
          crossAxisSpacing: 8, // Reduced spacing
          children: List.generate(9, (index) {
            final items = [
              ('Stocks', Icons.trending_up),
              ('Watchlist', Icons.visibility),
              ('News', Icons.newspaper),
              ('Portfolio', Icons.account_balance_wallet),
              ('IPO', Icons.rocket_launch),
              ('Mutual Funds', Icons.pie_chart),
              ('Crypto', Icons.currency_bitcoin),
              ('Learn', Icons.school),
              ('More', Icons.more_horiz),
            ];
            return _buildInfoContainer(
              items[index].$1,
              items[index].$2,
              containerGradients[index],
            );
          }),
        ),
        _buildCombinedStockList(),
        _buildInvestmentResources(),
      ],
    );
  }

  Widget _buildInfoContainer(String title, IconData icon, List<Color> colors) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8), // Smaller radius
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {},
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Positioned(
                right: -15,
                bottom: -15,
                child: Icon(
                  icon,
                  size: 80, // Increased from 70
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 34, // Increased from 28
                        color: Colors.white,
                      ),
                      SizedBox(height: 6), // Increased from 4
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.5, // Increased from 12
                          fontWeight: FontWeight.w600, // Made slightly bolder
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketOverview() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Market Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMarketIndicator('NIFTY 50', '19,425.35', '+0.45%'),
              _buildMarketIndicator('SENSEX', '64,363.78', '+0.52%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarketIndicator(String title, String value, String change) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          change,
          style: TextStyle(
            color:
                change.startsWith('+') ? Colors.greenAccent : Colors.redAccent,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCombinedStockList() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          children: [
            _buildStockSection('Most Active Stocks', _getMostActiveStocks()),
            Divider(height: 1),
            _buildStockSection('Top Gainers', _getTopGainers()),
            Divider(height: 1),
            _buildStockSection('Top Losers', _getTopLosers()),
          ],
        ),
      ),
    );
  }

  Widget _buildStockSection(String title, List<StockData> stocks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3192),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildStockTile(stocks[index]),
                if (index < stocks.length - 1)
                  Divider(height: 1, indent: 16, endIndent: 16),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStockTile(StockData stock) {
    return ListTile(
      title: Text(stock.name, style: TextStyle(fontWeight: FontWeight.w500)),

      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color:
              stock.change.startsWith('+')
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          stock.change,
          style: TextStyle(
            color:
                stock.change.startsWith('+')
                    ? Colors.green[700]
                    : Colors.red[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<StockData> _getMostActiveStocks() {
    return [
      StockData('Reliance', '₹2,543.25'),
      StockData('TCS', '₹3,456.70'),
      StockData('HDFC Bank', '₹1,678.90'),
    ];
  }

  List<StockData> _getTopGainers() {
    return [
      StockData('Adani Power', '₹245.60'),
      StockData('SBI', '₹567.80'),
      StockData('Infosys', '₹1,432.55'),
    ];
  }

  List<StockData> _getTopLosers() {
    return [
      StockData('Tech Mahindra', '₹1,123.45'),
      StockData('HCL Tech', '₹987.65'),
      StockData('ITC', '₹432.10'),
    ];
  }

  Widget _buildInvestmentResources() {
    final resources = [
      {
        'name': 'Moneycontrol',
        'url': 'https://www.moneycontrol.com',
        'description': 'Comprehensive financial news and analysis',
      },
      {
        'name': 'Screener.in',
        'url': 'https://www.screener.in',
        'description': 'Stock analysis and screening tool',
      },
      {
        'name': 'Tickertape',
        'url': 'https://www.tickertape.in',
        'description': 'Modern stock research platform',
      },
      {
        'name': 'Zerodha Varsity',
        'url': 'https://zerodha.com/varsity',
        'description': 'Free stock market education',
      },
      {
        'name': 'Trading View',
        'url': 'https://www.tradingview.com',
        'description': 'Charts and technical analysis',
      },
    ];

    return Container(
      margin: EdgeInsets.all(16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Investment Resources',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E3192),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: resources.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    resources[index]['name']!,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(resources[index]['description']!),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // TODO: Implement URL launcher
                    // Launch resources[index]['url']
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class StockData {
  final String name;

  final String change;

  StockData(this.name, this.change);
}
