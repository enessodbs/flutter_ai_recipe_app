import 'package:flutter_recipe_app/pages/auth/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_recipe_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Test için 'seenOnboarding' değerini belirleyin
    final seenOnboarding = false; // Bu değeri istediğiniz gibi ayarlayabilirsiniz.

    // MyApp widget'ını 'seenOnboarding' parametresi ile başlatın
    await tester.pumpWidget(MyApp(seenOnboarding: seenOnboarding));

    // Burada, app'ın doğru şekilde yüklendiğini doğrulamak için testler yapabilirsiniz.
    // Örneğin, login ekranının görünüp görünmediğini test edebilirsiniz.
    expect(find.byType(LoginPage), findsOneWidget);

    // Eğer onboarding ekranını test etmek isterseniz:
    // expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
