import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:train_booking_app/shared/size_shared.dart';
import 'package:train_booking_app/util/preference.dart';

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
          "PROFILE",
          style: TextStyle(color: Colors.white, letterSpacing: 2.0),
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
                  const Divider(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return logoutDialog();
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      margin: EdgeInsets.symmetric(
                          vertical: Height.sizedbox_height_10),
                      child: profileDetails(title: "Log out"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logoutDialog() {
    return AlertDialog(
      title: const Text('Logout'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Are you sure want to logout?'),
          SizedBox(height: Height.sizedbox_height_20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Preference.setBool(Preference.isLogin, false);
                  Preference.remove(Preference.userID);
                  Get.offAllNamed('/loginPage');
                },
                child: const Text('Yes'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'),
              )
            ],
          ),
        ],
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
