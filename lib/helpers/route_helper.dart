import 'package:flutter/material.dart';

class RouteHelper{
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  goToPage(String routeName){
    navKey.currentState.pushNamed(routeName);
  }
  goToPageWithReplacement(String routeName){
    navKey.currentState.pushReplacementNamed(routeName);
  }
  goToPageAndRemoveUntil(String routeName){
    navKey.currentState.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
  goBackFromPage(){
    navKey.currentState.pop();
  }
}