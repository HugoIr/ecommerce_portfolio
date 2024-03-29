import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funesia_clone/presentation/components/cubits/pages/pages_cubit.dart';
import 'package:funesia_clone/presentation/components/homepage/app_bar_home.dart';
import 'package:funesia_clone/presentation/components/homepage/navigation_bar_item.dart';
import 'package:funesia_clone/presentation/components/reusable_widgets/reusable_widget_main_page.dart';
import 'package:funesia_clone/presentation/pages/homepage/homepage.dart';
import 'package:funesia_clone/presentation/pages/official_store/official_store.dart';
import 'package:funesia_clone/presentation/pages/profile/profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  Widget switchPage(int currentIndex) {
    switch (currentIndex) {
      case 2:
        return const Profile();
      case 1:
        return const OfficialStore();
      default:
        return const Homepage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<PagesCubit, int>(
          builder: (context, index) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: (index == 0) ? AppBarHome() : null,
              bottomNavigationBar: Container(
                width: double.infinity,
                height: 56,
                // color: Colors.grey[200],
                // padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Spacer(
                      flex: 1,
                    ),
                    NavigationBarItem(
                      title: "Beranda",
                      iconData: Icons.home_rounded,
                      index: 0,
                    ),
                    Spacer(
                      flex: 5,
                    ),
                    NavigationBarItem(
                      title: "Profil",
                      iconData: Icons.person_rounded,
                      index: 2,
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              floatingActionButton: floatingActionButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: switchPage(index),
            );
          },
        ),
      ),
    );
  }
}
