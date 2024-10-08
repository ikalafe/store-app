import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mac_store_app/controllers/banner_controller.dart';
import 'package:mac_store_app/models/banner_model.dart';
import 'package:mac_store_app/provider/banner_provider.dart';
import 'package:mac_store_app/views/screens/nav_screen/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    _fetchBanners();
  }

  Future<void> _fetchBanners() async {
    final BannerController bannerController = BannerController();
    try {
      final banners = await bannerController.loadBanners();
      ref.read(bannerProvider.notifier).setBanners(banners);
    } catch (e) {
      print('Error fetch banners: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final banners = ref.watch(bannerProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AspectRatio(
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
        ),
      ),
    );
  }
}
