# -*- coding: utf-8 -*-
"""
Created on Tue Apr  7 16:15:30 2020

@author: Ogün Can KAYA
"""

import numpy as np
import pandas as pd
import math
import datetime
# %%

airQualityDF= pd.read_excel("umraniye.xlsx")
ibbTrafficDF = pd.read_excel("trafik.xlsx")

# %% İBB TRAFİK SPLİT %% #
#ibbTrafficxDF  = pd.DataFrame([datetime.datetime.strptime(str(da),"%Y-%m-%d  %H:%M:%S") for da in ibbTrafficDF["Trafik İndeks Tarihi"]], columns =["Time"])
ibbTrafficDF["Day"] = [da.day for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Month"] = [da.month for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Year"] = [da.year for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Hour"] = [da.hour for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
ibbTrafficDF["Minute"] = [da.minute for da in ibbTrafficDF["Trafik İndeks Tarihi"]]
#ibbTrafficDF["İndeks"] = [da for da in ibbTrafficDF["Trafik İndeks"]]
# %%  AİR QUALİTY SPLİT %% #
airxDF  = pd.DataFrame([datetime.datetime.strptime(str(da),"%Y-%m-%d  %H:%M:%S") for da in airQualityDF["Tarih"]], columns =["Time"])
airxDF["Day"] = [da.day for da in airxDF["Time"]]
airxDF["Month"] = [da.month for da in airxDF["Time"]]
airxDF["Year"] = [da.year for da in airxDF["Time"]]
airxDF["Hour"] = [da.hour for da in airxDF["Time"]]
airxDF["Minute"] = [da.minute for da in airxDF["Time"]]
airxDF["Second"] = [da.second for da in airxDF["Time"]]
#%%
#airxDF["İndeks"] = [da for da in ibbTrafficDF["Trafik İndeks"]]

# %% Trafik İndex Mean Year-Day-Month-Hour
meanTrafficDF = datexDF  = pd.DataFrame([datetime.datetime.strptime(str(da),"%Y-%m-%d  %H:%M:%S") for da in ibbTrafficDF["Trafik İndeks Tarihi"]], columns =["Time"])
# %%
ibbTrafficDF["IndexMean"] = 0
# %% datexDF[(datexDF.Year== 2020) & (datexDF.Day== 4) & (datexDF.Month==2) & (datexDF.Hour==11)].İndeks.mean()
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
#                    y.append(ibbTrafficxDF[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4)].İndeks.mean())
#                    for i in (ibbTrafficxDF[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4)].index):
#                        print(i)
#                    for i in ibbTrafficxDF[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4)].İndeks.mean()
#                        ibbTrafficxDF.loc[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4), 'Deneme'] = ibbTrafficxDF[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4)].İndeks.mean()
#                    ibbTrafficxDF[(ibbTrafficxDF.Year== row1) & (ibbTrafficxDF.Day== row2) & (ibbTrafficxDF.Month==row3) & (ibbTrafficxDF.Hour==row4)].index
# %%
ibbTrafficDF.to_excel("trafficDF.xlsx",
             sheet_name='Sheet_name_1')  
# %%




                      
