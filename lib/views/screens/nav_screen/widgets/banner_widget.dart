import 'package:flutter/material.dart';
import 'package:mac_store_app/controllers/banner_controller.dart';
import 'package:mac_store_app/models/banner_model.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController pageController = PageController();
  // A Future the will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: FutureBuilder(
          future: futureBanners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('مشکلی در بارگزاری بنر رخ داد: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('بنری یافت نشد ):'),
              );
            } else {
              final banners = snapshot.data!;
              return AspectRatio(
                aspectRatio: 2,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final banner = banners[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: ImageLoadingService(
                            imageBorderRadius: BorderRadius.circular(12),
                            imageUrl: banner.image,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 145,
                      right: 145,
                      bottom: 0,
                      child: Container(
                        width: 101,
                        height: 13,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: banners.length,
                            axisDirection: Axis.horizontal,
                            effect: const ExpandingDotsEffect(
                              paintStyle: PaintingStyle.fill,
                              dotColor: Color(0xffB6D6FD),
                              activeDotColor: Color(0xff4475B2),
                              spacing: 3.0,
                              dotHeight: 4,
                              radius: 4,
                              dotWidth: 8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      
      ),
    );
  }
}
