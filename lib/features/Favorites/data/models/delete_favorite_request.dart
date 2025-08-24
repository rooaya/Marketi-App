

import 'package:marketiapp/features/Home/data/models/base_request.dart';

class DeleteFavoriteRequest extends BaseRequest {
  final String productId;

  DeleteFavoriteRequest({
    required super.token,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
    };
  }
}