class LoginService {
  // Future<void> loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     final email = emailTextController.text;
  //     final password = passwordTextController.text;

  //     // Query the Supabase database to fetch user details
  //     final response = await supabase
  //         .from('users')
  //         .select()
  //         .eq('email', email)
  //         .eq('password', password)
  //         .execute();

  //     if (response.error == null && response.data.isNotEmpty) {
  //       // User with the provided email and password exists
  //       // You can navigate to the home page or perform other actions here
  //       Navigator.pushNamed(context, '/homePage');
  //     } else {
  //       // User not found or password is incorrect
  //       // Handle the login error
  //     }
  //   }
  // }
}
