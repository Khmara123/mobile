import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/detail.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class SupabaseTestPage extends StatefulWidget {
  const SupabaseTestPage({super.key});

  @override
  State<SupabaseTestPage> createState() => _SupabaseTestPageState();
}

class _SupabaseTestPageState extends State<SupabaseTestPage> {
  final String baseUrl = 'https://frvexfoezbscdbcvuxas.supabase.co';
  final String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZydmV4Zm9lemJzY2RiY3Z1eGFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDY4ODgsImV4cCI6MjA3NTMyMjg4OH0.XDr9MFxBMX0P42a4MwjstxtZeh_Caqdyrfpfr7d9ec8';

  List<dynamic> users = [];

  Future<void> loadUsers() async {
    print('loading users');
    final data = await Supabase.instance.client.from('events').select();
    print(data);

    setState(() {
      users = data;
    });
  }

  Future<void> addUser() async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/events');
      final response = await http.post(
        uri,
        headers: {
          'apikey': apiKey,
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation',
        },
        body: jsonEncode({'title': 'New Event', 'date': '2025-01-01'}),
      );

      if (response.statusCode == 201) {
        print('✅ Событие добавлено');
        await loadUsers();
      } else {
        print('❌ Ошибка при добавлении: ${response.statusCode}');
        print('Ответ: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Исключение при добавлении: $e');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/events?id=eq.$id');
      final response = await http.delete(
        uri,
        headers: {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 204) {
        print('🗑️ Событие удалено');
        await loadUsers();
      } else {
        print('❌ Ошибка при удалении: ${response.statusCode}');
        print('Ответ: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Исключение при удалении: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Список фестивалей')),

      /// 🔥 НИЖНЯЯ ПАНЕЛЬ ТЕПЕРЬ ЕСТЬ!
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // мы на странице событий
        onTap: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/second');
          if (index == 2) context.go('/supabase'); // текущая
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Календарь',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'События'),
        ],
      ),

      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final event = users[index];

                return ListTile(
                  title: Text('${event['title']}'),
                  subtitle: Text('Дата: ${event['date']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteUser(event['id']),
                  ),

                  /// 👉 При нажатии — переход на DetailApp через GoRouter
                  onTap: () {
                    final id = event['id'];
                    context.go('/detail/$id');
                  },
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: loadUsers,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
