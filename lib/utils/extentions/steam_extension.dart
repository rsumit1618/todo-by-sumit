import 'package:rxdart/rxdart.dart';

extension SafeSubjectAddExtn on Subject {
  void safeAdd(dynamic data) {
    if (!this.isClosed) {
      this.add(data);
    }
  }

  void safeSinkAdd(dynamic data) {
    if (!this.isClosed) {
      this.sink.add(data);
    }
  }
}
