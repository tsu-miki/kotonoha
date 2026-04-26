# e2e

`kotonoha_mobile`（`../app/`）に対する end-to-end（integration）テスト用のFlutterプロジェクト。

## 構成

- `integration_test/` — `package:integration_test` を使ったテストファイル群。これがこのプロジェクトの主役。
- `lib/main.dart` — `kotonoha_mobile` の `KotonohaApp` を起動するだけのエントリポイント。integration_test を実機/シミュレータにデプロイするためのホストアプリとして必要。**ビジネスロジックは置かない**。
- `pubspec.yaml` — `kotonoha_mobile` を `path: ../app` で参照。`integration_test`（Flutter SDK同梱）を dev_dependency として持つ。
- `android/`, `ios/` — `flutter create` 生成物。デバイスへのデプロイに必要。原則手で触らない。

## よく使うコマンド

```bash
# 依存パッケージ取得
flutter pub get

# 静的解析
flutter analyze

# 接続中のデバイス確認
flutter devices

# 単一E2Eテストを実行（要：接続中のデバイス/シミュレータ）
flutter test integration_test/title_test.dart

# integration_test 配下を全実行
flutter test integration_test/
```

## テストの書き方

- ファイルは `integration_test/<feature>_test.dart` の規則で配置。
- 各テストファイルの先頭で `IntegrationTestWidgetsFlutterBinding.ensureInitialized();` を呼ぶ。
- アプリ側のWidgetは `package:kotonoha_mobile/...` から import する。

## メモ

- `app/` 側の公開API（`KotonohaApp` などのクラス名・export パス）が変わるとここのテストが壊れる。一緒に更新する。
- `flutter test integration_test/` はデバイスがないと失敗するので、CIでE2Eを回す場合は別途エミュレータの起動が必要。
