import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// A widget for displaying text with clickable hyperlinks.
///
/// Hyperlinks should be in the format "(link_title)[link_address]". For example:
/// "Click here to visit (Google)[https://www.google.com]".
///
/// This widget uses regular expressions to identify hyperlinks in the text and
/// applies the [linkStyle] to them. The [textStyle] is applied to the rest of
/// the text.
///
/// When a hyperlink is tapped, it attempts to launch the provided URL using
/// the [url_launcher](https://pub.dev/packages/url_launcher) package. If the URL
/// is successfully launched, it opens the link in the default browser.
class HyperLink extends StatelessWidget {
  /// The text to display, including hyperlinks.
  final String text;

  /// The style of the non-link text.
  final TextStyle? textStyle;

  /// The style of the hyperlink text.
  final TextStyle? linkStyle;

  /// The launch mode for opening URLs.
  final LaunchMode mode;

  /// The configuration for web view.
  final WebViewConfiguration webViewConfiguration;

  /// The name of the web-only window.
  final String? webOnlyWindowName;

  /// Called when a pointer enters the link.
  final PointerEnterEventListener? linkOnEnter;

  /// Called when a pointer exits the link.
  final PointerExitEventListener? linkOnExit;

  /// The text alignment.
  final TextAlign textAlign;

  /// The text direction.
  final TextDirection? textDirection;

  /// Whether the text should break at soft line breaks.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The maximum number of lines for the text to span, wrapping if necessary.
  final int? maxLines;

  /// The locale for this text.
  final Locale? locale;

  /// The strut style to use.
  final StrutStyle? strutStyle;

  /// The width basis for the text layout.
  final TextWidthBasis textWidthBasis;

  /// The height behavior to use.
  final TextHeightBehavior? textHeightBehavior;

  /// The registrar for text selection.
  final SelectionRegistrar? selectionRegistrar;

  /// The color to use when highlighting the text for selection.
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
    RegExp linkRegex = RegExp(r'\[(.*?)\]\((.*?)\)');
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
      textWidthBasis: textWidthBasis,
      selectionColor: selectionColor,
      selectionRegistrar: selectionRegistrar,
      softWrap: softWrap,
      strutStyle: strutStyle,
      overflow: overflow,
    );
  }
}
