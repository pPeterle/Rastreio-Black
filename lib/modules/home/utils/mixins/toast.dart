import 'package:bot_toast/bot_toast.dart';

mixin ToastNotification {
  showText(String text) {
    BotToast.showText(text: text);
  }
}
