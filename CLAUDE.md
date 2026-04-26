# kotonoha

`kotonoha` リポジトリのルート。現状はFlutter製モバイルアプリ `kotonoha-mobile/` 一式と、それをCI/CDでビルド・配信するための `codemagic.yaml` で構成。

## ディレクトリ構成

- `kotonoha-mobile/` — モバイルアプリ本体（Flutterワークスペース）。詳細は `kotonoha-mobile/CLAUDE.md`。
- `codemagic.yaml` — Codemagic CI/CD定義。

## CI/CD

`codemagic.yaml` のワークフロー `android-firebase-distribution` が `main` への push をトリガーに走り、以下を実行する:

1. 環境変数からkeystoreを復号して `kotonoha-mobile/app/android/key.properties` を生成
2. `flutter pub get` → `flutter analyze` → `flutter test` → `flutter build apk --release`
3. `publishing.firebase` ブロックでAPKを Firebase App Distribution の `testers` グループへ配信

### 必要な環境変数（すべて Codemagic Application → Environment variables、Secret登録、リポジトリには持ち込まない）

| 変数名 | Variable group | 用途 |
|---|---|---|
| `CM_KEYSTORE` | （なし） | base64エンコードした署名用 `.jks` |
| `CM_KEYSTORE_PASSWORD` | （なし） | keystoreパスワード |
| `CM_KEY_PASSWORD` | （なし） | エイリアスの鍵パスワード |
| `CM_KEY_ALIAS` | （なし） | 鍵エイリアス名（`kotonoha`） |
| `FIREBASE_SERVICE_ACCOUNT` | `firebase_credentials` | サービスアカウントJSONの中身全体 |
| `FIREBASE_ANDROID_APP_ID` | `firebase_credentials` | Firebase App ID（`1:xxx:android:xxx`） |

Firebase関連2つを `firebase_credentials` グループに入れているのはCodemagicの仕様で、`publishing.firebase` ブロックの環境変数は **Variable group経由でしか渡せない**（スクリプト内なら `$VAR` で直接参照可能だが、`publishing:` 等の宣言的セクションは不可）。`codemagic.yaml` 側で `environment.groups: [firebase_credentials]` と参照している。keystore系は `scripts:` でしか使わないのでグループ不要。

### Firebase / Android 関連の事実（変えると配信が壊れる）

- Androidの applicationId / namespace は `io.github.tsumiki.kotonoha`。Firebase Console上のAndroidアプリ登録もこのIDで紐付いている。
- Firebase App Distributionの配信先テスターグループ名は `testers`。Firebase Console側で名前を変えたら `codemagic.yaml` の `groups:` も合わせる。
- 署名鍵（`.jks`）を紛失すると同じapplicationIdでアプリを更新できなくなる。Codemagic環境変数の `CM_KEYSTORE` が実質クラウドバックアップだが、別途手元にも控えを保管する。

## メモ

- iOSのCI/CDは未設定。将来追加するときは `codemagic.yaml` に `ios-firebase-distribution` などのワークフローを追記する。
