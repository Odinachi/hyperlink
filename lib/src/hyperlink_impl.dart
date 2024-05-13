import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HyperLink extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;
  final LaunchMode mode;
  final WebViewConfiguration webViewConfiguration;
  final String? webOnlyWindowName;
  final PointerEnterEventListener? linkOnEnter;
  final PointerExitEventListener? linkOnExit;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final SelectionRegistrar? selectionRegistrar;
  final Color? selectionColor;

  const HyperLink(
      {super.key,
      required this.text,
      this.linkStyle,
      this.textStyle,
      this.mode = LaunchMode.platformDefault,
      this.webViewConfiguration = const WebViewConfiguration(),
      this.webOnlyWindowName,
      this.linkOnEnter,
      this.linkOnExit,
      this.textAlign = TextAlign.start,
      this.textDirection,
      this.softWrap = true,
      this.overflow = TextOverflow.clip,
      this.textScaleFactor = 1.0,
      this.maxLines,
      this.locale,
      this.strutStyle,
      this.textWidthBasis = TextWidthBasis.parent,
      this.textHeightBehavior,
      this.selectionRegistrar,
      this.selectionColor});

  @override
  Widget build(BuildContext context) {
    // Regular expression to find "(link_title)[link_address]"
    RegExp linkRegex = RegExp(r'\((.*?)\)\[(.*?)\]');
    List<InlineSpan> children = [];

    int currentIndex = 0;
    linkRegex.allMatches(text).forEach((match) {
      // Add non-link text
      children.add(TextSpan(
        text: text.substring(currentIndex, match.start),
        style: textStyle,
      ));
      // Add link text
      children.add(TextSpan(
        text: match.group(1),
        // link_title
        style: linkStyle,
        onEnter: linkOnEnter,
        onExit: linkOnExit,
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final url = Uri.parse(match.group(2) ?? "");
            if (await canLaunchUrl(url)) {
              await launchUrl(
                url,
                mode: mode,
                webViewConfiguration: webViewConfiguration,
                webOnlyWindowName: webOnlyWindowName,
              );
            }
          },
      ));
      currentIndex = match.end;
    });

    // Add remaining non-link text
    if (currentIndex < text.length) {
      children.add(TextSpan(
        text: text.substring(currentIndex),
        style: textStyle,
      ));
    }

    return RichText(
      text: TextSpan(children: children),
      locale: locale,
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      selectionRegistrar: selectionRegistrar,
      softWrap: softWrap,
      strutStyle: strutStyle,
      overflow: overflow,
    );
  }
}
