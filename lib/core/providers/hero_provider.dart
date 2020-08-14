import 'package:super_hero/core/helpers/error_helper.dart';
import 'package:super_hero/core/models/hero.dart';
import 'package:super_hero/core/models/interface_screen.dart';
import 'package:super_hero/core/repositories/remote/interface_repository.dart';
import 'base_provider.dart';

class HeroProvider extends BaseProvider {
  InterfaceScreen _view;
  IRepository _repository;

  void init(InterfaceScreen view, IRepository repository){
    this._view = view;
    this._repository = repository;
  }

  void refresh(){
    notifyListeners();
  }

  Future<List<HeroModel>> listAllHeroes() async {
    return tryCatch<List<HeroModel>>(() async {

      final result = await syncTreatment(()=>_repository.listAll());

      if (result != null && result['results'] != null) {
        return (result['results'] as List).map((e) => HeroModel.fromJson(e)).toList();
      }
      return <HeroModel>[];

    }, errorCallback: _view.onError);
  }
}



