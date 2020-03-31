# SQL JOINS - theoretical notes

За целта на упражнението използваме следните таблици:

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91584280_2808307715926122_1195045680557588480_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeHlKWZXpzQc-NU2iTy0_mcmCzpespuCHah0GP2D7POWrbD6CWollIvAxD9EQFp_1OdJfg_notiIMgZe3N4peEX_OxnouIVgqcXe4UyAanOAqQ&_nc_ohc=TCo-rPUcLNYAX_BIcAL&_nc_ht=scontent.fsof9-1.fna&oh=593bbf2e944741e9ac09efa3088ae835&oe=5EAAA742)

## SQL INNER JOIN

Изпълняваме заявката:

```
SELECT * FROM products JOIN categories ON product.category_id = categories.id
```

При INNER JOIN на Products с Categories expand-ваме всички полета на таблицата Products: 

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91693103_1908066536167135_4667450035552649216_n.png?_nc_cat=107&_nc_sid=b96e70&_nc_eui2=AeE8Trdyg0pHB662BM0lKHrP53VKKptddErg9ciWymbdWrxEIWCrnJNtDTFfPN9It2UodSnSPR63MndnqU-nxdiY9CL01UEqJVw85CU0Lhtx4A&_nc_ohc=SnsozaVB2UcAX94iI9M&_nc_ht=scontent.fsof9-1.fna&oh=3e2acd6e097a7ce204e9a8c616a62bbf&oe=5EA8E52A)

Забелязваме, че 

 - в Categories имаме *Почистващи препарати*, но не и в *Products* няма съответстващ продукт

 - в *Products* имаме *Батерии* с кат. *110*, която липсва в *Categories*

   **Тези редове се губят в новополучената таблица!**

## SQL OUTER JOIN

### LEFT OUTER JOIN

Изпълненяваме следната заявка:

```
SELECT * FROM products LEFT JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91478287_271777703836366_5184341537080737792_n.png?_nc_cat=105&_nc_sid=b96e70&_nc_eui2=AeF5sv7f3EB7iKGVo6--36GqpIEXwGi1pwxjU0_mflBG_MBKsEzrdp8eOeMePAaDoTjzLXEblyxhuxxkm33I2FQXhNDcATB8_LDmaM5tKkzErQ&_nc_ohc=9EvizRDjcMQAX-c8ywX&_nc_ht=scontent.fsof9-1.fna&oh=e176c2d63c7aefe2697aa83ae50edff1&oe=5EA8A1A3)

Взимат се **всички стойности от Products (въпреки, че за Батериите нямаме съответстващи)** и се прави expansion с Categories, а **там, където няма съответстващи - се добавя NULL**

**За всички колони, които би трябвало да идват от Categories, ще получим NULL**

### RIGHT OUTER JOIN

Изпълненяваме следната заявка:

```
SELECT * FROM products RIGHT JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91974193_668693007248296_2087994850552053760_n.png?_nc_cat=106&_nc_sid=b96e70&_nc_eui2=AeEp1bzqJf4RYzAFDPcG8N5UPFuWOtuAsnVypf9mkMpPDbmfaOrju7U85WlM2gGd6dfWQtSI3NPhBd9vv7AUSYjq-nrpPcpfQ2FzKquKTSo4eQ&_nc_ohc=QkBZTHxfNfIAX_xARFz&_nc_ht=scontent.fsof9-1.fna&oh=c10cc0cac12c7857355721c0fc94c26d&oe=5EA7E489)

Резултатът ще бъде какъвто имаме в INNER JOIN с разликата, че това, **което ще се залепи, ще е от Categories (Почстващи препарати), а стойностите за Products ще са NULL**

--------

------------------------

**Разликата в използването на LEFT OUTER JOIN и RIGHT OUTER JOIN е за коя таблица искаме да изкараме всички стойности: дали за лявата или искаме за дясната**

------------------

----------

```
SELECT * FROM products RIGHT JOIN categories ON product.category_id = categories.id
-- equals (except columns order when SELECT *)
SELECT * FROM categories LEFT JOIN products ON product.category_id = categories.id
```

###  FULL OUTER JOIN

Изпълненяваме следната заявка:

```
SELECT * FROM products FULL JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91876163_1323363141187428_6613695636598423552_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeE3TaGwjYml_Usk-tDMuNpmg5hyPUXKV1pq9PyYmDkliQLL1sMKT-qT4Zg4sU4DDFXRgRmEohmz4hFzJflPNQslg-bkHGff-mTU4Kd_EdU8iA&_nc_ohc=oo6t1FpoRQIAX_j2odT&_nc_ht=scontent.fsof9-1.fna&oh=3b40e68a37dea9a12dd329504991f72e&oe=5EA9B71F)

**Резултатът е таблицата от INNER JOIN + допълнителните редове от LEFT JOIN & RIGHT JOIN**