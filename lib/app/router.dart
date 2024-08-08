import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tractian_test/app/ui/features/companies/companies_view.dart';

import 'ui/features/asset_tree/asset_tree_performatic_view.dart';

final goRouter = createGoRouter();

@visibleForTesting
GoRouter createGoRouter({String initialLocation = '/companies'}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    GoRoute(
      path: '/companies',
      builder: (_, __) => const CompaniesView(key: Key('companies'),),
    ),
    // GoRoute(
    //   path: '/locations-and-assets/:companyId',
    //   builder: (_, state) => AssetsTreeView(
    //     companyId: state.pathParameters['companyId'] ?? '',
    //   )
    // ),
    GoRoute(
        path: '/asset-tree/:companyId',
        builder: (_, state) => AssetsTreePerformaticView(
          companyId: state.pathParameters['companyId'] ?? '',
        )
    )
  ],
);