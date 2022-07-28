import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/view/edit/edit_child_view.dart';
import 'package:etiqa/view/edit/edit_dependant_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailsView extends StatefulWidget {
  final Product product;
  const DetailsView({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        centerTitle: true,
        title: Text(
          "Details",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Child Plans",
                      style: GoogleFonts.montserrat(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () async {
                        await Get.to(
                          () => EditChildPlanView(
                            childPlans: widget.product.childPlans!,
                          ),
                        );

                        setState(() {});
                      },
                      child: Text(
                        "Edit Form",
                        style: GoogleFonts.montserrat(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 1.h),
                Card(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.product.childPlans?.length,
                      itemBuilder: (context, index) {
                        ChildPlan? childPlan =
                            widget.product.childPlans![index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 2.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    childPlan.name,
                                    style: GoogleFonts.montserrat(),
                                  ),
                                  Text("RM ${childPlan.selectedPremium}",
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sum Insured",
                                    style: GoogleFonts.montserrat(),
                                  ),
                                  Text(
                                    "RM ${childPlan.selectedSum}",
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(height: 5.h),
                Visibility(
                  visible: widget.product.dependants != null &&
                      widget.product.dependants!.isNotEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dependants",
                        style: GoogleFonts.montserrat(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () async {
                          await Get.to(
                            () => EditDependantView(
                              dependents: widget.product.dependants!,
                            ),
                          );

                          setState(() {});
                        },
                        child: Text(
                          "Edit Dependant",
                          style: GoogleFonts.montserrat(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                widget.product.dependants != null &&
                        widget.product.dependants!.isNotEmpty
                    ? Card(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.product.dependants?.length,
                            itemBuilder: (context, index) {
                              Dependant? dependant =
                                  widget.product.dependants![index];
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 2.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dependant.name,
                                          style: GoogleFonts.montserrat(),
                                        ),
                                        Text(
                                          "${dependant.age}",
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
