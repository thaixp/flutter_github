import 'package:json_annotation/json_annotation.dart';
import 'package:myflutter/models/user.dart';

import 'cacheConfig.dart';

part 'profile.g.dart';


@JsonSerializable()
class Profile{

  @JsonKey(name: 'user')
  User? user;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'theme')
  int? theme;

  @JsonKey(name: 'cache')
  CacheConfig? cache;

  @JsonKey(name: 'lastLogin')
  String? lastLogin;

  @JsonKey(name: 'locale')
  String? locale;

  Profile();

  factory Profile.fromJson(Map<String, dynamic> srcJson) => _$ProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}


