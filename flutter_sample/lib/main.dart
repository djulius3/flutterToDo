import 'package:flutter/material.dart';

void main() => runApp(new SampleApp());

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome User!',
      home: new SampleList(),
      
    );
  }
}

class SampleList extends StatefulWidget {
  @override
  createState() => new SampleListState();
}

class SampleListState extends State<SampleList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
  // Only add the task if the user actually entered something
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  // Build the whole list of todo items
  Widget _buildList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildWithItem(_todoItems[index], index);
        }
      }
    ); 
  }

  Widget _buildWithItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _clickToRemove(index)
    );
  }

  void _addToList() {
  // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task'),
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                    Colors.red,
                    Colors.blue
                  ])          
                ),        
              ),    
            ),
            body: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context); // Close the add todo screen
              },
              
            )
          );
        }
      )
    );
  }

  void _removeItem(int index) {
  setState(() => _todoItems.removeAt(index));
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _clickToRemove(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Delete "${_todoItems[index]}"?'),
          actions: <Widget>[
            new TextButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new TextButton(
              child: new Text('REMOVE'),
              onPressed: () {
                _removeItem(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome User!'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Colors.red,
              Colors.blue
            ])          
         ),        
     ),    
      ),
      body: _buildList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addToList, // pressing this button now opens the new screen
        child: new Icon(Icons.add), 
        tooltip: 'Create Task',
      ),
    );
  }

  
}
