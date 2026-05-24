import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'chat_screen.dart';
import 'quiz_screen.dart';
import 'summary_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0B1020),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              Container(

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(

                  gradient: const LinearGradient(

                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFF6366F1),
                    ],
                  ),

                  borderRadius:
                  BorderRadius.circular(30),
                ),

                child: const Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      "AI Study Assistant",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Learn smarter with AI-powered tools",

                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )

                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2),

              const SizedBox(height: 35),

              const Text(

                "Features",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              featureCard(
                context,
                title: "Ask AI",
                subtitle: "Get explanations instantly",
                icon: Icons.smart_toy,
                gradient1: const Color(0xFF7C3AED),
                gradient2: const Color(0xFF5B21B6),

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const ChatScreen(),
                    ),
                  );
                },
              )

                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3),

              const SizedBox(height: 20),

              featureCard(
                context,
                title: "Quiz Generator",
                subtitle: "Generate MCQs using AI",
                icon: Icons.quiz,
                gradient1: const Color(0xFF2563EB),
                gradient2: const Color(0xFF1D4ED8),

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const QuizScreen(),
                    ),
                  );
                },
              )

                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3),


              const SizedBox(height: 20),

              featureCard(
                context,
                title: "Summarize Notes",
                subtitle:
                "Convert long notes into short summaries",

                icon: Icons.notes,

                gradient1:
                const Color(0xFF059669),

                gradient2:
                const Color(0xFF047857),

                onTap: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                      const SummaryScreen(),
                    ),
                  );
                },
              )

                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3),

            ],
          ),
        ),
      ),
    );
  }

  Widget featureCard(

      BuildContext context, {

        required String title,
        required String subtitle,
        required IconData icon,
        required Color gradient1,
        required Color gradient2,
        required VoidCallback onTap,
      }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(

          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
          ),

          borderRadius:
          BorderRadius.circular(28),

          boxShadow: [

            BoxShadow(
              color:
              gradient1.withValues(alpha: 0.4),

              blurRadius: 18,

              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Row(

          children: [

            Container(

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color:
                Colors.white.withValues(alpha: 0.15),

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Icon(
                icon,
                color: Colors.white,
                size: 34,
              ),
            ),

            const SizedBox(width: 20),

            Expanded(

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    title,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    subtitle,

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}