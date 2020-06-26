# -*- coding: utf-8 -*-
"""
Created on Tue Apr  7 16:15:30 2020

@author: Ogün Can KAYA
"""
import joblib
import numpy as np
import pandas as pd
import math
import matplotlib.pyplot as plt
import seaborn as sns
import datetime
# from sklearn.preprocessing import Imputer
import seaborn as seabornInstance 
from sklearn.model_selection import train_test_split 
from sklearn.linear_model import LinearRegression
from sklearn import metrics
import requests
from sklearn.preprocessing import LabelEncoder
# %%

airQualityDF= pd.read_excel("istanbul2.xlsx")

#%%
airQualityDF["Day"] = [da.day for da in airQualityDF["Tarih"]]
airQualityDF["Month"] = [da.month for da in airQualityDF["Tarih"]]
airQualityDF["Year"] = [da.year for da in airQualityDF["Tarih"]]
airQualityDF["Hour"] = [da.hour for da in airQualityDF["Tarih"]]
airQualityDF["Minute"] = [da.minute for da in airQualityDF["Tarih"]]
airQualityDF["Second"] = [da.second for da in airQualityDF["Tarih"]]
# %%
airQualityDF.fillna(0,inplace=True)
# %% İBB TRAFİK SPLİT %% #
ibbTrafficDF = pd.read_excel("trafficDF.xlsx")
ibbTrafficDF["Date"] = [str(da.date()) for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Day"] = [da.day for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Month"] = [da.month for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Year"] = [da.year for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Hour"] = [da.hour for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Minute"] = [da.minute for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
# %% Trafik İndex Mean Year-Day-Month-Hour
# %%

# %% datexDF[(datexDF.Year== 2020) & (datexDF.Day== 4) & (datexDF.Month==2) & (datexDF.Hour==11)].İndeks.mean()
def meanTrafficIndex():
    #Not run always / i did run one time and write trafficDF.xlsx file 
    ibbTrafficDF["IndexMean"] = 0
    for row1 in ibbTrafficDF.Year.unique():
        for row2 in ibbTrafficDF.Day.unique():
            for row3 in ibbTrafficDF.Month.unique():
                for row4 in ibbTrafficDF.Hour.unique():
                    x=ibbTrafficDF[(ibbTrafficDF.Year== row1) & (ibbTrafficDF.Day== row2) & (ibbTrafficDF.Month==row3) & (ibbTrafficDF.Hour==row4)]["Trafik İndeks"].mean()
                    if(math.isnan(x)):
                        pass
                    else:
                        for i in (ibbTrafficDF[(ibbTrafficDF.Year== row1) & (ibbTrafficDF.Day== row2) & (ibbTrafficDF.Month==row3) & (ibbTrafficDF.Hour==row4)].index):
                            ibbTrafficDF['IndexMean'][i] = x
# %%
def calculateAirQualityIndexSO2(so2):
    soi2=0
    if (so2>=0 and so2<=100):
     soi2= ((50-0)/(100-0))*(so2-0) + 0
    if (so2>=101 and so2<=250):
     soi2= ((100-51)/(250-101))*(so2-101) + 51
    if (so2>=251 and so2<=500):
     soi2= ((150-101)/(500-251))*(so2-251) + 101
    if (so2>=501 and so2<=850):
     soi2= ((200-151)/(850-501))*(so2-501) + 151
    if (so2>=851 and so2<=1100):
     soi2= ((300-201)/(1100-851))*(so2-851) + 201
    if (so2>=1101 and so2<= 1500):
     soi2= ((500-301)/(1500-1101))*(so2-1101) + 301
    
    return soi2
# %%
def calculateAirQualityIndexNo2(no2):
    noi2=0
    if (no2>=0 and no2<=100):
     noi2= ((50-0)/(100-0))*(no2-0) + 0
    if (no2>=101 and no2<=200):
     noi2= ((100-51)/(200-101))*(no2-101) + 51
    if (no2>=201 and no2<=500):
     noi2= ((150-101)/(500-201))*(no2-201) + 101
    if (no2>=501 and no2<=1000):
     noi2= ((200-151)/(1000-501))*(no2-501) + 151
    if (no2>=1001 and no2<=2000):
     noi2= ((300-201)/(2000-1001))*(no2-1001) + 201
    if (no2>=2001 and no2<= 3000):
     noi2= ((500-301)/(3000-2001))*(no2-2001) + 301
    return noi2
# %%
def calculateAirQualityIndexPM10(pm10):
    pm10i2=0
    if (pm10>=0 and pm10<=50):
     pm10i2= ((50-0)/(50-0))*(pm10-0) + 0
    if (pm10>=51 and pm10<=100):
     pm10i2= ((100-51)/(100-51))*(pm10-51) + 51
    if (pm10>=101 and pm10<=260):
     pm10i2= ((150-101)/(260-101))*(pm10-101) + 101
    if (pm10>=261 and pm10<=400):
     pm10i2= ((200-151)/(400-261))*(pm10-261) + 151
    if (pm10>=401 and pm10<=520):
     pm10i2= ((300-201)/(520-401))*(pm10-401) + 201
    if (pm10>=521 and pm10<= 620):
     pm10i2= ((500-301)/(620-521))*(pm10-521) + 301
    
    return pm10i2   
# %%
def calculateAirQualityIndexPM25(pm25):
    pm25i2=0
    if (pm25>=0 and pm25<=12):
     pm25i2= ((50-0)/(12-0))*(pm25-0) + 0
    if (pm25>=12.1 and pm25<=35.4):
     pm25i2= ((100-51)/(35.4-12.1))*(pm25-12.1) + 51
    if (pm25>=35.5 and pm25<=55.4):
     pm25i2= ((150-101)/(55.4-35.5))*(pm25-35.5) + 101
    if (pm25>=55.5 and pm25<=150.4):
     pm25i2= ((200-151)/(150.4-55.5))*(pm25-55.5) + 151
    if (pm25>=150.5 and pm25<=250.4):
     pm25i2= ((300-201)/(250.4-150.5))*(pm25-150.5) + 201
    if (pm25>=250.5 and pm25<= 350.4):
     pm25i2= ((400-301)/(350.4-250.5))*(pm25-250.5) + 301
    if (pm25>=350.5 and pm25<= 505.4):
     pm25i2= ((500-401)/(505.4-350.5))*(pm25-350.5) + 401
    return pm25i2      
# %%
def calculateAirQualityIndexCO(CO):
    coi2=0
    if (CO>=0 and CO<=5500):
     coi2= ((50-0)/(5500-0))*(CO-0) + 0
    if (CO>=5501 and CO<=10000):
     coi2= ((100-51)/(10000-5501))*(CO-5501) + 51
    if (CO>=10001 and CO<=16000):
     coi2= ((150-101)/(16000-10001))*(CO-10001) + 101
    if (CO>=16001 and CO<=24000):
     coi2= ((200-151)/(24000-16001))*(CO-16001) + 151
    if (CO>=24001 and CO<=32000):
     coi2= ((300-201)/(32000-24001))*(CO-24001) + 201
    if (CO>=32001 and CO<=40000):
     coi2= ((500-301)/(40000-32001))*(CO-32001) + 301
    return coi2  
# %%
def calculateAirQualityIndexO3(O3):
    o3i2=0
    if (O3>=0 and O3<=120):
     o3i2= ((50-0)/(120-0))*(O3-0) + 0
    if (O3>=121 and O3<=160):
     o3i2= ((100-51)/(160-121))*(O3-121) + 51
    if (O3>=161 and O3<=180):
     o3i2= ((150-101)/(180-161))*(O3-161) + 101
    if (O3>=181 and O3<=240):
     o3i2= ((200-151)/(240-181))*(O3-181) + 151
    if (O3>=241 and O3<=700):
     o3i2= ((300-201)/(700-241))*(O3-241) + 201
    if (O3>=701 and O3<=1700):
     o3i2= ((500-301)/(1700-701))*(O3-701) + 301
    return o3i2  
# %%
def calculateHKI():
    listPM10 = list(airQualityDF.filter(like='PM10').columns)
    listSO2 = list(airQualityDF.filter(like='SO2').columns)
    listNO2 = list(airQualityDF.filter(like='NO2').columns)
    listCO = list(airQualityDF.filter(like='CO').columns)
    listO3 = list(airQualityDF.filter(like='O3').columns)
    listPM25 = list(airQualityDF.filter(like='PM 2.5').columns)
    for pm10 in listPM10:
        airQualityDF["HKI"+pm10] = airQualityDF[pm10].apply(calculateAirQualityIndexPM10)
    for so2 in listSO2:
        airQualityDF["HKI"+so2] = airQualityDF[so2].apply(calculateAirQualityIndexSO2)
    for no2 in listNO2:
        airQualityDF["HKI"+no2] = airQualityDF[no2].apply(calculateAirQualityIndexNo2)
    for co in listCO:
        airQualityDF["HKI"+co] = airQualityDF[co].apply(calculateAirQualityIndexCO)
    for O3 in listO3:
        airQualityDF["HKI"+O3] = airQualityDF[O3].apply(calculateAirQualityIndexO3)
    for PM25 in listPM25:
        airQualityDF["HKI"+PM25] = airQualityDF[PM25].apply(calculateAirQualityIndexPM25)
calculateHKI()
# %%
def splitHKIValueAndValue(newList):
    listMaterialName=[]
    listHighValue = []
    for dongu in airQualityDF[newList].values:
        listMaterialName.append(newList[dongu.argmax()].split('-')[1])
        listHighValue.append(dongu.max())
    columnName = newList[0].split('HKI')[1].split('-')[0]
    columnType = columnName+'Type'
    airQualityDF['AQI-'+columnName] = listHighValue
    airQualityDF['AQI-'+columnType] = listMaterialName

#%%
def calculateGoodOrBadAir(listValues):
    hkiString=""
    
    for value in listValues:
        listHKIString=[]
        for hkiValues in airQualityDF[value]:
            if(hkiValues>=0 and hkiValues<=50):
                hkiString = 0
            if(hkiValues>=51 and hkiValues<=100):
                hkiString = 1
            if(hkiValues>=101 and hkiValues<=150):
                hkiString = 2
            if(hkiValues>=151 and hkiValues<=200):
                hkiString = 3
            if(hkiValues>=201 and hkiValues<=300):
                hkiString = 4
            if(hkiValues>=301 and hkiValues<=500):
                hkiString = 5
            listHKIString.append(hkiString)
        airQualityDF['HKIStr-'+value.split('-')[1]] = listHKIString
# %%
if __name__ == '__main__':
    # %%
    
    hkiKandilli = list(airQualityDF.filter(regex = 'HKIKandilli-').columns)
    hkiUskudar = list(airQualityDF.filter(regex = 'HKIÜsküdar-').columns)
    hkiSirinevler = list(airQualityDF.filter(regex = 'HKISirinevler-').columns)
    hkiMecidiyekoy = list(airQualityDF.filter(regex = 'HKIMecidiyekoy-').columns)
    hkiUmraniye =list(airQualityDF.filter(regex = 'HKIUmraniye-').columns)
    hkiBasaksehir = list(airQualityDF.filter(regex = 'HKIBasaksehir-').columns)
    hkiEsenyurt = list(airQualityDF.filter(regex = 'HKIEsenyurt-').columns)
    hkiSultanbeyli = list(airQualityDF.filter(regex = 'HKISultanbeyli-').columns)
    hkiKagithane = list(airQualityDF.filter(regex = 'HKIKagithane-').columns)
    hkiSultangazi = list(airQualityDF.filter(regex = 'HKISultangazi-').columns)
    hkiSilivri = list(airQualityDF.filter(regex = 'HKISilivri-').columns)
    hkiSile = list(airQualityDF.filter(regex = 'HKISile-').columns)

    splitHKIValueAndValue(hkiKandilli)
    splitHKIValueAndValue(hkiUskudar)
    splitHKIValueAndValue(hkiSirinevler)
    splitHKIValueAndValue(hkiMecidiyekoy)
    splitHKIValueAndValue(hkiUmraniye)
    splitHKIValueAndValue(hkiBasaksehir)
    splitHKIValueAndValue(hkiEsenyurt)
    splitHKIValueAndValue(hkiSultanbeyli)
    splitHKIValueAndValue(hkiKagithane)
    splitHKIValueAndValue(hkiSultangazi)
    splitHKIValueAndValue(hkiSilivri)
    splitHKIValueAndValue(hkiSile)
    # %%
    aqiList = list(airQualityDF.filter(regex = 'AQI-').columns)[::2]
    calculateGoodOrBadAir(aqiList)  
    ibbUniqueList = ibbTrafficDF['Date'].unique()
    for index, uniques in enumerate(ibbUniqueList):
        for date in ibbTrafficDF['Trafik İndeks Tarihi']:
            if(ibbUniqueList[index]==str(date.date())):
                print(date.date())
    
    #%%
    kandilliAllListColumnnName = list(airQualityDF.filter(regex = 'Kandilli').columns)
    kandilliAllListColumnns = (airQualityDF.filter(regex = 'Kandilli').values)
    kandilliAllList = pd.DataFrame(kandilliAllListColumnns, columns=kandilliAllListColumnnName)
    X = kandilliAllList.iloc[:, 8:14]
    y = kandilliAllList.iloc[:, 16]
    X_train, X_valid, y_train, y_valid = train_test_split(X, y, test_size=0.3, random_state=0)
    from keras.utils import to_categorical
    y_train = to_categorical(y_train)
    y_valid = to_categorical(y_valid)
    #%%
    nb_features = 6
    nb_classes = 4
    X_train = np.array(X_train).reshape(7810,6,1)
    X_valid = np.array(X_valid).reshape(3348,6,1)    

    #%%
    from tensorflow.keras.models import Sequential
    from tensorflow.keras.layers import LSTM, Dense, Activation, Dropout, Flatten, BatchNormalization, Conv1D, MaxPooling1D
    
    model=Sequential()
    # model.add(Conv1D(512,1,input_shape=(nb_features,1)))          
    # model.add(Activation("relu"))
    # model.add(MaxPooling1D(2))
    model.add(LSTM(512, input_shape=(nb_features,1)))
    model.add(Activation("relu"))
    model.add(BatchNormalization())
    model.add((Flatten()))
    model.add(Dropout(0.15))
    model.add(Dense(2048, activation="relu"))
    model.add(Dense(1024, activation="relu"))
    model.add(Dense(4, activation="softmax"))
    model.summary()
    model.compile(loss="categorical_crossentropy", optimizer ="adam", metrics = ["accuracy"])
    score = model.fit(X_train, y_train, epochs = 50, validation_data=(X_valid, y_valid))
    # %%
    import matplotlib.pyplot as plt
    plt.plot(score.history["acc"])
    plt.plot(score.history["val_acc"])
    plt.title("Model başarımları")
    plt.ylabel("Başarım")
    plt.xlabel("Epok sayısı")
    plt.legend(["Eğitim","Doğrulama"], loc="upper left")
    plt.show()
    #%%
    plt.plot(score.history["loss"],color="g")
    plt.plot(score.history["val_loss"],color="r")
    plt.title("Model Kayıpları")
    plt.ylabel("Kayıp")
    plt.xlabel("Epok sayısı")
    plt.legend(["Eğitim","Doğrulama"], loc="upper left")
    # %%
    #ortalama değerin verilmesi
    print(("Ortalama eğitim kaybı: ", np.mean(score.history["loss"])))
    print(("Ortalama Eğitim Başarımı: ", np.mean(score.history["acc"])))
    print(("Ortalama Doğrulama kaybı: ", np.mean(score.history["val_loss"])))
    print(("Ortalama Doğrulama Başarımı: ", np.mean(score.history["val_acc"])))
    
    # %%

#%%
    
    #%% Uskudar API
    r = requests.get('https://api.waqi.info/feed/@8159/?token=891351b0c50bf07574dddd0c24d86cd0fc37707a')
    json = r.json()
    apiUskudarCo = json['data']['iaqi']['co']['v']
    apiUskudarNo2 = json['data']['iaqi']['no2']['v']
    apiUskudarO3 = json['data']['iaqi']['o3']['v']
    apiUskudarPm10 = json['data']['iaqi']['pm10']['v']
    apiUskudarPm25 = json['data']['iaqi']['pm25']['v']
    apiUskudarSo2 = json['data']['iaqi']['so2']['v']
    addPm10 = calculateAirQualityIndexPM10(pd.Series([apiUskudarPm10])[0])   
    addCo = calculateAirQualityIndexCO(pd.Series([apiUskudarCo])[0])
    addNo2 = calculateAirQualityIndexNo2(pd.Series([apiUskudarNo2])[0])
    addO3 = calculateAirQualityIndexO3(pd.Series([apiUskudarO3])[0])
    # addPm25 = calculateAirQualityIndexPM25(pd.Series([apiUskudarPm25])[0])
    addSo2 = calculateAirQualityIndexSO2(pd.Series([apiUskudarSo2])[0])
    # %%
    predictList = [addPm10, addSo2, addNo2, addCo, addO3, 0]
    predictList = np.array(predictList)
    
    #%%
    x_input = predictList.reshape((1, 6, 1))
    yPredict = model.predict_classes(x_input)
    print(yPredict)
    
    ## 0 - İyi 
    ## 1 - Orta
    ## 2 - Hassas
    ## 3 - Sağlıksız
    ## 4 - Kötü
    ## 5 - Tehlikeli
#%%

    