import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketiapp/features/Favorites/presentation/vm/Favorite/favorite_cubit.dart';

class HeartIcon extends StatefulWidget {
  const HeartIcon({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  bool _showSnackbar = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteCubit, FavoriteState>(
      listenWhen: (previous, current) =>
          current is FavoriteAddSuccess ||
          current is FavoriteRemoveSuccess ||
          current is FavoriteAddFailure,
      listener: (context, state) {
        if (!_showSnackbar) return;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        /*   if (state is FavoriteAddSuccess) {
          context.showSnackBar(message: state.products.message!);
        } else if (state is FavoritesDeleteSuccess) {
          context.showSnackBar(message: state.products.message!);
        } else if (state is FavoritesGetFailure) {
          context.showSnackBar(message: state.error.message!);
        }*/
      },
      builder: (context, state) {
        //! [ReadContext] and its read method, similar to [watch], but doesn't make widgets rebuild if the value obtained changes.
        final cubit = context.watch<FavoriteCubit>();
        final isFav = cubit.isProudinFav(widget.productId);
        final isLoading = (state is FavoriteAddLoading &&
                state.productId == widget.productId) ||
            (state is FavoriteRemoveLoading &&
                state.ProductId == widget.productId);

        return Padding(
          padding: const EdgeInsets.only(top: 8, right: 8),
          key: ValueKey<bool>(isFav),
          child: isLoading
              ? const CupertinoActivityIndicator()
              : GestureDetector(
                  onTap: () async {
                    _showSnackbar = true;
                    await cubit.toggleFavorite(widget.productId);
                  },
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_outline)),
                ),
        );
      },
    );
  }
}
