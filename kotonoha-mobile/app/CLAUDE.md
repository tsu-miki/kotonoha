# kotonoha_mobile

Flutter製のモバイルアプリ。現状は最小構成（`kotonoha` というタイトルを中央に表示するだけ）。

## よく使うコマンド

```bash
# 依存パッケージ取得
flutter pub get

# 静的解析（lint / 型チェック）
flutter analyze

# テスト実行
flutter test

# 単一テストを実行
flutter test test/widget_test.dart

# ホットリロード付きで起動（接続デバイスを自動選択）
flutter run

# デバイス指定で起動
flutter devices              # デバイスID一覧
flutter run -d <device-id>

# Flutter / Dartの環境確認
flutter doctor -v
```

## ディレクトリ構成

- `lib/` — アプリ本体のDartソース。エントリポイントは `lib/main.dart`。
- `test/` — `flutter_test` を使ったウィジェット/ユニットテスト。
- `android/`, `ios/`, `macos/`, `linux/`, `windows/`, `web/` — 各プラットフォームの生成済みネイティブプロジェクト。原則として手で触らない（プラグイン追加や権限変更時のみ編集）。
- `pubspec.yaml` — 依存関係・アセット・フォント設定。
- `analysis_options.yaml` — `package:flutter_lints/flutter.yaml` をベースにしたlint設定。

## コーディング規約

- lintは `flutter_lints` のデフォルトに従う。違反が出たら原則ルールを満たす形で修正する（`// ignore:` での抑制は最小限）。
- 公開API・ウィジェット名は `UpperCamelCase`、それ以外は `lowerCamelCase`。
- 不要なコメント（生成テンプレートの `// TRY THIS:` など）は実装変更と同時に削除する。
- 文字列はシングルクォートを基本とする（lintのデフォルトに合わせる）。

## 変更時のチェックリスト

コードに手を入れたら、コミット前に以下を順に通す：

1. `flutter analyze` — 警告・エラー無し
2. `flutter test` — 全テストpass
3. UI変更がある場合は `flutter run` で実機/シミュレータで目視確認

## メモ

- アプリ名・パッケージ名は `kotonoha_mobile`（pubspec.yaml）。
- バージョンは `pubspec.yaml` の `version:` で管理（`1.0.0+1` 形式 = `<semver>+<buildNumber>`）。
