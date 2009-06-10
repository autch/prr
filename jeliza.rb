#                  *************Attention************
#お客様は、このマクロサンプルプログラムを現状のままで、もしくは改変した
#プログラムを第三者に配布することができます。                          
#
#ただし、このプログラムは株式会社ジャストシステムが作成したのものであり、
#このプログラムの著作権は、株式会社ジャストシステムに帰属します。
#従いまして、以下の条件に同意、遵守していただいた上でご利用下さいますよ
#うお願いいたします。
#
#①このプログラム及びお客様が改変したプログラムを配布する場合は、無償に
#て行って下さい。
#
#②お客様が改変したプログラムは、お客様と株式会社ジャストシステムの共同
#の著作物となります。従って、改変したプログラムには、以下の表示を改変し
#たプログラムの冒頭に行って下さい。
#「このプログラムは、株式会社ジャストシステムから提供されたプログラムを
#利用して作成したものです。」
#
#③このプログラム及びお客様が改変したプログラムに関するお問い合わせには、
#弊社は一切お答えいたしません。
#
#④弊社は、このプログラムがお客様の使用目的に適合することの保証は行いま
#せん。このプログラムの使用結果につきましては、お客様の責任とさせていた
#だきます。
#
#**********************************************************************
#　（Ｃ）　1993　株式会社ジャストシステム 
#**********************************************************************

######################################################
# マクロ名（会話）                                   #
# 見出し（一太郎と会話を）                           #
# ファイル名（JELIZA.TXT）                           #
#                                                    #
#      Ｊ・ＥＬＩＺＡ   1993/03/08  by Gian Luca     #
#                                                    #
#  ○はじめに                                        #
#    人工無能、ＥＬＩＺＡのタイプの会話プログラムで  #
#  す。Ｊ には人工無能と日本語とジャストシステムの   #
#  ３つの意味が入っています。単なるおもちゃなので、  #
#  ペットのように暇なときに相手をしてあげて下さい。  #
#  注意事項としては、次の３つです。                  #
#    1.日光が嫌い                                    #
#    2.水が嫌い                                      #
#    3.夜の１２時以降はエサを与えない                #
#  以上です。                                        #
#                                                    #
#  ○使い方                                          #
#    実際に実行すると、最初にタイトルが出ます。そし  #
#  て、知識ファイル名を聞いてきます。（ファイルが存  #
#  在しなくても構いません）続いて、学習 ON,OFF を決  #
#  めると会話がスタートします。会話を終了するには、  #
#  「ばいばい」、「バイバイ」、「さよなら」のどれか  #
#  または、「＠最後の挨拶」で設定した文を入力すれば  #
#  終わります。（ＥＳＣでも終わります。）            #
#                                                    #
#  ○知識ファイルについて                            #
#    最初に、知識ファイルを読み込んで、知識ベースを  #
#  作成します。このファイルは、テキスト形式なので、  #
#  エディタなどで編集可能です。最初に学習を ON にす  #
#  ると、会話学習結果を知識ファイルに書き出します。  #
#    知識ベースは、キーワードとそれに対する複数個の  #
#  応答として記録されています。また、会話に人格を持  #
#  たせるために予約キーワードがあります。予約キーワ  #
#  ード名は固定ですが、その応答は編集可能です。      #
#                                                    #
#  ○知識ファイルの書式                              #
#  「キーワード」    行先頭から始まる                #
#  「応答」          キーワード後、空白から始まる    #
#                                                    #
#   （例）                                           #
#  _____________________________                     #
#  |コンピュータ             <- キーワード1          #
#  |  コンピュータが嫌い？   <- 返答1                #
#  |  頭痛がする！           <- 返答2                #
#  |上司                     <- キーワード2          #
#  |  そいつが嫌いなんだろ                           #
#  | .....                                           #
#                                                    #
#  ＜予約キーワード＞                                #
#  ＠最初の挨拶      会話開始時                      #
#  ＠最後の挨拶      会話終了チェック、会話終了時    #
#  ＠受け流し        キーワードが知識外の時          #
#  ＠繰り返し        同じ文を入力した時              #
#  ＠空文            リターンだけ入力した時          #
#                                                    #
#  ○制限、その他                                    #
#  1.多分、知識ファイルは、大きすぎるとまずいので、  #
#    変な動作をしたら、適当に編集して下さい。        #
#  2.キーワードに一致しないと「＠受け流し」ばっかり  #
#    してしまいます。キーワードは、字種区切りして、  #
#    ひらがな以外で最も長いものを選びます。（区切り  #
#    がないか、文が短いと全体をキーワードにする）    #
#    だから、入力に漢字、カタカナを使った方が、キー  #
#    ワードに一致しやすいと思います。                #
#                                                    #
#  ○最後に                                          #
#  ・文字列添字の配列を活用させてもらいました。      #
#  ・仮想記憶なんかあるともっとすごい。              #
#  ・ちょっと遅いのが気になる。                      #
#  ・バグがあったらごめんなさい。                    #
#  ・データファイル名は jeliza.dat です              #
#                                                    #
#  ○参考文献                                        #
#  「Ｔｈｅ Ｐｌａｙ ｏｆ Ｗｏｒｄｓ」、ＡＳＣＩＩ   #
#  Ｈ・シルト：「Ｃで学ぶＡＩ」、マグロウヒル        #
#                                                    #
######################################################

