import 'package:event_bus/event_bus.dart';

/// @desc EventBus 单例
/// @time 2019-04-25 11:00
/// @author chenyun
class EventManager {
  static final EventManager _instance = EventManager._internal();

  factory EventManager() => _instance;

  EventBus _bus;

  /// 创建 dio 实例对象
  EventManager._internal() {
    if (_bus == null) {
      _bus = EventBus();
    }
  }

  EventBus get eventBus => _bus;

//  void post(event) {
//    _bus.fire(event);
//  }
//
//  Stream<T> on<T>() {
//    return _bus.on();
//  }
}
