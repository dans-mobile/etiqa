import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/view/details_child_view.dart';
import 'package:etiqa/view/details_dependant_view.dart';
import 'package:etiqa/viewmodel/form_viewmodel.dart';
import 'package:etiqa/widget/bottom_sheet.dart';
import 'package:etiqa/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final viewmodel = Get.put(FormViewModel());
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  late TextEditingController premium;
  late TextEditingController sumInsured;
  late TextEditingController dependantName;
  late TextEditingController dependantAge;

  @override
  void initState() {
    super.initState();

    resetToggle();
    premium = TextEditingController();
    sumInsured = TextEditingController();
    dependantName = TextEditingController();
    dependantAge = TextEditingController();
  }

  resetToggle() {
    for (var e in plan) {
      e["isSelected"] = false;
    }
  }

  @override
  void dispose() {
    super.dispose();

    premium.dispose();
    sumInsured.dispose();
    dependantName.dispose();
    dependantAge.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: GetBuilder<FormViewModel>(builder: (viewmodel) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _selectPlan(),
                  _selectChildPlan(),
                  _addDependant(),
                  SizedBox(height: 2.h),
                  const Divider(
                    thickness: 2,
                  ),
                  SizedBox(height: 2.h),
                  _generatedButton()
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _cardItem(var item) {
    return Card(
      color: item["isSelected"] != true ? Colors.white : kPrimary,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item["product"],
                style: GoogleFonts.montserrat(),
              ),
              Checkbox(
                activeColor: kPrimary,
                shape: const CircleBorder(),
                value: item["isSelected"],
                onChanged: (value) {
                  for (var e in plan) {
                    e["isSelected"] = false;
                  }

                  if (value == true) {
                    item["isSelected"] = value;
                    viewmodel.isPlanSelected.value = value!;
                    viewmodel.selectedProduct = item["product"];
                  } else {
                    viewmodel.isPlanSelected.value = value!;
                  }

                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectPlan() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          "Select Plan",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
            height: 10.h,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: plan.length,
              itemBuilder: (BuildContext context, int index) {
                var item = plan[index];
                return _cardItem(item);
              },
            ))
      ],
    );
  }

  _selectChildPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Child Plan",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Visibility(
              visible: viewmodel.selectedChildPlans.isNotEmpty,
              child: InkWell(
                onTap: (() => Get.to(() => DetailsChildView(
                    childPlans: viewmodel.selectedChildPlans))),
                child: Text(
                  "${viewmodel.selectedChildPlans.length} Child Plans",
                  style: GoogleFonts.montserrat(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        viewmodel.selectedChildPlan != null ? _childPlanForm() : Container(),
        SizedBox(
          height: viewmodel.selectedChildPlan != null ? 3.h : 2.h,
        ),
        Obx(
          () => Visibility(
            visible: viewmodel.selectedChildPlan == null,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 6.h,
              child: ElevatedButton(
                onPressed: viewmodel.isPlanSelected.value
                    ? () => _bottomSheet()
                    : null,
                style: ElevatedButton.styleFrom(primary: kPrimary),
                child: Text(
                  "+ Add Child Plan",
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _addDependant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add Dependant",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Visibility(
              visible: viewmodel.selectedDependents.isNotEmpty,
              child: InkWell(
                onTap: (() => Get.to(() => DetailsDependantView(
                    dependants: viewmodel.selectedDependents))),
                child: Text(
                  "${viewmodel.selectedDependents.length} Dependants",
                  style: GoogleFonts.montserrat(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Visibility(
          visible: viewmodel.showDependentForm.value,
          child: _dependentForm(),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 6.h,
          child: Visibility(
            visible: !viewmodel.showDependentForm.value,
            child: ElevatedButton(
              onPressed: viewmodel.selectedChildPlan != null ||
                      viewmodel.selectedChildPlans.isNotEmpty
                  ? () {
                      // if (_formKey.currentState!.validate()) {
                      //   viewmodel.showDependentForm.value = true;
                      //   viewmodel.refresh();
                      // }
                      viewmodel.showDependentForm.value = true;
                      viewmodel.refresh();
                    }
                  : () {
                      print('sini');
                    },
              style: ElevatedButton.styleFrom(primary: kPrimary),
              child: Text(
                "+ Add Dependant",
                style: GoogleFonts.montserrat(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }

  _generatedButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 6.h,
      child: ElevatedButton(
        onPressed: viewmodel.selectedChildPlans.isNotEmpty
            ? () {
                viewmodel.generateProduct();
              }
            : null,
        style: ElevatedButton.styleFrom(primary: Colors.black),
        child: Text(
          "Generated Plan",
          style: GoogleFonts.montserrat(
            color: kPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _bottomSheet() {
    return showMaterialModalBottomSheet(
        expand: false,
        context: context,
        builder: (context) => const BottomSheetBody());
  }

  _childPlanForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      viewmodel.selectedChildPlan!.name,
                      style: GoogleFonts.montserrat(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.green,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (viewmodel.showDependentForm.value) {
                            if (_formKey2.currentState!.validate()) {
                              viewmodel.addChildPlan();
                              // resetToggle();
                              viewmodel.cancelChildPlan();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Child Plan Successfully added!')),
                              );
                              return;
                            }
                          } else {
                            int intPremium = int.parse(premium.text);
                            int intSumInsured = int.parse(sumInsured.text);

                            viewmodel.selectedChildPlan?.selectedPremium =
                                intPremium;

                            viewmodel.selectedChildPlan?.selectedSum =
                                intSumInsured;

                            viewmodel.addChildPlan();
                            viewmodel.cancelChildPlan();
                            // resetToggle();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Child Plan Successfully added!')),
                            );
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                      ),
                    ),
                    IconButton(
                      color: Colors.red,
                      onPressed: () {
                        viewmodel.cancelChildPlan();
                        viewmodel.cancelDependant();

                        // for (ChildPlan e in childPlans) {
                        //   e.isSelected = false;
                        // }
                      },
                      icon: const Icon(
                        Icons.cancel,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Premium",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Min. Premium: RM${viewmodel.selectedChildPlan!.minPremium}",
                  style: GoogleFonts.montserrat(),
                ),
                Text(
                  "Max. Premium: RM ${viewmodel.selectedChildPlan!.maxPremium}",
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextField(
                  controller: premium,
                  strLenght:
                      viewmodel.selectedChildPlan!.maxPremium.toString().length,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter premium amount";
                    } else {
                      int amount = int.parse(value);

                      if (amount < viewmodel.selectedChildPlan!.minPremium ||
                          amount > viewmodel.selectedChildPlan!.maxPremium) {
                        return "Please enter the amount accordingly";
                      }
                    }

                    return null;
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "Min. Sum Insured: RM ${viewmodel.selectedChildPlan!.minSum}",
                  style: GoogleFonts.montserrat(),
                ),
                Text(
                  "Max. Sum Insured: RM ${viewmodel.selectedChildPlan!.maxSum}",
                  style: GoogleFonts.montserrat(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Visibility(
                  child: CustomTextField(
                    controller: sumInsured,
                    // ignore: prefer_null_aware_operators
                    strLenght: viewmodel.selectedChildPlan!.maxSum != null
                        ? viewmodel.selectedChildPlan!.maxSum.toString().length
                        : null,
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter premium amount";
                      } else {
                        int amount = int.parse(value);

                        if (viewmodel.selectedChildPlan!.maxSum != null) {
                          if (amount < viewmodel.selectedChildPlan!.minSum ||
                              amount > viewmodel.selectedChildPlan!.maxSum!) {
                            return "Please enter the amount accordingly";
                          }
                        }

                        if (viewmodel.selectedChildPlan!.maxSum == null &&
                            amount < viewmodel.selectedChildPlan!.minSum) {
                          return "Amount Insured cannot be low than minimum";
                        }
                      }

                      return null;
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _dependentForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kGrey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Dependant ${viewmodel.selectedDependents.length + 1}",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      color: Colors.green,
                      onPressed: () {
                        if (_formKey2.currentState!.validate()) {
                          int age =
                              int.parse(dependantAge.text.removeAllWhitespace);

                          Dependant dependent =
                              Dependant(name: dependantName.text, age: age);

                          viewmodel.addDependant(dependent);
                          viewmodel.cancelDependant();
                          dependantAge.clear();
                          dependantName.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                      ),
                    ),
                    IconButton(
                      color: Colors.red,
                      onPressed: () {
                        viewmodel.cancelDependant();
                        dependantAge.clear();
                        dependantName.clear();
                      },
                      icon: const Icon(
                        Icons.cancel,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextField(
                  controller: dependantName,
                  textInputType: TextInputType.name,
                  labelText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the required information";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextField(
                  controller: dependantAge,
                  labelText: "Age",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the required information";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
