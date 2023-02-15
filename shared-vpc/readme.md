# shared-vpc を作成する terraform のサンプルコード

## コンセプト

- ひとつの host プロジェクトから特定のサービスプロジェクトに対して、 dev, stg, prd とそれぞれの環境の subnet を払い出す
- Internal LB 用の subnet をそれぞれ払い出す
- serverless vpc access 用の subnet をそれぞれ払い出す
- ルートディレクトリにある main.tf で host プロジェクト用の設定を入れる
  - host プロジェクトの作成
  - VPC 作成に必要な API (compute.googleapis.com) の有効化
