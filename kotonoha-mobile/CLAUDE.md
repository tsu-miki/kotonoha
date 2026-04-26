# kotonoha-mobile

Flutter製モバイルアプリ `kotonoha` のワークスペース。`app/` と `e2e/` の2つのFlutterプロジェクトで構成される。

## 構成

- `app/` — アプリ本体。Flutterプロジェクト（パッケージ名 `kotonoha_mobile`）。詳細は `app/CLAUDE.md` を参照。
- `e2e/` — `package:integration_test` を使ったE2Eテスト用Flutterプロジェクト。`kotonoha_mobile` を `path: ../app` 依存で参照する。詳細は `e2e/CLAUDE.md` を参照。

## どこで作業するか

- アプリの機能追加・修正 → `app/`
- E2E（integration）テストの追加 → `e2e/integration_test/`
- 依存ライブラリ追加 → 該当側の `pubspec.yaml`（共通依存はない、それぞれ独立して管理）

## メモ

- リポジトリ名（外側のディレクトリ）は `kotonoha`、ワークスペースは `kotonoha-mobile`、Flutterパッケージ名は `kotonoha_mobile`。混同しないこと。
- `app/` 側のpublic API（クラス名・シンボル）を変更すると `e2e/` のテストが壊れる。両方を見て更新する。
