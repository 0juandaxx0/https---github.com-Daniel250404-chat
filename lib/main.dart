import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.purple[100]!,
        ),
      ),
      home: const LoginPage(), // Pantalla inicial de la app
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UberChat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Acción del botón de edición
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SearchBar(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  UserTile(
                    name: 'Julian',
                    code: '123',
                    description: 'chatea conmigo.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de añadir contacto
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddContactPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class UserTile extends StatelessWidget {
  final String name;
  final String code;
  final String description;

  const UserTile({
    Key? key,
    required this.name,
    required this.code,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, color: Colors.white),
      ),
      title: Text('$name ($code)'),
      subtitle: Text(description),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        // Cuando se toca el ListTile, navega a la pantalla de chat.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(userName: name),
          ),
        );
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: 'Buscar',
      ),
    );
  }
}

// Pantalla de Configuración
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UberChat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          ListTile(
            leading: Icon(Icons.person, size: 40),
            title: Text('configuracion'),
            subtitle: Text('Daniel'),
            trailing: ElevatedButton(
              onPressed: null,
              child: Text('perfil'),
            ),
          ),
          SettingsOptionTile(
            icon: Icons.notifications,
            title: 'notificaciones',
            description:
                'Description duis aute irure dolor in reprehenderit in voluptate velit.',
          ),
          SettingsOptionTile(
            icon: Icons.person_outline,
            title: 'personalizacion',
            description:
                'Description duis aute irure dolor in reprehenderit in voluptate velit.',
          ),
          SettingsOptionTile(
            icon: Icons.lock,
            title: 'privacidad',
            description:
                'Description duis aute irure dolor in reprehenderit in voluptate velit.',
          ),
          SettingsOptionTile(
            icon: Icons.language,
            title: 'idioma',
            description:
                'Description duis aute irure dolor in reprehenderit in voluptate velit.',
          ),
          SettingsOptionTile(
            icon: Icons.update,
            title: 'actualizaciones',
            description:
                'Description duis aute irure dolor in reprehenderit in voluptate velit.',
          ),
        ],
      ),
    );
  }
}

// Clase SettingsOptionTile personalizada
class SettingsOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SettingsOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(title),
      subtitle: Text(description),
      trailing: Icon(Icons.arrow_forward),
    );
  }
}

// Pantalla de añadir contacto
class AddContactPage extends StatelessWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir contacto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'NUMERO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Label',
                hintText: 'Input',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla de Chat
class ChatPage extends StatefulWidget {
  final String userName; // El nombre del usuario con quien se está chateando.

  const ChatPage({Key? key, required this.userName}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> messages = []; // Lista para almacenar mensajes.
  final TextEditingController _controller =
      TextEditingController(); // Controlador para el TextField.

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text); // Agregar mensaje a la lista.
        _controller.clear(); // Limpiar el TextField.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con ${widget.userName}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: messages[index],
                  isSentByMe:
                      true, // Suponemos que todos los mensajes son enviados por el usuario actual
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed:
                      _sendMessage, // Llamar a la función para enviar el mensaje.
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Clase ChatBubble
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({Key? key, required this.message, required this.isSentByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message),
      ),
    );
  }
}