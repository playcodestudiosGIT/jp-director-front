import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/models/http/leads_response.dart';
import 'package:jpdirector_frontend/models/lead.dart';

import '../api/jp_api.dart';

class LeadsProvider extends ChangeNotifier {
  List<Lead> _leads = [];

  List<Lead> get leads => _leads;

  bool _isOk = false;

  bool get isOk => _isOk;

  set isOk(bool value) {
    _isOk = value;
    notifyListeners();
  }

  set leads(List<Lead> value) {
    _leads = value;
    notifyListeners();
  }

  getLeads() async {
    // 0 - 100
    final resp = await JpApi.httpGet('/leads');
    final leadsResponse = LeadsResponse.fromJson(resp);

    _leads = leadsResponse.leads;

    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  Future<bool> createLead({required String email, required String telf}) async {
    final data = {
      "email": email,
      "telf": telf,
    };

    // Petición HTTP
    await JpApi.post('/leads', data).then((json) {
      final lead = Lead.fromJson(json);
      leads.add(lead);
      _isOk = true;
      notifyListeners();
      return true;
    }).catchError((e) {
      return false;
    });
    return false;
  }

  updateLead({required String? id, required String email, required String telf}) async {
    final data = {"email": email, "telf": telf};

    try {
      final json = await JpApi.put('/leads/$id', data);

      _leads = leads.map(
        (u) {
          if (u.uid != id) return u;
          u = Lead(email: json['email'], uid: json['uid'], telf: json['telf']);
          return u;
        },
      ).toList();

      notifyListeners();
    } catch (e) {
      throw Exception('Error en el update user  $e');
    }
  }

  deleteLead(String? id) async {
    try {
      final asd = await JpApi.delete('/leads/$id', {});
      _leads.removeWhere((lead) => (lead.uid == id));
      notifyListeners();
      return asd;
    } catch (e) {
      throw Exception('Error en el delete lead  $e');
    }
  }
}
