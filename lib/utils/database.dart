import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patient_inform/utils/patient_records.dart';
import 'package:patient_inform/utils/user_records.dart';

const String PATIENT_RECORDS_COLLECTION_REF = "patient-records";
const String NOTIFICATIONS_RECORDS_COLLECTION_REF = "notifications-record";
const String APPICATION_USERS_COLLECTION_REF = "app-users";

/// Database service class created to add, delete, and update information.
/// Generic so it can be reused across multiple collections.
/// @author: Ameer Ghazal
class DatabaseService<T> {
  // Create an instance of firestore.
  final _firestore = FirebaseFirestore.instance;

  // Collection reference, used to connect to a specific collection of data in the DB (e.g., user-record).
  late final CollectionReference<T> _collectionReference;
  final FromFirestore<T> fromFirestore;
  final ToFirestore<T> toFirestore;

  // Constructor.
  DatabaseService(String collectionRef,
      {required this.fromFirestore, required this.toFirestore}) {
    // Using the instance, grabs the collection with the ID, and converts the output data into the dictonary we specified in our patient records structure.
    _collectionReference = _firestore
        .collection(collectionRef)
        .withConverter<T>(
            fromFirestore: fromFirestore, toFirestore: toFirestore);
  }

  // // Get the current user data.
  // static Future<Map<String, dynamic>> getUserData() async {
  //   // Grab the users'
  // }

  // Get the patient data from the database.
  Stream<QuerySnapshot<T>> getData() {
    return _collectionReference.snapshots();
  }

  // Return a specific user's data.
  Stream<DocumentSnapshot> getUserData(String? userId) async* {
    var documentID = await getDocumentIdByUserId(userId);
    if (documentID != null) {
      yield* _collectionReference.doc(documentID).snapshots();
    }
  }

  // Get the document ID by the user ID.
  Future<String?> getDocumentIdByUserId(String? userId) async {
    var querySnapshot =
        await _collectionReference.where('firebaseID', isEqualTo: userId).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there's only one document per user ID
      return querySnapshot.docs.first.id;
    }

    return null; // No document found for the user ID
  }

  // Add data to database, based on the collection reference.
  void addData(T data) async {
    _collectionReference.add(data);
  }

  // Update data.
  void updateData(String? userId, T data) async {
    var documentID = await getDocumentIdByUserId(userId);
    _collectionReference.doc(documentID).set(data);
  }

  // Remove data.
  void deleteData(String id) {
    _collectionReference.doc(id).delete();
  }
}


//  // Constructor.
//   DatabaseService(ref, {required FirestoreConverter<T> converter}) {
//     // Using the instance, grabs the collection with the ID, and converts the output data into the dictonary we specified in our patient records structure.
//     _patientDataRef = _firestore.collection(ref).withConverter<PatientRecords>(
//         fromFirestore: (snapshots, _) =>
//             PatientRecords.fromJson(snapshots.data()!),
//         toFirestore: (patientRecord, _) => patientRecord.toJson());
//   }

//   // // Get the current user data.
//   // static Future<Map<String, dynamic>> getUserData() async {
//   //   // Grab the users'
//   // }

//   // Get the patient data from the database.
//   Stream<QuerySnapshot> getPatientData() {
//     print("made it here.");
//     print(_patientDataRef.id);
//     return _patientDataRef.limit(1).snapshots();
//   }

//   // Add user data to the database.
//   void addUserData(UserRecords userRecord) {}

//   // Add patient data to the database.
//   void addPatientData(PatientRecords patientRecord) {
//     _patientDataRef.add(patientRecord);
//   }

//   // Update patient data.
//   void updatePatientData(String patientDataID, PatientRecords patientRecord) {
//     _patientDataRef.doc(patientDataID).update(patientRecord.toJson());
//   }

//   // Remove patient data.
//   void deletePatientData(String patientDataID) {
//     _patientDataRef.doc(patientDataID).delete();
//   }
// }
