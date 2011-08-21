E-Cell 3 Model Repository
=========================

E-Cell 3 のモデルファイルおよびユーティリティのコレクションです。


Contents 内容
------------

### Kyoto_model

京都大学が開発した心筋細胞モデル

* kuzumoto_2007: Kuzumoto M et al. Prog Biophys Mol Biol. 2008;96(1-3):171-86. PMID: [17826821].

### liver

肝臓モデル

* chalhoub_2007: Chalhoub E et al. Am J Physiol Endocrinol Metab. 2007;293(6):E1676-86. PMID: [17911349]. 灌流肝臓の糖新生
* ohno_2008: Ohno H et al. Artif Life. 2008;14(1):3-28. PMID: [18171128]. アンモニア代謝の metabolic zonation

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


[17826821]: http://www.ncbi.nlm.nih.gov/pubmed/17826821
[17911349]: http://www.ncbi.nlm.nih.gov/pubmed/17911349
[18171128]: http://www.ncbi.nlm.nih.gov/pubmed/18171128
