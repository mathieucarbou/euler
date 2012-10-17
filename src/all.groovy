new File(".").eachFile {
    if (!(it.name in ['all.groovy', 'euler.groovy', 'euler.gp'])) {
        if (it.name.endsWith('.groovy')) {
            print("${it.name[0..-8]} ==> ")
            long time = System.currentTimeMillis()
            run(it)
            time = System.currentTimeMillis() - time
            if(time >= 1000) println("  (${time}ms)")
        } else if (it.name.endsWith('.gp')) {
            print("${it.name[0..-4]} ==> ")
            long time = System.currentTimeMillis()
            def proc = ['gp-2.6.exe', '-q', it.name].execute()
            proc.waitFor()
            time = System.currentTimeMillis() - time
            print (proc.inputStream.text ?: proc.errorStream.text)
            if(time >= 1000) println("  (${time}ms)")
        }
    }
}
