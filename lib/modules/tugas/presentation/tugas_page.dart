import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eofficeapp/common/themes/styles.dart';
import 'package:eofficeapp/modules/home/controllers/home_controller.dart';
import 'package:eofficeapp/modules/tugas/presentation/tugas_tab_pagi_page.dart';
import 'package:eofficeapp/modules/tugas/presentation/tugas_tab_siang_page.dart';

import '../controllers/tugas_controller.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({
    Key? key,
    required this.waktuTugas,
  }) : super(key: key);

  final int waktuTugas;

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late TugasController tugasController;
  late HomeController office2controller;
  final formatDate = DateFormat('yyyy-MM-dd');

  int currentTabIndex = 0;

  @override
  void initState() {
    tugasController = Get.put(TugasController());
    Get.lazyPut(() => HomeController());
    office2controller = Get.find<HomeController>();
    tugasController.tabIndex = widget.waktuTugas - 1;
    tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: widget.waktuTugas - 1,
    );
    if (widget.waktuTugas == 1) {
      tugasController.tugasTabPagiController.isLoading = false;
      tugasController.tugasTabPagiController.date = tugasController.date;
      tugasController.tugasTabPagiController.initLoadData();
    } else if (widget.waktuTugas == 2) {
      tugasController.tugasTabSiangController.isLoading = false;
      tugasController.tugasTabSiangController.date = tugasController.date;
      tugasController.tugasTabSiangController.initLoadData();
    }
    currentTabIndex = widget.waktuTugas - 1;
    tabController.animation!.addListener(() {
      var val = tabController.animation!.value + 0;
      var tabIndexRound = val.round();
      if (currentTabIndex != tabIndexRound) {
        changeTab(tabIndexRound);
      }
      currentTabIndex = tabIndexRound;
    });
    super.initState();
  }

  changeTab(int index) {
    tugasController.tabIndex = index;
    if (index == 0) {
      if (tugasController.tugasTabPagiController.date != tugasController.date) {
        tugasController.tugasTabPagiController.isLoading = false;
        tugasController.tugasTabPagiController.date = tugasController.date;
        tugasController.tugasTabPagiController.initLoadData();
      }
    } else if (index == 1) {
      if (tugasController.tugasTabSiangController.date !=
          tugasController.date) {
        tugasController.tugasTabSiangController.isLoading = false;
        tugasController.tugasTabSiangController.date = tugasController.date;
        tugasController.tugasTabSiangController.initLoadData();
      }
    }
  }

  refreshChangeTab() {
    changeTab(currentTabIndex);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            statusBarColor: mainColor.shade900,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.black,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blueGrey,
          elevation: 0,
          bottom: TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blueGrey,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: tugasController.tabIndex == 0
                  ? Colors.blue
                  : Colors.amber.shade600,
            ),
            indicatorPadding: const EdgeInsets.all(5),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("PAGI"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SIANG"),
                  ],
                ),
              ),
            ],
          ),
          title: const Text('Tugas'),
          actions: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 150,
              child: Center(
                child: FormBuilderDateTimePicker(
                  name: 'tanggal',
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialValue: tugasController.date,
                  inputType: InputType.date,
                  minLines: 1,
                  format: formatDate,
                  style: const TextStyle(color: Colors.blueGrey),
                  decoration: const InputDecoration(
                    labelText: '',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 6,
                    ),
                    filled: false,
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.blueGrey,
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    tugasController.date = value;
                    refreshChangeTab();
                  },
                ),
              ),
            ),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            TugasTabPagiPage(),
            TugasTabSiangPage(),
          ],
        ),
      ),
    );
  }
}
