import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/app/core/core.dart';
import 'package:tractian/app/core/entities/request/request.dart';
import 'package:tractian/app/design_system_kit/design_system_kit.dart';

class TreePage extends StatefulWidget {
  const TreePage({
    super.key,
    required this.locations,
    required this.components,
  });

  final List<RequestLocationsEntity> locations;
  final List<RequestComponentsEntity> components;

  @override
  State<TreePage> createState() => _TreePageState();
}

class _TreePageState extends State<TreePage> {
  String searchTerm = '';
  bool showEnergySensors = false;
  bool showCriticalSensors = false;

  late List<RequestLocationsEntity> filteredLocations;
  late List<RequestComponentsEntity> filteredAssets;

  @override
  void initState() {
    super.initState();
    filteredLocations = List.from(widget.locations);
    filteredAssets = List.from(widget.components);
  }

  @override
  void dispose() {
    filteredLocations.clear();
    filteredAssets.clear();
    super.dispose();
  }

  bool matchesFilter(RequestComponentsEntity asset) {
    if (showEnergySensors && asset.sensorType != 'energy') {
      return false;
    }
    if (showCriticalSensors && asset.status != 'alert') {
      return false;
    }
    return true;
  }

  bool matchesQuery(String name) {
    return name.toLowerCase().contains(searchTerm.toLowerCase());
  }

  void filterData() {
    setState(() {
      filteredAssets = widget.components.where((asset) {
        bool matches = matchesFilter(asset);
        bool queryMatches = matchesQuery(asset.name);
        return matches && queryMatches;
      }).toList();

      filteredLocations = widget.locations.where((location) {
        bool queryMatches = matchesQuery(location.name);
        return queryMatches;
      }).toList();
    });

    identifyParents();
  }

  void identifyParents() {
    Set<String?> parentIds = filteredAssets
        .map((asset) => asset.parentId)
        .where((id) => id.isNotEmpty)
        .toSet();
    while (parentIds.isNotEmpty) {
      final newParents = widget.components
          .where((asset) => parentIds.contains(asset.id))
          .toList();
      parentIds = newParents
          .map((asset) => asset.parentId)
          .where((id) => id.isNotEmpty)
          .toSet();
      for (var parent in newParents) {
        if (!filteredAssets.contains(parent)) {
          filteredAssets.add(parent);
        }
      }
    }

    Set<String?> locationParentIds = filteredLocations
        .map((location) => location.parentId)
        .where((id) => id.isNotEmpty)
        .toSet();
    while (locationParentIds.isNotEmpty) {
      final newLocationParents = widget.locations
          .where((location) => locationParentIds.contains(location.id))
          .toList();
      locationParentIds = newLocationParents
          .map((location) => location.parentId)
          .where((id) => id.isNotEmpty)
          .toSet();
      for (var parent in newLocationParents) {
        if (!filteredLocations.contains(parent)) {
          filteredLocations.add(parent);
        }
      }
    }

    Set<String?> assetLocationIds = filteredAssets
        .map((asset) => asset.locationId)
        .where((id) => id.isNotEmpty)
        .toSet();
    while (assetLocationIds.isNotEmpty) {
      final newLocationParents = widget.locations
          .where((location) => assetLocationIds.contains(location.id))
          .toList();
      assetLocationIds = newLocationParents
          .map((location) => location.parentId)
          .where((id) => id.isNotEmpty)
          .toSet();
      for (var parent in newLocationParents) {
        if (!filteredLocations.contains(parent)) {
          filteredLocations.add(parent);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TractianSearchBar(
            onChanged: (String value) {
              setState(() {
                searchTerm = value;
                filterData();
              });
            },
            onSubmitted: (String value) {
              setState(() {
                searchTerm = value;
                filterData();
              });
            },
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              FilterChip(
                avatar: SvgPicture.string(SVGIcons.bolt),
                label: const Text('Sensor de Energia'),
                selected: showEnergySensors,
                onSelected: (bool value) {
                  setState(() {
                    showEnergySensors = value;
                    filterData();
                  });
                },
              ),
              const SizedBox(width: 8),
              FilterChip(
                avatar: SvgPicture.string(SVGIcons.critical),
                label: const Text('Crítico'),
                selected: showCriticalSensors,
                onSelected: (bool value) {
                  setState(() {
                    showCriticalSensors = value;
                    filterData();
                  });
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: buildTree(filteredLocations, filteredAssets),
          ),
        ),
      ],
    );
  }

  List<Widget> buildTree(List<RequestLocationsEntity> locations,
      List<RequestComponentsEntity> assets) {
    List<Widget> tree = [];

    Map<String, List<RequestLocationsEntity>> locationMap = {};
    for (var location in locations) {
      if (location.parentId.isNotEmpty) {
        locationMap[location.parentId] ??= [];
        locationMap[location.parentId]!.add(location);
      }
    }

    Map<String, List<RequestComponentsEntity>> assetMap = {};
    for (var asset in assets) {
      if (asset.parentId.isNotEmpty) {
        assetMap[asset.parentId] ??= [];
        assetMap[asset.parentId]!.add(asset);
      } else if (asset.locationId.isNotEmpty) {
        assetMap[asset.locationId] ??= [];
        assetMap[asset.locationId]!.add(asset);
      }
    }

    for (var location in locations.where((loc) => loc.parentId.isEmpty)) {
      tree.add(buildLocationNode(location, locationMap, assetMap));
    }

    for (var asset in assets.where(
        (asset) => (asset.parentId.isEmpty) && (asset.locationId.isEmpty))) {
      tree.add(buildAssetNode(asset, assetMap));
    }

    return tree;
  }

  Widget buildLocationNode(
      RequestLocationsEntity location,
      Map<String, List<RequestLocationsEntity>> locationMap,
      Map<String, List<RequestComponentsEntity>> assetMap) {
    List<Widget> children = [];

    if (locationMap.containsKey(location.id)) {
      for (var subLocation in locationMap[location.id] ?? []) {
        children.add(buildLocationNode(subLocation, locationMap, assetMap));
      }
    }

    if (assetMap.containsKey(location.id)) {
      for (var asset in assetMap[location.id] ?? []) {
        children.add(buildAssetNode(asset, assetMap));
      }
    }

    return ExpansionTile(
      initiallyExpanded: true,
      title: FittedBox(
        alignment: Alignment.bottomLeft,
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.string(SVGIcons.location),
            const SizedBox(width: 8),
            Text(location.name),
          ],
        ),
      ),
      children: children.isEmpty ? <Widget>[] : children,
    );
  }

  Widget buildAssetNode(RequestComponentsEntity asset,
      Map<String, List<RequestComponentsEntity>> assetMap) {
    List<Widget> children = [];

    if (assetMap.containsKey(asset.id)) {
      for (var subAsset in assetMap[asset.id] ?? []) {
        children.add(buildAssetNode(subAsset, assetMap));
      }
    }

    return ExpansionTile(
      initiallyExpanded: true,
      title: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            asset.sensorType.isNotEmpty
                ? SvgPicture.string(SVGIcons.component)
                : SvgPicture.string(SVGIcons.assets),
            const SizedBox(width: 8),
            Text(asset.name),
          ],
        ),
      ),
      leading: asset.sensorType == 'energy'
          ? SvgPicture.string(SVGIcons.bolt)
          : null,
      trailing:
          asset.status == 'alert' ? SvgPicture.string(SVGIcons.critical) : null,
      children: children,
    );
  }
}
