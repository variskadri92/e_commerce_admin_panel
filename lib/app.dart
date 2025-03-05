import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/responsive/responsive_design.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/routes/routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';

import 'utils/constants/colors.dart';
import 'utils/constants/text_strings.dart';
import 'utils/device/web_material_scroll.dart';
import 'utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.light,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      getPages: AppRoutes.pages,
      initialRoute: Routes.dashboard,
      unknownRoute: GetPage(name: '/page-not-found', page: ()=>Scaffold(body: Center(child: Text('Page Not Found'),),)),
    );
  }
}


class ResponsiveDesignScreen extends StatelessWidget {
  const ResponsiveDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteLayout(
      desktop: Desktop(),
      tablet: Tablet(),
      mobile: Mobile(),
    );
  }
}
class Desktop extends StatelessWidget {
  const Desktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: RoundedContainer(
                height: 420,
                backgroundColor: Colors.blue,
                child: Center(child: Text('box 1')),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.red,
                          child: Center(child: Text('box 2')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.green,
                          child: Center(child: Text('box 3')),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.yellow,
                          child: Center(child: Text('box 4')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: RoundedContainer(
                backgroundColor: Colors.red[100]!,
                height: 200,
                child: const Center(child: Text('BOX 5')),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RoundedContainer(
                backgroundColor: Colors.red[100]!,
                height: 200,
                child: const Center(child: Text('BOX 6')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: RoundedContainer(
                height: 420,
                backgroundColor: Colors.blue,
                child: Center(child: Text('box 1')),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.red,
                          child: Center(child: Text('box 2')),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.green,
                          child: Center(child: Text('box 3')),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: RoundedContainer(
                          height: 200,
                          backgroundColor: Colors.yellow,
                          child: Center(child: Text('box 4')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        RoundedContainer(
          backgroundColor: Colors.red[100]!,
          height: 200,
          child: const Center(child: Text('BOX 5')),
        ),
        const SizedBox(height: 16),
        RoundedContainer(
          backgroundColor: Colors.red[100]!,
          height: 200,
          child: const Center(child: Text('BOX 6')),
        ),
      ],
    );
  }
}
class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RoundedContainer(
            height: 420,
            backgroundColor: Colors.blue,
            child: Center(child: Text('box 1')),
          ),
          SizedBox(height: 20,),
          RoundedContainer(
            height: 200,
            backgroundColor: Colors.red,
            child: Center(child: Text('box 2')),
          ),
          SizedBox(height: 20,),
          RoundedContainer(
            height: 200,
            backgroundColor: Colors.green,
            child: Center(child: Text('box 3')),
          ),
          SizedBox(height: 20,),
          RoundedContainer(
            height: 200,
            backgroundColor: Colors.yellow,
            child: Center(child: Text('box 4')),
          ),
          const SizedBox(height: 16),
          RoundedContainer(
            backgroundColor: Colors.red[100]!,
            height: 200,
            child: const Center(child: Text('BOX 5')),
          ),
          const SizedBox(height: 16),
          RoundedContainer(
            backgroundColor: Colors.red[100]!,
            height: 200,
            child: const Center(child: Text('BOX 6')),
          ),
        ],
      ),
    );
  }
}


