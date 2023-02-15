# shared-vpc

## concept

- ひとつの host プロジェクトから特定のサービスプロジェクトに対して、 dev, stg, prd とそれぞれの環境の subnet を払い出す
- serverless vpc access connector 用の subnet をそれぞれ払い出す
- ルートディレクトリにある main.tf で host プロジェクト用の設定を入れる
  - host プロジェクトの作成
  - VPC 作成に必要な API (compute.googleapis.com) の有効化
- sample_service.tf で subnt 利用側のサービスプロジェクトの雛形を作る
  - dev, stg, prd 内の locals.tf をいじって、サブネットを払い出したりする
- 作業フローとしては
  1. 利用サービスが増えたら sample_service.tf をコピペして sample_service2.tf みたいにして、各種サービス用の設定をつくる
  2. sample_service2.tf を dev, stg, prd にシンボリックリンクして、 dev, stg, prd から使えるようにする
  3. `cd dev/` して、 dev 環境で問題ないか plan したり apply したりする (CI/CD するなら、ここを自動化してもいいかもですね)
  4. 問題なければ prd で `terraform apply`
  5. 環境引き渡して FIN

## appendix

- public repository に置く都合で variables 使ってますが、locals がんがん使って各々のプロジェクトに最適な形で運用してください
- 払い出した subnet 同士の通信を制御するためには別途 [FW ルール](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) を作成する必要があります
- Internal Load Balancer を使用する場合は、別途 [Proxy 専用サブネット](https://cloud.google.com/load-balancing/docs/l7-internal/proxy-only-subnets?hl=ja) を作成する必要があります
