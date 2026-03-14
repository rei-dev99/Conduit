# Conduit
アプレンティス課題「Conduit」を実装しています。
ステップ1〜ステップ4まで実装完了しています。

## 使用技術
- Ruby 4.0.1
- Ruby on Rails 8
- Bootstrap
- ERB
- Kaminari（ページネーション）
- bcrypt（パスワードハッシュ化）

## ページ
- Authentication
  - Sign In(sessions/new.html.erb)
  - Sign Up(users/new.html.erb)
- Articles
  - Home(articles/index.html.erb)
  - Create(articles/new.html.erb)
  - Edit(articles/edit.html.erb)
  - Article(articles/show.html.erb)

## 機能

### CSSについて
- Bootstrap、RealWorldより適応。
- main.cssの読み込みで、403エラーが発生でスタイルが適応されないため、ローカルファイルにファイル作成して読み込みしてます。(app/assets/stylesheets/counduit.scss等)
- 不要な箇所は削除し、必要なところは手動で追加
- レスポンシブ未対応

### 要件
- routes.rb にルーティングを設定し、必要なページにアクセス
- Authenticationは、 Sign In と Sign Up の HTML を ERB ファイルとして作成
- Authentication (Sign In) 画面でメールアドレスとパスワードを入力し、「Sign In」を押すとログイン処理が実行される
- Authentication (Sign Up) 画面でメールアドレスとパスワードを入力し、「Sign Up」を押すとユーザー登録処理が実行される
- ログイン処理またはユーザー登録処理が成功した場合、Home 画面に遷移する
- Articleは、Home、Create、Edit、Article の HTML が ERB ファイルとして作成
- Home 画面と Article 画面に、ログイン情報に基づいて著者名が表示される
- Article 画面では、認証情報に基づき、著者のみ「Edit Article」ボタンが表示され、著者だけが記事を編集できる
- Article 画面では、認証情報に基づき、著者のみ「Delete Article」ボタンが表示され、著者だけが記事を削除できる
- Home 画面に表示される記事の数を最大 5 件とし、ページネーションを実装して次の 5 件にアクセスできるようにする
- Home 画面の記事一覧の下に「Create」ボタンを配置し、ボタンを押すと Create 画面に遷移する
- Create 画面で「Publish Article」を押すと、入力した内容がデータベースに保存され、Home 画面のリストに表示される
- Home 画面の記事をクリックすると、該当の記事の Article 画面に遷移する
- Article 画面で「Edit Article」ボタンを押すと Edit 画面に遷移し、各項目には記事の内容が入力済みで表示される
- Edit 画面で内容を変更して「Publish Article」を押すと、データベースが更新され、Home 画面でも更新後の内容が表示される
- 「Delete Article」ボタンを押すと記事がデータベースから削除され、Home 画面のリストからも削除される

## データベース設計

### users

| column | type |
|------|------|
| id | integer |
| email | string |
| password_digest | string |
| created_at | datetime |
| updated_at | datetime |

### articles

| column | type |
|------|------|
| id | integer |
| title | string |
| about | string |
| body | text |
| user_id | integer |
| created_at | datetime |
| updated_at | datetime |

### tags

| column | type |
|------|------|
| id | integer |
| name | string |
| created_at | datetime |
| updated_at | datetime |

### taggings

| column | type |
|------|------|
| id | integer |
| article_id | integer |
| tag_id | integer |
| created_at | datetime |
| updated_at | datetime |

### 関連

- User has_many :articles
- Article belongs_to :user

- Article has_many :taggings
- Article has_many :tags, through: :taggings

- Tag has_many :taggings
- Tag has_many :articles, through: :taggings

## 認証機能

Rails の `has_secure_password` を利用して認証機能を実装しています。

- bcrypt によりパスワードをハッシュ化
- セッションを利用してログイン状態を管理
- 未ログインユーザーは記事作成・編集にアクセスできないよう制御
- ログイン済みユーザーは Sign In / Sign Up ページへアクセスできないよう制御

## 参考

- タグ

https://qiita.com/kengo_7s/items/90338682c3912e13b1ef
  
- サインイン・サインアップ機能

https://qiita.com/d0ne1s/items/7c4d2be3f53e34a9dec7
