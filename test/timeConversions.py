import numpy as np
from datetime import datetime
from astropy import units as u
from astropy.time import Time
from astropy.coordinates import EarthLocation


# definitions
t1 = Time('2010-01-01 00:00:00', scale = 'utc')
t2 = Time('1987-08-23 10:25:00', scale = 'ut1')
location = EarthLocation(lat = 51.5 * u.deg, lon = 0.01 * u.deg)
tl1 = Time(t1, location = location)
tl2 = Time(t2, location = location)

# conversions
t1_jd = t1.jd
t2_jd = t2.jd
t1_mjd = t1.mjd
t2_mjd = t2.mjd
t1_ut1 = t1.ut1
t2_ut1 = t2.ut1
t1_utc = t1.utc
t2_utc = t2.utc
t1_lmst = tl1.sidereal_time('mean')
t2_lmst = tl2.sidereal_time('mean')
t1_last = tl1.sidereal_time('apparent')
t2_last = tl2.sidereal_time('apparent')
t1_gmst = tl1.sidereal_time('mean', 'greenwich')
t2_gmst = tl2.sidereal_time('mean', 'greenwich')
t1_gast = tl1.sidereal_time('apparent', 'greenwich')
t2_gast = tl2.sidereal_time('apparent', 'greenwich')



# printing conversions
print('==> t1 = ', t1)
print('  . t1 UTC = ', t1_utc)
print('  . t1 UT1 = ', t1_ut1)
print('  . t1 JD = ', t1_jd)
print('  . t1 MJD = ', t1_mjd)
print('  . t1 LMST = ', t1_lmst)
print('  . t1 LAST = ', t1_last)
print('  . t1 GMST = ', t1_gmst)
print('  . t1 GAST = ', t1_gast)

print('==> t2 = ', t2)
print('  . t2 UTC = ', t2_utc)
print('  . t2 UT1 = ', t2_ut1)
print('  . t2 JD = ', t2_jd)
print('  . t2 MJD = ', t2_mjd)
print('  . t2 LMST = ', t2_lmst)
print('  . t2 LAST = ', t2_last)
print('  . t2 GMST = ', t2_gmst)
print('  . t2 GAST = ', t2_gast)