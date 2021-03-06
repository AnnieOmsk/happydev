# coding: utf-8
class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :text

      t.timestamps
    end

    all_tweets = [
      'Думаю, лучшей характеристикой прошедшего <a href="https://twitter.com/search/%23happydev">#happydev</a> станет вопрос: "Когда будет ещё?"</p>&mdash; Илья Микодин (@flashader) <a href="https://twitter.com/flashader/status/252442652203692032">September 30, 2012</a>',
      'Еще, я завидую (белой завистью, конечно) всем дизайнерам, разработчикам, которые посещают конференции типа <a href="https://twitter.com/search/%23happydev">#happydev</a> или <a href="https://twitter.com/search/%23yac2012">#yac2012</a>.</p>&mdash; Никита Слимов (@nksoff) <a href="https://twitter.com/nksoff/status/252491433024561153">September 30, 2012</a>',
      'На <a href="https://twitter.com/search/%23HappyDev">#HappyDev</a> все было очень здорово! Компания душевная, организация очень продуманная! Респект @<a href="https://twitter.com/annieomsk">annieomsk</a> и @<a href="https://twitter.com/inem">inem</a>!</p>&mdash; Данил Снитко (@Kukalyakin) <a href="https://twitter.com/Kukalyakin/status/252422185480753152">September 30, 2012</a>',
      '<a href="https://twitter.com/search/%23happydev">#happydev</a> закончился. Внутри какое-то странное чувство печали.. Было круто и хочется еще..</p>&mdash; Andrey Krivko (@jastkand) <a href="https://twitter.com/jastkand/status/252400850964725760">September 30, 2012</a>',
      'Конференция <a href="https://twitter.com/search/%23HappyDev">#HappyDev</a> оказалась очень большой, интересной и полезной. Надеюсь, это только начало. Спасибо докладчикам и организаторам!</p>&mdash; Nikita Tolstov (@ntolstov) <a href="https://twitter.com/ntolstov/status/252392789390807041">September 30, 2012</a>',
      'Сделал 2 доклада и провел тренинг по <a href="https://twitter.com/search/%23DDD">#DDD</a>, спасибо участникам, отдельное Спасибо организаторам <a href="https://twitter.com/search/%23HappyDev">#HappyDev</a></p>&mdash; Александр Бындю (@alexanderbyndyu) <a href="https://twitter.com/alexanderbyndyu/status/252321052368199680">September 30, 2012</a>',
      '<a href="https://twitter.com/search/%23happydev">#happydev</a> удался, респект оргам, докладчикам и слушателям.</p>&mdash; Sergey Susikov (@Angerslave) <a href="https://twitter.com/Angerslave/status/252305490133004288">September 30, 2012</a>',
      'Второй день <a href="https://twitter.com/search/%23happydev">#happydev</a> доставляет пуще первого :-)</p>&mdash; Andrey Kozhuhov (@akozhuhov) <a href="https://twitter.com/akozhuhov/status/252326099613253633">September 30, 2012</a>',
      'Спасибо @<a href="https://twitter.com/annieomsk">annieomsk</a> и @<a href="https://twitter.com/inem">inem</a> (и всем-всем кто помогал) за классную конференцию <a href="https://twitter.com/search/%23HappyDev">#HappyDev</a>! Вы - супер!</p>&mdash; Vitalia(@buzyavka) <a href="https://twitter.com/buzyavka/status/252421343981756417">September 30, 2012</a>'
    ]

    Tweet.reset_column_information
    
    all_tweets.each do |tweet|
      Tweet.create(:text => tweet)
    end
  end
end
