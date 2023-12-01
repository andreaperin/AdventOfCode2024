list = readlines("day1/puzzle1.txt")
ll = map(x -> filter(isdigit, collect(x))[1] * filter(isdigit, collect(x))[end], list)
ll2 = parse.(Int, ll)
res = sum(ll2)

@show(res)

values_mapping = [
    "twone" => 21,
    "eightwo" => 82,
    "eighthree" => 83,
    "oneight" => 18,
    "threeigth" => 38,
    "fiveight" => 58,
    "nineight" => 98,
    "sevenine" => 79,
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9
]

list2 = deepcopy(list)

function _replace_composed(st::String)
    for i in values_mapping
        st = replace(st, i)
    end
    return st
end

list2 = _replace_num.(list2)

ll = map(x -> filter(isdigit, collect(x))[1] * filter(isdigit, collect(x))[end], list2)
ll = parse.(Int, ll)
res = sum(ll)

@show(res)