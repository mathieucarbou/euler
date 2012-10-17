import org.joda.time.LocalDate

def max = new LocalDate(2000, 12, 31), count = 0
for(LocalDate day = new LocalDate(1901, 1, 1); day.isBefore(max); day = day.plusMonths(1)) {
    if(day.dayOfWeek == 7) {
        //println "${day}"
        count++
    }
}
println count
