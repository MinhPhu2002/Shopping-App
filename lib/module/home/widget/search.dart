import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testapp/core/constants/icon_path.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    this.search,
    required this.onchange,
  });

  final String? search;
  final void Function(String? search) onchange;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController? searchController;

  @override
  void initState() {
    // TODO: implement initState
    searchController = TextEditingController(text: widget.search);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(245, 246, 250, 1),
      ),
      child: TextField(
        onSubmitted: (value) {
          widget.onchange.call(searchController?.text);
        },
        controller: searchController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: "Search...",
          hintStyle: const TextStyle(
              fontSize: 17, color: Color.fromRGBO(143, 149, 158, 1)),
          prefixIcon: SvgPicture.asset(
            IconPath.search,
            width: 20,
            height: 20,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
