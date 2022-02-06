import 'dart:async';
import 'package:http/http.dart' as http;

class Medicine
{
  int id;
  String title;
  String intro_content;
  String side_effect;
  String side_effect_content;
  String warning;
  String warning_content;
  String usage;
  String usage_content;

  Medicine.fromJson(Map json)
  : id = json['id'],
    title = json['title'],
    intro_content = json['intro_content'],
    side_effect = json['side_effect'],
    side_effect_content = json['side_effect_content'],
    warning = json['warning'],
    warning_content = json['warning_content'],
    usage = json['usage'],
    usage_content = json['usage_content'];

  Map toJson()
  {
    return {
      'id':id,
      'title':title,
      'intro_content':intro_content,
      'side_effect':side_effect,
      'side_effect_content':side_effect_content,
      'warning':warning,
      'warning_content':warning_content,
      'usage':usage,
      'usage_content':usage_content
    };
  }
}

class MedicineAPI
{
  static Future getMedicines() {
    return http.get(Uri.parse("https://medicine-303.herokuapp.com/medicines"));
  }
}