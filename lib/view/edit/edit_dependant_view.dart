import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EditDependantView extends StatelessWidget {
  final List<Dependant> dependents;
  final _formKey = GlobalKey<FormState>();

  EditDependantView({Key? key, required this.dependents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          "Dependant Plan Details",
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
                        "Dependant",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: isEdit != true
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
                        shrinkWrap: true,
                        itemCount: dependents.length,
                        itemBuilder: (context, index) {
                          Dependant? dependant = dependents[index];
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
                                      SizedBox(height: 2.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Name",
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
                                                        }

                                                        return null;
                                                      }),
                                                      onChanged: (value) {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          dependant.name =
                                                              value!;
                                                        }
                                                      },
                                                      initialValue:
                                                          dependant.name),
                                                )
                                              : Text(
                                                  dependant.name,
                                                  style: GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      SizedBox(height: 2.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Age",
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
                                                      }

                                                      return null;
                                                    }),
                                                    onChanged: (value) {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        int intValue =
                                                            int.parse(value!);

                                                        dependant.age =
                                                            intValue;
                                                      }
                                                    },
                                                    initialValue: dependant.age
                                                        .toString(),
                                                  ),
                                                )
                                              : Text(
                                                  "${dependant.age}",
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
