import math

def sine_table_maker():
    sine_table = []
    i = 0
    while i < 128:
        sine_table.append(round(math.sin(math.radians((0.703125*i))) * 127))
        i += 1
    print(sine_table)


sine_table_maker()