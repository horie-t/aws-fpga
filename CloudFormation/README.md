# EC2環境構築用のCloudFormation

[AWS EC2 F1インスタンスを使ってみる](https://horie-t.github.io/memo/aws-f1/index.html)にある環境を構築するためのCloudFormationです。AWS FPGA HDKのGitリポジトリのcloneまでを実行します。

**使い方**

本ディレクトリで以下のコマンドを実行します。キーペア名は、お持ちのキーペアの名前を指定してください。

```
aws cloudformation create-stack --stack-name F1Dev --template-body file://`pwd`/cloud_formation.yaml --parameters ParameterKey=KeyPairParameter,ParameterValue=キーペア名
```
