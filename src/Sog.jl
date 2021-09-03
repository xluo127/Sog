module Sog

export sog
"""
    sog(x)

The function `sog()` takes a `Vector` of any type `x` as its input with any possible length, and will return a `Bool Vector` with the same length as input. Values
 `true` or `false` in the output depends on whether one element in the `Vector` is the start of a group or not. The sog() will return 
 'nothing' if the length of input is 0. As any type can be applied in the input, be careful! To check whether two elements `a` and `b` are treated
as the same, please call `isequal(a, b)` to see the result. 

When taking `Vector` of `Vectors`, the length of output should the same as the length of every `Vector`, and what `sog()` do is to compare 
one element with the previous one on the same position for each `Vector`.

Examples:

    sog([1,2,2,2,1,3,3,1,1]) returns: [true, true, false, false, true, true, false, true, false]
    sog() returns: nothing
    sog(["a", "a", "a", 'a']) returns: [true, false, false, true]
    sog([[1, 1, 1, 2, 2], [1.5, 1.5, 20.0, 3.0, 3.0]] returns: [true, false, true, true, false]

"""
function sog(iVector=[], orders = eachindex(iVector))                       
    if iVector == []
        return nothing
    end

    len = length(iVector)
    #lenv = length(x[1])

    if typeof(iVector[1]) <: Vector{}           #For Vector of Vectors
        lenv = length(x[1])
        if lenv == 0
            return nothing 
        end    

        if lenv == 1
            return [true]
        end

        if lenv >= 2
            if length(eachindex(iVector)) != length(orders)
                println("Please specify the order of columns correctly! Number of columns is the length of order.")
                return nothing
            end
            oVector = ini0(iVector[orders[1]])
            for i in orders[2:end]
                oVector = zore_or_one(oVector, iVector[i])
            end
            return oVector
        end 
    
    elseif len == 1
        return [true]
    
    else
        oVector = ini0(iVector)
    end

    return oVector
end

function ini0(x1)
    len = length(x1)
    re = zeros(Bool, len)
    re[1] = 1
    for j in 2:len
        @inbounds re[j] = !(x1[j]===x1[j-1])
    end
    return re
end

function zore_or_one(re, xi)
    Threads.@threads for j in 2:length(re)
        @inbounds re[j] = re[j]==1 ? 1 : !(xi[j]===xi[j-1])
    end
    return re
end

end