import 'package:flutter/material.dart';
import 'package:note_app_firebase/provider/task.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/tasks.dart';

class EditTaskScreen extends StatefulWidget {
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  var _isInit = true;
  var _isLoading = false;

  var _editedProduct = Task(
    id: '',
    title: '',
    description: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<Tasks>(context, listen: false)
            .findById(productId as String);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
     var userId = Provider.of<Auth>(context,listen: false).getUserId;
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != '') {
      await Provider.of<Tasks>(context, listen: false)
          .updateTask(_editedProduct.id, _editedProduct,userId);
    } else {
      try {
        await Provider.of<Tasks>(context, listen: false)
            .addTask(_editedProduct,userId);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Task(
                          title: value!,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Task(
                          title: _editedProduct.title,
                          description: value!,
                          id: _editedProduct.id,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
