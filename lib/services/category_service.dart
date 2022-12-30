import 'package:todo_apps/repository/repository.dart';

import '../models/category.dart';

class CategoryService {
  Repository? _repository;

  CategoryService() {
    _repository = Repository();
  }

  //Create data
  saveCategory(CategoryItem categoryItem) async {
    return await _repository!
        .insertData('categories', categoryItem.categoryMap());
  }

  //Read data from table
  readCategories()async{
    return await _repository!.readData('categories');
  }

  //Read data from table by Id
  readCategoryById(categoryId)async{
    return await _repository?.readDataById('categories', categoryId);
  }
}
