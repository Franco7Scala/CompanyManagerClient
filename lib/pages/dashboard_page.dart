import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/bottom_menu.dart';
import 'package:company_manager_client/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider=StateProvider<int>((ref) => 2);

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex=ref.watch(selectedIndexProvider);
    
    return Scaffold(
      
      bottomNavigationBar: ResponsiveLayout.isMobile(context) ? const BottomMenu() : null,

      body: SafeArea(
        child: ResponsiveLayout(
          
          mobile: Constants.pages[selectedIndex],

          tablet: Row(
            children: <Widget>[ 
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                  child: const IntrinsicHeight(child: SideMenu())
                )
              ),
              Expanded(
                flex: 6,
                child: Constants.pages[selectedIndex],
              ),
            ],
          ),

          desktop: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                      child: const IntrinsicHeight(child: SideMenu())
                    )
                ),
              ),
              Expanded(
                flex: 6,
                child: Constants.pages[selectedIndex],
              ),
            ],
          ),
          
        ),  
      ),
    );
  }
}