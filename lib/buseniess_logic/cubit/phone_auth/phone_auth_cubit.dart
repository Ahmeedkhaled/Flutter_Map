import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;
  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future <void> submitPhoneNumber(String phoneNumber)async{
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: "+2$phoneNumber",
  timeout: const Duration(seconds: 14),
  verificationCompleted:verificationCompleted ,
  verificationFailed: verificationFailed,
  codeSent: codeSent,
  codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
);

  }


 void verificationCompleted (PhoneAuthCredential credential) async {
   print("verificationCompleted");
    await signIn(credential);
  }
  void verificationFailed (FirebaseAuthException e) {
       print("verificationFailed");

    emit(PhoneAuthError(errorMessage: e.toString()));
    print(e.toString());
  }
  void codeSent (String verificationId, int? resendToken) async {
    print("codeSent");
    this.verificationId=verificationId;
    emit(PhoneAuthSubmited());
  }
void codeAutoRetrievalTimeout(String verificationId){
  print("codeAutoRetrievalTimeout");

}
Future<void> submitOtp(String otpCode)async{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
}

Future<void> signIn(PhoneAuthCredential credential)async{
  FirebaseAuth auth = FirebaseAuth.instance;
  try{
    await auth.signInWithCredential(credential);
    emit(PhoneOtpVerified());
  
  }catch(e){
    emit(PhoneAuthError(errorMessage: e.toString()));
  }
}
Future<void> logOut()async{
  await FirebaseAuth.instance.signOut();
}
User getLoggedInUser(){
  return FirebaseAuth.instance.currentUser!;
}
}