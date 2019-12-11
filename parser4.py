my_input = open("derevo.ged", "r")
my_output = open("output.pl", "w")

base = {}

for line in my_input.readlines():
    words = line.split(" ")
    
    if len(words) >= 3:
        r1 = words[1]
        r2 = words[2]
        
        if r2[0] == "I":
            key = words[1]
            
        if r1 == "GIVN":
            name = words[2]
            
        if r1 == "SURN":
            surn = words[2]
            value = (name[:-1], surn[:-1])
            newElem = {key:value}
            base.update(newElem)

        if r1 == "HUSB":
            husb = words[2]
            
            for k, (a, b) in base.items():
                
                if k == husb[:-1]:
                    father = a + " " + b
                    
        if r1 == "WIFE":
            wife = words[2]
            
            for k, (a, b) in base.items():
                
                if k == wife[:-1]:
                    mother = a + " " + b
                    
        if r1 == "CHIL":
            chil = words[2]
            
            for k, (a, b) in base.items():
                
                if k == chil[:-1]:
                    child = a + " " + b
                    
            r = "parents(%r, %r, %r).\n" % (child, father, mother)
            my_output.write(r)

        if r1 == "SEX":
            if r2[:-1] == "F":
                r = "sex(%r, 'f').\n" % (name[:-1] + " " + surn[:-1])
                my_output.write(r)

            if r2[:-1] == "M":
                r = "sex(%r, 'm').\n" % (name[:-1] + " " + surn[:-1])
                my_output.write(r)     
my_input.close()
my_output.close()
