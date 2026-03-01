/// プロトコル相対URLを正規化してパース
///
/// `//example.com/img.jpg` → `https://example.com/img.jpg` に変換。
/// null・空文字列・不正なURLの場合は null を返す。
Uri? tryParseUri(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  return Uri.tryParse(raw.startsWith('//') ? 'https:$raw' : raw);
}
