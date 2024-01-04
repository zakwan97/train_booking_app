import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:train_booking_app/shared/size_shared.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: const Text(
          'Profile',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            profileImage('assets/images/avatar-circle.png'),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              margin: EdgeInsets.symmetric(vertical: Height.sizedbox_height_10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    margin: EdgeInsets.symmetric(
                        vertical: Height.sizedbox_height_10),
                    child: profileDetails(title: "Profile"),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    margin: EdgeInsets.symmetric(
                        vertical: Height.sizedbox_height_10),
                    child: profileDetails(title: "Wallet"),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    margin: EdgeInsets.symmetric(
                        vertical: Height.sizedbox_height_10),
                    child: profileDetails(title: "Settings"),
                  ),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    margin: EdgeInsets.symmetric(
                        vertical: Height.sizedbox_height_10),
                    child: profileDetails(title: "About Us"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileImage(String? image) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: Height.sizedbox_height_15),
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Image.asset(
      image!,
      height: 16.h,
      width: 34.6.w,
    ),
  );
}

Widget profileDetails({String? title}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: Height.sizedbox_height_10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title!,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 12,
          color: Colors.black,
        ),
      ],
    ),
  );
}
