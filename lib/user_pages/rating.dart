import 'package:Eye_Health/models/rating.dart';
import 'package:Eye_Health/services/rating.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RatingPieChart extends StatefulWidget {
  @override
  _RatingPieChartState createState() => _RatingPieChartState();
}

class _RatingPieChartState extends State<RatingPieChart> {
  late Future<RatingResult> ratingData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      ratingData = RatingService().getRatingData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentiment Analysis'),
      ),
      body: FutureBuilder<RatingResult>(
        future: ratingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No data available.'));
          }

          final sentiment = snapshot.data!;
          final chartData = [
            SentimentChartData('Positif', sentiment.positif, Colors.green),
            SentimentChartData('Negatif', sentiment.negatif, Colors.red),
          ];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Pie Chart using fl_chart
                  SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: chartData.map((data) {
                          return PieChartSectionData(
                            color: data.color,
                            value: data.value.toDouble(),
                            title: '${data.label}\n${data.value}',
                            radius: 60,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                        centerSpaceRadius: 40,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display reviews
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sentiment.reviews.length,
                    itemBuilder: (context, index) {
                      var review = sentiment.reviews[index];
                      return ListTile(
                        title: Text(review.komentar),
                        trailing: Text(
                          review.sentiment,
                          style: TextStyle(
                            color: review.sentiment == 'Positif'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        child: const Icon(Icons.refresh),
        tooltip: 'Refresh Data',
      ),
    );
  }
}

/// Data model for the Pie Chart
class SentimentChartData {
  final String label;
  final int value;
  final Color color;

  SentimentChartData(this.label, this.value, this.color);
}
