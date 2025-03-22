import 'package:flutter/material.dart';

import 'package:installed_apps/installed_apps.dart';

final pm = InstalledAppsWithCache();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var apps = await pm.getInstalledApplications();

  apps.sort((a, b) {
    final aName = a.label ?? a.name ?? a.packageName;
    final bName = b.label ?? b.name ?? b.packageName;
    return aName.compareTo(bName);
  });

  return runApp(Apps(apps: apps));
}

class Apps extends StatefulWidget {
  const Apps({super.key, required this.apps});

  final List<ApplicationInfo> apps;

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  final Set<String> _selectedIds = {};

  Widget buildTile(List<ApplicationInfo> apps, int i) {
    final app = apps[i];
    final isSelected = _selectedIds.contains(app.packageName);
    return AppGridTile(
      app: app,
      selected: isSelected,
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedIds.remove(app.packageName);
          } else {
            _selectedIds.add(app.packageName);
          }
        });
      },
    );
  }

  List<ApplicationInfo> get systemApps =>
      widget.apps.where((e) => e.maybeSystem).toList();
  List<ApplicationInfo> get userApps =>
      widget.apps.where((e) => !e.maybeSystem).toList();

  @override
  Widget build(BuildContext context) {
    final userApps = this.userApps;
    final systemApps = this.systemApps;
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('Your apps'),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20)),
                SliverToBoxAdapter(
                  child: Text(
                    'User apps: ',
                    style: TextTheme.of(context).headlineSmall,
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 10)),
                SliverGrid.builder(
                  itemBuilder: (_, i) => buildTile(userApps, i),
                  itemCount: userApps.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    'System apps: ',
                    style: TextTheme.of(context).headlineSmall,
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 10)),
                SliverGrid.builder(
                  itemBuilder: (_, i) => buildTile(systemApps, i),
                  itemCount: systemApps.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AppGridTile extends StatelessWidget {
  const AppGridTile({
    super.key,
    required this.app,
    required this.onTap,
    this.selected = false,
  });

  final ApplicationInfo app;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final iconId = app.iconId;
    final hasIconId = iconId != null;

    Widget content = switch (app) {
      AndroidApplicationInfo() => AnimatedFractionallySizedBox(
        duration: kThemeAnimationDuration,
        widthFactor: selected ? 0.6 : 1.0,
        child: Column(
          children: [
            if (hasIconId)
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: Image(
                    errorBuilder: (_, _, _) => ColoredBox(color: Colors.red),
                    image: InstalledAppImage(iconId),
                    loadingBuilder: (context, child, event) {
                      if (event == null) {
                        return Center(
                          child: child,
                        );
                      }
                      final exp = event.expectedTotalBytes;
                      return CircularProgressIndicator(
                        value: switch(exp) {
                          int() => event.cumulativeBytesLoaded / exp,
                          null => null,
                        },
                      );
                    },
                  ),
                ),
              )
            else
              Expanded(child: FractionallySizedBox(
                widthFactor: 0.7,
                child: ColoredBox(color: Colors.red),
              )),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: [
                  Text(
                    app.label ?? 'No name',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    };

    content = GestureDetector(onTap: onTap, child: content);

    return GridTile(child: content);
  }
}
