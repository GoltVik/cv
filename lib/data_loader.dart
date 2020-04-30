import 'dart:convert';

import 'package:cv/models/certificate_model.dart';
import 'package:cv/models/language_model.dart';
import 'package:flutter/services.dart';

import 'models/experience_model.dart';

class DataLoader {
  Future<String> _loadAsset(String fileName) async {
    return await rootBundle.loadString('assets/$fileName.json');
  }

  Future<List<ExperienceModel>> loadExperience() async {
    var dataString = await _loadAsset('experience');
    var jsonList = jsonDecode(dataString);
    return (jsonList as List)
        .map((json) => ExperienceModel.fromJson(json))
        .toList();
  }

  Future<List<ExperienceModel>> loadEducation() async {
    var dataString = await _loadAsset('education');
    var jsonList = jsonDecode(dataString);
    return (jsonList as List)
        .map((json) => ExperienceModel.fromJson(json))
        .toList();
  }

  Future<List<LanguageModel>> loadLanguages() async {
    var dataString = await _loadAsset('languages');
    var jsonList = jsonDecode(dataString);
    return (jsonList as List)
        .map((json) => LanguageModel.fromJson(json))
        .toList();
  }

  Future<List<String>> loadSkills() async {
    var dataString = await _loadAsset('skills');
    var jsonList = jsonDecode(dataString);
    return (jsonList as List).map((e) => e as String).toList();
  }

  Future<List<CertificateModel>> loadCerts() async {
    var dataString = await _loadAsset('certificates');
    var jsonList = jsonDecode(dataString);
    return (jsonList as List)
        .map((json) => CertificateModel.fromJson(json))
        .toList();
  }
}
