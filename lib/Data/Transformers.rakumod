use v6.d;

sub EXPORT {
    use Data::Transformers::Arrays;
    use Data::Transformers::Rescale;

    Map.new:
            '&array-pad' => &Data::Transformers::Arrays::array-pad,
            '&center-array' => &Data::Transformers::Arrays::center-array,
            '&rescale' => &Data::Transformers::Rescale::rescale,
            ;
}


unit module Data::Transformers;

use Data::TypeSystem::Predicates;
use Stats;

#==========================================================
# Accumulate
#==========================================================

our proto sub accumulate($data) is export {*}

multi sub accumulate(@data) {

    return do given @data {

        when $_.all ~~ Numeric:D { ([\+] @data).Array }

        when is-matrix($_) {
            my @res;
            for $_ -> @a {
                if @res {
                    @res.push((@res.tail <<+>> @a).Array)
                } else {
                    @res.push(@a.Array)
                }
            }
            return @res.Array
        }

        die {
            'The first argument is expected to be list of numbers or a list numeric lists.'
        }
    }
}

#==========================================================
# Standardize
#==========================================================

# Should the mean and standard deviation be calculated here or make a dependency on "Stats".

#| Standardize data (shift and rescale the elements of a list)
our proto sub standardize(@data, | --> Array:D) is export {*}

multi sub standardize(@data, $center = Whatever, $scale = Whatever --> Array:D) {
    return standardize(@data, :$center, :$scale)
}

multi sub standardize(
        @data where @data.all ~~ Numeric:D,
        :$center is copy = Whatever,
        :$scale is copy = Whatever --> Array:D) {

    $center = mean(@data) if $center.isa(Whatever);
    $center = $center(@data) if $center ~~ Callable:D;
    die 'The second argument ($center) is expected to be a number, a callable, or Whatever' unless $center ~~ Numeric:D;

    $scale = sd(@data) if $scale.isa(Whatever);
    $scale = $scale(@data) if $scale ~~ Callable:D;
    die 'The third argument ($scale) is expected to be a number, a callable, or Whatever' unless $scale ~~ Numeric:D;

    my @res = (@data <<->> $center) <</>> $scale;
    return @res
}

multi sub standardize(@data where @data.all ~~ Positional:D, :$center = Whatever, :$scale = Whatever --> Array:D) {
    # This assumes that we _just_ have a matrix of numbers.
    my @res = |zip(|@data».Array).map({ standardize($_, :$center, :$scale) });
    @res = |zip(|@res».Array);
    return @res;
}