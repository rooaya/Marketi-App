

import 'package:marketiapp/features/Home/data/models/base_request.dart';

class AddFavoriteRequest extends BaseRequest {
  final String productId;

  AddFavoriteRequest({
    required super.token,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
    };
  }
}