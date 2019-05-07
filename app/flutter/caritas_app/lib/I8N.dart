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
      'students_title':'Students',
      'home':'Home',
      'rfid_title':'RFID Page',
      'manuel_title':'Manuel Page',
      'setting_title':'Setting Page',
      'confirm':'Confirm',
      'cancel':'Cancel',
      'add_student':'Add Student',
      'add_staff':'Add Staff',
      'location_text':'Location ',
      'submit_text':'Submit',
    },
    'zh':{
      'apptitle':'明愛樂勤應用程式',
      'students_title':'學生',
      'home':'主頁',
      'rfid_title':'無線感應頁面',
      'manuel_title':'手動加入',
      'setting_title':'設定',
      'confirm':'確定',
      'cancel':'取消',
      'add_student':'添加學生',
      'add_staff':'添加職員',
      'location_text':'地點 ',
      'submit_text':'提交',
    },
  };
  String get apptitle{return I8N_values[locale.languageCode]['apptitle'];}
  String get home{return I8N_values[locale.languageCode]['home'];}
  String get students_title{return I8N_values[locale.languageCode]['students_title'];}
  String get manuel_title{return I8N_values[locale.languageCode]['manuel_title'];}
  String get rfid_title{return I8N_values[locale.languageCode]['rfid_title'];}
  String get setting_title{return I8N_values[locale.languageCode]['setting_title'];}
  String get confirm{return I8N_values[locale.languageCode]['confirm'];}
  String get cancel{return I8N_values[locale.languageCode]['cancel'];}
  String get add_student{return I8N_values[locale.languageCode]['add_student'];}
  String get add_staff{return I8N_values[locale.languageCode]['add_staff'];}

  String get location_text{return I8N_values[locale.languageCode]['location_text'];}
  String get submit_text{return I8N_values[locale.languageCode]['submit_text'];}
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
