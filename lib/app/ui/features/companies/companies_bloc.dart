import 'package:bloc/bloc.dart';
import 'package:tractian_test/app/domain/exceptions/failed_get_companies.dart';
import 'package:tractian_test/app/domain/repositories/company_repository.dart';
import 'package:tractian_test/app/ui/features/companies/companies_events.dart';
import 'package:tractian_test/app/ui/features/companies/companies_states.dart';
import 'package:tractian_test/injectors/injector.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  final companyRepository = getIt.get<CompanyRepository>();

  CompaniesBloc([super.initialState = const EmptyCompaniesState()]) {
    on<FetchCompaniesEvent>(getAllCompanies);
  }

  Future<void> getAllCompanies(FetchCompaniesEvent event, Emitter<CompaniesState> emit) async {
    try {
      emit(const LoadingCompaniesState());
      final companies = await companyRepository.getAllCompanies();
      emit(FetchedCompaniesState(companies));
    } on FailedGetCompanies catch(e) {
      emit(FailedCompaniesState(e.message));
    }
  }
}
