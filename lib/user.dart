import 'dart:io';

import 'package:clivia_base/notifier.dart';
import 'package:clivia_base/util/context.dart';
import 'package:clivia_base/util/http.dart';
import 'package:clivia_base/util/io.dart';
import 'package:clivia_base/util/l10n.dart';
import 'package:clivia_base/util/router.dart';
import 'package:clivia_user/listener.dart';
import 'package:clivia_user/sign/inup.dart';
import 'package:flutter/material.dart';

class User {
  static bool anonymous = true;
  static Map<String, dynamic> _map = {};
  static final List<String> _modifies = [
    'idcard',
    'name',
    'nick',
    'mobile',
    'email',
    'weixin',
    'qq',
    'avatar',
    'gender',
    'birthday',
  ];
  static final List<UserListener> _listeners = [];

  static Future<void> init() async {
    Http.listen((uri, headers) async {
      if (uri == '/user/sign-out') return Future.value(true);

      String? destroy = headers.value('user-destroy');
      if (destroy != null) {
        await delete(destroy);
      }

      return Future.value(false);
    });

    await sign();
  }

  static Future<bool> signInUp() async {
    await PageRouter.push(const InUpPage());

    return Future.value(on());
  }

  static Future<bool> signUp(String username, String password, String nick, String invitecode) async {
    return _sign('/user/sign-up', {
      'type': '',
      'uid': username,
      'password': password,
      'nick': nick,
      'invitecode': invitecode,
    });
  }

  static Future<bool> signIn(String username, String password) async {
    return _sign('/user/sign-in', {
      'type': '',
      'uid': username,
      'password': password,
    });
  }

  static Future<bool> _sign(String uri, Map<String, String> body) async {
    Map<String, dynamic>? map = await Http.service(uri, data: body, message: true);
    if (map == null) return Future.value(false);

    _map = map;

    Map<String, dynamic> m = {};
    if (body.containsKey('uid')) m['user.uid'] = body['uid'];
    m['user.id'] = map['id'];
    await Context.sets(m);
    await _password();
    if (_listeners.isNotEmpty) {
      for (UserListener listener in _listeners) {
        await listener.signIn();
      }
    }

    return Future.value(true);
  }

  static Future<String?> signInPassword(String password) async {
    Map<String, dynamic> map = await Http.post('/user/sign-in-password', {'id': Context.get('user.id', defaultValue: ''), 'password': password});
    if (map['code'] > 0) return Future.value(map['message']);

    await sign();

    return Future.value(null);
  }

  static Future<String?> signInGesture(String gesture) async {
    Map<String, dynamic> map = await Http.post('/user/sign-in-gesture', {'id': Context.get('user.id', defaultValue: ''), 'gesture': gesture});
    if (map['code'] > 0) return Future.value(map['message']);

    await sign();

    return Future.value(null);
  }

  static Future<void> sign() async {
    Map<String, dynamic>? map = await Http.service('/user/sign');
    if (map != null && map.containsKey('id')) {
      _map = map;
      await Context.set('user.id', map['id']);
      await _password();
      if (_listeners.isNotEmpty) {
        for (UserListener listener in _listeners) {
          await listener.signIn();
        }
      }
    }
  }

  static Future<void> _password() async {
    Map<String, dynamic>? map = await Http.service('/user/password/has');
    if (map == null) return;

    await Context.sets({
      'user.screen': map['screen'] ?? 0,
      'user.gesture': map['gesture'] ?? 0,
      'user.destroy': map['destroy'] ?? 0,
    });
  }

  static bool on() => _map.containsKey('id');

  static String id() => get('id', '');

  static String code(String empty) => get('code', empty);

  static String avatar(String empty) => get('avatar', empty);

  static String nick(String empty) => get('nick', empty);

  static int grade() => get('grade', 0);

  static dynamic get(String key, dynamic empty) {
    return _map[key] ?? empty;
  }

  static String uid() => Context.get('user.uid', defaultValue: '');

  static bool screen() => Context.get('user.screen', defaultValue: 0) > 0;

  static bool gesture() => Context.get('user.gesture', defaultValue: 0) > 0;

  static bool destroy() => Context.get('user.destroy', defaultValue: 0) > 0;

  static Future<bool> passwordAuth(String type, String password) async {
    dynamic data = await Http.service('/user/password/auth', data: {
      'type': type,
      'password': password,
    });

    return data != null && data;
  }

  static Future<String> passwordSet(BuildContext context, String type, String password, [bool unique = false]) async {
    String? data = await Http.service('/user/password/set', data: {
      'type': type,
      'new': password,
      'old': '',
      'unique': unique,
    });

    switch (data) {
      case '':
        return '';
      case 'screen':
        return l10n(null, 'me.settings.lock-screen.same');
      case 'gesture':
        return l10n(null, 'sign.gesture.same');
      case 'destroy':
        return l10n(null, 'sign.destroy.same');
      default:
        return l10n(null, 'failure');
    }
  }

  static Future<bool> passwordOff(String type, String password) async {
    dynamic data = await Http.service('/user/password/off', data: {
      'type': type,
      'password': password,
    });

    return data != null && data;
  }

  static Future<dynamic> passwordOnOff(
      BuildContext context, bool on, String type, String password, void Function(void Function()) setState, String wrong) async {
    if (on) {
      String set = await passwordSet(context, type, password);
      if (set != '') return Future.value(set);

      await User.sign();
      setState(() {});

      return Future.value(null);
    }

    bool off = await User.passwordOff(type, password);
    if (!off) return Future.value(wrong);

    await User.sign();
    setState(() {});

    return Future.value(null);
  }

  static Future<bool> modify(Map<String, String> map) {
    Map<String, String> body = {};
    for (var name in _modifies) {
      if (_map.containsKey(name)) body[name] = _map[name].toString();
    }
    body.addAll(map);

    return _sign('/user/modify', body);
  }

  static Future<void> signOut() async {
    await Http.service('/user/sign-out');
    _map = {};
    if (_listeners.isNotEmpty) {
      for (UserListener listener in _listeners) {
        await listener.signOut();
      }
    }

    return Future.value(null);
  }

  static Future<void> delete(String id) async {
    await Io.delete('');
    exit(0);
  }

  static Future<Map<String, dynamic>> find(String idUidCode) async {
    Map<String, dynamic>? map = await Http.service("/user/find", data: {'idUidCode': idUidCode});

    return Future.value(map == null || map.isEmpty || !map.containsKey('code') ? {} : map);
  }

  static void onOrSignIn(BuildContext context, WidgetsBindingObserver observer, Future<void> Function() function, [bool pop = false]) {
    if (on()) {
      function();
    } else {
      WidgetsBinding.instance.addObserver(observer);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await PageRouter.push(const InUpPage());
        if (on()) {
          function();
        } else {
          if (pop) PageRouter.pop();
          Notifier.setNavigation(context, 0);
        }
      });
    }
  }

  static void addListener(UserListener listener) => _listeners.add(listener);
}
