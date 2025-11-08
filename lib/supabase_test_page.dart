import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SupabaseTestPage extends StatefulWidget {
  const SupabaseTestPage({super.key});

  @override
  State<SupabaseTestPage> createState() => _SupabaseTestPageState();
}

class _SupabaseTestPageState extends State<SupabaseTestPage> {
  final String baseUrl = 'https://cirljvnifsjeqelaarjd.supabase.co';
  final String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpcmxqdm5pZnNqZXFlbGFhcmpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI2MTAwOTIsImV4cCI6MjA3ODE4NjA5Mn0.VKCuMCeeLsbF80p1D7M5GNkZwN1___uxn57uV_9Tm94';

  List<dynamic> users = [];

  Future<void> loadUsers() async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/users_demo?select=*');
      final response = await http.get(
        uri,
        headers: {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
        });
        print('✅ Данные успешно загружены: ${users.length}');
      } else {
        print('❌ Ошибка при загрузке: ${response.statusCode}');
        print('Ответ: ${response.body}');
      }
    } catch (e) {
      print('⚠️ Исключение при загрузке: $e');
    }
  }

  Future<void> addUser() async {
    try {
      final uri = Uri.parse('$baseUrl/rest/v1/users_demo');
      final response = await http.post(
        uri,
        headers: {
          'apikey': apiKey,
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation',
        },
        body: jsonEncode({'name': 'New User', 'age': 21}),
      );

      if (response.statusCode == 201) {
        print('✅ Пользователь добавлен');
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
      final uri = Uri.parse('$baseUrl/rest/v1/users_demo?id=eq.$id');
      final response = await http.delete(
        uri,
        headers: {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'},
      );

      if (response.statusCode == 204) {
        print('🗑️ Пользователь удалён');
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
      appBar: AppBar(title: const Text('Supabase Demo')),
      body: users.isEmpty
          ? const Center(
              child: Text(
                'Нет данных (возможно, нет доступа к таблице)',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('${user['name']} (${user['age']})'),
                  subtitle: Text('ID: ${user['id']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteUser(user['id']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
