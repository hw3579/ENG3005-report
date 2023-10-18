import matplotlib.pyplot as plt

# Provided data
x_c_odd = [1, 3, 5, 7, 9, 11]
pressure_coefficient_odd = [1.020044543, 0.819599109, 0.458797327, 0.23830735, 0.057906459, -0.102449889]

x_c_even = [2, 4, 6, 8, 10, 12]
pressure_coefficient_even = [-0.663697105, -0.643652561, -0.643652561, -0.683741648, -0.683741648, -0.703786192]

# Plotting the data
plt.figure(figsize=(10,6))
plt.plot(x_c_odd, pressure_coefficient_odd, marker='o', linestyle='-', color='b', label="Odd x/c")
plt.plot(x_c_odd, pressure_coefficient_even, marker='x', linestyle='--', color='r', label="Even x/c")
plt.title("Pressure Coefficient vs. Chord Fraction (x/c)")
plt.xlabel("x/c (Chord Fraction)")
plt.ylabel("Pressure Coefficient")
plt.ylim(max(pressure_coefficient_odd + pressure_coefficient_even), min(pressure_coefficient_odd + pressure_coefficient_even))
plt.legend()
plt.grid(True)
plt.show()
