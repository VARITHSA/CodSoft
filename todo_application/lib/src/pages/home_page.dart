import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/providers/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    // _found = _todoList;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  // void searchFilter(String query) {
  //   List<Todo> result = [];
  //   if (query.isEmpty) {
  //     result = _todoList;
  //   } else {
  //     result = _todoList
  //         .where((element) =>
  //             element.task.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     _found = result;
  //   });
  // }

  final _controller = TextEditingController();
  final List<Todo> _found = [];
  // final List<Todo> _todoList = TodoNotifier().items;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoNotifier>(context);
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 247, 233, 247),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 247, 233, 247),
        backgroundColor: Colors.grey[100],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Icon(Icons.menu),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => _showAlertDialog(context),
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
                  child: Text(
                    "Hi Shouyo!",
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "${todoProvider.boxItems.length} remaining tasks",
                    style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: _controller,
                        // onChanged: (value) => searchFilter(value),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(Icons.search),
                            iconColor: Colors.deepPurple,
                            hintText: 'Search your text',
                            hintStyle: GoogleFonts.poppins()),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Your Tasks',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          todoProvider.removeAll();
                        },
                        child: Text(
                          'clear',
                          style: GoogleFonts.poppins(color: Colors.deepPurple),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Consumer<TodoNotifier>(
            builder: (context, value, child) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  itemCount: value.boxItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final Todo todo = value.boxItems.elementAt(index);
                    return Provider(
                      create: (context) => (todo, index),
                      child: const ListWidget(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<(Todo, int)>(context);
    print('Heyd ');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ExpansionTile(
          leading: Selector<TodoNotifier, bool>(
            selector: (_, c) {
              return c.boxItems.elementAt(todo.$2).isActive;
            },
            builder: (context, state, child) {
              return Checkbox(
                  value: state,
                  onChanged: (v) => context
                      .read<TodoNotifier>()
                      .finishTask(todo.$1, todo.$2, v ?? state));
            },
          ),
          expandedAlignment: Alignment.topLeft,
          childrenPadding: const EdgeInsets.only(left: 16.0),
          title: Text(
            todo.$1.task,
            style: GoogleFonts.poppins(),
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  todo.$1.description,
                  style: GoogleFonts.poppins(fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<TodoNotifier>().removeTask(todo.$1);
                    },
                    child: const Icon(Icons.delete),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_showAlertDialog(BuildContext context) {
  final taskProvider = Provider.of<TodoNotifier>(context, listen: false);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            "Create Task",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.35),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      // hintText: "title",
                      border: UnderlineInputBorder(),
                      labelText: 'title'),
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      // hintText: "title",
                      border: UnderlineInputBorder(),
                      labelText: 'description'),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          taskProvider.addTask(
                              titleController.text, descriptionController.text);
                          Navigator.pop(context);
                          titleController.clear();
                          descriptionController.clear();
                        },
                        child: const Text("Save"))),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // taskProvider.removeTask(Todo(
                      //     task: titleController.text,
                      //     description: descriptionController.text));
                      taskProvider.removeAll();
                      Navigator.pop(context);
                    },
                    child: const Text("Clear"),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

// AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   height: 60,
//                   width: double.maxFinite,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: Text(
//                           todo.task,
//                           // box.get('key'),
//                           style: GoogleFonts.poppins(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const Spacer(),
//                       InkWell(
//                         onTap: () {
//                           value.removeTask(todo);
//                         },
//                         child: const Icon(Icons.delete),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           value.showDes();
//                         },
//                         child: const Icon(Icons.arrow_drop_down),
//                       )
//                     ],
//                   ),
//                 ),
