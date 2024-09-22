import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okuur/controllers/add_log_controller.dart';
import 'package:okuur/core/constants/colors.dart';
import 'package:okuur/routes/addLog/components/add_log_app_bar.dart';
import 'package:okuur/routes/addLog/components/add_log_button.dart';
import 'package:okuur/routes/addLog/components/log_info.dart';

class AddLogPage extends StatefulWidget {
  const AddLogPage({super.key});

  @override
  State<AddLogPage> createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {

  @override
  void initState() {
    super.initState();
    Get.put(AddLogController());
    AddLogController controller = Get.find();
    controller.clearAll();
  }

  AppColors colors = AppColors();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: null,
        body: Padding(
          padding: const EdgeInsets.only(right: 12,left: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 12,),
                  addLogAppBar(context),
                  const SizedBox(height: 16,),
                  const LogInfo(),
                  const SizedBox(height: 12,),
                  AddLogButton(),
                  const SizedBox(height: 12,),
                ],),
            ),
          ),
        ),
      ),
    );
  }

}