import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hirely/feature/home/view/details_screen.dart';
import 'package:hirely/feature/post/view_model/job_controller.dart';

import '../../../core/extentions/image_path.dart';
import '../../../shared/containers/custom_image.dart';
import '../../../shared/model/color_model.dart';
import '../../profile/view_model/user_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((t) {
      ref.read(userProvider.notifier).userInitialize();
      ref.read(jobProvider.notifier).jobInitialize();
    });
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(jobProvider).jobs;
    return Scaffold(
      backgroundColor: Colors.white, //Color(0xfff2f4f5),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F6FB), //Colors.white,
        title: Row(
          children: [
            CustomImage(
              height: 35,
              width: 35,
              imagePath: ImagePath.appbar_logo,
            ),
            Text("Hirely", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xff188273)),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: home!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(index: index)));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 2, color: Colors.blueAccent),
                                color: Colors.blueAccent
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  fit: BoxFit.cover,
                                  height: 40,
                                  width: 40,
                                  "https://cldryweohlzpfeteqesz.supabase.co/storage/v1/object/public/${home[index].img}",
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(home[index].userName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(home[index].getFormattedDateTime(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(home[index].title, maxLines: 2, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 2),
                        Text(home[index].about, maxLines: 8, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400), overflow: TextOverflow.ellipsis),
                        SizedBox(height: 8),
                        if (index != home.length - 1) Divider(height: 1, color: Colors.grey),
                        if (index != home.length - 1) SizedBox(height: 8),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
