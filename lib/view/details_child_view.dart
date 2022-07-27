import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DetailsChildView extends StatelessWidget {
  final List<ChildPlan> childPlans;
  const DetailsChildView({Key? key, required this.childPlans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Text(
                "Child Plans",
                style: GoogleFonts.montserrat(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 1.h),
              Card(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: childPlans.length,
                    itemBuilder: (context, index) {
                      ChildPlan? childPlan = childPlans[index];
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            ],
          ),
        ),
      ),
    );
  }
}
