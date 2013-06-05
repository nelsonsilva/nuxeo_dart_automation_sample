library model;

import 'package:web_ui/observe.dart';
import 'package:web_ui/observe/html.dart';
import 'package:nuxeo/automation.dart' as nuxeo;
import 'package:nuxeo/http/client.dart' as http;

nuxeo.Automation NX = null;

var nuxeoUrl = "http://localhost:8080/nuxeo/site/automation";

@observable
bool isConnected = false;

@observable
Map<String, List> categories = toObservable({});

connect() {
  var client = new http.Client(nuxeoUrl);
  NX = new nuxeo.Automation(client);

  NX.registry.then((nuxeo.OperationRegistry registry) {
    isConnected = true;
    registry.ops.forEach((name, nuxeo.Operation op) {
      if (!categories.containsKey(op.category)) {
        categories[op.category] = toObservable([]);
      }
      categories[op.category].add(op);
    });
  });
}


