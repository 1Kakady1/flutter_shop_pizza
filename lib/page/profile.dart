import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pizza_time/redux/state/history/history.actions.dart';
import 'package:pizza_time/redux/store.dart';
import 'package:pizza_time/styles/colors.dart';
import 'package:pizza_time/widgets/profile/profile_history/profile_history.container.dart';
import 'package:pizza_time/widgets/profile/profile_user/profile_user.container.dart';
import 'package:pizza_time/widgets/snack/snack.dart';
import 'package:redux/redux.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  late ScrollController _scrollController;
  late String _title;
  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 2,
      vsync: this,
    );
    _controller.addListener(_changeTab);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_changeTab);
    _scrollController.removeListener(_scrollListener);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _title = _controller.index == 0
        ? FlutterI18n.translate(context, "profile.title_tab_one")
        : FlutterI18n.translate(context, "profile.title_tab_two");
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    if (store.state.history.isLoad == false) {
      Future.delayed(Duration(milliseconds: 2000), () {
        ScaffoldMessenger.of(context).clearSnackBars();
      });
    }
  }

  void _scrollListener() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _controller.index == 1 &&
        store.state.history.error == "" &&
        store.state.history.isLoad == false) {
      final Store<AppState> disp =
          StoreProvider.of<AppState>(context, listen: false);
      ScaffoldMessenger.of(context).showSnackBar(snackBar("Loading history",
          isLoad: true,
          ctx: context,
          fullWidth: true,
          duration: Duration(hours: 1),
          borderRadius: BorderRadius.circular(0)));
      disp.dispatch(RequestHistoryAction(
          error: "",
          isLoad: true,
          offset: store.state.history.offset,
          id: store.state.user.info.id));
    }
  }

  void _changeTab() {
    setState(() {
      _title = _controller.index == 0
          ? FlutterI18n.translate(context, "profile.title_tab_one")
          : FlutterI18n.translate(context, "profile.title_tab_two");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      TabsItem(
          body: () => SliverToBoxAdapter(
                  child: Column(
                children: [
                  ProfileUserContainer(),
                  SizedBox(
                    height: 260,
                  )
                ],
              )),
          tabID: "profile",
          name: "profile.label_tab_setting"),
      TabsItem(
          tabID: "history",
          body: () => ProfileHistoryContainer(),
          name: "profile.title_tab_two")
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration.zero);
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: BackButton(color: AppColors.write),
                  backgroundColor: AppColors.red[300],
                  pinned: true,
                  snap: true,
                  floating: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken),
                            image: AssetImage("assets/img/bg1.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          _title,
                          style: TextStyle(color: AppColors.write),
                        ))),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(Icons.settings),
                          text: FlutterI18n.translate(
                              context, "profile.label_tab_setting")),
                      Tab(
                          icon: Icon(Icons.history),
                          text: FlutterI18n.translate(
                              context, "profile.label_tab_history")),
                    ],
                    controller: _controller,
                    indicatorColor: AppColors.write,
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _controller,
            children: _tabs.map((TabsItem item) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      controller: _scrollController,
                      key: PageStorageKey<String>(item.name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        item.body(),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class TabsItem {
  final String tabID;
  final String name;
  final Widget Function() body;

  TabsItem({required this.tabID, required this.name, required this.body});
}
