
# 1.Basics_ R - With solutions


# Chunk 1  -------------------------------
# To write a comment, type # before the sentence you want to write.
# Anything to the right of a # in a script will be ignored by R.
# TIP: To comment on a whole paragraph, select the lines you want to comment and press at the same time on your keyboard (Ctrl) + (Shift) + (c).
# TIP: To run: Click anywhere on the line you want to run and either 1) click (Ctr)+(Enter) or 2) click on run bottom (up right corner of Source/Script)
               # If you want to run several lines, highlight them all and do as explained above.

# You can get output in the Console simply by typing math in the script and running it:
3+5
12/2

#  Assign values to objects
# (<-) assigns values on the right to objects on the left. 
# TIP: PC: Type (Alt) and (-) at the same time. Mac: (Option) and (-)

weight_kg <- 55    # doesn't print anything, but it has created an object. You can see it in the Environment window.
(weight_kg <- 55)  # Putting parenthesis around the call prints the value of `weight_kg`
weight_kg          # and so does typing (or "calling") the name of the object

# R iS cAsE SeNsItIvE!!
weight_KG # Error: object 'weight_KG' not found

# You can override an object. Be careful!
weight_kg <- 60 
weight_kg # If you call wight_kg you see that its value is now 60. You can also see this change in the Environment window.

## >> C.1.1.Exercise  ----
# Create an object (a vector) that is half the value of weight_kg (use weight_kg <- 60) called "half_weight_kg"
half_weight_kg <- weight_kg / 2
half_weight_kg
# You can give whichever name you want to an object, but it is a good idea to choose something that makes sense.
beautiful_day <- weight_kg / 2
beautiful_day
half_weight_kg
## FIN Exercise



# To concatenate two vectors (aka, to put them together) we use c()
both_weights<-c(weight_kg, half_weight_kg)
both_weights

mum <- "Claire"
dad<- "Pablo"
parents <- c(mum, dad)

## >> C.1.2.Exercise  ----
# Create a vector called "daughter" with a female's name and another one called "dog" with a dog's name
daughter <- "Anita"
dog <- "Poppy"
# Create a new vector called "family" with the names of all family members (use this order mum, dad, daugther, dog)
family <- c(parents, daughter, dog)
family
class(family)
c(mum, dad, daughter, dog)

family_char <- c("Claire", "Pablo" , "Anita",  "Poppy")
class(family_char)
## FIN Exercise

# VECTOR
a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
# Indexing a vector
c[2] # Extract second element of c
a[3] # Extract third element of a
a[1:3] # Extrat all elements between the first and the third elements, of a
b[c(1,3)] # Extract first and third element of b
# NOTE the differences in between vector c and command/function c. The choice of c as the name of a vector is a pretty bad one. See ?c or help(c)

## >> C.1.3.Exercise  ----
# Extract the first element of the vector family: the mum
family[1]
# Extract the forth element of the vector family: the dog
family[4]
# Extract both the name of the dad and the daughter (do it at the same time -using only one command-, if possible)
family[c(2,3)]
## FIN Exercise



# Chunk 2 -------------------------------

# DATA FRAME
Identification <- c(1,2,3,4)
Colors <- c("red", "white", "red", NA) # Note NA
Succeeded <- c(TRUE,TRUE,TRUE,FALSE)
mydata <- data.frame(Identification, Colors, Succeeded) # Join those vectors together to create a data.frame
mydata
names(mydata) <- c("ID","Color","Passed") # Change the variable/column names 
# Indexing a data.frame
mydata[ ,c(1:2)] # columns 1 and 2 of data frame. All rows
# Other ways to identify observations in a data.frame
mydata[,c("ID","Color")] # columns ID and Color from data frame
mydata$Passed # variable ID in the data frame
# The $ operator is used constantly. It retrieves/extracts a variable in a dataset.

## >> C.2.1. Exercise ----
# Create a data frame called family_df with two columns: name and age
# For column name, use the previous family vector
# For column age, make up ages for our family
family
age <- c(45, 48, 10, 7)
family_df <- data.frame(family, age)
family_df
names(family_df) <- c("name","age") # variable names 
family_df
## FIN Exercise


# MATRIX
# generates 5 x 4 numeric matrix 
nb_matrix<-matrix(data = 1:20, nrow=5,ncol=4)
nb_matrix

help(matrix)
?matrix
??matrix
?graph_from_data_frame
??graph_from_data_frame

# another example
cells <- c(1,26,24,68)
mymatrix <- matrix(data = cells, nrow=2, ncol=2, byrow=TRUE)
mymatrix

# Indexing a matrix (as we did with data.frames)
nb_matrix[,4] # 4th column of matrix

## >> C.2.2. Exercise ----
# Extract the 3rd row of nb_matrix 
nb_matrix[3,]
# Extract rows 2,3,4 of columns 1,2,3
nb_matrix[2:4,1:3]
nb_matrix[c(2,3,4), c(1,2,3)]
## FIN Exercise

# Chunk 3 -------------------------------

# LIST
# example of a list with 4 components - 
#a string, a numeric vector, a matrix, and a scalar 
mylist <- list(name=c("Fred", "Lola"), mynumbers=a, mymatrix=nb_matrix, age=5.3)
mylist

# Indexing a list
mylist[[2]] # 2nd component of the list
mylist[[2]][3] # Extract the third element of the 2nd component of the list
# Other ways to identify observations in a list
mylist[["mynumbers"]] # component named mynumbers in list
mylist[["mynumbers"]][3]


# FACTOR*. R treats factors as INTEGER vectors, where each integer corresponds to a category, or a level
# Variable gender with 20 "male" entries and 30 "female" entries 
gender <- c(rep("male",20), rep("female", 30)) 
gender
class(gender) # class is a function. It tells us what type of data we are dealing with
class(mylist)

