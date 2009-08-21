#' Is a year a leap year?
#'
#' If x is a recognized date-time object, leap.year will return whether x 
#' occurs during a leap year. If x is a number, leap.year returns whether it 
#' would be a leap year under the Gregorian calendar. 
#'
#' aliases leap.year leap_year leapyear
#' @param date a date-time object or a year 
#' @return TRUE if x is a leap year, FALSE otherwise
#' @keywords logic chron
#' @examples
#' x <- as.Date("2009-08-02")
#' leap.year(x) # FALSE
#' leap.year(2009) # FALSE
#' leap.year(2008) # TRUE
#' leap.year(1900) # FALSE
#' leap.year(2000) # TRUE
leap.year <- function(date) {
  recognized <- recognize(date)
  if (recognized)
    year <- year(date)
  else if (all(is.numeric(date)))
    year <- date
  else
    stop("unrecognized date format")
  (year %% 4 == 0) & ((year %% 100 != 0) | (year %% 400 == 0))
}

#' The current time 
#'
#' @param tzone a character vector specifying which time zone you would like 
#' the current time in. tzone defaults to the system time zone set on your 
#' computer.
#' @return the current date and time as a POSIXct object
#'
#' @keywords chron utilities
#' @examples
#' now()
#' now("GMT")
#' now() == now() # would be true if computer processed both at the same instant
#' now() < now() # TRUE
#' now() > now() # FALSE
now <- function(tzone = "") 
  with_tz(Sys.time(),tzone)


#' The current date 
#'
#' @param tzone a character vector specifying which time zone you would like to 
#' find the current date of. tzone defaults to the system time zone set on your 
#' computer.
#' @return the current date as a Date object
#'
#' @keywords chron utilities
#' @examples
#' today("")
#' today("GMT")
#' today("") == today("GMT") # not always true
#' today() < as.Date("2999-01-01") # TRUE  (so far)
today <- function(tzone ="") {
  timethere <- with_tz(Sys.time(),tzone)
  daythere <- floor_date(timethere, "day")
  as.Date(daythere)
}

#' Does date time occur in the am or pm?
#'
#' @aliases am pm
#' @param x a date-time object  
#' @return TRUE or FALSE depending on whethe x occurs in the am or pm 
#' @keywords chron 
#' @examples
#' x <- now()
#' am(x) 
#' pm(x) 
am <- function(x) hour(x) < 12
pm <- function(x) !am(x)


#' Get date-time in a different time zone
#' 
#' with_tz returns a date-time as it would appear in a different time zone.  
#' The actual moment of time measured does not change, just the time zone it is 
#' measured in.
#'
#' @param time a POSIXct, POSIXlt, Date, or chron date-time object.
#' @param tzone a character string containing the time zone to convert to. R must recognize the name contained in the string as a time zone on your system.
#' @return a POSIXct object in the updated time zone
#' @keywords chron manip
#' @seealso \code{link{replace_tz}}
#' @examples
#' x <- as.POSIXct("2009-08-07 00:00:00 CDT")
#' with_tz(x, "GMT")
#' # "2009-08-07 05:00:00 GMT"
with_tz <- function (time, tzone = "") 
  as.POSIXct(format(as.POSIXct(time), tz = tzone), tz = tzone)

#' 1970-01-01 GMT
#'
#' Origin is the date-time for 1970-01-01 GMT in POSIXct format. This date-time 
#' is the origin for the numbering system used by POSIXct, POSIXlt, chron, and 
#' Date classes.
#'
#' @keywords data chron
#' @examples
#' origin
#' # "1970-01-01 GMT"
origin <- with_tz(structure(0, class = c("POSIXt", "POSIXct")), "GMT")