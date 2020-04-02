# SQL JOINS - theoretical notes

За целта на упражнението използваме следните таблици:

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91584280_2808307715926122_1195045680557588480_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeHlKWZXpzQc-NU2iTy0_mcmCzpespuCHah0GP2D7POWrbD6CWollIvAxD9EQFp_1OdJfg_notiIMgZe3N4peEX_OxnouIVgqcXe4UyAanOAqQ&_nc_ohc=TCo-rPUcLNYAX_BIcAL&_nc_ht=scontent.fsof9-1.fna&oh=593bbf2e944741e9ac09efa3088ae835&oe=5EAAA742)

## SQL INNER JOIN

Изпълняваме заявката:

```sql
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

```sql
SELECT * FROM products LEFT JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91478287_271777703836366_5184341537080737792_n.png?_nc_cat=105&_nc_sid=b96e70&_nc_eui2=AeF5sv7f3EB7iKGVo6--36GqpIEXwGi1pwxjU0_mflBG_MBKsEzrdp8eOeMePAaDoTjzLXEblyxhuxxkm33I2FQXhNDcATB8_LDmaM5tKkzErQ&_nc_ohc=9EvizRDjcMQAX-c8ywX&_nc_ht=scontent.fsof9-1.fna&oh=e176c2d63c7aefe2697aa83ae50edff1&oe=5EA8A1A3)

Взимат се **всички стойности от Products (въпреки, че за Батериите нямаме съответстващи)** и се прави expansion с Categories, а **там, където няма съответстващи - се добавя NULL**

**За всички колони, които би трябвало да идват от Categories, ще получим NULL**

### RIGHT OUTER JOIN

Изпълненяваме следната заявка:

```sql
SELECT * FROM products RIGHT JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91974193_668693007248296_2087994850552053760_n.png?_nc_cat=106&_nc_sid=b96e70&_nc_eui2=AeEp1bzqJf4RYzAFDPcG8N5UPFuWOtuAsnVypf9mkMpPDbmfaOrju7U85WlM2gGd6dfWQtSI3NPhBd9vv7AUSYjq-nrpPcpfQ2FzKquKTSo4eQ&_nc_ohc=QkBZTHxfNfIAX_xARFz&_nc_ht=scontent.fsof9-1.fna&oh=c10cc0cac12c7857355721c0fc94c26d&oe=5EA7E489)

Резултатът ще бъде какъвто имаме в INNER JOIN с разликата, че това, **което ще се залепи, ще е от Categories (Почстващи препарати), а стойностите за Products ще са NULL**

--------

------------------------

**Разликата в използването на LEFT OUTER JOIN и RIGHT OUTER JOIN е за коя таблица искаме да изкараме всички стойности: дали за лявата или искаме за дясната**

------------------

----------

```sql
SELECT * FROM products RIGHT JOIN categories ON product.category_id = categories.id
-- equals (except columns order when SELECT *)
SELECT * FROM categories LEFT JOIN products ON product.category_id = categories.id
```

###  FULL OUTER JOIN

Изпълненяваме следната заявка:

```sql
SELECT * FROM products FULL JOIN categories ON product.category_id = categories.id
```

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91876163_1323363141187428_6613695636598423552_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeE3TaGwjYml_Usk-tDMuNpmg5hyPUXKV1pq9PyYmDkliQLL1sMKT-qT4Zg4sU4DDFXRgRmEohmz4hFzJflPNQslg-bkHGff-mTU4Kd_EdU8iA&_nc_ohc=oo6t1FpoRQIAX_j2odT&_nc_ht=scontent.fsof9-1.fna&oh=3b40e68a37dea9a12dd329504991f72e&oe=5EA9B71F)

**Резултатът е таблицата от INNER JOIN + допълнителните редове от LEFT JOIN & RIGHT JOIN**

###  SELF JOIN

Възможно е да join-нем една таблица със себе си. При този вид винаги именуваме таблиците, които join-ваме. Пример (from week2-ManyRelations-exercise):

```sql
--5. Напишете заявка, която извежда двойките модели на персонални компютри,
--които имат еднаква честота и памет. Двойките трябва да се показват само по
--веднъж, например само (i, j), но не и (j, i).

