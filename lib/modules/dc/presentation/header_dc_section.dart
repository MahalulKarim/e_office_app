import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';
import 'package:eofficeapp/modules/profil/presentation/profil_page.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HeaderDCSection extends StatelessWidget {
  const HeaderDCSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    final AuthController authController = Get.find<AuthController>();

    Future<void> showProfileDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: Obx(
              () => (authController.userdata['id_user'] != null &&
                      authController.userdata['id_user'] != "")
                  ? Row(
                      children: [
                        (authController.userdata['foto_url'] != null &&
                                authController.userdata['foto_url'] != "")
                            ? CachedNetworkImage(
                                height: 55,
                                width: 55,
                                fit: BoxFit.cover,
                                imageUrl: authController.userdata['foto_url'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    SkeletonAnimation(
                                  shimmerColor: Colors.blueGrey.shade50,
                                  shimmerDuration: 1000,
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 55,
                                  width: 55,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 32,
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                radius: 24,
                                backgroundColor: mainColor,
                                foregroundColor: Colors.white,
                                child: Text(
                                  authController.userdata['email'] != null
                                      ? authController.userdata['email'][0]
                                          .toUpperCase()
                                      : "",
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authController.userdata['email'] ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                authController.userdata['phone'] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                      Get.to(() => const ProfilPage());
                    },
                    child: const Text(
                      "Edit profil",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      await authController.logout();
                      Get.offAllNamed('/splash');
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          );
        },
      );
    }

    return Obx(
      () => Container(
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Image.asset(
                'assets/img_logo.png',
                height: 40,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            authController.userdata != null
                ? authController.userdata['id_user'] == null
                    ? ElevatedButton(
                        onPressed: () => Get.toNamed(
                          '/login',
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          showProfileDialog();
                        },
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      )
                : const SizedBox(),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
