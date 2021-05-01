import sys
sys.path.append('../pyMOSChar')
import spice3read as s3r
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc

rc('text', usetex=True)
rc('font', family='serif')

from glob import glob
runs = glob('../sims/tsmc_bandgap_real_variation[0-9]*.raw')
simdata = []
for run in runs:
    simdata.append(s3r.read(run))

print('read in {} simulations'.format(len(simdata)))

times = [dat['time'][0] for dat in simdata]
maxtime = times[np.asarray([len(x) for x in times]).argmax()]

vdds = [dat['v(vdd)'][0][-1] for dat in simdata]
vbgs = [dat['v(vbg)'][0] for dat in simdata]
vbgs_interpd = [np.interp(maxtime, dat['time'][0], dat['v(vbg)'][0]) for dat in simdata]

final_vbgs = [dat[-1] for dat in vbgs]
mean_vbgs = np.mean(final_vbgs)
std_vbgs = np.std(final_vbgs)

print('Data from 40 Gaussian sims')
print('mean Vout = {} V'.format(mean_vbgs))
print('std dev Vout = {} V'.format(std_vbgs))

fig, ax = plt.subplots()
for i, vdd in enumerate(vdds):
    ax.plot(maxtime*1e6, vbgs_interpd[i])

ax.grid()
label=np.around(vdd, 3)
ax.set_title(r"Transient simulation (n = {})."
"\n"  
r"{} $\leq$ Vdd $\leq$ {}"
"\n"
r"$\mu$ = {} mV. $\sigma$ = {} mV".format(len(vdds), np.around(np.min(vdds), 4), np.around(np.max(vdds), 4), np.around(mean_vbgs*1e3,3), np.around(std_vbgs*1e3,3)))
ax.set_xlabel('Time (microseconds)')
ax.set_ylabel('Vout (V)')
plt.show()