class GenerData {
  late final List<GenerModel> list;

  GenerData.fromJson(Map<String, dynamic> json){
    list = List.from(json['genres']).map((e)=>GenerModel.fromJson(e)).toList();
  }
}

class GenerModel {

  late final int id;
  late final String name;

  GenerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }


}