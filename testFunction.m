function hata = testFunction(k, data,dataLabels, testData, testDataLabels, weights, dictionary)

    predicted_labels = zeros(1, length(testData));
    real_labels = zeros(1, length(testData));
    for i=1:length(testData)
        real_labels(i) = dictionary(char( testDataLabels(i))); 
        sinif = knn(k,data, dataLabels, testData(i, :), weights);
        predicted_labels(i) = dictionary(char(sinif.sinif));
        %mesaj='KLASIK k-NN YONTEMINE GORE SINIF TAHMINI';
        %Yazdir(mesaj,sinif); 
    end
    hata = LossFunction(predicted_labels, real_labels);
    hata = hata / length(real_labels) * 100;
end
%hata hesaplıyor