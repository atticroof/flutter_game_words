import 'package:flutter/widgets.dart';

typedef XRouteBuilder = Route Function(WidgetBuilder widgetBuilder);

abstract class XRouteNavigator {
  factory XRouteNavigator({required XRouteBuilder routeBuilder}) => _XRouteNavigatorImpl(routeBuilder);

  GlobalKey<NavigatorState> get navigatorKey;

  void next(WidgetBuilder widgetBuilder);
  void first(WidgetBuilder widgetBuilder);
  void second(WidgetBuilder widgetBuilder);
  void pop({bool toFirst = false});
}

class _XRouteNavigatorImpl implements XRouteNavigator {
  _XRouteNavigatorImpl(this._routeBuilder);

  @override
  late final navigatorKey = GlobalKey<NavigatorState>();
  final XRouteBuilder _routeBuilder;

  @override
  void next(WidgetBuilder widgetBuilder, {XRouteBuilder? routeBuilder}) =>
      navigatorKey.currentState?.push(_routeBuilder(widgetBuilder));

  @override
  void first(WidgetBuilder widgetBuilder, {XRouteBuilder? routeBuilder}) =>
      navigatorKey.currentState?.pushAndRemoveUntil(_routeBuilder(widgetBuilder), (_) => false);

  @override
  void second(WidgetBuilder widgetBuilder, {XRouteBuilder? routeBuilder}) =>
      navigatorKey.currentState?.pushAndRemoveUntil(_routeBuilder(widgetBuilder), (_) => _.isFirst);

  @override
  void pop({bool toFirst = false}) =>
      toFirst ? navigatorKey.currentState?.popUntil((route) => route.isFirst) : navigatorKey.currentState?.pop();
}
