import 'package:json_annotation/json_annotation.dart';

part 'cacheConfig.g.dart';


@JsonSerializable()
class CacheConfig{

  @JsonKey(name: 'enable')
  bool? enable;

  @JsonKey(name: 'maxAge')
  int? maxAge;

  @JsonKey(name: 'maxCount')
  int? maxCount;

  CacheConfig();

  factory CacheConfig.fromJson(Map<String, dynamic> srcJson) => _$CacheConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CacheConfigToJson(this);

}