#    main()

#-----------------------------------------------------
# main         : 初期設定、会話、終了処理            |
# 入力         : なし                                |
# 出力         : なし                                |
#-----------------------------------------------------
def main()

    errorbreakmode(0, 0, 0)

    $dat_file = "jeliza.dat"            # データファイル名

    タイトル()
    初期設定()
    知識読込($知識ファイル名)
    会話処理()
    if $学習 == true then
        知識保存($知識ファイル名)
    end

end

#*****************************************************
# 初期設定     : 知識ファイル名、学習、乱数を設定    *
# 利用方法     : 1. call 初期設定                    *
#*****************************************************

#-----------------------------------------------------
# タイトル     : 気持ちの問題                        |
# 入力         : なし                                |
# 出力         : なし                                |
#-----------------------------------------------------
def タイトル()

    message("Ｊ・ＥＬＩＺＡ", 0)

end

#-----------------------------------------------------
# 初期設定     : 知識ファイル名、学習、乱数等設定    |
# 入力         : なし                                |
# 出力         : $学習,$知識ファイル名               |
#-----------------------------------------------------
def 初期設定()

    履歴初期化()
    $繰り返し数 = 0

    $知識ファイル名 = ""
    if existfile($dat_file) then
        $知識ファイル名 = $dat_file
    else
        gof = getoptionfile()
        path = breakdownpath(gof["マクロ"])
        drive = path["drive"]
        dir = path["directory"]
        $知識ファイル名 = drive & dir & $dat_file
    end

    確定 = false
    if exact($知識ファイル名, "") != true then
        guidance("知識ファイル = " & $知識ファイル名)
        case alert("知識ファイル = " & $知識ファイル名)
            when 1 then
                確定 = true
            when 2 then
                確定 = false
            else
                guidance("")
                stop()            # エスケープ終了
        end
        guidance("")
    end

    if 確定 != true then
        guidance("知識ファイルを指定してください")
        $知識ファイル名 = inputfile("", "*.dat")
        guidance("")
        if exact($知識ファイル名, "") == true then
            stop()
        end
    end

    guidance("知識ファイルに学習結果を保存")
    case alert("会話学習する")
        when 1 then
            $学習 = true
        when 2 then
            $学習 = false
        else
            guidance("")
            stop()            # エスケープ終了
    end
    guidance("")

end

#-----------------------------------------------------
# 履歴初期化   : 会話履歴バッファの初期化            |
# 入力         : なし                                |
# 出力         : $履歴(),$履歴最大数                 |
#-----------------------------------------------------
def 履歴初期化()

    $履歴最大数 = 15
    (1).upto($履歴最大数) do |添字|
        $履歴[添字] = ""
    end

end

#-----------------------------------------------------
# 履歴登録     : 会話履歴バッファへの登録            |
# 入力         : 文                                  |
# 出力         : なし                                |
#-----------------------------------------------------
def 履歴登録(文)

    置換 = 1
    最短長 = 100
    if len(文) >= 8 then
        (1).upto($履歴最大数) do |添字|
            長さ = len($履歴[添字])
            if 長さ < 最短長 then
                置換 = 添字
                最短長 = 長さ
            end
        end
        $履歴[置換] = 文
    end

end

