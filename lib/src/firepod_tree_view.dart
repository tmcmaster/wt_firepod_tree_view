import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wt_models/wt_models.dart';

class FirepodTreeView extends StatefulWidget {
  final TreeNode treeNode;

  const FirepodTreeView._({
    Key? key,
    required this.treeNode,
  }) : super(key: key);

  @override
  FirepodTreeViewState createState() => FirepodTreeViewState();

  factory FirepodTreeView.fromList(List list) {
    final treeNode = listToTreeNode(list);
    return FirepodTreeView._(
      treeNode: treeNode,
    );
  }

  factory FirepodTreeView.fromMap(Map map) {
    final treeNode = mapToTreeNode(map);
    return FirepodTreeView._(
      treeNode: treeNode,
    );
  }

  static int keyIndex = 0;

  static String nextKey() {
    return (++keyIndex).toString();
  }

  static TreeNode listToTreeNode(List<dynamic> list) {
    final parent = TreeNode(key: nextKey(), data: 'Root Node');
    _walkList(list, parent);
    return parent;
  }

  static TreeNode mapToTreeNode(Map map) {
    final parent = TreeNode(key: nextKey(), data: 'Root Node');
    _walkMap(map, parent);
    return parent;
  }

  static void _walkMap(Map map, TreeNode parent) {
    for (final entry in map.entries) {
      if (entry.value is String ||
          entry.value is int ||
          entry.value is double ||
          entry.value is bool) {
        parent.add(
            TreeNode(key: nextKey(), data: '${entry.key} : ${entry.value}'));
      } else if (entry.value is Map) {
        final mapParent = TreeNode(key: nextKey(), data: 'Map : ${entry.key}');
        _walkMap(entry.value as Map, mapParent);
        parent.add(mapParent);
      } else if (entry.value is List) {
        final listParent =
        TreeNode(key: nextKey(), data: 'List : ${entry.key}');
        _walkList(entry.value as List, listParent);
        parent.add(listParent);
      } else if (entry.value is JsonSupport) {
        final jsonData = (entry.value as JsonSupport).toJson();
        _walkObject(jsonData, parent);
      }
    }
  }

  static void _walkList(List<dynamic> list, TreeNode parent) {
    for (final item in list) {
      if (item is String || item is int || item is double || item is bool) {
        parent.add(TreeNode(key: nextKey(), data: item));
      } else if (item is Map<String, dynamic>) {
        final mapParent = TreeNode(key: nextKey(), data: 'Map');
        parent.add(mapParent);
        _walkMap(item, mapParent);
      } else if (item is List) {
        final listParent = TreeNode(key: nextKey(), data: 'List');
        parent.add(listParent);
        _walkList(item, listParent);
      } else if (item is JsonSupport) {
        final jsonData = item.toJson();
        _walkObject(jsonData, parent);
      }
    }
  }

  static void _walkObject(dynamic object, TreeNode parent) {
    if (object is String ||
        object is int ||
        object is double ||
        object is bool) {
      parent.add(TreeNode(key: nextKey(), data: object.toString()));
    } else if (object is Map) {
      final mapParent = TreeNode(key: nextKey(), data: 'Map');
      parent.add(mapParent);
      _walkMap(object, mapParent);
    } else if (object is List) {
      final listParent = TreeNode(key: nextKey(), data: 'List');
      parent.add(listParent);
      _walkList(object, listParent);
    } else {}
  }
}

class FirepodTreeViewState extends State<FirepodTreeView> {
  static const showSnackBar = false;
  static const expandChildrenOnReady = false;

  final Map<int, Color> colorMapper = {
    0: Colors.white,
    1: Colors.blueGrey[50]!,
    2: Colors.blueGrey[100]!,
    3: Colors.blueGrey[200]!,
    4: Colors.blueGrey[300]!,
    5: Colors.blueGrey[400]!,
    6: Colors.blueGrey[500]!,
    7: Colors.blueGrey[600]!,
    8: Colors.blueGrey[700]!,
    9: Colors.blueGrey[800]!,
    10: Colors.blueGrey[900]!,
  };

  TreeViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: widget.treeNode.expansionNotifier,
        builder: (context, isExpanded, _) {
          return FloatingActionButton.extended(
            onPressed: () {
              if (widget.treeNode.isExpanded) {
                _controller?.collapseNode(widget.treeNode);
              } else {
                _controller?.expandAllChildren(widget.treeNode);
              }
            },
            label: isExpanded
                ? const Text("Collapse all")
                : const Text("Expand all"),
          );
        },
      ),
      body: TreeView.simple(
        tree: widget.treeNode,
        showRootNode: true,
        expansionIndicatorBuilder: (context, node) =>
            ChevronIndicator.rightDown(
              tree: node,
              color: Colors.blue[700],
              padding: const EdgeInsets.all(8),
            ),
        indentation: const Indentation(style: IndentStyle.squareJoint),
        onItemTap: (item) {
          if (kDebugMode) print("Item tapped: ${item.key}");

          if (showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Item tapped: ${item.key}"),
                duration: const Duration(milliseconds: 750),
              ),
            );
          }
        },
        onTreeReady: (controller) {
          _controller = controller;
          if (expandChildrenOnReady)
            controller.expandAllChildren(widget.treeNode);
        },
        builder: (context, node) => Card(
          color: colorMapper[node.level.clamp(0, colorMapper.length - 1)]!,
          child: ListTile(
            title: Text(node.data.toString()),
            subtitle: const Text(''),
          ),
        ),
      ),
    );
  }
}