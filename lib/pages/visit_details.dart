import 'package:flutter/material.dart';
import 'package:patient_inform/pages/current_visit_page.dart';
import 'package:patient_inform/utils/current_visit_data.dart';
import 'package:patient_inform/widgets/themed_app_bar.dart';
import 'package:patient_inform/utils/constants.dart';

//TODO: Make data into format like Home Page for data transfer from database
class VisitDetailsPage extends StatelessWidget {
  static const _currentVisits = [
    CurrentVisitData(
        timeOfEvent: '2:00pm',
        eventDescription: 'You have checked into the Smith Health ER'),
    CurrentVisitData(
        timeOfEvent: '2:15pm',
        eventDescription:
            'Your care starts soon, Shelly the ER Triage Nurse will be with you in just a moment. Be ready to answer some questions about your visit today. '),
    CurrentVisitData(
        timeOfEvent: '2:30pm',
        eventDescription:
            'Shelly completed your triage and you are assigned a Triage Level 3 (Click here to see what that means)\nEstimated Wait Time is 60 minutes.'),
    CurrentVisitData(
        timeOfEvent: '2:35pm',
        eventDescription:
            'An order for Abdominal X-ray has been placed and blood work has been requested.'),
    CurrentVisitData(
        timeOfEvent: '2:40pm',
        eventDescription:
            'Eric with Xray just signed up to come take you to get your Xray - He will be with you momentarily.'),
    CurrentVisitData(
        timeOfEvent: '2:45pm',
        eventDescription:
            'Steve with lab will be by to take you for a blood draw - This will happen right after your X-ray.'),
    CurrentVisitData(
        timeOfEvent: '3:30pm',
        eventDescription:
            'Your X-ray has been read by the radiologist Dr. Smith - We are working hard to get you into an ER Room.'),
    CurrentVisitData(
        timeOfEvent: '3:45pm', eventDescription: 'Your blood work is back.'),
    CurrentVisitData(
        timeOfEvent: '3:50pm',
        eventDescription:
            'A room just opened up and your Nurse will be Cheyenne, she or the tech will be out to pick you up and take you to your room.'),
    CurrentVisitData(
        timeOfEvent: '4:00pm',
        eventDescription:
            'Dr. Sinek just signed up and will be here soon. He is finshing up on some other patients. Please press your call out if you need your Nurse Cheyenne or your Tech.'),
    CurrentVisitData(
        timeOfEvent: '4:15pm',
        eventDescription:
            'The doctor has ordered some pain meds and your nurse will be bringing them shortly.'),
    CurrentVisitData(
        timeOfEvent: '5:00pm',
        eventDescription:
            'We are glad you are feeling better. Your discharge orders as well as a work note has been printed. Your nurse will bring them in soon. Please feel free to ask any questions.'),
    CurrentVisitData(
        timeOfEvent: '5:30pm',
        eventDescription:
            'We thank you for your visit today at Smith Health. Your care team was Cheyenne RN and Dr. Sinek. We hope we took excellent care of you or your loved one today. Please feel free to rate us on a scale of 0-10 where 10 is excellent. Don\'t forget to follow up with your Primary Care Provider and find your results from today\'s visit on your MyChart (Link to MyChart)'),
  ];

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
                // child: const Text("Insert Painter Here"),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    for (var i = 0; i < _currentVisits.length; ++i)
                      CurrentVisitEvent(
                          data: _currentVisits[i],
                          isLastEvent: i == _currentVisits.length - 1)
                  ],
                ),
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
