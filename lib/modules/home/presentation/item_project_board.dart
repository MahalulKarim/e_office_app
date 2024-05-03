import 'package:flutter/material.dart';
import 'package:eofficeapp/common/models/project_board_response.dart';

class ItemProjectBoard extends StatelessWidget {
  const ItemProjectBoard({
    Key? key,
    required this.data,
    this.onPressed,
  }) : super(key: key);

  final ProjectBoardData data;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.task ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold, // Tambahkan font bold
                    height: 1.5, // Atur jarak ke bawah
                  ),
                ),
// Menampilkan informasi name_users_join
                if (data.name_users_join != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.name_users_join!.map((join) {
                      return Text(
                        'User Join: $join',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      );
                    }).toList(),
                  ),
                Text(
                  data.dateCreated ?? "",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
