import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:nabung_dong/app/routes/app_pages.dart';
import 'package:nabung_dong/app/utils/app_color.dart';
import 'package:nabung_dong/app/widgets/custom_input.dart';

import 'setting_controller.dart';

class BootstrapButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color textColor;

  const BootstrapButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          elevation: 0,
          primary: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class SettingView extends GetView<SettingController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: mHeight / 7,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Image.asset(
              "assets/images/square.png",
              width: mWidth / 3,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About The Application",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text("Aplikasi ini dibuat oleh:"),
                Text("Nama\t\t\t\t : Tegar Dwi Vantoro"),
                Text("NIM\t\t\t\t\t\t\t\t: 2141764134"),
                Text("Tanggal\t: 23 September 2023"),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mHeight,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ganti Password',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passC,
                  label: "Password Saat Ini",
                  hint: "Masukkan password anda saat ini",
                  obsecureText: controller.obsecureText.value,
                  suffixIcon: IconButton(
                    icon: (controller.obsecureText != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureText.value =
                          !(controller.obsecureText.value);
                    },
                  ),
                ),
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passNewC,
                  label: "Password Baru",
                  hint: "Masukkan password baru anda",
                  obsecureText: controller.obsecureTextNew.value,
                  suffixIcon: IconButton(
                    icon: (controller.obsecureTextNew != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureTextNew.value =
                          !(controller.obsecureTextNew.value);
                    },
                  ),
                ),
              ),
              Obx(
                () => BootstrapButton(
                  text:
                      (controller.isLoading.isFalse) ? 'Simpan' : 'Loading...',
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.changePassword();
                    }
                  },
                  backgroundColor: AppColor.primaryColor,
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BootstrapButton(
                text: 'Kembali',
                onPressed: () async {
                  Get.back();
                },
                backgroundColor: AppColor.dark,
                textColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              BootstrapButton(
                text: 'Logout',
                onPressed: () async {
                  Get.offAllNamed(Routes.LOGIN);
                },
                backgroundColor: AppColor.contentColorRed,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
