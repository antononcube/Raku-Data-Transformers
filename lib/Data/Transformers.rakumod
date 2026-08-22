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