USE pc;
SELECT p1.model as model_1, p2.model as model_2, p1.speed, p1.ram
FROM pc p1
JOIN pc p2 ON p1.speed = p2.speed AND p1.ram = p2.ram AND p1.model < p2.model;
```

Output:

![image-20200402165925170](C:\Users\garnaudo\AppData\Roaming\Typora\typora-user-images\image-20200402165925170.png)

**Пример 2 (основен):**

```sql
SELECT s.name
FROM ships s
JOIN outcomes o1 ON s.name = o1.ship AND o1.result = 'damaged'
JOIN battles b1 ON o1.battle = b1.name
JOIN outcomes o2 ON s.name = o2.ship
JOIN battles b2 ON o2.battle = b2.name AND b1.date < b2.date;
```

Стъпка 1 (таблици):

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/92080469_235762594279110_1450758550073638912_n.png?_nc_cat=107&_nc_sid=b96e70&_nc_eui2=AeF1j39BHXzJm_NswLxaPvtOjjm3GFkixN2Q80uAvACdFBaqNIrY9r_dOhv2csMKAHxk9sVluEwr_0FE6ub-eIWlDMgG_4R3ss39pREM_EuRpw&_nc_ohc=AI4YdG3LcPIAX_URsu4&_nc_ht=scontent.fsof9-1.fna&oh=80175a3f17b5157253259df038fbdcc7&oe=5EAC2E52)

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91647898_2562693284048609_3285843538436161536_n.png?_nc_cat=103&_nc_sid=b96e70&_nc_eui2=AeF8KM3HzoNX2Wnrn78jbBaIx0ecd-0VCGx1xNCsrc8s5QNcbXODELYIKZ6CfsmOMWEkRsqX8322dyfXmvI_efFONvi7Xtdfazt-f_-Hu9HhDQ&_nc_ohc=kEDFmTH32qwAX8IwRB9&_nc_ht=scontent.fsof9-1.fna&oh=08fba30aa53f9a7b24ab8fef57181857&oe=5EABEBDB)

Резултат:

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91873401_548635615771892_4497336345282215936_n.png?_nc_cat=108&_nc_sid=b96e70&_nc_eui2=AeGNmzZ-47voQ9qD9CSXoY0ur_pgk_9JwIA3HEKnfD5fypAYJMSkUbb0teojqZ_soaYBaYolCb1cqsSHGfT69Brz7qHzRiErWhAz_FN4QGNmJw&_nc_ohc=1gcELo5Hi3cAX_Ic1cy&_nc_ht=scontent.fsof9-1.fna&oh=0a75f40b45fc1b22571c6a84b0ce6342&oe=5EACC676)

Стъпка 2 (таблции и резултат):

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91498415_259747558369752_5560563707089518592_n.png?_nc_cat=100&_nc_sid=b96e70&_nc_eui2=AeEbqvzGVxIQro2-Je33InDwD3AjZCVJp8m1YJNDwO-cMFPBGdlvhMw-NjmUY1VQYRrWTJNz-JhwGAijexb9jAdluDiw2X3DoBsXcAOFTUtfMQ&_nc_ohc=JCvJYGIr8EUAX9yTqfA&_nc_ht=scontent.fsof9-1.fna&oh=6a2c178bada695b4606ff48c8d12848c&oe=5EAA49DA)

Стъпка 3 (допълнително условие):

![img](https://scontent.fsof9-1.fna.fbcdn.net/v/t1.15752-9/91908499_887488058390604_3150387232062308352_n.png?_nc_cat=105&_nc_sid=b96e70&_nc_eui2=AeE0EXy_2m8XYsRWXKRI_yJjSGnrlrh3bvsW141USY1gnAfq4-ADOxQrvuJEMqeRX1uycpqV7dVxVGAQwDAFoEjsbaAN583fE1sQJMGwJYsuAw&_nc_ohc=_hLa0t5WIfcAX8ia3ra&_nc_ht=scontent.fsof9-1.fna&oh=dbb37bc49881a2d1f538651e2cbe438f&oe=5EAC372C)