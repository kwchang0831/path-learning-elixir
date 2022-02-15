# Basic

## Run

Get dependencies first

```shell
mix do deps.get
```

Run the specific exercise

```shell
mix run ./code/basic/00-HelloWorld.exs
```

## Contents

### **00-HelloWorld.exs**

### **01-ExUnit.exs**

### **02-List.exs**

### **02-List-Filter-Benchmark.exs**
  
Quick Summary:

```shell
Comparison:                  
Comprehension                30.90
Enum_Filter                  28.41 - 1.09x slower +2.84 ms
Enum_Filter_Map              20.67 - 1.50x slower +16.03 ms
Stream_Filter_ToList         13.34 - 2.32x slower +42.61 ms
Stream_Filter_Map            12.07 - 2.56x slower +50.48 ms
```
