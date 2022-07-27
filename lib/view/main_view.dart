import 'package:etiqa/const.dart';
import 'package:etiqa/model/plan_model.dart';
import 'package:etiqa/view/details_view.dart';
import 'package:etiqa/view/form_view.dart';
import 'package:etiqa/viewmodel/main_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MainPageView extends StatelessWidget {
  MainPageView({Key? key}) : super(key: key);

  final viewmodel = Get.put(MainPageViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: SafeArea(
          child: GetBuilder<MainPageViewModel>(builder: (viewmodel) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
              child: viewmodel.products.isNotEmpty
                  ? ListView.builder(
                      itemCount: viewmodel.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = viewmodel.products[index];
                        return _cardItem(context, index, product);
                      },
                    )
                  : Center(
                      child: Text(
                        "You have not added any plans yet.",
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
            );
          }),
        ),
        bottomNavigationBar: _bottomButton());
  }

  Widget _cardItem(BuildContext context, int index, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 5.h,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: (() => Get.to(() => DetailsView(
                            product: product,
                          ))),
                      child: Text(
                        "View Details",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.childPlans!.first.name,
                        style: GoogleFonts.montserrat(),
                      ),
                      Text(
                        "RM ${product.childPlans!.first.selectedPremium}",
                        style: GoogleFonts.montserrat(),
                      ),
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
                        "RM ${product.childPlans!.first.selectedSum}",
                        style: GoogleFonts.montserrat(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  product.dependants != null && product.dependants!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Dependents",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.dependants![0].name,
                                  style: GoogleFonts.montserrat(),
                                ),
                                Text(
                                  "${product.dependants![0].age}",
                                  style: GoogleFonts.montserrat(),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: kPrimary,
      centerTitle: true,
      title: Text(
        "Insurance App",
        style: GoogleFonts.montserrat(),
      ),
      actions: [
        IconButton(
            onPressed: () => viewmodel.retrieveProducts(),
            icon: const Icon(Icons.refresh))
      ],
    );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 48.0,
      ),
      child: SizedBox(
        height: 8.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kPrimary,
            shape: const StadiumBorder(),
          ),
          onPressed: () async {
            await Get.to(
              () => const FormView(),
            );

            viewmodel.retrieveProducts();
          },
          child: Text(
            'ADD PLAN',
            style: GoogleFonts.montserratAlternates(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
