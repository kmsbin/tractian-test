import 'package:tractian_test/app/domain/entities/company.dart';

class CompanyDto {
  final String id;
  final String name;

  CompanyDto({
    required this.id,
    required this.name,
  });

  factory CompanyDto.fromMap(Map<String, dynamic> jsonMap) {
    return CompanyDto(
      id: jsonMap['id'] as String,
      name: jsonMap['name'] as String,
    );
  }

  static List<CompanyDto> fromListMap(List jsonListMap) {
    return jsonListMap
      .map((it) => CompanyDto.fromMap((it as Map).cast()))
      .toList();
  }

  CompanyEntity toEntity() {
    return CompanyEntity(id: id, name: name);
  }
}