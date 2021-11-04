# Logicle transformation operator

##### Description

`logicle_transform` operator performs a logicle transformation of
the data.

##### Usage

Input projection|.
---|---
`row`   | represents the variables (e.g. channels, markers, genes)
`col`   | represents the observations (e.g. cells, samples, indviduals) 
`y-axis`| measurement value


Input parameters|.
---|---
None.


Output relations|.
---|---
`transform`| numeric, per cell

##### Details

The operator is the `logicleTransform` function in from the flowCore
package available in R.

##### References

See the `flowCore::logicleTransform` function of the R package for more details.


