import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/product_viewmodel.dart';
import '../widgets/search_filter_widget.dart';
import '../widgets/product_grid_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controllers moved into widgets

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductViewModel>(context, listen: false).loadInitial();
    });
  }

  @override
  void dispose() {
    super.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FakeStore - Productos'),
        actions: [
          IconButton(
            onPressed: () => vm.refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: const SearchFilterWidget(),
      ),
      body: const ProductGridWidget(),
    );
  }
}
