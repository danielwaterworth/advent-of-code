ids = list(map(lambda x: int(x.replace("B", "1").replace("F", "0").replace("L", "0").replace("R", "1"), 2), data))
ids.sort()
highest = ids[-1]
lowest = ids[0]
my_id = set(range(lowest, highest)) - set(ids)
