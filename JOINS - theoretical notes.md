## SQL INNER JOIN Keyword



![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91584280_2808307715926122_1195045680557588480_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeHlKWZXpzQc-NU2iTy0_mcmCzpespuCHah0GP2D7POWrbD6CWollIvAxD9EQFp_1OdJfg_notiIMgZe3N4peEX_OxnouIVgqcXe4UyAanOAqQ&_nc_ohc=TCo-rPUcLNYAX_BIcAL&_nc_ht=scontent.fsof9-1.fna&oh=593bbf2e944741e9ac09efa3088ae835&oe=5EAAA742)

При INNER JOIN на Products с Categories expand-ваме всички полета на таблицата Products: 

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91693103_1908066536167135_4667450035552649216_n.png?_nc_cat=107&_nc_sid=b96e70&_nc_eui2=AeE8Trdyg0pHB662BM0lKHrP53VKKptddErg9ciWymbdWrxEIWCrnJNtDTFfPN9It2UodSnSPR63MndnqU-nxdiY9CL01UEqJVw85CU0Lhtx4A&_nc_ohc=SnsozaVB2UcAX94iI9M&_nc_ht=scontent.fsof9-1.fna&oh=3e2acd6e097a7ce204e9a8c616a62bbf&oe=5EA8E52A)

Забелязваме, че 

 - в Categories имаме name Почистващи препарати, но не и в Products няма съответстващ продукт

 - в Products имаме Батерии с кат. 110, която липсва в Categories

   ​		

Тези редове се губят в новополучената таблица!



