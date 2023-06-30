import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
enum MealType { breakfast, lunch, dinner, snack }

String getMealType(MealType type, BuildContext context){
  switch(type){
    case MealType.breakfast:
      return AppLocalizations.of(context)!.breakfast;
    case MealType.lunch:
      return AppLocalizations.of(context)!.lunch;
    case MealType.dinner:
      return AppLocalizations.of(context)!.dinner;
    case MealType.snack:
      return AppLocalizations.of(context)!.snack;
  }
}