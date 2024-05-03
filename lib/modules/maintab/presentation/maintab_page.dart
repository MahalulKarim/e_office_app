import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:eofficeapp/modules/laporan/presentation/laporan_3_page.dart';
import 'package:eofficeapp/modules/presensi/presentation/presensi_page.dart';
import '../../dc/presentation/dc_page.dart';
import '../../home/presentation/home_page.dart';

class MainTabPage extends StatefulWidget {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  late PersistentTabController persistentTabController;

  @override
  void initState() {
    permissionCheck();
    persistentTabController = PersistentTabController();
    super.initState();
  }

  permissionCheck() async {
    // if (await Permission.manageExternalStorage.status.isDenied) {
    //   await Permission.manageExternalStorage.request();
    // }
  }

  List<Widget> buildScreens() => [
        const HomePage(),
        const PresensiPage(),
        const Laporan3Page(),
        const DCPage(),
      ];

  List<PersistentBottomNavBarItem> navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.home),
          inactiveIcon: const Icon(LineIcons.home),
          title: "Home",
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          activeColorPrimary: mainColor.shade900,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.fingerprint),
          inactiveIcon: const Icon(LineIcons.fingerprint),
          title: "Presensi",
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          activeColorPrimary: mainColor.shade900,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.bookReader),
          inactiveIcon: const Icon(LineIcons.bookReader),
          title: "Laporan",
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          activeColorPrimary: mainColor.shade900,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.person_circle_fill),
          inactiveIcon: const Icon(CupertinoIcons.person_circle),
          title: "Akun",
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
          activeColorPrimary: mainColor.shade900,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      statusBarColor: mainColor.shade900,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
    ));
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: persistentTabController,
        resizeToAvoidBottomInset: true,
        confineInSafeArea: false,
        screens: buildScreens(),
        items: navBarsItems(),
        bottomScreenMargin: 0,
        backgroundColor: Colors.white,
        padding: const NavBarPadding.only(
          top: 10,
          left: 0,
          right: 0,
        ),
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.black,
        ),
        navBarStyle: NavBarStyle.simple,
        // itemAnimationProperties: const ItemAnimationProperties(
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.ease,
        // ),
        // screenTransitionAnimation: const ScreenTransitionAnimation(
        //   animateTabTransition: true,
        //   curve: Curves.ease,
        //   duration: Duration(milliseconds: 200),
        // ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
