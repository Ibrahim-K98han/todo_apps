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
  TextEditingController _editCategoriesNameController = TextEditingController();
  TextEditingController _editCategoriesDescriptionController = TextEditingController();

  CategoryItem _categoryItem = CategoryItem();
  CategoryService _categoryService = CategoryService();
  List<CategoryItem> _categoryList = <CategoryItem>[];
  var category;

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories()async{
    _categoryList = <CategoryItem>[];
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        var categoryModel = CategoryItem();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId)async{
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoriesNameController.text = category[0]['name']?? 'No Name';
      _editCategoriesDescriptionController.text = category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

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
              onPressed: ()async{
               _categoryItem.name = _categoriesNameController.text;
               _categoryItem.description = _categoriesDescriptionController.text;

               var result = await _categoryService.saveCategory(_categoryItem);
               print(result);
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

  _editFormDialog(BuildContext context){
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
              onPressed: ()async{
                _categoryItem.name = _categoriesNameController.text;
                _categoryItem.description = _categoriesDescriptionController.text;

                var result = await _categoryService.saveCategory(_categoryItem);
                print(result);
              },
              child: Text('Update')
          )
        ],
        title: Text('Edit Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _editCategoriesNameController,
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
                controller: _editCategoriesDescriptionController,
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
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Card(
              elevation: 10,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    _editCategory(context, _categoryList[index].id);
                  },
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_categoryList[index].name.toString()),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )
                    )
                  ],
                ),
              ),
            ),
          );
        },
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
