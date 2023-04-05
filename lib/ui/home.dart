import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallpaper_hub_flutter_bootcamp/ui/search.dart';
import 'package:wallpaper_hub_flutter_bootcamp/ui/wallpaper_view.dart';
import '../api_services/photos_service.dart';
import '../models/category_model.dart';
import '../widgets/appbar.dart';
import '../widgets/category_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  CategoryModel? categoryModel;
  TextEditingController searchC = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    searchC.clear();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: WallpaperAppBar(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
             decoration: BoxDecoration(
                 color: const Color(0xfff5f8fd),
               borderRadius: BorderRadius.circular(30),
             ),
             child:  Row(
               children: [
                 Expanded(
                   child: TextFormField(
                     controller: searchC,
                     onEditingComplete: () => FocusScope.of(context).requestFocus(FocusNode()),
                     decoration: InputDecoration(
                         hintText: "search wallpaprs",
                         suffixIcon: IconButton(icon: const Icon(Icons.search),
                           onPressed: (){
                             if (searchC.text != "") {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => SearchView(
                                         search: searchC.text,
                                       )));
                             }
                           },),
                         border: InputBorder.none
                     ),

                   ),
                 )
               ],
             ),
           ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryDetails.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      imageAssetUrl: categoryDetails[index].imageAssetUrl!,
                      categoryName: categoryDetails[index].categorieName!,
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: height/1.43,
              child: FutureBuilder(
              future: PhotosService().getApi(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // print(snapshot.data!.photos!.length);
                          // print(snapshot.data!.status);
                          return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1.3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5),
                              itemCount: snapshot.data!.photos!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => ImageView(
                                           imgPath: '${snapshot.data!.photos![index]!.src!.portrait}',
                                        )
                                    ));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network("${snapshot.data!.photos![index]!.src!.portrait}",
                                    fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Wallpapers Provided by: www.pexels.com",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12
                ),
                ),
              ],),
          ],
        ),
      ),
    );
  }
}
