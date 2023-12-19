source /share/tools/pwndbg/gdbinit.py

# Custom scripts
python
import string
def de_bruijn(length: int, alphabet, *, n: int = 4) -> str:
    k = len(alphabet)
    a = [0] * n * k
    sequence = []

    def db(t, p):
        if t > n:
            if n % p == 0:
                sequence.extend(a[1 : p + 1])
        else:
            a[t] = a[t - p]
            db(t + 1, p)
            for j in range(a[t - p] + 1, k):
                a[t] = j
                db(t + 1, t)

    db(1, 1)
    return "".join(alphabet[i] for i in sequence)[:length]

class CyclicString:
    def __init__(self, alphabet=string.ascii_uppercase + string.ascii_lowercase):
        self.alphabet = alphabet
        self.generated = ""

    def generate(self, length: int) -> str:
        if length <= len(self.generated):
            return self.generated
        self.generated = de_bruijn(length, self.alphabet)
        return self.generated

    def find(self, subseq: str) -> int:
        if any(c not in self.alphabet for c in subseq):
            return -1

        return self.generated.find(subseq)

cs = CyclicString()

def __pattc(length):
    print(cs.generate(length))

def __patto(substr):
    res = cs.find(substr)
    if res < 0:
        print('Not found')
    print(res)
end

define pattc
    python __pattc($arg0)
end

define patto
    python __patto($arg0)
end

# contextoutput regs /dev/null true
# contextoutput stack /dev/null true
# contextoutput disasm /dev/null true

set follow-fork-mode parent

# define hook-quit
#    shell tmux kill-window
#end

# python
# import atexit
# import os
# from pwndbg.commands.context import contextoutput, output, clear_screen
# bt_name, bt_tty = os.popen('tmux new-window -n "pwndbg" -P -F "#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
# # bt_name, bt_tty = os.popen('tmux split-window -P -F "#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
# st_name, st_tty = os.popen(F'tmux split-window -h -t {bt_name} -P -F "#{{pane_id}}:#{{pane_tty}}" -d "cat -"').read().strip().split(":")
# re_name, re_tty = os.popen(F'tmux split-window -h -t {st_name} -P -F "#{{pane_id}}:#{{pane_tty}}" -d "cat -"').read().strip().split(":")
# di_name, di_tty = os.popen('tmux split-window -h -P -F "#{pane_id}:#{pane_tty}" -d "cat -"').read().strip().split(":")
#
#
# contextoutput("backtrace", bt_tty, True)
# contextoutput("stack", st_tty, True)
# contextoutput("regs", re_tty, True)
# contextoutput("disasm", di_tty, True)
# contextoutput("legend", di_tty, True)
# contextoutput("ghidra", bt_tty, True)
#
# atexit.register(lambda: [os.popen(F"tmux kill-pane -t {name}").read() for name in (bt_name, st_name, re_name, di_name)])
# end
source /home/laika/.local/lib/python3.8/site-packages/voltron/entry.py
set debuginfod enabled on
