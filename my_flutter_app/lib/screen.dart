import 'package:flutter/material.dart';
import 'api.dart';
import 'models.dart';
import 'item_form_screen.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ApiService apiService = ApiService();
  List<ItemModel> items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
    });
    try {
      final newItems = await apiService.fetchItems();
      setState(() {
        items = [];
        items.addAll(newItems);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await apiService.deleteItem(id);
      setState(() {
        items.removeWhere((item) => item.id == id);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items List')),
      body: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(
              title: Text(item.lastName),
              subtitle: Text(item.lastName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemFormScreen(item: item),
                      ),
                    ).then((_) =>fetchItems()),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteItem(item.id),
                  ),
                ],
              ),
            );
          } else if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ElevatedButton(
              onPressed: fetchItems,
              child: Text('Load More'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemFormScreen()),
        ).then((_) => fetchItems()),
      )
    );
  }
}
