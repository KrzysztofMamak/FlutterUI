import 'package:flutter/material.dart';
import 'package:flutter_samples/communication_widgets/first_child_page.dart';
import 'package:flutter_samples/communication_widgets/second_child_page.dart';

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _myTitle = 'My Parent Title';
  String? _updateChild2Title;
  String? _updateChild1Title;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _updateChild2(String text) => setState(() => _updateChild2Title = text);

  void _updateParent(String text) => setState(() => _myTitle = text);

  @override
  Widget build(BuildContext context) {
    return ParentProvider(
      tabController: _tabController,
      title: _updateChild2Title ?? '',
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              _myTitle,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            child: Text('Action 1'),
            onPressed: () => setState(() {
              _updateChild1Title = 'Update from Parent';
            }),
          ),
          TabBar(
            controller: _tabController,
            tabs: <Tab>[
              Tab(
                text: 'First',
                icon: Icon(Icons.check_circle),
              ),
              Tab(
                text: 'Second',
                icon: Icon(Icons.crop_square),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                FirstChildPage(
                  title: _updateChild1Title ?? '',
                  child2Action2: _updateParent,
                  child2Action3: _updateChild2,
                ),
                SecondChildPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParentProvider extends InheritedWidget {
  final TabController tabController;
  final Widget child;
  final String title;

  ParentProvider({
    Key? key,
    required this.child,
    required this.tabController,
    required this.title,
  }) : super(key: key, child: child);

  static ParentProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ParentProvider>()!;
  }

  @override
  bool updateShouldNotify(ParentProvider oldWidget) {
    return true;
  }
}
