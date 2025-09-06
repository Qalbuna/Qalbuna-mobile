import 'package:flutter/material.dart';

class JournalMenuWidget extends StatelessWidget {
  final VoidCallback onAddJournal;
  final VoidCallback onDeleteJournal;

  const JournalMenuWidget({
    super.key,
    required this.onAddJournal,
    required this.onDeleteJournal,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) {
        if (value == 'add') onAddJournal();
        if (value == 'delete') onDeleteJournal();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'add',
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text('Tambah Jurnal'),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(width: 8),
              Text('Hapus Jurnal'),
            ],
          ),
        ),
      ],
    );
  }
}