new File(".").eachFile {
    if (!(it.name in ['all.groovy', 'euler.groovy', 'euler.gp'])) {
        if (it.name.endsWith('.groovy')) {
            print("${it.name[0..-8]} ==> ")
            run(it)
        } else if (it.name.endsWith('.gp')) {
            print("${it.name[0..-4]} ==> ")
            def proc = ['gp-2.6.exe', '-q', it.name].execute()
            proc.waitFor()
            print (proc.inputStream.text ?: proc.errorStream.text)
        }
    }
}
