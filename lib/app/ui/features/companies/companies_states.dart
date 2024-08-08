import 'package:tractian_test/app/domain/entities/company.dart';

sealed class CompaniesState {
  const CompaniesState();
}

final class FetchedCompaniesState extends CompaniesState {
  final List<CompanyEntity> companies;
  const FetchedCompaniesState(this.companies);
}

final class EmptyCompaniesState extends CompaniesState {
  const EmptyCompaniesState();
}

final class LoadingCompaniesState extends CompaniesState {
  const LoadingCompaniesState();
}

final class FailedCompaniesState extends CompaniesState {
  final String message;
  const FailedCompaniesState(this.message);
}