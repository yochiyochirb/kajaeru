# language: ja

フィーチャ:
  主催者として、投票は投票者ひとりにつき一回までとしたい。
  なぜなら、公正な投票をしてコミュニティメンバーの総意を投票結果に反映させたいからだ。

  シナリオ: すでに投票をしている場合は新たに投票できない
    前提 GitHub アカウント "alice" でログインしている
    かつ 以下の内容で新規投票している:
      | 投票対象 | コメント         |
      | bob      | いつもありがとう |
    ならば 投票が完了すること

    もし 新規投票画面に直接アクセスする

    ならば "alice" の投票編集画面に遷移すること
    かつ "あなたは既に投票済みです。" というメッセージが表示されていること
