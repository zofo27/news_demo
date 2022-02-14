import 'package:flutter/material.dart';
import 'package:news_demo/model/categories_model.dart';
import 'package:news_demo/reusable/custom_cards.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  FocusNode? searchNode;
  bool isCategory = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      children: <Widget>[
        Container(
          height: 46,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.16),
                offset: const Offset(0, 3),
                blurRadius: 6,
              )
            ],
          ),
          padding: EdgeInsets.fromLTRB(
              25, 0, _searchController.text.isNotEmpty ? 10 : 25, 0),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: TextFormField(
                  controller: _searchController,
                  focusNode: searchNode,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    hintText: "Buscar...",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minHeight: 19,
                      minWidth: 19,
                    ),
                  ),
                ),
              )),
              _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.search_off),
                      color: Colors.black45,
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          isCategory = false;
                        });
                      },
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.black45,
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 17,
        ),
        if (_searchController.text.isEmpty) ...[
          const Text(
            "Top Noticias",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 149 / 114,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(4, (index) {
              return CategoriesCard(
                category: categories[index].name,
                imageUrl: categories[index].imageUrl,
              );
            }),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text("Buscar todo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(
            height: 10,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 149 / 114,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: List.generate(categories.length - 4, (index) {
              return CategoriesCard(
                category: categories[index + 4].name,
                imageUrl: categories[index + 4].imageUrl,
              );
            }),
          ),
        ] else ...[
          if (_searchController.text.isNotEmpty) ...[
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Resultados para: ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.55),
                  )),
              TextSpan(
                  text: _searchController.text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1fa2f9),
                  )),
            ])),
            const SizedBox(
              width: 17,
            ),
            Column(
              children: List.generate(10, (index) {
                return const SearchCard();
              }),
            )
          ] else ...[
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "No hay resultados para: ",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.55),
                  )),
              TextSpan(
                  text: _searchController.text,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1fa2f9),
                  )),
            ])),
            const SizedBox(
              height: 120,
            ),
            const SizedBox(height: 59),
            const Text(
              "No se encontraron resultados...",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xffbebebe),
              ),
              textAlign: TextAlign.center,
            ),
          ]
        ]
      ],
    );
  }
}
