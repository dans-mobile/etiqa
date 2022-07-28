import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EditChildPlanView extends StatelessWidget {
  final List<ChildPlan> childPlans;
  final _formKey = GlobalKey<FormState>();

  EditChildPlanView({Key? key, required this.childPlans}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          "Child Plan Details",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Text(
                        "Child Plans",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: isEdit.value != true
                            ? () {
                                isEdit.value = true;
                              }
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  isEdit.value = false;
                                }
                              },
                        child: Text(
                          !isEdit.value ? "Edit" : "Save",
                          style: GoogleFonts.montserrat(
                            color: !isEdit.value
                                ? Colors.blueAccent
                                : Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Form(
                    key: _formKey,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: childPlans.length,
                        itemBuilder: (context, index) {
                          ChildPlan? childPlan = childPlans[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Obx(
                              () => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Min. Premium : ${childPlan.minPremium}\nMax. Premium : ${childPlan.maxPremium}",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            childPlan.name,
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          isEdit.value
                                              ? SizedBox(
                                                  height: 50,
                                                  width: 30.w,
                                                  child: CustomTextField(
                                                    validator: ((value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Cannot Empty";
                                                      } else {
                                                        int amount =
                                                            int.parse(value);

                                                        if (amount <
                                                                childPlan
                                                                    .minPremium ||
                                                            amount >
                                                                childPlan
                                                                    .maxPremium) {
                                                          return "Wrong amount";
                                                        }
                                                      }

                                                      return null;
                                                    }),
                                                    onChanged: (value) {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        int intValue =
                                                            int.parse(value!);

                                                        childPlan
                                                                .selectedPremium =
                                                            intValue;
                                                      }

                                                      print(childPlan
                                                          .selectedPremium);
                                                    },
                                                    initialValue: childPlan
                                                        .selectedPremium
                                                        .toString(),
                                                  ),
                                                )
                                              : Text(
                                                  "RM ${childPlan.selectedPremium}",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Min. Sum Insured : ${childPlan.minSum}\nMax. Sum Insured : ${childPlan.maxSum}",
                                        style: GoogleFonts.montserrat(),
                                      ),
                                      SizedBox(height: 2.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sum Insured",
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          isEdit.value
                                              ? SizedBox(
                                                  height: 50,
                                                  width: 30.w,
                                                  child: CustomTextField(
                                                    validator: ((value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "Cannot Empty";
                                                      } else {
                                                        int amount =
                                                            int.parse(value);
                                                        if (childPlan.maxSum !=
                                                                null &&
                                                            childPlan.maxSum ==
                                                                0) {
                                                          if (amount <
                                                              childPlan
                                                                  .minSum) {
                                                            return "Wrong amount";
                                                          }
                                                        } else {
                                                          if (amount <
                                                                  childPlan
                                                                      .minSum ||
                                                              amount >
                                                                  childPlan
                                                                      .maxSum!) {
                                                            return "Wrong amount";
                                                          }
                                                        }
                                                      }

                                                      return null;
                                                    }),
                                                    onChanged: (value) {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        int intValue =
                                                            int.parse(value!);

                                                        childPlan.selectedSum =
                                                            intValue;
                                                      }
                                                    },
                                                    initialValue: childPlan
                                                        .selectedSum
                                                        .toString(),
                                                  ),
                                                )
                                              : Text(
                                                  "RM ${childPlan.selectedSum}",
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
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
