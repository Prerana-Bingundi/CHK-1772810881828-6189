import 'package:flutter/material.dart';

class CropGuidancePage extends StatefulWidget {
  const CropGuidancePage({super.key});

  @override
  State<CropGuidancePage> createState() => _CropGuidancePageState();
}

class _CropGuidancePageState extends State<CropGuidancePage> {

  String selectedCrop = "Wheat";
  String selectedSeason = "Rabi";

  Map<String, String>? result;

  Map<String, Map<String, Map<String, String>>> cropGuidance = {

    "Wheat": {
      "Rabi": {
        "fertilizer": "Urea & DAP",
        "irrigation": "Irrigate every 7 days",
        "yield": "18-22 Quintals per Acre",
        "tips": "Sow seeds in rows 20cm apart",
        "pest": "Use Chlorpyrifos for stem borer"
      },
      "Kharif": {
        "fertilizer": "NPK 20:20:20",
        "irrigation": "Irrigate every 10 days",
        "yield": "15-18 Quintals per Acre",
        "tips": "Use drought resistant seeds",
        "pest": "Spray neem oil"
      }
    },

    "Rice": {
      "Kharif": {
        "fertilizer": "Urea & Potash",
        "irrigation": "Maintain water level",
        "yield": "20-25 Quintals per Acre",
        "tips": "Use puddled soil method",
        "pest": "Use Carbaryl for leaf folder"
      },
      "Rabi": {
        "fertilizer": "NPK Mix",
        "irrigation": "Irrigate every 5 days",
        "yield": "18-20 Quintals per Acre",
        "tips": "Use early maturity seeds",
        "pest": "Spray neem oil"
      }
    },

    "Maize": {
      "Kharif": {
        "fertilizer": "NPK 120:60:40",
        "irrigation": "Irrigate every 8 days",
        "yield": "25-30 Quintals per Acre",
        "tips": "Maintain row spacing 60cm",
        "pest": "Control fall armyworm with Spinosad"
      },
      "Rabi": {
        "fertilizer": "Urea + Potash",
        "irrigation": "Irrigate every 10 days",
        "yield": "20-24 Quintals per Acre",
        "tips": "Use hybrid maize seeds",
        "pest": "Use neem spray"
      }
    },

    "Cotton": {
      "Kharif": {
        "fertilizer": "NPK 100:50:50",
        "irrigation": "Irrigate every 12 days",
        "yield": "15-20 Quintals per Acre",
        "tips": "Use Bt cotton seeds",
        "pest": "Use pheromone traps for bollworm"
      }
    },

    "Sugarcane": {
      "Kharif": {
        "fertilizer": "NPK 250:115:115",
        "irrigation": "Irrigate every 10 days",
        "yield": "350-400 Quintals per Acre",
        "tips": "Use trench planting method",
        "pest": "Control borers using Chlorpyrifos"
      }
    },

    "Soybean": {
      "Kharif": {
        "fertilizer": "NPK 30:60:30",
        "irrigation": "Rainfed crop usually",
        "yield": "10-15 Quintals per Acre",
        "tips": "Seed treatment with Rhizobium",
        "pest": "Use neem oil for aphids"
      }
    },

    "Tomato": {
      "Rabi": {
        "fertilizer": "Farmyard manure + NPK",
        "irrigation": "Irrigate every 4 days",
        "yield": "200-250 Quintals per Acre",
        "tips": "Use staking support",
        "pest": "Spray Imidacloprid"
      },
      "Kharif": {
        "fertilizer": "Organic compost + NPK",
        "irrigation": "Irrigate every 3 days",
        "yield": "180-220 Quintals per Acre",
        "tips": "Use mulching",
        "pest": "Control fruit borer using pheromone traps"
      }
    }

  };

  void getGuidance() {
    setState(() {
      result = cropGuidance[selectedCrop]?[selectedSeason];
    });
  }

  Widget infoCard(String title, String value, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [

          Icon(icon, color: color),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(value)

              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Crop Guidance"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text("Select Crop", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 5),

            DropdownButtonFormField<String>(
              value: selectedCrop,
              items: cropGuidance.keys
                  .map((crop) => DropdownMenuItem(
                value: crop,
                child: Text(crop),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCrop = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            const Text("Select Season", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 5),

            DropdownButtonFormField<String>(
              value: selectedSeason,
              items: ["Rabi", "Kharif"]
                  .map((season) => DropdownMenuItem(
                value: season,
                child: Text(season),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedSeason = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14),
                ),

                onPressed: getGuidance,

                child: const Text("Get Guidance"),
              ),
            ),

            const SizedBox(height: 20),

            if (result != null) ...[

              infoCard("Fertilizer", result!["fertilizer"]!, Icons.eco, Colors.green),

              infoCard("Irrigation", result!["irrigation"]!, Icons.water_drop, Colors.blue),

              infoCard("Expected Yield", result!["yield"]!, Icons.bar_chart, Colors.orange),

              infoCard("Farming Tips", result!["tips"]!, Icons.lightbulb, Colors.purple),

              infoCard("Pest Control", result!["pest"]!, Icons.bug_report, Colors.red),

            ]

          ],
        ),
      ),
    );
  }
}