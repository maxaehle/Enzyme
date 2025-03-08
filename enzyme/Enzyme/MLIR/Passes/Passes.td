//===- Passes.td - Enzyme pass tablegen macros  ---------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef ENZYME_PASSES
#define ENZYME_PASSES

include "mlir/Pass/PassBase.td"

def DifferentiatePass : Pass<"enzyme"> {
  let summary = "Differentiate Passes";
  let dependentDialects = [
    "cf::ControlFlowDialect"
  ];
  let constructor = "mlir::enzyme::createDifferentiatePass()";
}

def PrintActivityAnalysisPass : Pass<"print-activity-analysis"> {
  let summary = "Print the results of activity analysis";
  let constructor = "mlir::enzyme::createPrintActivityAnalysisPass()";
  let options = [
    ListOption<
      /*C++ variable name=*/"funcsToAnalyze",
      /*CLI argument=*/"funcs",
      /*type=*/"std::string",
      /*description=*/"The names of the functions to perform activity analysis on"
    >,
    Option<
      /*C++ variable name=*/"verbose",
      /*CLI argument=*/"verbose",
      /*type=*/"bool",
      /*default=*/"false",
      /*description=*/"Print detailed activity information"
    >,
    Option<
      /*C++ variable name=*/"annotate",
      /*CLI argument=*/"annotate",
      /*type=*/"bool",
      /*default=*/"false",
      /*description=*/"Annotate every operation and value with its activity"
    >,
    Option<
      /*C++ variable name=*/"inactiveArgs",
      /*CLI argument=*/"inactive-args",
      /*type=*/"bool",
      /*default=*/"false",
      /*description=*/"Whether all arguments are assumed to be inactive"
    >,
    Option<
      /*C++ variable name=*/"duplicatedRet",
      /*CLI argument=*/"duplicated-ret",
      /*type=*/"bool",
      /*default=*/"false",
      /*description=*/"Whether the return is duplicated"
    >,
  ];
}

def PrintAliasAnalysisPass : Pass<"test-print-alias-analysis"> {
  let summary = "Print the results of alias analysis";
  let constructor = "mlir::enzyme::createPrintAliasAnalysisPass()";
}

def EnzymeOpsToMemRefPass : Pass<"convert-enzyme-to-memref"> {
  let summary = "Lower custom Enzyme ops to the MemRef dialect";
  let dependentDialects = [
    "memref::MemRefDialect",
    "arith::ArithDialect",
    "scf::SCFDialect",
    "cf::ControlFlowDialect",
  ];
  let constructor = "mlir::enzyme::createEnzymeToMemRefPass()";
}

def ShadowedGradientToCachePass : Pass<"convert-enzyme-shadowed-gradient-to-cache"> {
  let summary = "Convert Enzyme Shadowed Gradient to Cache Ops";
  let constructor = "mlir::enzyme::createShadowedGradientToCachePass()";
}

def AddToOpToIndexAndLoadPass : Pass<"add-to-op-to-index-and-load"> {
  let summary = "Convert AddTo op inside linalg generic to index and memref load/store DEPRECATED";
  let constructor = "mlir::enzyme::createAddToOpToIndexAndLoadPass()";
}

def AddToOpToSplitPass : Pass<"add-to-op-to-split"> {
  let summary = "Duplicate linalg.generic once for each output to remove enzyme.addTo op";
  let constructor = "mlir::enzyme::createAddToOpToSplitPass()";
}

def RemoveUnusedEnzymeOpsPass : Pass<"remove-unnecessary-enzyme-ops"> {
  let summary = "Remove Unnecessary Enzyme Ops";
  let constructor = "mlir::enzyme::createRemoveUnusedEnzymeOpsPass()";
}

def SimplifyMemrefCachePass : Pass<"simplify-memref-cache"> {
  let summary = "Rewrite all cache<memref<cache<...>>> to cache<memref<...>> if possible";
  let constructor = "mlir::enzyme::createSimplifyMemrefCachePass()";
}

#endif // ENZYME_PASSES
