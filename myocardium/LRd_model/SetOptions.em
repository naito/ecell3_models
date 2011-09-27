@{
StepInterval = 0.01  # (msec)

'''モデル中ので共有する値'''
'''cAMP0 (M)'''
cAMP0 = 2.939695632625512e-7

'''アボガドロ数'''
N_A = 6.0221367e+23

'''ファラデー定数（C/mmol）'''
F   = 96.4867

'''気体定数（mV/K/mmol）'''
R   = 8.3143

A_cap = 0.0001534

zNa = 1.0
zK  = 1.0
zCa = 2.0
zCl = -1.0

R_F = R / F

R_FzNa = R / F / zNa
R_FzK  = R / F / zK
R_FzCa = R / F / zCa
R_FzCl = R / F / zCl

FzNa_R = zNa * F / R
FzK_R  = zK  * F / R
FzCa_R = zCa * F / R
FzCl_R = zCl * F / R

# (/sec)
'''
_pA2J = 1.0e-15 * N_A / F
_pA2J_Na = 1.0e-15 * N_A / zNa / F
_pA2J_K  = 1.0e-15 * N_A / zK  / F
_pA2J_Ca = 1.0e-15 * N_A / zCa / F
_pA2J_Cl = 1.0e-15 * N_A / zCl / F

_C2mV = 1.0e-15 / N_A * F
'''

# (/msec)
_pA2J = 1.0e-18 * N_A / F
_pA2J_Na = 1.0e-18 * N_A / zNa / F
_pA2J_K  = 1.0e-18 * N_A / zK  / F
_pA2J_Ca = 1.0e-18 * N_A / zCa / F
_pA2J_Cl = 1.0e-18 * N_A / zCl / F

_C2mV = 1.0e-18 / N_A * F

'''モデル内パラメータ'''

}
