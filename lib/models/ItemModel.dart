class ItemModel {
  String code;

  String? name;

  Map<String, dynamic>? gsInfo;

  ItemModel({required this.code});

  Future<String?> getName() async{
    name ??= "NAME $code";
    return name;
  }

  Future<Map<String, dynamic>?> getGS1Info() async{
    gsInfo ??= {"manufacturer" : "OLOLO", "weight": "5", "weightType": "kg", "description"  : "new not found ever prodict"};
    return gsInfo;
  }

  Future<ItemModel> loadInfo() async{
    await getName();
    await getGS1Info();
    return this;
  }

  @override
  String toString() {
    return "{ name: '$name', parameters: ";
  }
}