#-----------------------------------------------------
# 履歴出力     : 会話履歴からのデータ取得            |
# 入力         : なし                                |
# 出力         : 文                                  |
#-----------------------------------------------------
def 履歴出力()

    有効数 = 0
    (1).upto($履歴最大数) do |数|
        if exact($履歴[数], "") == false then
            有効数 = 有効数 + 1
            有効[有効数] = 数
        end
    end

    if 有効数 != 0 then
        添字 = 正数乱数(有効数)
        _prr_result = $履歴[有効[添字]]
        $履歴[有効[添字]] = ""
    else
        _prr_result = "誰がなんと言おうと、カレーが好きだ"
    end
    remove(有効)  # 必要？

_prr_result
end

#*****************************************************
# 会話処理     : 知識を学習しながら会話する          *
# 利用方法     : 1. 受け流し設定                     *
#              : 2. 知識読込                         *
#              : 3. 会話処理                         *
#              : 4. 知識保存                         *
#*****************************************************

#-----------------------------------------------------
# 会話処理     : 会話のループ                        |
# 入力         : なし                                |
# 出力         : なし                                |
#-----------------------------------------------------
def 会話処理()

    $質問中 = true
    $注目語[1] = "＠最初の挨拶"
    $注目語数 = 1
    $出力文 = 最初の挨拶()

    while true do
	remove($入力文)
        $入力文 = 文字入力($出力文)
        if !isblank($入力文) then
            $入力文 = zen(clean(trim($入力文)))
        end

        if isblank($入力文) || 最後の挨拶？($入力文) == true then
            $出力文 = 最後の挨拶()
            message($出力文)
            break
        elsif 正数乱数(100) == 50 then
            $出力文 = "ちょっと都合が悪いんで。" & 最後の挨拶()
            message($出力文)
            break
        elsif $繰り返し数 > 15 then
            $出力文 = "同じことばっかり言って。" & 最後の挨拶()
            message($出力文)
            break
        elsif exact($入力文, "") == true then
            $出力文 = 空文返答()
        elsif 繰り返し？() == true then
            $出力文 = 繰り返し返答($入力文)
        else
            履歴登録($入力文)
            字種区切り($入力文)
            if $質問中 == true then
                会話学習($入力文)
            end
            注目語決定()
            出力文決定()
        end

        $前入力文 = $入力文
    end

end

#-----------------------------------------------------
# 最初の挨拶   : 「こんにちは」、「やあ元気」など    |
# 入力         : なし                                |
# 出力         : 文                                  |
#-----------------------------------------------------
def 最初の挨拶()

    if exist($知識["＠最初の挨拶"]) == false then
        $知識["＠最初の挨拶"][1] = "こんにちは"
        添字 = 1
    else
        個数 = size($知識["＠最初の挨拶"])
        添字 = 正数乱数(個数)
    end
    _prr_result = $知識["＠最初の挨拶"][添字]

_prr_result
end

#-----------------------------------------------------
# 最後の挨拶   : 「さようなら」、「じゃまた」など    |
# 入力         : なし                                |
# 出力         : 文                                  |
#-----------------------------------------------------
def 最後の挨拶()

    if exist($知識["＠最後の挨拶"]) == false then
        $知識["＠最後の挨拶"][1] = "さようなら"
        添字 = 1
    else
        個数 = size($知識["＠最後の挨拶"])
        添字 = 正数乱数(個数)
    end
    _prr_result = $知識["＠最後の挨拶"][添字]

_prr_result
end

#-----------------------------------------------------
# 最後の挨拶？ : $知識( "＠最後の挨拶" )に一致？     |
# 入力         : 入力文                              |
# 出力         : 一致 TRUE  不一致 FALSE             |
#-----------------------------------------------------
def 最後の挨拶？(挨拶)

    出力 = false
    if find("ばいばい", 挨拶) > 0 || find("バイバイ", 挨拶) > 0 || find("さよなら", 挨拶) > 0 || find("さようなら", 挨拶) > 0 then
        出力 = true
    end

    if 出力 == false && exist($知識["＠最後の挨拶"]) == true then
        for 要素 in $知識["＠最後の挨拶"] do
            if exact(挨拶, 要素, 4) == true then
                出力 = true
                break
            end
        end
    end

    _prr_result = 出力

_prr_result
end

