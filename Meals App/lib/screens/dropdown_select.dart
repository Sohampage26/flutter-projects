import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_analytics/firebase_analytics.dart';

class DropdownSelect extends StatefulWidget {
  const DropdownSelect({Key? key}) : super(key: key);

  @override
  _DropdownSelectState createState() => _DropdownSelectState();
}

class _DropdownSelectState extends State<DropdownSelect> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  String? selectedDistrict;
  String? selectedSubDistrict;
  String? selectedVillage;

  Map<String, List<String>> districtSubDistrictMap = {};
  Map<String, List<String>> subDistrictVillageMap = {};

  @override
  void initState() {
    super.initState();
    loadCSVData();
  }

  Future<void> loadCSVData() async {
    final String csvString = await rootBundle.loadString('lib/assets/info.csv');
    final List<List<dynamic>> csvTable =
        CsvToListConverter().convert(csvString);

    for (var row in csvTable) {
      String district = row[0];
      String subDistrict = row[1];
      String village = row[2];

      districtSubDistrictMap.putIfAbsent(district, () => []);
      if (!districtSubDistrictMap[district]!.contains(subDistrict)) {
        districtSubDistrictMap[district]!.add(subDistrict);
      }

      subDistrictVillageMap.putIfAbsent(subDistrict, () => []);
      subDistrictVillageMap[subDistrict]!.add(village);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Dropdown'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedDistrict,
              hint: const Text('Select District',
                  style: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedSubDistrict = null;
                  selectedVillage = null;
                });
                analytics.logEvent(
                  name: 'select_district',
                  parameters: <String, dynamic>{
                    'district': selectedDistrict,
                  },
                );
              },
              items: districtSubDistrictMap.keys.map((String? district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district ?? '',
                      style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedSubDistrict,
              hint: const Text('Select Sub-District',
                  style: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  selectedSubDistrict = value;
                  selectedVillage = null;
                });
                analytics.logEvent(
                  name: 'select_sub_district',
                  parameters: <String, dynamic>{
                    'sub_district': selectedSubDistrict,
                  },
                );
              },
              items: selectedDistrict != null
                  ? districtSubDistrictMap[selectedDistrict!]!
                      .map((String? subDistrict) {
                      return DropdownMenuItem<String>(
                        value: subDistrict,
                        child: Text(subDistrict ?? '',
                            style: TextStyle(color: Colors.white)),
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedVillage,
              hint: const Text('Select Village',
                  style: TextStyle(color: Colors.white)),
              onChanged: (value) {
                setState(() {
                  selectedVillage = value;
                });
                analytics.logEvent(
                  name: 'select_village',
                  parameters: <String, dynamic>{
                    'village': selectedVillage,
                  },
                );
              },
              items: selectedSubDistrict != null
                  ? subDistrictVillageMap[selectedSubDistrict!]!
                      .map((String? village) {
                      return DropdownMenuItem<String>(
                        value: village,
                        child: Text(village ?? '',
                            style: TextStyle(color: Colors.white)),
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(height: 20),
            Text(
              'Selected District: ${selectedDistrict ?? "None"}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Selected Sub-District: ${selectedSubDistrict ?? "None"}',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'Selected Village: ${selectedVillage ?? "None"}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
