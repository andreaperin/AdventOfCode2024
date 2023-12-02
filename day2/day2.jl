using DataFrames
list = readlines("day2/puzzle2.txt")

game_regex = r"\d+(?=:)"
result_regex = r"(?<=\;)(.*?)(?=\;)"

blue_regex = r"\d+?(?= blue)"
red_regex = r"\d+?(?= red)"
green_regex = r"\d+?(?= green)"

# test = list[10]
# m=match(game_regex, test).match
# m=parse(Int, m)

function get_game(st::String)
    parse(Int,match(game_regex, st).match)
end
games = get_game.(list)

list2 = deepcopy(list)
function replace_colon(st::String)
    st = replace(st, ":" => ";")
    st * ";"
end

list2 = replace_colon.(list2)

function get_single_result(sub_st::String)
    res_data = Dict()
    try
        r = parse(Int, match(blue_regex, sub_st).match)
        res_data[:blue] = r
    catch 
        res_data[:blue] = 0
    end
    try
        r = parse(Int, match(red_regex, sub_st).match)
        res_data[:red] = r
    catch 
        res_data[:red] = 0

    end
    try
        r = parse(Int, match(green_regex, sub_st).match)
        res_data[:green] = r
    catch e
        res_data[:green] = 0
    end
    return res_data
end

function parse_result(st::String)
    m = collect(eachmatch(result_regex, st))
    res = map(x -> get_single_result(String(x.match)), m)
    return res
end

outputs = parse_result.(list2)

df = DataFrame(game = games, results = outputs)

p=df.results[40]

function ispossible_single(dict::Dict)
    if dict[:blue] > 14 || dict[:red] > 12 || dict[:green] > 13
        return false
    else
        return true
    end
end

function parse_ispossible(v_dict::Vector{Dict{Any, Any}})
    res = possible_single.(v_dict)
    return all(res)
end


# p = df.results[6]
# parse_ispossible(p)

imp_bit = parse_ispossible.(df.results)

df[!,:impossible] = imp_bit

filtered_df = filter(row -> row.impossible == true, df)

sum_res = sum(filtered_df.game)

@show(sum_res)


#### Part2

test = df.results[1]

function minimum_set(v_dict::Vector)
    b=maximum(map(x -> x[:blue], v_dict))
    r=maximum(map(x -> x[:red], v_dict))
    g=maximum(map(x -> x[:green], v_dict))
    return [b,r,g]
end

function power_set(v_dict::Vector)
    b = maximum(map(x -> x[:blue], v_dict))
    r = maximum(map(x -> x[:red], v_dict))
    g = maximum(map(x -> x[:green], v_dict))
    return b * r * g
end

df[!, :min_set] = minimum_set.(df.results)
df[!, :power_set] = power_set.(df.results)

res2 = sum(df.power_set)

@show(res2)