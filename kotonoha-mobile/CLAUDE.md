# kotonoha-mobile

Flutter製モバイルアプリ `kotonoha` のワークスペース。`app/` と `e2e/` の2つのFlutterプロジェクトで構成される。

## 構成

- `app/` — アプリ本体。Flutterプロジェクト（パッケージ名 `kotonoha_mobile`）。詳細は `app/CLAUDE.md` を参照。
- `e2e/` — `package:integration_test` を使ったE2Eテスト用Flutterプロジェクト。`kotonoha_mobile` を `path: ../app` 依存で参照する。詳細は `e2e/CLAUDE.md` を参照。

## どこで作業するか

- アプリの機能追加・修正 → `app/`
- E2E（integration）テストの追加 → `e2e/integration_test/`
- 依存ライブラリ追加 → 該当側の `pubspec.yaml`（共通依存はない、それぞれ独立して管理）

## テスト記述ルール（BDD・日本語）

`app/test/`（widget / unit テスト）と `e2e/integration_test/`（E2Eテスト）のテストケースは **BDDスタイルかつ日本語** で書く。

- 対象クラス・画面・機能などのコンテキストは `group(...)` でまとめる。例: `group('KotonohaApp', () { ... })`、`group('ホーム画面', () { ... })`。`group` は必要に応じてネストしてよい。
- ケース名（`testWidgets` / `test` の第1引数）は「〜すると、〜される / 〜できる」のような自然な日本語で記述する。`should ...` のような英語形式は使わない。
- ケース内は **Given / When / Then** を意識し、節の境目に短いコメント（`// Given:`, `// When:`, `// Then:`）を入れる。装飾過剰にならない範囲で。
- アサーションのreasonメッセージ（`expect(..., reason: ...)`）も日本語で書く。
- 実装の詳細ではなく、ユーザー/呼び出し側から見た**振る舞い**を記述する。

例:

```dart
group('KotonohaApp', () {
  testWidgets('起動するとタイトル「kotonoha」が画面に表示される', (tester) async {
    // Given: ルートウィジェットをポンプする
    await tester.pumpWidget(const KotonohaApp());

    // Then: タイトル「kotonoha」が1件表示されている
    expect(find.text('kotonoha'), findsOneWidget);
  });
});
```

## CI/CD

リポジトリ直下の `../codemagic.yaml` でCodemagicのビルドが定義されている。`main` への push をトリガーに `app/` の Android APK をビルドし、Firebase App Distribution の `testers` グループに配信する。詳細は `../CLAUDE.md` を参照。

## メモ

- リポジトリ名（外側のディレクトリ）は `kotonoha`、ワークスペースは `kotonoha-mobile`、Flutterパッケージ名は `kotonoha_mobile`、AndroidのapplicationIdは `io.github.tsumiki.kotonoha`。それぞれ別物なので混同しないこと。
- `app/` 側のpublic API（クラス名・シンボル）を変更すると `e2e/` のテストが壊れる。両方を見て更新する。
