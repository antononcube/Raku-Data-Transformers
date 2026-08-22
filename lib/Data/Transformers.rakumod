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