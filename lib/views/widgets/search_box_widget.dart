import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../models/product_model.dart';
import '../../services/http_call.dart';
import '../product_details.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TypeAheadField<ProductModel?>(
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: const TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: 'Search Username',
          ),
        ),
        suggestionsCallback: ApiService.getUserSuggestions,
        itemBuilder: (context, ProductModel? suggestion) {
          final user = suggestion!;

          return ListTile(
              leading: SizedBox(
                width: 50,
                child: Image.network(user.imageLink),
                // child: CircleAvatar( backgroundImage: NetworkImage(user.imageLink))
              ),
              title: Text(
                user.name,
                maxLines: 1,
                style: const TextStyle(
                    fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text('${user.brand}'));
        },
        noItemsFoundBuilder: (context) => const SizedBox(
          height: 100,
          child: Center(
            child: Text(
              'Product not Found.',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        onSuggestionSelected: (ProductModel? suggestion) {
          final user = suggestion!;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      title: user.name,
                      imageLink: user.imageLink,
                      brand: user.brand.toString(),
                      description: user.description,
                      name: user.name,
                      price: user.price!,
                    )),
          );
        },
      ),
    );
  }
}



// SizedBox(
//       height: 50,
//       // width: 100,
//       child: TextField(
//         //onChanged: onChange,
//         keyboardType: TextInputType.text,
//         decoration: InputDecoration(
//             // fillColor: Colors.grey,
//             prefixIcon: const Icon(
//               Icons.search_outlined,
//               color: Colors.black,
//               size: 28,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.black.withOpacity(0.1),
//                 width: 1,
//               ),
//               borderRadius: const BorderRadius.all(Radius.circular(7.0)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.grey.withOpacity(0.5),
//                 width: 1,
//               ),
//               borderRadius: const BorderRadius.all(Radius.circular(7.0)),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//             hintText: 'Search for products',
//             filled: true,
//             hintStyle: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: Colors.black,
//             )),
//       ),
//     );


