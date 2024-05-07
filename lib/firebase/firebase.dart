import 'package:thc/firebase/src/user.dart';

export 'archive/fetch_survey.dart';
export 'archive/livestream.dart';
export 'src/user.dart';
export 'src/user_type.dart';
export 'src/firestore.dart';

ThcUser get user => ThcUser.instance!;
set user(ThcUser? updated) {
  ThcUser.instance = updated;
}
