import 'package:bekia_pay/core/shared/logic/api_result.dart';
import 'package:bekia_pay/core/utils/extensions/num_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PointsRepo {
  Future<ApiResult<num>> getPoints() async {
    final session = Supabase.instance.client.auth.currentSession;
    try {
      final userData = await Supabase.instance.client
          .from("profiles")
          .select("points_balance")
          .eq("id", session!.user.id)
          .timeout(5.sec);
      if (userData.isNotEmpty) {
        final num points = userData.first["points_balance"] as num;
        return ApiResult.success(points);
      } else {
        return ApiResult.failure("something went wrong with user");
      }
    } catch (exception) {
      return ApiResult.failure(exception.toString());
    }
  }
}
