
import 'package:flutter/material.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/widgets/AppWidget.dart';
import 'package:provider/provider.dart';

import 'AppDetails.dart';
class CategoryProducts extends StatefulWidget {
  const CategoryProducts({Key key}) : super(key: key);

  @override
  _CategoryProductsState createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body:  ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context,index)=>SizedBox(height: 20,),
          shrinkWrap: true,
          itemCount:appProvider.appcategories.length,
          itemBuilder: (context,index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          AppDetails(
                            appModel: appProvider.appcategories[index],
                            description: appProvider.appcategories[index].description,
                            price: appProvider.appcategories[index].price,
                            image: appProvider.appcategories[index].images,
                            name: appProvider.appcategories[index].name,
                            demolink: appProvider.appcategories[index].demolink,
                            features: appProvider.appcategories[index].features,)));
                },
                child: AppWidget(appModel: appProvider.appcategories[index],));
          }),
    );
  }
}
