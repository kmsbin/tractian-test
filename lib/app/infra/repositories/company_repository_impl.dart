import 'package:tractian_test/app/domain/entities/company.dart';
import 'package:tractian_test/app/domain/repositories/company_repository.dart';

final class CompanyRepositoryImpl implements CompanyRepository {

  @override
  Future<List<CompanyEntity>> getAllCompanies() async {
    return [
      CompanyEntity(
        id: 'jaguar_unit',
        name: 'Jaguar Unit',
      ),
      CompanyEntity(
        id: 'tobias_unit',
        name: 'Tobias Unit',
      ),
      CompanyEntity(
        id: 'apex_unit',
        name: 'Apex Unit',
      ),
    ];
  }
}