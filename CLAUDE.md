# kotonoha

`kotonoha` リポジトリのルート。現状はFlutter製モバイルアプリ `kotonoha-mobile/` 一式と、それをCI/CDでビルド・配信するための `codemagic.yaml` で構成。

## ディレクトリ構成

- `kotonoha-mobile/` — モバイルアプリ本体（Flutterワークスペース）。詳細は `kotonoha-mobile/CLAUDE.md`。
- `codemagic.yaml` — Codemagic CI/CD定義。

## CI/CD

`codemagic.yaml` のワークフロー `android-firebase-distribution` が `main` への push をトリガーに走り、以下を実行する:

1. 環境変数からkeystoreを復号して `kotonoha-mobile/app/android/key.properties` を生成
2. `flutter pub get` → `flutter analyze` → `flutter test` → `flutter build apk --release`
3. 成果物 (`app-release.apk`) を Firebase App Distribution の `testers` グループへ配信

### 必要な環境変数（Codemagic UI で Secret 登録、リポジトリには持ち込まない）

| 変数名 | 用途 |
|---|---|
| `CM_KEYSTORE` | base64エンコードした署名用 `.jks` |
| `CM_KEYSTORE_PASSWORD` | keystoreパスワード |
| `CM_KEY_PASSWORD` | エイリアスの鍵パスワード |
| `CM_KEY_ALIAS` | 鍵エイリアス名（`kotonoha`） |
| `FIREBASE_SERVICE_ACCOUNT` | サービスアカウントJSONの中身全体 |
| `FIREBASE_ANDROID_APP_ID` | Firebase App ID（`1:xxx:android:xxx`） |

### Firebase / Android 関連の事実（変えると配信が壊れる）

- Androidの applicationId / namespace は `io.github.tsumiki.kotonoha`。Firebase Console上のAndroidアプリ登録もこのIDで紐付いている。
- Firebase App Distributionの配信先テスターグループ名は `testers`。Firebase Console側で名前を変えたら `codemagic.yaml` の `groups:` も合わせる。
- 署名鍵（`.jks`）を紛失すると同じapplicationIdでアプリを更新できなくなる。Codemagic環境変数の `CM_KEYSTORE` が実質クラウドバックアップだが、別途手元にも控えを保管する。

## メモ

- iOSのCI/CDは未設定。将来追加するときは `codemagic.yaml` に `ios-firebase-distribution` などのワークフローを追記する。
