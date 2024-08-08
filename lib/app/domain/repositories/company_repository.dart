import 'package:dart_code_metrics_annotations/annotations.dart';
import 'package:tractian_test/app/domain/entities/company.dart';
import 'package:tractian_test/app/domain/exceptions/failed_get_companies.dart';

abstract interface class CompanyRepository {
  @Throws({FailedGetCompanies})
  Future<List<CompanyEntity>> getAllCompanies();
}