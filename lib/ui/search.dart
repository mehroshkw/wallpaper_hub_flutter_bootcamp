import 'package:flutter/material.dart';
import 'package:wallpaper_hub_flutter_bootcamp/ui/wallpaper_view.dart';
import '../api_services/catergory_service.dart';
import '../widgets/appbar.dart';

class SearchView extends StatefulWidget {
  String search;
   SearchView({super.key, required this.search});


  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // leading: Container(),
        backgroundColor: Colors.white,
        title: WallpaperAppBar(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: height/1.16,
              child: FutureBuilder(
                  future: CategoryService().getCatApi(widget.search),
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
