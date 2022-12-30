import 'package:flutter/material.dart';
import 'package:todo_apps/models/category.dart';
import 'package:todo_apps/screens/home_screen.dart';
import 'package:todo_apps/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _categoriesNameController = TextEditingController();
  TextEditingController _categoriesDescriptionController = TextEditingController();
  CategoryItem _categoryItem = CategoryItem();
  CategoryService _categoryService = CategoryService();

  _showFormDialog(BuildContext context){
    return showDialog(context: context,barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red
              ),
              onPressed: ()=>Navigator.pop(context),
              child: Text('Cancel')
          ),
          ElevatedButton(
              onPressed: (){
               _categoryItem.name = _categoriesNameController.text;
               _categoryItem.description = _categoriesDescriptionController.text;
               _categoryService.saveCategory(_categoryItem);
              },
              child: Text('Save')
          )
        ],
        title: Text('Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _categoriesNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                  hintText: 'Write a category',
                  labelText: 'Category'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _categoriesDescriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                    ),
                    hintText: 'Write a description',
                    labelText: 'Description'
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        title: Text('Categories'),
      ),
      body: Center(
        child: Text('Welcome to Categories screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
