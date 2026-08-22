# Data::Transformers

Raku package with algorithms for transforming and smoothing data.

----

-----

## Installation

From Zef ecosystem:

```
zef install Data::Tranformers
```

From GitHub:

```
zef install https://github.com/antononcube/Raku-Data-Tranformers.git
```

----

## `array-pad` 

Pad the edges with 0s: 

```raku
use Data::Transformers;

array-pad([1,2,3], 1)
```

Specify different padding on each side:

```raku
array-pad(1..3, [2, 4])
```

Pad the edges of a matrix:

```raku
.say for array-pad([[1, 2], [3, 4]], 2)
```

Pad according to a named rule:

```raku
array-pad(1..3, 2, "Fixed")
```

Pad only on the right:

```raku
array-pad(1..3, [0, 2])
```

Remove elements from each edge of an array:

```raku
array-pad(1..10, -2)
```

This is equivalent to dropping the first two elements:

```raku
array-pad([1, 2, 3, 4], [-2, 0]);
```

This is equivalent to dropping the last two elements:

```raku
array-pad([1, 2, 3, 4], [0, -2]);
```

### Named rules

Pad by repeating periodically:

```raku
array-pad(1..6, 4, "Periodic")
```

```raku
array-pad(1..3, 4, "Periodic")
```

Pad with the reversal of the list:

```raku
array-pad(1..3, 4, "Reversed")
```

Pad with the negative of the reversal:

```raku
array-pad(1..3, 4, "ReversedNegation")
```

Pad by reflecting about the edge:

```raku
array-pad(1..3, 4, "Reflected")
```

----

## `center-array`

Create a list of length 5 with a single 1 at the center:

```raku
center-array(5)
```

Create a list of length 5 with the specified element at the center:

```raku
center-array('x', 5)
```

Place an element at the center of a 2D array:

```raku
.say for center-array('x', [5, 5])
```

Center a list in a 2D array:

```raku
.say for center-array(1..3, [5, 5])
```

The default padding is zero:

```raku
center-array([1, 2, 3], 6)
```

----

## `rescale`

Rescale to run from 0 to 1 over the range -10 to 10:

```raku
rescale(2.5, [-10, 10])
```

```raku
rescale(12.5, [-10, 10])
```

```raku
rescale(3, [-9, 7], [11, 28])
```

Complex number inputs:

```raku
rescale(1 + 2i, [0, 5])
```

```raku
rescale(1 + 2i, [0, 1 + 1i])
```

Rescale so that all the list elements run from 0 to 1:

```raku
rescale([-.7, .5, 1.2, 5.6, 1.8])
```

----

## `clip`

*Not implemented yet.*
