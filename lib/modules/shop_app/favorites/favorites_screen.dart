import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/states.dart';
import 'package:udemy_flutter/models/shop_app/favorites_model.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: !(state is ShopLoadingGetFavoritesState),
          builder: (context) {
            final favoritesModel = ShopCubit.get(context).favoritesModel;

            if (favoritesModel == null) {
              // Handle null case
              return Center(
                child: Text('No favorites found',style: Theme.of(context).textTheme.bodyText1,),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) =>
                  buildListProduct(favoritesModel.data!.data![index].product!, context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: favoritesModel.data!.data!.length,
            );
          },
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

}
