![data.table](https://github.com/SzymkowskiDev/datatable-cookbook/blob/master/data.table_logo.png?raw=true)

# data.table Cookbook 🥘📗
The data.table package converts the built-in R data frame into a more performant data object called data.table.
The data.table object achieves better performance in terms of:
* memory efficiency
* speed of operations

## Contents
Table of contents goes here (to be added later)

## 🎓 Learning Materials
* [Official docs](https://rdatatable.gitlab.io/data.table/)
* [GitHub repo](https://github.com/Rdatatable/data.table)
* [CRAN Vignette](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
* [CRAN](https://cran.r-project.org/web/packages/data.table/index.html)
* [CHEAT SHEET](https://github.com/SzymkowskiDev/datatable-cookbook/blob/master/datatable.pdf)
* [R Documentation](https://www.rdocumentation.org/packages/data.table/versions/1.14.2)

## 🚀 How to run
Open the cookbook.R file in IDE like R Studio.

## 📦 Packages

```R
library(data.table)
```

## 📝 How to create a data.table object?

You can create a data.table by supplying data.table() function with column=values like arguments.
```R
DT = data.table(
  ID = c("b","b","b","a","a","c"),
  a = 1:6,
  b = 7:12,
  c = 13:18
)
```

Or you can supply a data.frame to the data.table() funtion:
```R
dt = data.frame(A = c(1, 2), B = c(2, 3))
DT_2 = data.table(dt)
```
Similar outcome could be achived with functions setDT() and as.data.table().

Lastly, you can load a .CSV file with the help of fread() function:
```R
DT_3 = fread("data.csv")
```

## 📝 How to select rows (based on row numbers)?

* data.tables use the following square bracket notation: data_table[ROWS, COLUMNS].
* Hence, the first position refers to rows

```R
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
```

## 📝 How to select rows (based on values)?

* To subset rows based on values, one can supply logic to the first argument of the square bracket notation
* That logic can contain unqoted names of columns
* Inside the square brakcte notation pipie | means "or", while ampersand & mean "and"

```R
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
```

## 📝 How to subset rows where values are not empty?

* Use the combiination of negation ! and is.na() function:
```R
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
```

## 📝 How to subset rows where values are present in a vector of items?

* You can use the %in% operator inside the square brackets notation:
```R
test_vector <- c("b", "a")
DT[ID %in% test_vector]
# ID a  b  c  d
# 1:  b 1  7 13  1
# 2:  b 2  8 14 NA
# 3:  b 3  9 15  3
# 4:  a 4 10 16 NA
# 5:  a 5 11 17  5
```

## 📝 How to subsets rows where values match a regex pattern?

* You can accomplish the task with the help of %like% operator followed by a regex expression
```R
DT$r <- c("mark_spencer", "mark_joseph", "john_j", "john_q", "john_d", "john_k")
DT[r %like% "mark*", ]
# ID a b  c  d            r
# 1:  b 1 7 13  1 mark_spencer
# 2:  b 2 8 14 NA  mark_joseph
```
Bear in mind the following regex rules:
* regex expression is contained within quotation marks "regex_expression"
* The asterisk * means one or a number of charactres wildcard
* The underscore ? means a single character wildcard:
```R
DT[r %like% "j?hn*", ]
# ID a  b  c  d           r
# 1:  b 2  8 14 NA mark_joseph
# 2:  b 3  9 15  3      john_j
# 3:  a 4 10 16 NA      john_q
# 4:  a 5 11 17  5      john_d
# 5:  c 6 12 18 NA      john_k
```
* []	Represents any single character within the brackets:
```R
DT$n <- c("hot", "hat", "hit", "hot", "hat", "hit")
DT[n %like% "h[oa]t"]
# ID a  b  c  d            r   n
# 1:  b 1  7 13  1 mark_spencer hot
# 2:  b 2  8 14 NA  mark_joseph hat
# 3:  a 4 10 16 NA       john_q hot
# 4:  a 5 11 17  5       john_d hat
```


## 📝 How to select columns (based on number)?

* Simply supply indices to the second argument of the square brackets notation:
```R
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
```

## 📝 How to drop columns from a data.table?

* Prefix the j (column) index with the minus sign:
```R
DT[, -1]
# a  b  c  d            r   n
# 1: 1  7 13  1 mark_spencer hot
# 2: 2  8 14 NA  mark_joseph hat
# 3: 3  9 15  3       john_j hit
# 4: 4 10 16 NA       john_q hot
# 5: 5 11 17  5       john_d hat
# 6: 6 12 18 NA       john_k hit
```

## 📝 How to select columns by their names?

* You supply column names to the j index BUT inside .() otherwise output will not be a data.table:
```R
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
```

## 📧 Contact
[![](https://img.shields.io/twitter/url?label=/SzymkowskiDev&style=social&url=https%3A%2F%2Ftwitter.com%2FSzymkowskiDev)](https://twitter.com/SzymkowskiDev) [![](https://img.shields.io/twitter/url?label=/kamil-szymkowski/&logo=linkedin&logoColor=%230077B5&style=social&url=https%3A%2F%2Fwww.linkedin.com%2Fin%2Fkamil-szymkowski%2F)](https://www.linkedin.com/in/kamil-szymkowski/) [![](https://img.shields.io/twitter/url?label=@szymkowskidev&logo=medium&logoColor=%23292929&style=social&url=https%3A%2F%2Fmedium.com%2F%40szymkowskidev)](https://medium.com/@szymkowskidev) [![](https://img.shields.io/twitter/url?label=/SzymkowskiDev&logo=github&logoColor=%23292929&style=social&url=https%3A%2F%2Fgithub.com%2FSzymkowskiDev)](https://github.com/SzymkowskiDev)

## 📄 License
[MIT License](https://choosealicense.com/licenses/mit/) ©️ 2019-2020 [Kamil Szymkowski](https://github.com/SzymkowskiDev "Get in touch!")

[![](https://img.shields.io/badge/license-MIT-green?style=plastic)](https://choosealicense.com/licenses/mit/)





