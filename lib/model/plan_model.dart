class Product {
  Product({
    required this.name,
    required this.childPlans,
    this.dependants,
  });

  String name;
  List<ChildPlan>? childPlans;
  List<Dependant>? dependants;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
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
        maxSum: json["maxSum"],
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
        "selectedSum": selectedSum,
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
