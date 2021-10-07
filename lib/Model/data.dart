import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';
@JsonSerializable()
class User{
  late int id;
  late String name;
  late String email;
  late String gender;
  late String status;
  late String created_at;
  late String updated_at;

  User(this.id, this.name, this.email, this.gender, this.status,
      this.created_at, this.updated_at);

  factory User.fromJson(Map<String,dynamic>json)=>_$UserFromJson(json);
  Map<String,dynamic>toJson()=>_$UserToJson(this);
}


@JsonSerializable()
class ResponseData{
  late int
  code;
  late dynamic meta;
  late List<dynamic> data;

  ResponseData(this.code, this.meta, this.data);
  factory ResponseData.fromJson(Map<String,dynamic>json)=>_$ResponseDataFromJson(json);
  Map<String,dynamic>toJson()=>_$ResponseDataToJson(this);

}