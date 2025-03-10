get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)

add_flang_library(FortranLower
  Allocatable.cpp
  Bridge.cpp
  CallInterface.cpp
  Coarray.cpp
  ConvertCall.cpp
  ConvertConstant.cpp
  ConvertExpr.cpp
  ConvertExprToHLFIR.cpp
  ConvertType.cpp
  ConvertVariable.cpp
  ComponentPath.cpp
  CustomIntrinsicCall.cpp
  DumpEvaluateExpr.cpp
  HostAssociations.cpp
  IO.cpp
  IterationSpace.cpp
  LoweringOptions.cpp
  Mangler.cpp
  OpenACC.cpp
  OpenMP.cpp
  PFTBuilder.cpp
  Runtime.cpp
  SymbolMap.cpp
  VectorSubscripts.cpp

  DEPENDS
  FIRDialect
  FIRBuilder
  FIRSupport
  FIRTransforms
  HLFIRDialect
  ${dialect_libs}

  LINK_LIBS
  FIRDialect
  FIRBuilder
  FIRSupport
  FIRTransforms
  HLFIRDialect
  ${dialect_libs}
  FortranCommon
  FortranParser
  FortranEvaluate
  FortranSemantics
  MLIRAffineToStandard
  MLIRFuncDialect
  MLIRLLVMDialect
  MLIRSCFToControlFlow

  LINK_COMPONENTS
  Support
)
