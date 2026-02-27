// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/cache_service.dart';
import 'providers/tasks_provider.dart';
import 'theme/app_theme.dart';
import 'utils/routes.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/tasks/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cache = CacheService();
  await cache.init();
  runApp(
    ProviderScope(
      overrides: [
        cacheServiceProvider.overrideWithValue(cache),
      ],
      child: const TaskMasterApp(),
    ),
  );
}

class TaskMasterApp extends ConsumerWidget {
  const TaskMasterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'TaskMaster',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.home: (_) => const HomeScreen(),
      },
    );
  }
}
