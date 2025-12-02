import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/product_viewmodel.dart';
import 'product_card.dart';

class ProductGridWidget extends StatefulWidget {
  const ProductGridWidget({super.key});

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        Provider.of<ProductViewModel>(context, listen: false).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductViewModel>(
      builder: (context, vm, _) {
        if (vm.loading && vm.displayed.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => vm.refresh(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemCount: vm.displayed.length + (vm.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= vm.displayed.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final p = vm.displayed[index];
                return ProductCard(
                  product: p,
                  onTap: () => Navigator.pushNamed(context, '/detalle', arguments: p),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
