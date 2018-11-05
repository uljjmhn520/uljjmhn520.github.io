---
title: "debian 修改时区"
comments: true
share: true
toc: true
date: "2015-06-18 00:00:01"
categories:
  - other

tags:
  - debian
  - timezone

---



从前blog移植过来，暂无摘要，后期再补

<!--more-->

  


配置时区的命令是：

    dpkg-reconfigure tzdata
    
运行后选择要修改的时区对应的编号，如选Asia时，在Geographic area: 填6

    debconf: unable to initialize frontend: Dialog
    debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
    debconf: falling back to frontend: Readline
    Configuring tzdata
    ------------------
    Please select the geographic area in which you live. Subsequent configuration questions will narrow this down by presenting a list of cities, representing the time zones in which they are located.
      1. Africa  2. America  3. Antarctica  4. Australia  5. Arctic Ocean  6. Asia  7. Atlantic Ocean  8. Europe  9. Indian Ocean  10. Pacific Ocean  11. System V timezones  12. US  13. None of the above
    Geographic area: 6


选择后Asia后，


    Please select the city or region corresponding to your time zone.
      1. Aden      8. Baghdad   15. Chita       22. Dubai        29. Hovd       36. Kamchatka    43. Kuala_Lumpur  50. Muscat        57. Pontianak  64. Samarkand      71. Tbilisi        78. Urumqi
      2. Almaty    9. Bahrain   16. Choibalsan  23. Dushanbe     30. Irkutsk    37. Karachi      44. Kuching       51. Nicosia       58. Pyongyang  65. Seoul          72. Tehran         79. Ust-Nera
      3. Amman     10. Baku     17. Chongqing   24. Gaza         31. Istanbul   38. Kashgar      45. Kuwait        52. Novokuznetsk  59. Qatar      66. Shanghai       73. Tel_Aviv       80. Vientiane
      4. Anadyr    11. Bangkok  18. Colombo     25. Harbin       32. Jakarta    39. Kathmandu    46. Macau         53. Novosibirsk   60. Qyzylorda  67. Singapore      74. Thimphu        81. Vladivostok
      5. Aqtau     12. Beirut   19. Damascus    26. Hebron       33. Jayapura   40. Khandyga     47. Magadan       54. Omsk          61. Rangoon    68. Srednekolymsk  75. Tokyo          82. Yakutsk
      6. Aqtobe    13. Bishkek  20. Dhaka       27. Ho_Chi_Minh  34. Jerusalem  41. Kolkata      48. Makassar      55. Oral          62. Riyadh     69. Taipei         76. Ujung_Pandang  83. Yekaterinburg
      7. Ashgabat  14. Brunei   21. Dili        28. Hong_Kong    35. Kabul      42. Krasnoyarsk  49. Manila        56. Phnom_Penh    63. Sakhalin   70. Tashkent       77. Ulaanbaatar    84. Yerevan
    Time zone: 66



选上海则选66


    Current default time zone: 'Asia/Shanghai'
    
    Local time is now:      Fri Oct 16 11:20:19 CST 2015.
    
    Universal Time is now:  Fri Oct 16 03:20:19 UTC 2015.


设置成功