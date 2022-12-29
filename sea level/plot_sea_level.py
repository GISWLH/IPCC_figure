import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter, AutoMinorLocator

#set the font
font = {'size'   : 11}
plt.rc('font',family='Times New Roman')
plt.rcParams['ytick.right'] = plt.rcParams['ytick.labelright'] = True
plt.rcParams['ytick.left'] = plt.rcParams['ytick.labelleft'] = False

#read the data
in_file='./data/FAQ9.2_v5.0_data.xlsx'
df=pd.read_excel (in_file, sheet_name='time_series', header =0)

# set the color (obs, ssp85, ssp26, respectively)
color_palette=('#000000','#f48c61','#56acf8')

fig, ax = plt.subplots(1,1,figsize=(8,2))
unit=100 #100 for cm, 1 for m
i = 0 # color index
for type in df.type_data.unique():
	subset=df.loc[(df['type_data']==type)]
	ax.plot(subset.Year, subset.GMSL_m*unit, color=color_palette[i])
	ax.fill_between(subset.Year,subset.lower_m*unit, subset.upper_m*unit, alpha=0.2, color=color_palette[i])
	i += 1
# set the axis
ax.xaxis.set_minor_locator(MultipleLocator(10))
ax.xaxis.set_major_locator(MultipleLocator(20))
ax.yaxis.set_minor_locator(MultipleLocator(.25*unit))
ax.yaxis.set_major_locator(MultipleLocator(.5*unit))
ax.spines['top'].set_visible(False)
ax.spines['left'].set_visible(False)
plt.xlim([1970,2100])
plt.ylim([-0.02*unit, 1.1*unit])
plt.xlabel('Years')
plt.show()


