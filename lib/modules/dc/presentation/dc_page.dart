import 'package:accordion/accordion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eofficeapp/modules/logo-banner/logo_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/auth/controllers/auth_controller.dart';
import 'package:eofficeapp/modules/dc/controllers/dc_page_controller.dart';
import 'package:eofficeapp/modules/dc/presentation/header_dc_section.dart';
import 'package:eofficeapp/modules/profil/controllers/profil_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class DCPage extends StatefulWidget {
  const DCPage({Key? key}) : super(key: key);

  @override
  State<DCPage> createState() => _DCPageState();
}

class _DCPageState extends State<DCPage> {
  late AuthController authController;
  final DCPageController markazPageController = Get.put(DCPageController());
  final profilController = Get.isRegistered<ProfilController>()
      ? Get.find<ProfilController>()
      : Get.put(ProfilController());

  final _refreshController = RefreshController();

  @override
  void initState() {
    Get.lazyPut(() => AuthController());
    authController = Get.find<AuthController>();
    profilController.getProfil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await profilController.getProfil();
            _refreshController.refreshCompleted();
            _refreshController.loadComplete();
          },
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 10,
                    ),
                    child: const HeaderDCSection(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authController.userdata['id_user'] != null &&
                                  authController.userdata['id_user'] != ""
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(21),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.blueGrey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      (authController.userdata['foto_url'] !=
                                                  null &&
                                              authController
                                                      .userdata['foto_url'] !=
                                                  "")
                                          ? CachedNetworkImage(
                                              height: 55,
                                              width: 55,
                                              fit: BoxFit.cover,
                                              imageUrl: authController
                                                  .userdata['foto_url'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
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
                                                shimmerColor:
                                                    Colors.blueGrey.shade50,
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
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
                                                authController.userdata[
                                                            'email'] !=
                                                        null
                                                    ? authController
                                                        .userdata['email'][0]
                                                        .toUpperCase()
                                                    : "",
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              authController
                                                      .userdata['email'] ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              authController
                                                      .userdata['phone'] ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Accordion(
                              maxOpenSections: 5,
                              paddingListTop: 10,
                              disableScrolling: true,
                              headerBackgroundColor: Colors.blue.shade800,
                              contentBorderColor: Colors.blue.shade800,
                              contentBackgroundColor: Colors.blue.shade100,
                              paddingListHorizontal: 0,
                              scaleWhenAnimating: false,
                              children: [
                                AccordionSection(
                                  isOpen: true,
                                  headerBorderRadius: 14,
                                  contentBorderRadius: 14,
                                  contentVerticalPadding: 16,
                                  contentHorizontalPadding: 16,
                                  headerPadding: const EdgeInsets.all(10),
                                  leftIcon: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.info_outline_rounded,
                                      color: mainColor,
                                    ),
                                  ),
                                  header: const Text(
                                    'Info',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  content: const Text(
                                    'E-OFFICE adalah Aplikasi pengelolaan kinerja karyawan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                                AccordionSection(
                                  isOpen: true,
                                  headerBorderRadius: 14,
                                  contentBorderRadius: 14,
                                  contentVerticalPadding: 16,
                                  contentHorizontalPadding: 16,
                                  headerPadding: const EdgeInsets.all(10),
                                  leftIcon: Container(
                                    height: 28,
                                    width: 28,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.verified,
                                      color: mainColor,
                                    ),
                                  ),
                                  header: const Text(
                                    'Versi Aplikasi',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  content: Text(
                                    "Versi ${markazPageController.versionStr}",
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Platform.isIOS ? 20 : 0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Platform.isIOS
                                ? ElevatedButton(
                                    onPressed: () {
                                      launchUrl(Uri.parse(
                                          'https://app.eoffice.my.id/deleteaccount'));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      surfaceTintColor: Colors.red,
                                    ),
                                    child: const Text(
                                      "Permohonan Hapus Akun",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                          SizedBox(
                            height: Platform.isIOS ? 20 : 40,
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LogoBanner(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
