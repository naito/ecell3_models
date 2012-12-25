CrossFireProcess
================

* 任意のVariable（target）のValueが、任意の閾値（threshold）を上回った（または下回った）際に、任意のVariable（flag）のValueを 1.0 に設定する任意の時間遅れのValueを、任意のVaiableに書き込む。flag の Value は、数値計算の１ラウンドが経過すると 0.0 に書き換えられる（フラグが立つのは１ラウンド間だけ）。
* 任意の時間（delay）、フラグが立つタイミングを遅延することができる。

Contents 内容
-------------

* CrossFireProcess.cpp：Processのソースコード
* CrossFireProcess_Test.em：動作テスト用のサンプルモデル

Usage 使い方
------------

ecell3-dmcでコンパイルする。CrossFireProcess.soが生成される。

    ecell3-dmc CrossFireProcess.cpp

テスト用モデルを使用する際は、CrossFireProcess.soのあるディレクトリにECELL3_DM_PATHを通しておく。

    ecell3-em2eml CrossFireProcess_Test.em
    ECELL3_DM_PATH=. ecell3-session -f CrossFireProcess_Test.eml

Specification 仕様
------------------

### CrossFireProcess

* VariableReferenceList
  * target: 観察対象のVariable
  * flag: フラグとして利用するVariable
* threshold: 閾値。target.Valueとthresholdを比較してフラグの判定を行う
* isFromBelow: 整数で1か0に設定する。1の場合、target.Valueが増加しながら閾値を超えたとき、flag.Valueが1となる。0の場合、target.Valueが減少しながら閾値を下回ったとき、flag.Valueが1となる。
* delay: 閾値を上（下）回ってからflag.Valueが1に書き換えられる（フラグが立つ）までの時間。0.0とすれば、閾値を上（下）回るのと同時にフラグが立つ。

### CrossFireProcess_Test 

* Variable:/:t 現在時刻
* Process:/:clock 時計。時間経過とともにtを増加させる。
* Variable:/:x フラグ判定の基準として用いる変数。
* Process:/:dxdt xにsinカーブを描かせる（周期2π）
* Variable:/:flag フラグ。0か1の値をとる
* Process:/:checker xの値が0.5（threshold）を超えたら（isFromBelow）、その0.1秒後（delay）に、１ラウンド間だけ、flagを1.0に書き換える
* Variable:/:y フラグの影響を受ける変数
* Process:/:dydt yを単調増加させる
* Process:/:devide_y flag が1の時（１ラウンド）だけ「target.Value * 500.0」の速度でyを減少させる。このモデルではStepIntervalが0.001秒に設定されているので、「target.Value * 500.0」の速度で0.001秒間 y が減少することになる。即ち、y は１ラウンドで半減する。ひとつの Variable に ExpressionFluxProcess と ExpressionAssignmentProcess でアクセスすると、どちらか片方の結果しか反映されないため、ExpressionFluxProcessで無理矢理「半減」を実現している。


