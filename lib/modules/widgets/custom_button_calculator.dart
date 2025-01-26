part of './../../core/helpers/export_manager/export_manager.dart';

class CustomButtonCalculatorWidget extends StatelessWidget {
  const CustomButtonCalculatorWidget({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 50.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10).r,
        ),
        color: ColorManager.greenColor,
        onPressed: onPressed,
        child: Text(
          'CALCULATOR',
          textAlign: TextAlign.center,
          style: buildTextStyle(fontSize: 20, context: context),
        ),
      ),
    );
  }
}
