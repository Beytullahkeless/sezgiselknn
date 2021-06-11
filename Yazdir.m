function Yazdir(mesaj,etiket )
disp(mesaj);
global komsu;
    for i=1:length(komsu)
        fprintf('%d. komsu bilgileri\n',i);
        komsu_bilgileri=[' sinifi: ',komsu(i).sinif,' indeksi: ',komsu(i).indeks,'uzakligi:',komsu(i).uzaklik,'ters uzakligi:',komsu(i).ters_uzaklik];
        disp(komsu_bilgileri);
    end
  
disp('sonuç itibariyle verinin ait oldugu sinif ve diger bilgiler');
disp(etiket)

end

