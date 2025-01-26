part of './../core/helpers/export_manager/export_manager.dart';

class BMIResultScreen extends StatefulWidget {
  final double bmiValue;
  final bool isMale;
  final int age;
  final String bmiCategory;
  final String bmiInterpretation;
  final Color bmiCategoryColor;
  const BMIResultScreen({
    super.key,
    required this.bmiValue,
    required this.isMale,
    required this.age,
    required this.bmiCategory,
    required this.bmiCategoryColor,
    required this.bmiInterpretation,
  });

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> {
  bool isAdLoaded = false;
  @override
  void initState() {
    super.initState();
    AdManager.loadAdBanner((updateState) {
      updateState(() {
        isAdLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'BMI Result',
          style: buildTextStyle(fontSize: 20, context: context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    Spacer(),
                    // Radial Gauge for BMI Value
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 10,
                          maximum: 40,
                          axisLabelStyle: GaugeTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: const Color(0x1E00A9B5),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          ranges: gaugeRange,
                          pointers: gaugePointer,
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                              widget: Text(
                                widget.bmiValue.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              angle: 90,
                              positionFactor: 0.7,
                            )
                          ],
                        ),
                      ],
                    ),

                    CustomText(
                      title: widget.bmiCategory,
                      color: widget.bmiCategoryColor,
                      fontSize: 25,
                    ),
                    CustomText(
                      title: widget.bmiInterpretation,
                      color: ColorManager.whiteColor,
                      fontSize: 14,
                    ),
                    Spacer(),
                    CustomText(
                      title: 'Version: $appVersion',
                      color: ColorManager.whiteColor,
                      fontSize: 14,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isAdLoaded && AdManager.bannerAd != null,
              child: SizedBox(
                height: AdManager.bannerAd!.size.height.toDouble(),
                width: AdManager.bannerAd!.size.width.toDouble(),
                child: AdWidget(ad: AdManager.bannerAd!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GaugePointer> get gaugePointer {
    return <GaugePointer>[
      NeedlePointer(
        value: widget.bmiValue,
        needleColor: Colors.blueAccent,
        needleLength: 0.8,
        needleStartWidth: 1,
        needleEndWidth: 4,
      )
    ];
  }

  List<GaugeRange> get gaugeRange {
    return <GaugeRange>[
      GaugeRange(
        startValue: 10,
        endValue: 18.5,
        color: ColorManager.blueColor,
        startWidth: 20,
        endWidth: 20,
      ),
      GaugeRange(
        startValue: 18.6,
        endValue: 24.9,
        color: ColorManager.greenColor,
        startWidth: 20,
        endWidth: 20,
      ),
      GaugeRange(
        startValue: 25,
        endValue: 29.9,
        color: ColorManager.orangeColor,
        startWidth: 20,
        endWidth: 20,
      ),
      GaugeRange(
        startValue: 30,
        endValue: 40,
        color: ColorManager.redColor,
        startWidth: 20,
        endWidth: 20,
      ),
    ];
  }

  @override
  void dispose() {
    AdManager.disposeAdBanner();
    super.dispose();
  }
}
