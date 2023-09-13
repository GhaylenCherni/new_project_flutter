import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/search/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/search/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var SearchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,Searchstate>(
        listener:(context,state) {},
        builder:(context,state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: SearchController,
                        type: TextInputType.text,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                          {
                            return'Enter text to search';
                          }
                          return null;
                        },
                      onSubmit: (String text)
                      {
                        SearchCubit.get(context).Search(text);
                      },
                        label: 'Search',
                        prefix: Icons.search_outlined,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildListProduct(SearchCubit.get(context).model!.data!.data![index],context,isoldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data!.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
