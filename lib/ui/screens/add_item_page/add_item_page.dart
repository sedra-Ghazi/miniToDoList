import 'package:flutter/material.dart';
import 'package:flutter_application_4/core/data/models/card_model.dart';
import 'package:flutter_application_4/core/data/repository/shared_preferece_repository.dart';

class AddEditPage extends StatefulWidget {
  final VoidCallback onSave;
  final CardModel? cardToEdit;

  const AddEditPage({
    Key? key,
    this.cardToEdit,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.cardToEdit != null) {
      _titleController.text = widget.cardToEdit!.title;
      _descriptionController.text = widget.cardToEdit!.description;
    }
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
     
      //final String id = DateTime.now().millisecondsSinceEpoch.toString();
      
      
      final newCard = CardModel(
        id: widget.cardToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: widget.cardToEdit?.createdAt ?? DateTime.now(),
      );

      if (widget.cardToEdit == null) {
        storage.addCard(newCard);
      } else {
        storage.updateCard(newCard);
      }

      
     // storage.addCard(newCard);

      
      widget.onSave();
      Navigator.pop(context);
    }
  }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _descriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.cardToEdit == null ? 'Add  New Card' : 'Edit Card'),
        actions: [
          if (widget.cardToEdit != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                storage.deleteCard(widget.cardToEdit!.id);
                widget.onSave();
                Navigator.pop(context);
              },
            ),
        ],
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),//تستخدم مشان نحنا مو بالعادة عندنا بس تعمل push بيصير بال appbar فيarrowبشكل افتراضي  ززفهاد مشان نعمل شكل ال arrow على كيفنا نغيره بس نحنا بهالحالة بدنا ال action لانه بتساع ويدجات

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
               
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                
                
                ElevatedButton(
                  onPressed: _saveCard,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}