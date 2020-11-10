# Implicit assumptions: input is
# 1) numeric vector, since round accepts only numeric
# 2) not NA / (missing values not allowed per default in test_count())
# 3) not empty
# 4) non-negative integerish (which is what test_count checks)
# 5) scalar, i.e. one single count 

################################################################################
## bad:
# count_them <- function(supposedly_a_count) {
#     if (!checkmate::test_count(supposedly_a_count)) {
#         warning(
#             "rounding ", supposedly_a_count,
#             " to the nearest integer."
#         )
#         supposedly_a_count <- round(supposedly_a_count)
#     }
#     supposedly_a_count
# }

################################################################################
# good:
count_them <- function(supposedly_a_count){
    require(checkmate)
    assert(
        check_numeric(supposedly_a_count, 
                         lower = 0L, # non-negative
                         null.ok = FALSE), # better readability than !check_null
        check_vector(supposedly_a_count,
                     min.len = 1L, # 'round()' needs at least 1 argument  
                     max.len = 1L), # input must be one count - not multiple
        combine = "and"
    )
    # 'round()' rounds to integer numbers but returns numeric object
    # transform to class integer as add-on
    if(!test_integerish(supposedly_a_count)) {
        return(as.integer(
            round(supposedly_a_count)
            )
        )
    } else 

}

count_them <- function(supposedly_a_count){
    require(checkmate)
    assert_count(supposedly_a_count)
    as.integer(round(supposedly_a_count))
}
count_them <- function(supposedly_a_count) {
    if (!checkmate::test_count(supposedly_a_count)) {
        warning(
            "rounding ", supposedly_a_count,
            " to the nearest integer."
        )
        supposedly_a_count <- round(supposedly_a_count)
    }
    supposedly_a_count
}

