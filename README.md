# AstronomicalCoordinates.jl


Tools to handle astronomical coordinates, including celestial coordinates (equatorial, galactic, supergalactic, horizontal, etc), as well as geocoordinates, and time coordinates (e.g., LST, LAST, etc).

This code is still being tested, but most features seem to work (see `test/`). 
Some functions are cross-checked against Astropy.


### Usage

The usage relies heavily on Julia's `Base.convert`.
Everything is a specific type.

Coordinate transformations can be done as:
```
coordICRS = CoordinatesICRS(10., 30.)
coordEq = convert(CoordinatesEquatorial, coordICRS)
```
Time conversions follow the same logic:
```
utc = TimeUTC(DateTime(2010, 01, 01, 00, 00, 00))
gmst = convert(TimeGMST, utc)
```

### Performance

This design is certainly elegant, but I am not sure it is efficient.
It should be benchmarked against other packages.

### Disclaimer

This package is under development, the skeleton is in place but many of the implementations have not yet been tested.
Use it at your own risk!