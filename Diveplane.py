seed = 1
data = []
probsum = 0

def init(idata, iseed=1):
	global data
	global probsum
	global seed
	for key in sorted(idata, key=int):
		intprob = int(idata[key] * 100)
		probsum += intprob
		for i in range(0,intprob):
			data.append(key)
	seed = iseed

def rand():
	rn = int(lcg() * probsum)
	return data[rn]

def lcg():
	modulus = (2**31)-1
	multiplier = 1103515245
	increment = 12345
	mask = 0x3FFFFFFF
	global seed

	seed = ( ( ( multiplier * seed ) + increment ) % modulus ) & mask

	return seed / float(((2**30)-1))

if __name__ == "__main__":
	#d = { 1:0.25, 2:0.5, 7:0.25 }
	import input
	init(input.d,123)
	for i in range(0,10000):
		print rand()
		#print lcg()
