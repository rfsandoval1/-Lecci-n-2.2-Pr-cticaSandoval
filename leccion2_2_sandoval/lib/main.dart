import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/data/datasources/fakestore_datasource.dart';
import 'src/data/repositories/product_repository_impl.dart';
import 'src/domain/usecases/get_products_usecase.dart';
import 'src/presentation/viewmodels/product_viewmodel.dart';
import 'src/presentation/routes/app_routes.dart';

void main() {
  final datasource = FakeStoreDataSource();
  final repository = ProductRepositoryImpl(datasource);
  final usecase = GetProductsUseCase(repository);

  runApp(MyApp(usecase: usecase, repository: repository));
}

class MyApp extends StatelessWidget {
  final GetProductsUseCase? usecase;
  final ProductRepositoryImpl? repository;

  const MyApp({super.key, this.usecase, this.repository});

  @override
  Widget build(BuildContext context) {
    final _datasource = repository == null ? FakeStoreDataSource() : repository!.datasource;
    final _repository = repository ?? ProductRepositoryImpl(_datasource);
    final _usecase = usecase ?? GetProductsUseCase(_repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(_usecase, _repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: "/",
        theme: ThemeData(
          colorSchemeSeed: Colors.red,
          useMaterial3: true,
        ),
      ),
    );
  }
}
