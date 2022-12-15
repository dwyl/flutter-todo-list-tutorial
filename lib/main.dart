import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/repository/todoRepository.dart';

import 'providers.dart';
import 'todo.dart';

/// Keys for components for testing
final bottomNavigationBarKey = UniqueKey();
final addTodoKey = UniqueKey();

// coverage:ignore-start
void main() {
  runApp(const ProviderScope(child: App()));
}
// coverage:ignore-end

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulHookConsumerWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> onRefresh() {
    return ref.read(todoListProvider.notifier).fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Todo>> todosProvider = ref.watch(todoListProvider); // this is only used for the loading animation

    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RefreshIndicator(
            onRefresh: onRefresh,
            child: Scaffold(
              body: todosProvider.when(
                  loading: () => const Center(child: Center(child: CircularProgressIndicator())),
                  error: (error, stack) => const Center(
                          child: Center(
                        child: Text('Could\'nt make API request. Make sure server is running.'),
                      )),
                  data: (_) => ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                        children: [
                          TextField(
                            key: addTodoKey,
                            controller: newTodoController,
                            decoration: const InputDecoration(
                              labelText: 'What do we need to do?',
                            ),
                            onSubmitted: (value) {
                              ref.read(todoListProvider.notifier).add(value);
                              newTodoController.clear();
                            },
                          ),
                          const SizedBox(height: 42),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text('${ref.watch(uncompletedTodosCount)} items left', style: const TextStyle(fontSize: 20)),
                          ),
                          if (todos.isNotEmpty) const Divider(height: 0),
                          for (var i = 0; i < todos.length; i++) ...[
                            if (i > 0) const Divider(height: 0),
                            ProviderScope(
                              overrides: [
                                _currentTodo.overrideWithValue(todos[i]),
                              ],
                              child: const TodoItem(),
                            ),
                          ],
                        ],
                      )),
              bottomNavigationBar: const Menu(),
            )));
  }
}

/// Bottom menu widget
class Menu extends HookConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    int currentIndex() {
      switch (filter) {
        case TodoListFilter.completed:
          return 2;
        case TodoListFilter.active:
          return 1;
        case TodoListFilter.all:
          return 0;
      }
    }

    return BottomNavigationBar(
      key: bottomNavigationBarKey,
      elevation: 0.0,
      onTap: (value) {
        if (value == 0) ref.read(todoListFilter.notifier).state = TodoListFilter.all;
        if (value == 1) ref.read(todoListFilter.notifier).state = TodoListFilter.active;
        if (value == 2) ref.read(todoListFilter.notifier).state = TodoListFilter.completed;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'All', tooltip: 'All'),
        BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: 'Active',
          tooltip: 'Active',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.done),
          label: 'Completed',
          tooltip: 'Completed',
        ),
      ],
      currentIndex: currentIndex(),
      selectedItemColor: Colors.amber[800],
    );
  }
}

/// A provider which exposes the [Todo] displayed by a [TodoItem].
///
/// By retrieving the [Todo] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
///
/// This encapsulation ensures that when adding/removing/editing todos,
/// only what the impacted widgets rebuilds, instead of the entire list of items.
final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();
    final itemIsFocused = useIsFocused(itemFocusNode);

    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            // Only call for todo text change if a value is actually different
            if (todo.description != textEditingController.text) {
              // Commit changes only when the textfield is unfocused, for performance
              ref.read(todoListProvider.notifier).edit(id: todo.id, description: textEditingController.text);
            }
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) => ref.read(todoListProvider.notifier).toggle(todo),
          ),
          title: itemIsFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}

bool useIsFocused(FocusNode node) {
  final isFocused = useState(node.hasFocus);

  useEffect(
    () {
      void listener() {
        isFocused.value = node.hasFocus;
      }

      node.addListener(listener);
      return () => node.removeListener(listener);
    },
    [node],
  );

  return isFocused.value;
}