#-----------------------------------------------------
# 繰り返し返答 : 「同じことを言うな」など            |
# 入力         : 入力文                              |
# 出力         : 出力文                              |
#-----------------------------------------------------
def 繰り返し返答(文)

    $質問中 = false
    $繰り返し数 = $繰り返し数 + 1
    数 = 正数乱数(4)

    if 数 > 3 then
        _prr_result = "こっちも『" & 文 & "』"
    else
        if exist($知識["＠繰り返し"]) == false then
            $知識["＠繰り返し"][1] = "同じことを言うな"
            添字 = 1
        else
            個数 = size($知識["＠繰り返し"])
            添字 = 正数乱数(個数)
        end
        _prr_result = $知識["＠繰り返し"][添字]
    end

_prr_result
end

#-----------------------------------------------------
# 繰り返し？   : 会話履歴中に入力文が存在            |
# 入力         : なし                                |
# 出力         : 一致 TRUE  不一致 FALSE             |
#-----------------------------------------------------
def 繰り返し？()

    _prr_result = false
    if $前入力文 != nil && exact($入力文, $前入力文, 4) == true then
        _prr_result = true
    else
        (1).upto($履歴最大数) do |添字|
            if exact($履歴[$入力文][添字], 4) == true then
                _prr_result = true
                break
            end
        end
    end

_prr_result
end

#-----------------------------------------------------
# 空文返答     : 「何かいってよ」など                |
# 入力         : なし                                |
# 出力         : 文                                  |
#-----------------------------------------------------
def 空文返答()

    $質問中 = false
    数 = 正数乱数(20)
    case 数
        when 1 then
            _prr_result = "確か「" & 履歴出力() & "」って言ってたよ"
        when 2 then
            _prr_result = "「" & 履歴出力() & "」って言ったの覚えてる？"
        when 3 then
            _prr_result = "この前の「" & 履歴出力() & "」って発言は納得いかんな"
        when 4 then
            _prr_result = "「" & 履歴出力() & "」って発言を詳しく聞かせてよ"
        when 5 then
            数字 = zen(leftb(thistime(), 2))
            if code(数字) == code("０") then
                数字 = rightb(数字, 2)
            end
            _prr_result = "もう" & 数字 & "時か"
        when 6 then
            _prr_result = "今年は西暦" & zen(leftb(thisdate(), 4)) & "年です"
        when 7 then
            数字 = zen(midb(thisdate(), 6, 2))
            if code(数字) == code("０") then
                数字 = rightb(数字, 2)
            end
            _prr_result = 数字 & "月は忙しいな"
        when 8 then
            数字 = zen(rightb(thisdate(), 2))
            if code(数字) == code("０") then
                数字 = rightb(数字, 2)
            end
            _prr_result = "あれ、今日は" & 数字 & "日なのか"
        when 9 then
            キー = キー出力()
            _prr_result = "ところであなた、「" & キー & "」って知ってる？"
            $質問中 = true
        when 10 then
            キー = キー出力()
            _prr_result = "暇そうだから、「" & キー & "」って教えて"
            $質問中 = true
        when 10 then
            キー = キー出力()
            _prr_result = "お願いだから、「" & キー & "」を説明して"
            $質問中 = true
        when 11 then
            キー = キー出力()
            _prr_result = "「" & キー & "」について詳しく知りたいな"
            $質問中 = true
        else
            if exist($知識["＠空文"]) == false then
                $知識["＠空文"][1] = "何か言ってもらわないと"
                添字 = 1
            else
                個数 = size($知識["＠空文"])
                添字 = 正数乱数(個数)
            end
            _prr_result = $知識["＠空文"][添字]
    end

_prr_result
end

#-----------------------------------------------------
# 会話学習     : 質問に対する返答の記憶              |
# 入力         : 質問に対する返答                    |
# 出力         : なし                                |
#-----------------------------------------------------
def 会話学習(返答)

    (1).upto($注目語数) do |添字|
        キー = $注目語[添字]
        if exist($知識[キー]) == true then
            既存 = false
            要素数 = size($知識[キー])
            (1).upto(要素数) do |番号|
                if exact($知識[返答][キー][番号], 4) == true then
                    既存 = true
                    break
                end
            end
            if 既存 == false then
                $知識[キー][要素数 + 1] = 返答
            end
        else
            $知識[キー][1] = 返答
        end
    end

