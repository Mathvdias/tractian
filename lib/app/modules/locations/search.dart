import 'package:flutter/material.dart';

// Classe para representar um item de localização
class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({
    required this.id,
    required this.name,
    this.parentId,
  });
}

// Classe para representar um item de ativo
class Asset {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;

  Asset({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
  });
}

// Widget para exibir a árvore de ativos e localizações
class TreeWidget extends StatelessWidget {
  final List<Location> locations;
  final List<Asset> assets;
  final String searchTerm;

  const TreeWidget({
    super.key,
    required this.locations,
    required this.assets,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context) {
    // Aplicar filtros de pesquisa
    final filteredLocations = locations.where((location) =>
        location.name.toLowerCase().contains(searchTerm.toLowerCase()));
    final filteredAssets = assets.where(
        (asset) => asset.name.toLowerCase().contains(searchTerm.toLowerCase()));

    // Construir a árvore
    final treeItems = buildTree(filteredLocations, filteredAssets);

    return ListView.builder(
      itemCount: treeItems.length,
      itemBuilder: (context, index) {
        final item = treeItems[index];
        return buildTreeItem(item);
      },
    );
  }

  // Construir a árvore com base nas localizações e ativos filtrados
  List<dynamic> buildTree(
      Iterable<Location> filteredLocations, Iterable<Asset> filteredAssets) {
    List<dynamic> tree = [];

    for (var location in filteredLocations) {
      // Adicionar localização à árvore
      tree.add(location);

      // Adicionar ativos filhos à árvore
      final children = filteredAssets
          .where((asset) => asset.locationId == location.id)
          .toList();
      tree.addAll(children);
    }

    return tree;
  }

  // Construir um item de árvore com base no tipo (Location ou Asset)
  Widget buildTreeItem(dynamic item) {
    if (item is Location) {
      return ExpansionTile(
        title: Text(item.name),
        children: const [],
      );
    } else if (item is Asset) {
      return ListTile(
        title: Text(item.name),
      );
    } else {
      return const SizedBox();
    }
  }
}

class MyTreePage extends StatefulWidget {
  const MyTreePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyTreePageState createState() => _MyTreePageState();
}

class _MyTreePageState extends State<MyTreePage> {
  final List<Location> locations = [
    Location(id: '1', name: 'Location 1', parentId: null),
    Location(id: '2', name: 'Location 2', parentId: null),
  ];

  final List<Asset> assets = [
    Asset(id: '1', name: 'Asset 1', parentId: null, locationId: '1'),
    Asset(id: '2', name: 'Asset 2', parentId: null, locationId: '1'),
    Asset(id: '3', name: 'Asset 3', parentId: null, locationId: '2'),
  ];

  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search',
            hintText: 'Enter search term',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {
              searchTerm = value;
            });
          },
        ),
        Expanded(
          child: TreeWidget(
            locations: locations,
            assets: assets,
            searchTerm: searchTerm,
          ),
        ),
      ],
    );
  }
}

