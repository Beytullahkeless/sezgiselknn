function sinif = knn(k,data,dataLabels,testData,weights)
global komsu;
uzaklik_dizisi=Uzaklik_Hesapla(1,data,testData, weights);
[komsu]=Komsu_Bul(k, uzaklik_dizisi,dataLabels);
[sinif]=Sinif_Bul();
end