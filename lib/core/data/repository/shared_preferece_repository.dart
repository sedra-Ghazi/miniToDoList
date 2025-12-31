import 'package:flutter_application_4/core/data/models/card_model.dart';
import 'package:flutter_application_4/core/enums/data_type.dart';
import 'package:flutter_application_4/main.dart';



final SharedPreferencesRepository storage =
    SharedPreferencesRepository.instance;

class SharedPreferencesRepository {
  static final SharedPreferencesRepository _instance =
      SharedPreferencesRepository._internal();
  static SharedPreferencesRepository get instance => _instance;
  SharedPreferencesRepository._internal();

  static const String prefFirstLaunch = 'PREF_FIRST_LAUNCH';
   static const String cardListKey = 'PREF_CARD_LIST';


  void setCardList(List<CardModel> list) {
  setPreference(
    dataType: DataType.STRING,
    key: cardListKey,
    value: CardModel.encode(list),
  );
}

 List<CardModel> getCardList() {
  if (globalSharedPrefs!.containsKey(cardListKey)) {
    final String jsonString = getPreference(key: cardListKey);
    if (jsonString.isNotEmpty) {
      return CardModel.decode(jsonString);
    }
  }
  return [];
}

void addCard(CardModel card) {
  final List<CardModel> currentList = getCardList();
  currentList.add(card);
  setCardList(currentList);
}


void updateCard(CardModel updatedCard) {
  final List<CardModel> currentList = getCardList();
  final index = currentList.indexWhere((card) => card.id == updatedCard.id);
  
  if (index != -1) {
    currentList[index] = updatedCard;
    setCardList(currentList);
  }
}

void deleteCard(String cardId) {
  final List<CardModel> currentList = getCardList();
  currentList.removeWhere((card) => card.id == cardId);
  setCardList(currentList);
}



  

  setFirstLaunch(bool value) {
    setPreference(dataType: DataType.BOOL, key: prefFirstLaunch, value: value);
  }

  bool getFirstLaunch() {
    if (globalSharedPrefs!.containsKey(prefFirstLaunch)) {
      return getPreference(key: prefFirstLaunch);
    } else {
      return true;
    }
  }

  setPreference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPrefs!.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPrefs!.setBool(key, value);
        break;
      case DataType.STRING:
        await globalSharedPrefs!.setString(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPrefs!.setDouble(key, value);
        break;
      case DataType.LISTSTRING:
        await globalSharedPrefs!.setStringList(key, value);
        break;
    }
  }

  dynamic getPreference({required String key}) {
    return globalSharedPrefs!.get(key);
  }
}





