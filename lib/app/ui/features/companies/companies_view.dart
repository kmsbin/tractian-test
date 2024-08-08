import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tractian_test/app/ui/features/companies/companies_bloc.dart';
import 'package:tractian_test/app/ui/features/companies/companies_events.dart';
import 'package:tractian_test/app/ui/shared/design_system_spacing.dart';

import 'companies_states.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  final companiesBloc = CompaniesBloc();

  @override
  void initState() {
    super.initState();
    companiesBloc.add(const FetchCompaniesEvent());
  }

  @override
  void dispose() {
    companiesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companhias')),
      body: BlocBuilder<CompaniesBloc, CompaniesState>(
        bloc: companiesBloc,
        builder: (context, state) {
          if (state is LoadingCompaniesState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is! FetchedCompaniesState) {
            return const SizedBox();
          }
          return ListView(
            padding: EdgeInsets.all(DesignSystemSpacing(2).getSize()),
            children: [
              for (final company in state.companies)
                InkWell(
                  onTap: () => context.push('/asset-tree/${company.id}'),
                  child: Card(
                    color: const Color(0xff1c70ff),
                    child: Padding(
                      padding: EdgeInsets.all(DesignSystemSpacing(2).getSize()),
                      child: Row(
                        children: [
                          Text(
                            company.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                // ListTile(
                //   title: Text(company.name),
                //   subtitle: Text(company.id),
                //   onTap: () => context.push('/asset-tree/${company.id}'),
                // )
            ],
          );
        }
      ),
    );
  }
}