end

#-----------------------------------------------------
# 注目語決定   : 入力文から注目語候補を決める        |
# 入力         : なし                                |
# 出力         : $注目語($最重要)                    |
#-----------------------------------------------------
def 注目語決定()

    remove($注目語)
    $注目語数 = 0
    $最重要 = 0

    if $形態素数 <= 1 || len($入力文) <= 5 then
        $注目語[1] = $入力文
        $注目語数 = 1
        $最重要 = 1
    else
        $注目語数 = 0
        $最重要 = 0
        (1).upto($形態素数) do |添字|
            字種 = code($形態素[添字])
            if 字種 == 1 || 字種 == 2 || 字種 == 4 then
                $注目語数 = $注目語数 + 1
                $注目語[$注目語数] = $形態素[添字]
                if $注目語数 == 1 then
                    $最重要 = 1
                    最大長 = len($注目語[$最重要])
                else
                    長さ = len($注目語[$注目語数])
                    if 長さ > 最大長 || 長さ == 最大長 && 字種(code($注目語[$注目語数])) > 字種(code($注目語[$最重要])) then
                        $最重要 = $注目語数
                        最大長 = 長さ
                    end
                end
            end
        end
        if $注目語数 == 0 then
            $注目語[1] = $形態素[1]
            $注目語数 = 1
            $最重要 = 1
        end
    end

end

#-----------------------------------------------------
# 出力文決定   : 知識と注目語から出力文を決める      |
# 入力         : なし                                |
# 出力         : $出力文                             |
#-----------------------------------------------------
def 出力文決定()

    キー = $注目語[$最重要]
    if exist($知識[キー]) == false then
        数 = 正数乱数(35)
        case 数
            when 1 then
                $出力文 = "ところで、「" & 履歴出力() & "」って言ったよね"
                $質問中 = false
            when 2 then
                $出力文 = "さっきこんな事を言ったね：「" & 履歴出力() & "」"
                $質問中 = false
            when 3 then
                $出力文 = "「" & 履歴出力() & "」って発言は納得いかんな"
                $質問中 = false
            when 4 then
                $出力文 = "「" & キー & "」って何なの？"
                $質問中 = true
            when 5 then
                $出力文 = "「" & キー & "」について教えて下さい"
                $質問中 = true
            when 6 then
                $出力文 = "「" & キー & "」は知らないな"
                $質問中 = true
            when 7 then
                $出力文 = "「" & キー & "」の意味を教えて"
                $質問中 = true
            when 8 then
                キー = キー出力()
                $出力文 = "ところで「" & キー & "」って何なの？"
                $質問中 = true
            when 9 then
                キー = キー出力()
                $出力文 = "あれっ、「" & キー & "」って何だったっけ？"
                $質問中 = true
            when 10 then
                キー = キー出力()
                $出力文 = "話は変わるけど、「" & キー & "」って言葉が気になって"
                $質問中 = true
            when 11 then
                キー = キー出力()
                $出力文 = "君、「" & キー & "」を説明しなさい"
                $質問中 = true
            when 12 then
                数字 = zen(leftb(thistime(), 2))
                if code(数字) == code("０") then
                    数字 = rightb(数字, 2)
                end
                $出力文 = "今は" & 数字 & "時だね"
                $質問中 = false
            when 13 then
                数字 = zen(leftb(thisdate(), 4))
                $出力文 = "確か今年は" & 数字 & "年だね"
                $質問中 = false
            when 14 then
                数字 = zen(midb(thisdate(), 6, 2))
                if code(数字) == code("０") then
                    数字 = rightb(数字, 2)
                end
                $出力文 = "ところで、今月は" & 数字 & "月だね"
                $質問中 = false
            when 15 then
                数字 = zen(rightb(thisdate(), 2))
                if code(数字) == code("０") then
                    数字 = rightb(数字, 2)
                end
                $出力文 = "今日は" & 数字 & "日だね"
                $質問中 = false
            else
                $出力文 = 受け流し出力()
                $質問中 = true
        end
    else
        個数 = size($知識[キー])
        添字 = 正数乱数(個数)
        $出力文 = $知識[キー][添字]
        $質問中 = false
    end

end

