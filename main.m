clear all
clc
global VERI;
global komsu;
%[0,0,0.014779321333850,0.124137340171327,0.544585024446482]    
fprintf('k-en yakin komsu algoritmasi ile siniflandirma yapabilirsiniz\n');
komsu_sayisi=3;%input('lutfen k-komsu sayisini giriniz:');
uzaklik_bagintisi_no=1;%input('uzaklik bagintisi seçiminde Oklit için 1, Manhattan için 2 veya Minkovski icin 3 tusuna basiniz:');

Verileri_Oku();
keySet = {'Very Low', 'Low', 'Middle', 'High'};
valueSet = [1 2 3 4];
dictionary = containers.Map(keySet,valueSet);
run = 25;
sonuclar= ones(1, run);
esik = 0.2;
for i=1:run
[bestSolution, sonuclar(i), iteration] = BMO(komsu_sayisi,5, 1000, VERI.Veri_Seti, VERI.Veri_Siniflari, VERI.Yeni_Veri, VERI.Yeni_Veri_Siniflari, dictionary);
end

%for i=1:length(bestSolution)
   %if  bestSolution(i) < esik
       %VERI.Veri_Seti(:,2);
   %end
%end

xlswrite("sonuc3.xls", sonuclar, "Hata degerleri");
% predicted_labels = zeros(1, length(VERI.Yeni_Veri));
% real_labels = zeros(1, length(VERI.Yeni_Veri));

% for i=1:length(VERI.Yeni_Veri)
%     real_labels(i) = dictionary(char(VERI.Yeni_Veri_Siniflari(i))); 
%    uzaklik_dizisi=Uzaklik_Hesapla(uzaklik_bagintisi_no,VERI.Veri_Seti,VERI.Yeni_Veri(i, :), agirlik_katsayilari);
%     [komsu]=Komsu_Bul(komsu_sayisi,uzaklik_dizisi,VERI.Veri_Siniflari);
%     [sinif]=Sinif_Bul();
%     predicted_labels(i) = dictionary(char(sinif.sinif));
%     mesaj='KLASIK k-NN YONTEMINE GORE SINIF TAHMINI';
%     %Yazdir(mesaj,sinif);
% end
% loss = LossFunction(predicted_labels, real_labels);

%[sinif_2]=Sinif_Bul_Agirlikli_Oylama();
%mesaj='AGIRLIKLI OYLAMA YONTEMINE GORE SINIF TAHMINI';
%Yazdir(mesaj,sinif_2);
