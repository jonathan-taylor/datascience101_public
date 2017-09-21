import os

def Rscript():
    value = os.popen('which R').read().strip()
    if not value:
        raise ValueError('"which" could not find "R"')
    return value + 'script'
