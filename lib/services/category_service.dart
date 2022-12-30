import 'package:todo_apps/repository/repository.dart';

import '../models/category.dart';

class CategoryService {
  Repository? _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(CategoryItem categoryItem) async {
    return await _repository!
        .insertData('categories', categoryItem.categoryMap());
  }
}
