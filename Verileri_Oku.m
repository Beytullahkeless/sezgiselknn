function Verileri_Oku( )

global VERI
% VERI.Veri_Seti=[2,4;3,6;3,4;4,10;5,8;6,3;7,9;9,7;11,7;10,2];
% VERI.Veri_Siniflari={'KÖTÜ','ÝYÝ','ÝYÝ','KÖTÜ','KÖTÜ','ÝYÝ','ÝYÝ','KÖTÜ','KÖTÜ','KÖTÜ'};
% VERI.Yeni_Veri=[8,4];



training_data = readtable('veri_seti.xls', 'Sheet', 'Training_Data','range', 'A:F');
test_data = readtable('veri_seti.xls', 'Sheet', 'Test_Data','range', 'A:F');

VERI.Veri_Seti = training_data{:,1:5};
VERI.Veri_Siniflari = training_data{:,6}';
VERI.Yeni_Veri = test_data{:,1:5};
VERI.Yeni_Veri_Siniflari = test_data{:,6}';
end

