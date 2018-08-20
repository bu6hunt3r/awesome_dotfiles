source ~/peda/peda.py

def init-pwngdb
        source ~/peda/peda.py
        source ~/Pwngdb/pwngdb.py
        source ~/Pwngdb/angelheap/gdbinit.py
        
        define hook-run
         	python
        	import angelheap
        	angelheap.init_angelheap()
       	end
end

def init-pwndbg
	source ~/pwndbg/gdbinit.py
end
