import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorTab extends StatelessWidget {
  const AuthorTab({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // صورة الكاتب
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1E3A8A),
                    Color(0xFF3B82F6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: ClipOval(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E293B),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/image/9999.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E293B),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 80,
                          color: Color(0xFF60A5FA),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // اسم الكاتب
            Text(
              'أحمد علي حمدان (رحمه الله تعالى)',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            // النبذة التعريفية
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1E293B),
                    const Color(0xFF1E293B).withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Text("""
                وُلِد في بلدة كفر كلبين ـ أعزاز، حلب، سوريا عام 1968، في عائلة بسيطة. أتمَّ دراسته الابتدائية والإعدادية في بلدته، وأكمل الثانوية في أعزاز، حيث تميّز بين أقرانه وحصل على المرتبة الثانية في دفعته

                حصل على شهادة الثانوية العامة (البكالوريا) في أعزاز عام 1986، ثم تابع دراسته في جامعة حلب، وحصل على الإجازة في العلوم الطبيعية عام 1990. بعد ذلك التحق بكلية الشريعة في جامعة دمشق، حيث نال الإجازة عام 2003، وعمل إمامًا وخطيبًا في الجامع الكبير في صوران أعزاز لمدة خمس سنوات، ثم واصل خدمة العلم إمامًا وخطيبًا في جامع آخر بنفس البلدة لخمسة أعوام إضافية

            حصل لاحقًا على درجة الماجستير في الحديث الشريف من جامعة دمشق عام 2010، ودَرّس مادة العلوم (علم الأحياء) في ثانوية صوران لمدة تزيد عن خمس وعشريه.ن عاما، كما عمل في الثانوية الشرعية بأعزاز كمعلم ومربي، مقتديًا بالنبي محمد صلى الله عليه وسلم قولًا وفعلًا

      كان رحمة الله عليه محبًا للعلم والأدب، مولعًا بالعلوم كعلم النفس والخط والرياضة والعلوم عامةً، وكان دائمًا يحث طلابه ومحبّيه على السعي وراء المعرفة وطلب العلم. عُرِف بحبه الشديد للقراءة، وكانت له همة عالية يضرب بها المثل، ولم يكن يضيع وقتًا دون عمل مفيد

      قضى حياته في ميادين العلم والتعليم، وكان آخر عهده في الدنيا تحضيره لنيل الدكتوراه في علوم الحديث الشريف، ولكن لقاء الله كان أحب وأقرب إليه. وقد كان لي شرف تصميم معظم أغلفة كتبه ومساعدته فيها، وعهد لي ولولدي سعد (أبو إسحاق كما سماه رحمه الله) بمكتبته بعد وفاته، لتكون وقفاً وذخراً للمسلمين وطلاب العلم إن شاء الله

      نسأل الله عز وجل أن يرحمه رحمة واسعة، ويجزيه عن العلم الذي نشره خير الجزاء، ويجعلنا خير خلف لخير سلف

      والحمد لله رب العالمين

    كتبه: محمد أحمد حمدان
                  """
                    ,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            // أزرار التواصل
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A),
                          Color(0xFF3B82F6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl('mailto:author@example.com');
                      },
                      icon: const Icon(Icons.email),
                      label: const Text('eng.MohamadAhmadHamdan@gamil.com'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A),
                          Color(0xFF3B82F6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl('https://wa.me/+963967770101');
                      },
                      icon: const Icon(Icons.chat),
                      label: const Text('+963967770101'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF1E3A8A),
                          Color(0xFF3B82F6),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

