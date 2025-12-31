
import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/data/models/card_model.dart';
import 'package:flutter_application_4/core/data/repository/shared_preferece_repository.dart';
import 'package:flutter_application_4/ui/screens/add_item_page/add_item_page.dart';
 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> _cards = [];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    final cards = storage.getCardList();
    setState(() {
      _cards = cards;
    });
  }

  // void _deleteCard(String cardId) {
  //   storage.deleteCard(cardId);
  //   _loadCards();
  // }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditPage(onSave: _loadCards),
                ),
              );
            },
          ),
        ],
      ),
      body: _cards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No cards yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap + button to add your first card',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                 return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      card.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(card.description),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEditPage(
                              cardToEdit: card,
                              onSave: _loadCards,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );

                // return Card(
                //   margin: const EdgeInsets.only(bottom: 12),
                //   elevation: 2,
                //   child: Padding(
                //     padding: const EdgeInsets.all(16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                        
                //         Row(
                //           children: [
                //             Container(
                //               width: 8,
                //               height: 8,
                //               decoration: BoxDecoration(
                //                 color: Colors.blue,
                //                 shape: BoxShape.circle,
                //               ),
                //             ),
                //             const SizedBox(width: 12),
                //             Expanded(
                //               child: Text(
                //                 card.title,
                //                 style: const TextStyle(
                //                   fontSize: 18,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         const SizedBox(height: 12),
                       
                //         Text(
                //           card.description,
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Colors.grey[700],
                //           ),
                //         ),
                //         const SizedBox(height: 8),
                       
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
    );
  }
}