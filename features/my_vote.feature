# language: ja

フィーチャ:
  投票者として、自分が投票した人とコメントを確認できるようにしたい。
  なぜなら、自分が投票した相手とそのコメント内容を確認して、今現在の気持ちにより近い投票内容を反映させられるようにしたいからだ。

  シナリオ: マイページで自分の投票した内容を確認できる
    前提 GitHub アカウント "alice" でログインしている
    かつ 以下の内容で投票が済んでいる:
      | 投票対象者 | コメント             |
      | doe        | いつも助かっています |
    もし マイページへアクセスする
    かつ 投票内容を確認する

    ならば 以下の投票内容が表示されていること:
      | 投票対象者 | コメント             |
      | doe        | いつも助かっています |

  シナリオ: 投票が済んでいない場合はマイページにメッセージが表示される
    前提 GitHub アカウント "alice" でログインしている
    もし マイページへアクセスする
    かつ 投票内容を確認する

    ならば "まだ投票していません" と表示されること
