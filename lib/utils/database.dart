import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patient_inform/utils/patient_records.dart';

const String PATIENT_RECORDS_COLLECTION_REF = "patient-records";
const String NOTIFICATIONS_RECORDS_COLLECTION_REF = "notifications-record";

class DatabaseService {
  // Create an instance of firestore.
  final _firestore = FirebaseFirestore.instance;

  // Collection reference, used to connect to a specific collection of data in the DB (e.g., user-record).
  late final CollectionReference _patientDataRef;

  // Constructor.
  DatabaseService(ref) {
    // Using the instance, grabs the collection with the ID, and converts the output data into the dictonary we specified in our patient records structure.
    _patientDataRef = _firestore.collection(ref).withConverter<PatientRecords>(
        fromFirestore: (snapshots, _) =>
            PatientRecords.fromJson(snapshots.data()!),
        toFirestore: (patientRecord, _) => patientRecord.toJson());
  }

  // Get the patient data from the database.
  Stream<QuerySnapshot> getPatientData() {
    return _patientDataRef.limit(1).snapshots();
  }

  // Add patient data to the database.
  void addPatientData(PatientRecords patientRecord) {
    _patientDataRef.add(patientRecord);
  }

  // Update patient data.
  void updatePatientData(String patientDataID, PatientRecords patientRecord) {
    _patientDataRef.doc(patientDataID).update(patientRecord.toJson());
  }

  // Remove patient data.
  void deletePatientData(String patientDataID) {
    _patientDataRef.doc(patientDataID).delete();
  }
}
