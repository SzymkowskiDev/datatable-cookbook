library(data.table)

# Creating a data table
DT = data.table(
  ID = c("b","b","b","a","a","c"),
  a = 1:6,
  b = 7:12,
  c = 13:18
)

dt = data.frame(A = c(1, 2), B = c(2, 3))
DT_2 = data.table(dt)

DT_3 = fread("data.csv")

# is.data.table(DT_3)


# How to select rows (based on row numbers)?
DT[1,]
# ID a b  c
# 1:  b 1 7 13
DT[1:3,]
# ID a b  c
# 1:  b 1 7 13
# 2:  b 2 8 14
DT[c(1,6),]
# ID a  b  c
# 1:  b 1  7 13
# 2:  c 6 12 18

# How to select rows (based on values)?
DT[a==2,]
# ID a b  c
# 1:  b 2 8 14
DT[ID == 'a' | ID == 'c', ]
# ID a  b  c
# 1:  a 4 10 16
# 2:  a 5 11 17
# 3:  c 6 12 18
DT[a > 3, ]
# ID a  b  c
# 1:  a 4 10 16
# 2:  a 5 11 17
# 3:  c 6 12 18

# How to subset rows where values are not empty?
DT$d <- c(1, NA, 3, NA, 5, NA)
# ID a  b  c  d
# 1:  b 1  7 13  1
# 2:  b 2  8 14 NA
# 3:  b 3  9 15  3
# 4:  a 4 10 16 NA
# 5:  a 5 11 17  5
# 6:  c 6 12 18 NA
DT[!is.na(d), ]
# ID a  b  c d
# 1:  b 1  7 13 1
# 2:  b 3  9 15 3
# 3:  a 5 11 17 5

# How to subset rows where values are present in a vector of items?
test_vector <- c("b", "a")
DT[ID %in% test_vector]
# ID a  b  c  d
# 1:  b 1  7 13  1
# 2:  b 2  8 14 NA
# 3:  b 3  9 15  3
# 4:  a 4 10 16 NA
# 5:  a 5 11 17  5

# How to subsets rows where values match a regex pattern?
DT$r <- c("mark_spencer", "mark_joseph", "john_j", "john_q", "john_d", "john_k")
DT[r %like% "mark*",]
# ID a b  c  d            r
# 1:  b 1 7 13  1 mark_spencer
# 2:  b 2 8 14 NA  mark_joseph

DT[r %like% "j?hn*",]
# ID a  b  c  d           r
# 1:  b 2  8 14 NA mark_joseph
# 2:  b 3  9 15  3      john_j
# 3:  a 4 10 16 NA      john_q
# 4:  a 5 11 17  5      john_d
# 5:  c 6 12 18 NA      john_k

DT$n <- c("hot", "hat", "hit", "hot", "hat", "hit")
DT[n %like% "h[oa]t"]
# ID a  b  c  d            r   n
# 1:  b 1  7 13  1 mark_spencer hot
# 2:  b 2  8 14 NA  mark_joseph hat
# 3:  a 4 10 16 NA       john_q hot
# 4:  a 5 11 17  5       john_d hat

# How to select columns (based on number)?
DT[,1]
# ID
# 1:  b
# 2:  b
# 3:  b
# 4:  a
# 5:  a
# 6:  c
DT[,1:3]
# ID a  b
# 1:  b 1  7
# 2:  b 2  8
# 3:  b 3  9
# 4:  a 4 10
# 5:  a 5 11
# 6:  c 6 12
DT[, c(1, 7)]
# ID   n
# 1:  b hot
# 2:  b hat
# 3:  b hit
# 4:  a hot
# 5:  a hat
# 6:  c hit

# How to drop columns from a data.table?
DT[, -1]
# a  b  c  d            r   n
# 1: 1  7 13  1 mark_spencer hot
# 2: 2  8 14 NA  mark_joseph hat
# 3: 3  9 15  3       john_j hit
# 4: 4 10 16 NA       john_q hot
# 5: 5 11 17  5       john_d hat
# 6: 6 12 18 NA       john_k hit

# How to select columns by their names?
DT[, ID] # not like this
# This outputs values "b" "b" "b" "a" "a" "c"
is.data.table(DT[, ID])
# FALSE

DT[, .(ID)]
# This outputs a data.table
# ID
# 1:  b
# 2:  b
# 3:  b
# 4:  a
# 5:  a
# 6:  c
