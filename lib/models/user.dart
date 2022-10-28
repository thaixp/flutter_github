import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';


@JsonSerializable()
class User{

  @JsonKey(name: 'login')
  String? login;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'node_id')
  String? nodeId;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'site_admin')
  bool? siteAdmin;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'company')
  String? company;

  @JsonKey(name: 'blog?')
  String? blog;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'hireable')
  bool? hireable;

  @JsonKey(name: 'bio')
  String? bio;

  @JsonKey(name: 'public_repos')
  int? publicRepos;

  @JsonKey(name: 'public_gists')
  int? publicGists;

  @JsonKey(name: 'followers')
  int? followers;

  @JsonKey(name: 'following')
  int? following;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'total_private_repos')
  int? totalPrivateRepos;

  @JsonKey(name: 'owned_private_repos')
  int? ownedPrivateRepos;

  User();

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


