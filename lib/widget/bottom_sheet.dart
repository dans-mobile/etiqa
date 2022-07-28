import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/viewmodel/form_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({Key? key}) : super(key: key);

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  final viewmodel = Get.find<FormViewModel>();
  ChildPlan? selectedChildPlan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 2.h),
          Text(
            "Select Child Plan",
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: childPlans.length,
            itemBuilder: (BuildContext context, int index) {
              ChildPlan childPlan = childPlans[index];
              return Row(
                children: [
                  GetBuilder<FormViewModel>(builder: (context) {
                    return Checkbox(
                      activeColor: kPrimary,
                      shape: const CircleBorder(),
                      value: childPlan.isSelected,
                      onChanged: (value) {
                        for (ChildPlan e in childPlans) {
                          e.isSelected = false;
                        }

                        childPlan.isSelected = value!;
                        selectedChildPlan = childPlan;
                        setState(() {});
                      },
                    );
                  }),
                  Text(
                    childPlan.name,
                    style: GoogleFonts.montserrat(),
                  )
                ],
              );
            },
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                if (selectedChildPlan != null) {
                  viewmodel.selectedChildPlan = selectedChildPlan;
                  viewmodel.update();
                }

                Get.back();
              },
              style: ElevatedButton.styleFrom(primary: kPrimary),
              child: Text(
                "Add Plans",
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
