E-Cell 3 Model Repository
=========================

E-Cell 3 のモデルファイルおよびユーティリティのコレクションです。


Contents 内容
------------

### Kyoto_model

京都大学が開発した心筋細胞モデル

* Kuzumoto_2007



Usage 使い方
-----------

### Model File (EM file)

モデルファイルは、以下のように ecell3-em2eml を実行して 
EML ファイルに変換します。EML ファイルを ecell3-session、
ecell3-session-monitor で load してシミュレーションを
実行します。

    ecell3-em2eml foo.em


### Custom Process

カスタムProcessが含まれる場合、それぞれのモデルのディレクトリ
で `make` を実行すると、同じディレクトリに、Processの
共有オブジェクト（.so）ファイルが生成されます。

    make

