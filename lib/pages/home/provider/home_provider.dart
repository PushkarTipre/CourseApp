import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/models/CoursePurchasedInfo.dart';

import '../controller/home_controller.dart';

final purchasedCoursesProvider =
    FutureProvider.family<List<CoursePurchaseData>?, String>((ref, userToken) {
  return ref
      .read(purchasedCoursesControllerProvider(userToken: userToken).future);
});
