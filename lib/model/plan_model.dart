import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.name,
    required this.childPlans,
    this.dependants,
  });

  String name;
  List<ChildPlan>? childPlans;
  List<Dependant>? dependants;
  int id;

  @override
  List<Object> get props => [id];

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        id: json["id"],
        childPlans: json["childPlans"] != null
            ? List<ChildPlan>.from(
                json["childPlans"].map((x) => ChildPlan.fromJson(x)))
            : [],
        dependants: json["dependants"] != null
            ? List<Dependant>.from(
                json["dependants"].map((x) => Dependant.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "childPlans": childPlans != null
            ? List<dynamic>.from(
                childPlans!.map((x) => x.toJson()),
              )
            : [],
        "dependants": dependants != null
            ? List<dynamic>.from(
                dependants!.map((x) => x.toJson()),
              )
            : [],
      };
}

class ChildPlan {
  ChildPlan({
    required this.name,
    required this.minPremium,
    required this.maxPremium,
    required this.minSum,
    this.maxSum,
    this.selectedSum,
    this.selectedPremium,
    this.isSelected = false,
  });

  String name;
  int minPremium;
  int maxPremium;
  int? selectedPremium;
  int minSum;
  int? maxSum;
  int? selectedSum;
  bool isSelected;

  factory ChildPlan.fromJson(Map<String, dynamic> json) => ChildPlan(
        name: json["name"],
        minPremium: json["minPremium"],
        maxPremium: json["maxPremium"],
        minSum: json["minSum"],
        maxSum: json["maxSum"] ?? 0,
        selectedPremium: json["selectedPremium"],
        selectedSum: json["selectedSum"] ?? json["minSum"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "minPremium": minPremium,
        "maxPremium": maxPremium,
        "minSum": minSum,
        "maxSum": maxSum,
        "selectedPremium": selectedPremium,
        "selectedSum": selectedSum ?? 0,
      };
}

class Dependant {
  Dependant({
    required this.name,
    required this.age,
  });

  String name;
  int age;

  factory Dependant.fromJson(Map<String, dynamic> json) => Dependant(
        name: json["name"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
      };
}
