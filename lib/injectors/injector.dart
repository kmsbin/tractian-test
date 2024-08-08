import 'package:get_it/get_it.dart';
import 'package:tractian_test/app/domain/repositories/asset_tree_repository.dart';
import 'package:tractian_test/app/domain/repositories/company_repository.dart';
import 'package:tractian_test/app/infra/repositories/asset_tree_repository_performatic_impl.dart';
import 'package:tractian_test/app/infra/repositories/company_repository_impl.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerFactory<AssetTreeRepository>(() => AssetTreeRepositoryImpl());
  getIt.registerFactory<CompanyRepository>(() => CompanyRepositoryImpl());
}