import 'package:domain/entities/todo_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/presentation/todo/todo_home_page_view_model.dart';

class TodoHomePageView extends BasePageViewWidget<TodoHomePageViewModel> {
  const TodoHomePageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, TodoHomePageViewModel model) {
    return _TodoHomeContent(model: model);
  }
}

class _TodoHomeContent extends StatefulWidget {
  final TodoHomePageViewModel model;

  const _TodoHomeContent({required this.model});

  @override
  State<_TodoHomeContent> createState() => _TodoHomeContentState();
}

class _TodoHomeContentState extends State<_TodoHomeContent> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Todo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            _AuthPanel(
              model: model,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Create todo',
                    ),
                    onSubmitted: (_) => _createTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: model.isBusy ? null : _createTodo,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            if (model.message != null) ...[
              const SizedBox(height: 8),
              Text(model.message!),
            ],
            const SizedBox(height: 12),
            Expanded(
              child: model.todos.isEmpty
                  ? const Center(child: Text('No todos yet'))
                  : ListView.separated(
                      itemCount: model.todos.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return _TodoTile(
                          todo: model.todos[index],
                          onChanged: () => model.toggleTodo(model.todos[index]),
                          onDelete: () => model.deleteTodo(model.todos[index].id),
                          onRename: (title) => model.updateTitle(
                            model.todos[index],
                            title,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _createTodo() {
    widget.model.createTodo(title: _titleController.text);
    _titleController.clear();
  }
}

class _AuthPanel extends StatelessWidget {
  final TodoHomePageViewModel model;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _AuthPanel({
    required this.model,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final user = model.currentUser;
    if (user != null) {
      return Row(
        children: [
          Expanded(child: Text(user.email ?? user.displayName ?? 'Logged in')),
          TextButton.icon(
            onPressed: model.isBusy ? null : model.syncTodos,
            icon: const Icon(Icons.sync),
            label: const Text('Sync'),
          ),
        ],
      );
    }
    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Email',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Password',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: model.isBusy
                    ? null
                    : () => model.loginWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                child: const Text('Login'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: model.isBusy
                    ? null
                    : () => model.registerWithEmail(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                child: const Text('Register'),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.outlined(
              onPressed: model.isBusy ? null : model.loginWithGoogle,
              icon: const Icon(Icons.g_mobiledata),
            ),
          ],
        ),
      ],
    );
  }
}

class _TodoTile extends StatefulWidget {
  final TodoEntity todo;
  final VoidCallback onChanged;
  final VoidCallback onDelete;
  final ValueChanged<String> onRename;

  const _TodoTile({
    required this.todo,
    required this.onChanged,
    required this.onDelete,
    required this.onRename,
  });

  @override
  State<_TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<_TodoTile> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.todo.title);
  }

  @override
  void didUpdateWidget(covariant _TodoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo.title != widget.todo.title) {
      _controller.text = widget.todo.title;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (_) => widget.onChanged(),
      ),
      title: TextField(
        controller: _controller,
        decoration: const InputDecoration(border: InputBorder.none),
        onSubmitted: widget.onRename,
      ),
      subtitle: Text(widget.todo.isSynced ? 'Synced' : 'Local'),
      trailing: IconButton(
        onPressed: widget.onDelete,
        icon: const Icon(Icons.delete_outline),
      ),
    );
  }
}
