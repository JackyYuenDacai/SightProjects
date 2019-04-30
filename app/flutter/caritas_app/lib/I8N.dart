import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class I8N{
  I8N(this.locale);
  final Locale locale;
  static I8N of(BuildContext context){
    return Localizations.of<I8N>(context, I8N);
  }
  static Map<String,Map<String,String>> I8N_values = {
    'en':{
      'apptitle':'CaritasApp',
      'home':'Home',
    },
    'zh':{
      'apptitle':'明愛樂勤應用程式',
      'home':'主頁',
    }
  };
  String get apptitle{return I8N_values[locale.languageCode]['apptitle'];}
  String get home{return I8N_values[locale.languageCode]['home'];}
}
class I8NDelegate extends LocalizationsDelegate<I8N>{
  const I8NDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<I8N> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<I8N>(I8N(locale));
  }

  @override
  bool shouldReload(I8NDelegate old) => false;
}
