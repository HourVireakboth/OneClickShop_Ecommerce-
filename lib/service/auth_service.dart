import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Googel Sign In
  static String? gmail;
  static String? gname;
  Future<bool> signInwithGoogel() async {
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    gmail = gUser?.email;
    gname = gUser?.displayName;
    print("Guser email=${gUser?.email}");
    print("Guser id=${gUser?.id}");
    print("Guser displayName:${gUser?.displayName}");

    // obatiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print("Guser AccessToken:${gAuth.accessToken}");
    print("Guser idToken:${gAuth.idToken}");

    // create a new credentail for user

    // finally, lets sign in
    if (gmail!.isNotEmpty && gname!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
