import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Color> gradientColors = [
    Color(0xFF2E3192), // Deep Blue
    Color(0xFF1BFFFF), // Cyan
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
            onPressed: () {},
          ),
        ],
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
          child: Column(
            children: [_buildMarketOverview(), _buildCombinedStockList()],
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
      StockData('Adani Power', '₹245.60', ),
      StockData('SBI', '₹567.80', ),
      StockData('Infosys', '₹1,432.55', ),
    ];
  }

  List<StockData> _getTopLosers() {
    return [
      StockData('Tech Mahindra', '₹1,123.45'),
      StockData('HCL Tech', '₹987.65'),
      StockData('ITC', '₹432.10'),
    ];
  }
}

class StockData {
  final String name;
 
  final String change;

  StockData(this.name, this.change);
}
