# language: ja

フィーチャ:
  管理者として、認証が済んだメンバーにのみ Kajaeru を使ってもらいたい。
  なぜなら、コミュニティの中で閉じた活動にしたいからだ。

  シナリオ: サインインせずに投票画面にアクセスできない
    もし 新規投票画面に直接アクセスする

    ならば サインインページに遷移すること
    かつ "サインインしてください。" というメッセージが表示されていること
