import scipy.stats as st


p_high = (0.1, 0.9)
c_high = (0, 5)
soil_change_high = st.rv_discrete(values = (c_high, p_high))

print(soil_change_high.var())