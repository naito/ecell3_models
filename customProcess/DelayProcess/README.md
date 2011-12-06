Delay Process
=============

* 時間遅れを表現するProcess。任意のFullPNの、任意の時間遅れの値を、任意のVaiableに書き込む。

* 現在のバージョンは、テストモデルでしか動きません。

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

## DelayProcess

