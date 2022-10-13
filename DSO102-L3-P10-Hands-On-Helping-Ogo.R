#Ogo's original code
#icesphereweights = c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)

#LHK only comments should start with #; updated code:
icesphereweights = c(0.96, 1.51, 2.17, 3.85, 4.45, 6.02)


#Ogo's original code
diam = function(icesphere) {2/2.54 * (icesphere /0.92 * 4/3 * pi) ^ 1/3}

#LHK:
  #There's a missing * between 2/2.54 and (icesphere – so that should actually be: 
    #2/2.54 * (icesphere
  #Fractions should always be in parenthesis so the PEMDAS math order works – 
    #so 4/3 should be (4/3)
  #we'll need a bunch more parenthesis ;)
    #The 1/3 will need to be in parenthesis, since it's a fraction: (1/3)
    #We'll need parenthesis around what that exponent is being applied to: 
      #(icesphere / 0.92 * (4/3) * pi)
    #And that whole calculation will need to be in parenthesis: 
      #((icesphere / 0.92 * (4/3) * pi) ^ (1/3)
#Updated code:
diam = function(icesphere) {(2/2.54) * ((icesphere / 0.92 * (4/3) * pi) ^ (1/3))}


#Ogo's original code
for (icesphere in icesphereweights){
  isd = diam(icesphere)
  cat(icesphere, "grams =", isd "diameter\n")
}

#LHK there's a missing comma between isd and "diameter\n"; updated code
for (icesphere in icesphereweights) {
  isd = diam(icesphere)
  cat(icesphere, "grams=", isd, "diameter\n")
}

#remove icesphereweights and icesphere
remove(icesphereweights)
remove(icesphere)