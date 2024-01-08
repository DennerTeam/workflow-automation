import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workflow_automation/controller/gsheet_controller.dart';
import 'package:http/http.dart' as http;
import 'package:workflow_automation/model/pg_hostel.dart';
import 'package:workflow_automation/ui/pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GSheetController controller = Get.put(GSheetController());

  List<DataColumn> getColumnNames(List<String> names) {
    return names.map((String name) {
      return DataColumn(
          label: Expanded(
              child: Text(
        name[0].toUpperCase() + name.substring(1),
        textAlign: TextAlign.center,
      )));
    }).toList();
  }

  List<DataRow> getRows(List<PGHostel> rows) {
    return rows.map((PGHostel row) {
      return DataRow(
        cells: row
            .getFieldNames()
            .map((data) => DataCell(ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100, // Set the minimum width
                  maxWidth: 500, // Set the maximum width
                ),
                child: Text(
                  data,
                  overflow: TextOverflow.ellipsis,
                ))))
            .toList(),
      );
    }).toList();
  }

  final List<String> messages = [
    "Just a moment, we're tuning the algorithms for you.",
    "Hang tight! We're making everything perfect for you.",
    "Gathering the pixies to do their thing...",
    "Hold on, we're bending time and space for your request!",
    "Cooking up something special, just for you...",
    "On a digital expedition. Be right back with your treasures!",
    "Sifting through the matrix of awesomeness...",
    "Beaming up your request through the cyber galaxy.",
    "Conjuring the code wizards for some spellbinding action!",
    "We're currently feeding the hamsters that power our servers.",
    "Polishing the pixels for a shiny result...",
    "Our digital elves are crafting your request with care.",
    "Our server squirrels are nuts about getting your request done!",
    "Just like fine art, perfection takes a bit of time..."
  ];

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAll(LoginScreen()); // Navigate back to LoginScreen
  }

  final PageController _pageController = PageController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _logout,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Denner Workflow Automation',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20), // Provides some spacing
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextButton(
              onPressed: () async {
                if (!controller.isLoading.value) {
                  controller.fetchDataFromSheet();
                }
              },
              child: const Text('Fetch PG/Hostel from Sheets 📄'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                onSurface: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20), // Provides some spacing
          Obx(() {
            if (!controller.isLoading.value) {
              if (controller.rowData.value.isNotEmpty) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DataTable(
                      columnSpacing: 38, // Adjust spacing between columns
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // Change color of the heading row
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.blueAccent.withOpacity(0.08);
                        }
                        return Colors
                            .lightBlue; // Use whatever color suits your need
                      }),
                      headingTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      dataRowColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        // Change color of the data rows
                        if (states.contains(MaterialState.selected)) {
                          return Colors.grey.withOpacity(0.5);
                        }
                        return Colors
                            .white; // Use any color that fits your theme
                      }),
                      border: TableBorder.all(
                        color: Colors.black, // Add border color
                        width: 1, // Border width
                      ),
                      columns: getColumnNames(controller.columnNames),
                      rows: getRows(controller.rowData.value),
                    ),
                  ),
                );
              } else
                return Container(
                  child: Center(
                      child: Text(
                    "No PG Hostel Data!",
                    style: TextStyle(fontSize: 18),
                  )),
                );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          }),
          const SizedBox(height: 20), // Provides some spacing
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextButton(
              onPressed: () async {
                if (controller.rowData.value.isEmpty) {
                  Get.snackbar("Error", "No PG Hostel data to upload!");
                  return;
                }
                _timer =
                    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
                  if (_pageController.hasClients) {
                    int nextPage = _pageController.page!.round() + 1;
                    if (nextPage == messages.length) {
                      nextPage = 0;
                    }
                    _pageController.animateToPage(
                      nextPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                });
                await controller.sendToSupabase();
                _timer?.cancel();
              },
              child: const Text('Send to Supabase 🚀'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
                onSurface: Colors.grey,
              ),
            ),
          ),
          Obx(
            () => (controller.isDataUploading.value)
                ? Expanded(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            messages[index],
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  )
                : Container(),
          ),
          Obx(() => (!controller.isDataUploading.value &&
                  controller.error.value.isNotEmpty)
              ? Center(
                  child: Text(
                  controller.error.value,
                  textAlign: TextAlign.center,
                ))
              : Container())
        ],
      ),
    );
  }
}