#-----------------------------------------------------
# 受け流し出力 : 分からないときの文生成              |
# 入力         : なし                                |
# 出力         : 出力文                              |
#-----------------------------------------------------
def 受け流し出力()

    if exist($知識["＠受け流し"]) == false then
        $知識["＠受け流し"][1] = "そうだったのか"
        添字 = 1
    else
        個数 = size($知識["＠受け流し"])
        添字 = 正数乱数(個数)
    end
    _prr_result = $知識["＠受け流し"][添字]

_prr_result
end

#-----------------------------------------------------
# キー出力     : 知識にあるキーを出力する            |
# 入力         : なし                                |
# 出力         : キー                                |
#-----------------------------------------------------
def キー出力()

    最小応答数 = 100
    添字配列 = arrayindex($知識)
    for キー in 添字配列 do
        if code(キー) != code("＠") then
            応答数 = size($知識[キー])
            if 応答数 < 最小応答数 then
                候補 = キー
                最小応答数 = 応答数
            end
        end
    end

    remove($注目語)
    $注目語数 = 1
    $最重要 = 1
    if 候補 != nil then
        $注目語[1] = 候補
    else
        $注目語[1] = "キーマカレー"
    end

_prr_result
end

#*****************************************************
# 知識入出力   : 知識のファイルへの読み書き          *
# 利用方法     : 1. 知識読込 （会話開始前）          *
#              : 2. 知識保存 （会話終了後）          *
#*****************************************************

#-----------------------------------------------------
# 知識読込     : ファイルから知識を読み込む          |
# 入力         : ファイル名                          |
# 出力         : なし                                |
#-----------------------------------------------------
def 知識読込(名前)

    guidance("知識ファイル " & 名前 & " を読込中")
    ファイル = 1
    番号 = 1
    open(ファイル, 名前, "INPUT")
    if missing(ファイル) == true then
        $知識["＠受け流し"][1] = "はいはい"
        $知識["＠最初の挨拶"][1] = "こんにちは"
        $知識["＠別れの挨拶"][1] = "さようなら"
        $知識["＠繰り返し"][1] = "同じことばっかりだね"
        $知識["＠空文"][1] = "黙ってないで"
    else
        while missing(ファイル) != true do
            lineinput(ファイル, 文字列)
            コード = code(文字列)
            if コード == code(" ") || コード == code("　") then
                反応 = true
            else
                反応 = false
            end
            文字列 = zen(clean(trim(文字列)))   # DOSの1ah
            if code(文字列) != code("") then
                if 反応 == true then
                    $知識[キー][番号] = 文字列
                    番号 = 番号 + 1
                else
                    キー = 文字列
                    番号 = 1
                end
            end
        end
        close(ファイル)
    end
    guidance("")

end

#-----------------------------------------------------
# 知識保存     : ファイルに知識を保存する            |
# 入力         : ファイル名                          |
# 出力         : なし                                |
#-----------------------------------------------------
def 知識保存(名前)

    guidance("知識ファイル " & 名前 & " に保存中")
    ファイル = 1
    create(ファイル, 名前, "NEWOLD")
    if missing(ファイル) == true then
        message("知識が保存できませんでした")
    else
        添字配列 = arrayindex($知識)
        for キー in 添字配列 do
            lineprint(ファイル, キー)
            for 反応 in $知識[キー] do
                lineprint(ファイル, "　" & 反応)
            end
        end
        close(ファイル)
    end
    guidance("")

end

#-----------------------------------------------------
# 知識表示     : 知識を表示する                      |
# 入力         : なし                                |
# 出力         : なし                                |
#-----------------------------------------------------
def 知識表示()
    添字配列 = arrayindex($知識)
    for キー in 添字配列 do
        番号 = 1
        for 反応 in $知識[キー] do
            message("(" & キー & "," & 番号 & ") -> " & 反応)
            番号 = 番号 + 1
        end
    end
end

#*****************************************************
# 形態素解析   : べた書き文字列を字種区切りする      *
# 利用方法     : 1. call 字種区切り( "..." )         *
#              : 2. $形態素(1,...,$形態素数)         *
#*****************************************************

