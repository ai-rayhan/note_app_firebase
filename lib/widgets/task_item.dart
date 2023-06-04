import 'package:flutter/material.dart';
import 'package:note_app_firebase/provider/task.dart';
import 'package:note_app_firebase/provider/tasks.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});



  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Tasks>(context);
    final products = productsData.items;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: products[i],
            child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
    );
  }
}








class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<Task>(context, listen: false);
    var sc = ScaffoldMessenger.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        title: Text(task.title),
              trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, 'addtask',
                    arguments: task.id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Tasks>(context, listen: false)
                      .deleteProduct(task.id);
                } catch (e) {
                  sc.showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      ),
    );
  }
}
