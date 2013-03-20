import java.util.concurrent.Callable
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.Future

def gp = System.getProperty('os.name').toLowerCase().contains('windows') ? 'C:\\cygwin\\usr\\local\\bin\\gp-2.6.exe' : 'gp'
def ExecutorService executor = Executors.newFixedThreadPool(10)
Collection<Future> futures = []

def etime = System.currentTimeMillis()

new File(".").eachFile {
    if (!(it.name in ['all.groovy', 'euler.groovy', 'euler.gp', 'map.gp'])) {
        if (it.name.endsWith('.groovy')) {
            futures << executor.submit({ File script ->
                StringWriter out = new StringWriter()
                GroovyShell shell = new GroovyShell();
                shell.setProperty('out', out);
                out.print("[GY] ${it.name[0..-8]} ==> ")
                long time = System.currentTimeMillis()
                shell.run(script)
                time = System.currentTimeMillis() - time
                if (time >= 1000) out.println("  |-- ${time.toString().padLeft(6, '_')} ms")
                return [
                    output: out.toString(),
                    time: time
                ]
            }.curry(it) as Callable<String>)
        } else if (it.name.endsWith('.gp')) {
            futures << executor.submit({ File script ->
                StringWriter out = new StringWriter()
                out.print("[GP] ${it.name[0..-4]} ==> ")
                long time = System.currentTimeMillis()
                try {
                    def proc = [gp, '-q', '-s', '30M', '-p', '2M', it.name].execute()
                    proc.waitFor()
                    def r = proc.inputStream.text ?: proc.errorStream.text
                    if (r) out.print(r) else out.print('ERROR\n')
                } catch (e) {
                    out.println e.message
                }
                time = System.currentTimeMillis() - time
                if (time >= 1000) out.println("  |-- ${time.toString().padLeft(6, '_')} ms")
                return [
                    output: out.toString(),
                    time: time
                ]
            }.curry(it) as Callable<String>)
        }
    }
}

long wtime = 0
futures.each {
    it.get().with {
        wtime += it.time as long;
        print(it.output)
    }
}
println("RUN: ${System.currentTimeMillis() - etime} ms | ALL: ${wtime} ms")
executor.shutdown()
