import 'package:flutter/material.dart';

class MonitoramentoView extends StatelessWidget {
  const MonitoramentoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(painter: DonutChartPainter()),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Tempo gasto no celular = 12 Horas/dia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Text(
              'Tempo em outros Apps',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildAppUsageItem(Colors.blueAccent, 'TikTok', '37%'),
            _buildAppUsageItem(Colors.tealAccent, 'Whatsapp', '19%'),
            _buildAppUsageItem(Colors.red, 'Instagram', '13%'),
            _buildAppUsageItem(Colors.blue, 'Youtube', '13%'),
            _buildAppUsageItem(Colors.grey, 'Outros', '18%'),
          ],
        ),
      ),
    );
  }

  Widget _buildAppUsageItem(
    Color color,
    String appName,
    String percentage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              appName,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Text(
            percentage,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 50.0;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Simulação das fatias do gráfico (apenas visual)
    final sections = [
      {'color': Colors.tealAccent, 'sweepAngle': 1.6 * 3.14159}, // Grande
      {'color': Colors.red, 'sweepAngle': 0.8 * 3.14159},
      {'color': Colors.blue, 'sweepAngle': 0.8 * 3.14159},
      {'color': Colors.lightGreen, 'sweepAngle': 0.4 * 3.14159},
      {'color': Colors.grey, 'sweepAngle': 0.4 * 3.14159},
      {'color': Colors.blueAccent, 'sweepAngle': 0.2 * 3.14159}, // Pequeno
    ];

    double startAngle = -3.14159 / 2; // Começa de cima

    for (var section in sections) {
      paint.color = section['color'] as Color;
      final sweepAngle = section['sweepAngle'] as double;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
