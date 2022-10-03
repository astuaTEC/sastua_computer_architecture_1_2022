# How to do the modulo operation in ARM assembly?

```
a = a + b;
c = a % 8;
```

In this particular case, when doing modulo for 8, if the values can be assumed to be nonnegative, you can do the % 8 part as & 7. In that case, the assembly for your case would be: 

```
add rA, rA, rB
and rC, rA, #7
```

https://stackoverflow.com/questions/42938673/how-to-do-the-modulo-operation-in-arm-assembly