gender <- factor(gender) 
gender
class(gender)
levels(gender) # R sorts levels alphabetically
# We can change the order of the levels of a factor by:
gender2 <- factor(gender, levels = c("male", "female"))
levels(gender2) 
# We can also change the levels names by renaming the factor labels:
gender3 <-factor(gender, labels = c("red", "yellow"))
levels(gender3)
# Note that it is very important to maintain the same order as the order of the factor levels!
# To avoid confusion, you can change the order of the levels AND the names of the labels at the same time:
gender4 <- factor(gender,
                  levels = c("male", "female"), # make male the first level
                  labels = c("hombre", "mujer")) # change label male by label hombre

str(gender) # STRUCTURE. original
str(gender2) # we changed the order of the levels
str(gender3) # we changed the label of the levels
str(gender4) # we changed both the order and the labels of the levels
# R now treats gender as a nominal variable 
summary(gender) 


# For an ordinal variable, we need to add the argument "ordered = TRUE"
quality_product <- c("G", "B", "Avg", "Avg", "Avg", "G", "B", "G", "G", "G") # G = good, Avg = average, B = bad
quality_product_f <- factor(quality_product, ordered = TRUE,
                            levels = c("B", "Avg", "G")) # Tell R that this is an ordered vector
quality_product_f # Note that B < Avg < G
str(quality_product_f)

# FUNCTIONS 
family_df
str(family_df) # structure
      # Wait a second... Why is family a Factor?!
      # ?data.frame

## >> PLAY ----
head(family_df, 2) # First 2 rows, all columns
head(family_df) # By default, head() gives you the first 6 rows, all columns. Our dataset only has 4 rows!
summary(family_df)
dim(family_df) # dimensions. Rows and columns

mean(family_df) # It doesn´t work. I need to specify a column
mean(family_df$age)
sum(family_df$age)

mean(age) # Why does this one work?
## FIN Exercise


# Chunk 4  -------------------------------
heights <- c(2, 4, 4, NA, 6)
str(heights)
summary(heights)

mean(heights) # ??
max(heights) # ??
mean(heights, na.rm = TRUE) # Remove NA for this arithmetic operation
max(heights, na.rm = TRUE)


# Do we have missing values?
is.na(heights)
summary(is.na(heights))

# identify location of NAs in vector
which(is.na(heights)) # Index, or location, 4 has an NA

# identify count of NAs in data frame
sum(is.na(heights)) # We only have one NA

# Extract those elements which are not missing values.
!is.na(heights)  # The operator `!` in R means NO. Thus, !is.na = those that are NOT missing values. Returns logical vector
heights[!is.na(heights)] # Extract all values from heights that are not missing values
heights[c(1,2,3,5)]

# Extract those elements which are complete cases (case=row). 
complete.cases(heights) # returns a logical vector indicating which cases are complete. 
heights[complete.cases(heights)]
# or subset with `!` operator to get incomplete cases.
!complete.cases(heights)
heights[!complete.cases(heights)]

## >> C.4.1. Exercise ----
# Create another column for family_df called profession where you give a 
# profession to each family member, except to the dog. Tip: *assign* a new *column*
family_df$profession <- c("researcher", "IT", "student", NA)
# Retrieve all cases in family_df that don't have NAs.
family_df[complete.cases(family_df), ]
## FIN Exercise



## >> PLAY ----
is.na(family_df)
is.na(family_df$name)
is.na(family_df$profession)
colSums(is.na(family_df)) # Compute the total missing values in each colum

        # New example. Recode missing values with the mean:
        x <- c(1:4, NA, 6:7, NA) # vector with missing data
        x
        is.na(x) # Does x have NAs? Yes
        which(is.na(x)) # NAs are in positions 5 and 8
        mean(x) # It doesn't work, why?
        mean(x, na.rm = TRUE) # Mean of x, without the NAs
        
        x[is.na(x)] # Extract positions 5 and 8 (the TRUE ones) of x
        x[is.na(x)] <- mean(x, na.rm = TRUE) # *assign* (<-) the mean of x to the cells where we have NA values in x
        x
        
        round(x, 1) # Round the values of x and give me only 1 decimal point
        x # x still has a lot of decimal points. Why?
## FIN Exercise
        
# Some people code NA as 99. If you feed these type of data to R, R won't know those are NAs.
# Example of a data frame that codes missing values as 99
df <- data.frame(col1 = c(1:3, 99), col2 = c(2.5, 4.2, 99, 3.2))
df
# change 99s to NAs
df[df == 99] <- NA # in the locations that df== 99, insert an NA
df

## >> C.4.2. Exercise ----
# Create another column for family_df called salary where you give a 
# salary to each family member, except to the dog.
family_df$salary <- c(1500, 1350, 23, NA)
# This family loves their dog and they dedicate 1% of their overall mean salary to him. 
# Recode the salary missing value of the dog with 0.01 of the mean of the family's salary.
family_df$salary[is.na(family_df$salary)] <- mean(family_df$salary, na.rm = TRUE) * 0.01
family_df
# Get incomplete cases with the `!` operator
family_df[!complete.cases(family_df),]
## FIN Exercise




# Other ocasions when R will return NA (or error, or warning):
var (8)                                  # Variance of one number
as.numeric (c("1", "2", "three", "4"))   # Illegal conversion
c(1, 2, 3)[4]                            # Vector subscript out of range                   
NA - 1                                   # Most operations on NAs produce NAs
a <- data.frame (a = 1:3, b = 2:4)
a[4,]                                    # Data frame row subscript out of range. # The first NA in the output is the row number
a[,4]                                    # Specifying a non-existent column just produces an error
