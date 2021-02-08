#!/usr/bin/python3
""" Project Euler 92. sorusunun cok buyuk sayilar icin (orn: 10^100) bir cozumu.

https://projecteuler.net/problem=92

https://docs.google.com/presentation/d/15CvrR3Fhlrc2v57GYJBIc5bDxmR3CUXDq76BRe7cuu8/edit?usp=sharing
"""
from collections import defaultdict


def kareler_toplami(sayi):
    """ Bir sayinin kareler toplami zincirinin hangi sayida
    sonlandigini ozyinelemeli bulur.
    """
    if sayi in [0, 1, 89]:
        return sayi
    else:
        yeni_toplam = sum([int(i)**2 for i in str(sayi)])
        return kareler_toplami(yeni_toplam)


def main(basamak_sayisi):
    # Bulundugumuz basamaga kadar olan sayilarin ilk kareler toplamina
    # kac kere ulasildiginin sayac icinde tutalim.
    sayac = defaultdict(lambda: 0)
    # Sifirinci basamakta 0'a 1 kere ulasabildik.
    sayac[0] = 1
    for basamak in range(basamak_sayisi):

        # Her basamakta bir onceki basamakla islem yapmak istedigimiz icin
        # sayacin bir onceki basamaktaki halini bir degiskende tutalim.
        sayac_dongusu = list(sayac.items())

        # O basamaktaki tum rakamlar icin,
        for rakam in range(1, 10):
            # Onceki basamktaki sayactaki tum degerleri gezelim.
            for onceki_toplam, sayac_degeri in sayac_dongusu:
                # olusacak yeni toplam,
                toplam = (rakam ** 2) + onceki_toplam
                # sayac degeri kadar arttir
                sayac[toplam] += sayac_degeri

    # Ulasilan tum sayilara kac kere ulastigimizi artik bildigimize gore,
    # bunlardan 89'a ulasilanlarin sayisini bulabiliriz.
    kac_tane_89 = 0
    for sayi, sayac_degeri in sayac.items():
        if kareler_toplami(sayi) == 89:
            kac_tane_89 += sayac_degeri
    return kac_tane_89


if __name__ == '__main__':
    # 10^n icin soruyu cozelim
    n = 100
    print(main(n))
