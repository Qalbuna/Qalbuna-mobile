import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class AnalysisLoadingWidget extends StatefulWidget {
  final double size;
  
  const AnalysisLoadingWidget({
    super.key, 
    this.size = 100,
  });

  @override
  State<AnalysisLoadingWidget> createState() => _AnalysisLoadingWidgetState();
}

class _AnalysisLoadingWidgetState extends State<AnalysisLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CirclesPainter(_animation.value),
            size: Size(widget.size, widget.size),
          );
        },
      ),
    );
  }
}

class CirclesPainter extends CustomPainter {
  final double animationValue;
  
  CirclesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    
    final circles = <Map<String, double>>[
      {'opacity': 0.2, 'size': 0.3},
      {'opacity': 0.4, 'size': 0.5}, 
      {'opacity': 0.6, 'size': 0.7},
      {'opacity': 0.8, 'size': 0.9},
    ];
    
    for (int i = 0; i < circles.length; i++) {
      final circle = circles[i];
      final baseOpacity = circle['opacity']!;
      final baseSize = circle['size']!;
      
      final animatedOpacity = baseOpacity * (0.3 + 0.7 * animationValue);
      final animatedSize = baseSize * (0.8 + 0.2 * animationValue);
      
      final paint = Paint()
        ..color = AppColors.v1Primary500.withValues(alpha: animatedOpacity)
        ..style = PaintingStyle.fill;
      
      final radius = maxRadius * animatedSize;
      canvas.drawCircle(center, radius, paint);
    }
    
    final centerPaint = Paint()
      ..color = AppColors.v1Primary500
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(center, maxRadius * 0.2, centerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}