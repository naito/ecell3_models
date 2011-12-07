Delay Process
=============

* 時間遅れを表現するProcess。任意のVariableの、任意の時間遅れのValueを、任意のVaiableに書き込む。
* Processが初期化される際に、記録対象のVariableのLoggerを自動的に作成し、Loggerに記録された過去の値を参照する仕様。
* ProcessからLoggerを操作するサンプルにもなっている。

Contents 内容
-------------

* DelayProcess.cpp：Processのソースコード
* DelayProcess_Test.em：動作テスト用のサンプルモデル

Usage 使い方
------------

ecell3-dmcでコンパイルする。DelayProcess.soが生成される。

    ecell3-dmc DelayProcess.cpp

テスト用モデルを使用する際は、DelayProcess.soのあるディレクトリにECELL3_DM_PATHを通しておく。

    ecell3-em2eml DelayProcess_Test.em
    ECELL3_DM_PATH=. ecell3-session -f DelayProcess_Test.eml

Specification 仕様
------------------

### DelayProcess

Problem 問題点
------------------

* シミュレーションの経過とともにLoggerのデータが大きくなるため、読み出し時間が増大し、徐々にシミュレーションの進行が遅くなるかもしれない
* 将来的には、Process内に、時間遅れ分だけのデータを保持するarrayを持たせる仕様に変更した方が効率的だろう。