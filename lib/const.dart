import 'dart:ui';

import 'package:etiqa/model/plan_model.dart';

const kPrimary = Color(0xffFFBF00);
const kGrey = Color(0xffF5F7FF);

List plan = [
  {"product": "Product ABC", "isSelected": false},
  {"product": "Product DEF", "isSelected": false},
  {"product": "Product GHI", "isSelected": false},
];

List<ChildPlan> childPlans = [
  ChildPlan(
      name: "Rider A",
      minPremium: 100,
      maxPremium: 500,
      minSum: 100000,
      maxSum: 200000,
      isSelected: false),
  ChildPlan(
    name: "Rider B",
    minPremium: 200,
    maxPremium: 1000,
    minSum: 200000,
    maxSum: null,
  ),
  ChildPlan(
    name: "Rider C",
    minPremium: 300,
    maxPremium: 2000,
    minSum: 300000,
    maxSum: 500000,
  ),
];
