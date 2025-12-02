import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/product_viewmodel.dart';

class SearchFilterWidget extends StatefulWidget implements PreferredSizeWidget {
  const SearchFilterWidget({super.key});

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProductViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => vm.applySearch(v),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            hint: const Text('Categoría'),
            value: vm.selectedCategory,
            items: [
              const DropdownMenuItem(value: null, child: Text('Todas')),
              ...vm.categories.map((c) => DropdownMenuItem(value: c, child: Text(c)))
            ],
            onChanged: (v) => vm.applyCategory(v),
          ),
        ],
      ),
    );
  }
}
