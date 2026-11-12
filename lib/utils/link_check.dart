/// Offline, heuristic checks for links scanned from QR codes.
///
/// This does not contact any service and cannot tell whether a site is
/// actually malicious. It only flags common traits of phishing / disguised
/// links so the user can think twice before opening them (see issue #6).
class LinkCheck {
  static const Set<String> _shorteners = {
    'bit.ly',
    'buff.ly',
    'cutt.ly',
    'goo.gl',
    'is.gd',
    'ow.ly',
    'rebrand.ly',
    'shorturl.at',
    't.co',
    't.ly',
    'tiny.cc',
    'tinyurl.com',
    'rb.gy',
    'v.gd',
  };

  static final RegExp _ipv4 = RegExp(r'^\d{1,3}(\.\d{1,3}){3}$');

  /// Returns human readable reasons why [uri] looks risky, or an empty list.
  static List<String> warnings(Uri uri) {
    final reasons = <String>[];
    final host = uri.host.toLowerCase();

    if (uri.scheme == 'http') {
      reasons.add('The connection is not encrypted (http).');
    }
    if (uri.userInfo.isNotEmpty) {
      reasons.add(
        'The link contains text before "@", which can disguise the real site.',
      );
    }
    if (_ipv4.hasMatch(host) || host.contains(':')) {
      reasons.add('The link points to a raw IP address instead of a domain.');
    }
    if (host.split('.').any((label) => label.startsWith('xn--')) ||
        host.contains('%') ||
        host.runes.any((r) => r > 0x7f)) {
      reasons.add(
        'The domain uses international characters that can imitate '
        'another site.',
      );
    }
    if (_shorteners.contains(host) ||
        _shorteners.any((s) => host.endsWith('.$s'))) {
      reasons.add('The link is shortened, so the destination is hidden.');
    }
    if (uri.hasPort && uri.port != 80 && uri.port != 443) {
      reasons.add('The link uses an unusual port (${uri.port}).');
    }
    return reasons;
  }
}