#-----------------------------------------------------
# 字種区切り   : 文字列を字種区切りする              |
# 入力         : べた書き文字列                      |
# 出力         : $形態素（$形態素数)                 |
#-----------------------------------------------------
def 字種区切り(入力)

    remove($形態素)
    $形態素数 = 1
    出力 = ""
    位置 = 1
    文字 = mid(入力, 位置, 1)
    コード = code(文字)
    現種類 = 字種(コード)
    前種類 = -1
    while 現種類 != 0 do
        if 前種類 == -1 then
            出力 = 文字
        elsif 現種類 == 前種類 then
            出力 = 出力 & 文字
        else
            $形態素[$形態素数] = 出力
            $形態素数 = $形態素数 + 1
            出力 = 文字
        end
        前種類 = 現種類
        位置 = 位置 + 1
        文字 = mid(入力, 位置, 1)
        コード = code(文字)
        現種類 = 字種(コード)
    end
    if 前種類 != -1 then
        $形態素[$形態素数] = 出力
    else
        $形態素数 = 0
    end

end

#-----------------------------------------------------
# 字種         : 文字種を調べる                      |
# 入力         : 文字コード                          |
# 出力         : 空文字列 "" 0  漢字 1  カタカナ 2   |
#              : ひらがな 3  英数字 4  それ以外 5    |
#-----------------------------------------------------
def 字種(コード)

    if コード == code("") then
        _prr_result = 0
    elsif 漢字？(コード) == true then
        _prr_result = 1
    elsif カタカナ？(コード) == true then
        _prr_result = 2
    elsif ひらがな？(コード) == true then
        _prr_result = 3
    elsif 英数字？(コード) == true then
        _prr_result = 4
    else
        _prr_result = 5
    end

_prr_result
end

#-----------------------------------------------------
# 漢字？       : 文字が漢字か調べる                  |
# 入力         : 文字コード                          |
# 出力         : 漢字 TRUE  漢字以外 FALSE           |
#-----------------------------------------------------
def 漢字？(コード)

    if コード >= code("亜") && コード <= code("龠") then
        _prr_result = true
    else
        _prr_result = false
    end

_prr_result
end

#-----------------------------------------------------
# カタカナ？   : 文字がカタカナか調べる              |
# 入力         : 文字コード                          |
# 出力         : カタカナ TRUE  カタカナ以外 FALSE   |
#-----------------------------------------------------
def カタカナ？(コード)

    if コード >= code("ァ") && コード <= code("ヶ") || コード == code("ー") then
        _prr_result = true
    else
        _prr_result = false
    end

_prr_result
end

#-----------------------------------------------------
# ひらがな？   : 文字がひらがなか調べる              |
# 入力         : 文字コード                          |
# 出力         : ひらがな TRUE  ひらがな以外 FALSE   |
#-----------------------------------------------------
def ひらがな？(コード)

    if コード >= code("ぁ") && コード <= code("ん") then
        _prr_result = true
    else
        _prr_result = false
    end

_prr_result
end

#-----------------------------------------------------
# 英数字？     : 文字が英数字か調べる                |
# 入力         : 文字コード                          |
# 出力         : 英数字 TRUE  英数字以外 FALSE       |
#-----------------------------------------------------
def 英数字？(コード)

    if コード >= code("０") && コード <= code("９") || コード >= code("Ａ") && コード <= code("ｚ") then
        _prr_result = true
    else
        _prr_result = false
    end

_prr_result
end

#*****************************************************
# 乱数生成     : 時間を種に乱数（１〜ｎ）を発生する  *
# 利用方法     : 1. $正数 = 正数乱数( $最大値 )      *
#*****************************************************

#-----------------------------------------------------
# 正数乱数     : 正の整数                            |
# 入力         : 最大値                              |
# 出力         : １〜最大値までの整数                |
#-----------------------------------------------------
def 正数乱数(最大値)
    数 = thisminute() & thissecond()
    _prr_result = 数 % 最大値 + 1
_prr_result
end

#-----------------------------------------------------
# ThisSecond   : 現在秒の文字列を返す                |
# 入力         : なし                                |
# 出力         : 現在秒の文字列  "05","59","00"      |
#-----------------------------------------------------
def thissecond()
    _prr_result = rightb(thistime(), 2)
_prr_result
end

#-----------------------------------------------------
# ThisMinute   : 現在分の文字列を返す                |
# 入力         : なし                                |
# 出力         : 現在分の文字列  "15","09","41"      |
#-----------------------------------------------------
def thisminute()
    _prr_result = midb(thistime(), 4, 2)
_prr_result
end

