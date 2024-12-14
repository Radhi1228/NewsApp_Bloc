// import 'package:flutter/material.dart';
//
// class DetailScreen extends StatefulWidget {
//   const DetailScreen({super.key});
//
//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }
//
// class _DetailScreenState extends State<DetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("News Detail"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             article.urlToImage != null
//                 ? Image.network(article.urlToImage!, fit: BoxFit.cover, width: double.infinity)
//                 : Image.asset('assets/default_image.png', fit: BoxFit.cover, width: double.infinity),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 article.title ?? "No Title",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 article.description ?? "No Description Available",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../model/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final Article article;
  GlobalKey repaintKey = GlobalKey();

  NewsDetailScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Detail"),
      ),
      body: RepaintBoundary(
        key: repaintKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              article.urlToImage != null
                  ? CachedNetworkImage(imageUrl: article.urlToImage ?? "",
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
              // Image.network(article.urlToImage!,
              //         fit: BoxFit.cover, width: double.infinity)
                  : Image.asset('assets/image/news.jpg',
                      fit: BoxFit.cover, width: double.infinity),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  article.title ?? "No Title",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              //
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  article.description ?? "No Description Available",
                  style: const TextStyle(
                      fontSize: 16, decorationColor: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Share.share('${article.title}\n\nRead more: ${article.urlToImage ?? ""}');
                      },
                      icon: const Icon(Icons.share),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                        onPressed: () {
                          SaveImage();
                          //SaveImage().then(onValue)
                        },
                        icon: const Icon(Icons.save_alt_outlined)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> SaveImage() async {
    RenderRepaintBoundary boundary =
        repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    var bytes = byteData!.buffer.asUint8List();
    String name =
        "${DateTime.now().hour},${DateTime.now().minute},${DateTime.now().second},${DateTime.now().day},${DateTime.now().month},${DateTime.now().year}";
    if (Platform.isAndroid) {
      await File("storage/emulated/0/Download/$name.png").writeAsBytes(bytes);
      return "storage/emulated/0/Download/$name.png";
    } else {
      Directory? dir = await getDownloadsDirectory();

      await File("${dir!.path}/$name.png");
      return "${dir!.path}/$name.png";
    }
  }
}