import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/filters/filter_bloc.dart';
import '../../../domain/filters/value_objects.dart';
import '../../../extra/style/style.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category.empty(),
      Category('Business'),
      Category('Entertainment'),
      Category('General'),
      Category('Health'),
      Category('Science'),
      Category('Sports'),
      Category('Technology'),
    ];

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return SizedBox(
          height: 32,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemBuilder: (context, index) {
              final _category = categories[index];

              return _Item(
                category: _category,
                isSelected: _category == state.category,
                onSelected: () => context
                    .read<FilterBloc>()
                    .add(FilterEvent.categoryChanged(category: _category)),
              );
            },
          ),
        );
      },
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    Key? key,
    required this.category,
    required this.onSelected,
    required this.isSelected,
  }) : super(key: key);

  final Category category;
  final VoidCallback onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        category.value.fold((_) => 'All', (val) => val),
      ),
      selected: isSelected,
      selectedColor: Palette.amaranth,
      onSelected: (isSelected) {
        onSelected.call();
      },
    );
  }
}
