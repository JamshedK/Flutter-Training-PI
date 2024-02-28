import 'package:flutter/material.dart';
import 'package:tutorial/_themed_app_bar.dart';
import 'package:tutorial/constants.dart';

class VisitDetailsPage extends StatelessWidget {
  const VisitDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(
        title: 'Visit Details',
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5.0),
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Visiting Date",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          height: 1.5,
                        )),
                    Text(
                      "15 July 2023",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              _titleText("Reason"),
              const SizedBox(height: 5.0),
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                child: const Text(
                    "Knee Fracture and had a bad back pain for the last 2 weeks.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.5,
                    )),
              ),
              const SizedBox(height: 15.0),
              _titleText("Treatment"),
              const SizedBox(height: 5.0),
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                child: const Text(
                    "Doctors performed knee surgery and gave pain killer.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.5,
                    )),
              ),
              const SizedBox(height: 15.0),
              //TODO: Ask John about styling here: Keep as is or make it look like others?
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Time",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          height: 1.5,
                        )),
                    Text(
                      "2 hrs 45 minutes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              _titleText("Care Takers"),
              const SizedBox(height: 5.0),
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _careTakerRow("Eric", "X-Ray"),
                    const SizedBox(height: 5.0),
                    _careTakerRow("Steve", "Lab Attendee"),
                    const SizedBox(height: 5.0),
                    _careTakerRow("Shelly", "Triage"),
                    const SizedBox(height: 5.0),
                    _careTakerRow("Dr. Sinek", "Doctor"),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              _titleText("Timeline"),
              const SizedBox(height: 5.0),
              Container(
                decoration: _greyStyledBox,
                padding: const EdgeInsets.all(15),
                //TODO: Use Painter to put timeline snippet here
                child: const Text("Insert Painter Here"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _titleText(title) => Text(
        title,
        style: const TextStyle(
            fontStyle: FontStyle.italic, fontSize: 14, height: 1.5),
      );

  BoxDecoration get _greyStyledBox => BoxDecoration(
        border: Border.all(color: const Color(0x22000000), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      );

  Widget _careTakerRow(name, description) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                height: 1.5,
              )),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      );
}
