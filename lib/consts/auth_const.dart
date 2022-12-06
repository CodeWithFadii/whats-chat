import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

User? user = firebaseAuth.currentUser;
const String collectionUser = 'User';
const String collectionChats = 'Chats';
