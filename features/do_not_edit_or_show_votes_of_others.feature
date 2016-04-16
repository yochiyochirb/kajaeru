# language: ja

フィーチャ:
  使用者として、他の人から自分の投票内容を閲覧してほしくない。
  なぜなら、誰に投票しなんというコメントをつけたかは自分の想いに依るものなので、見られるのは恥ずかしいからだ。

  背景:
    前提 GitHub アカウント "alice" でログインしている
    かつ 以下の内容で投票がある:
      | 投票者 | 投票対象者 | コメント         |
      | bob    | alice      | いつもありがとう |

  シナリオ: 自分以外の人の投票は閲覧することができない
    もし "bob" の投票詳細ページに直接アクセスする
    ならば 該当ページが見つからないこと

  シナリオ: 自分以外の人の投票は編集することができない
    もし "bob" の投票編集ページに直接アクセスする
    ならば 該当ページが見つからないこと
