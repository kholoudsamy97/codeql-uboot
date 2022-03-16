/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
  // TODO: copy from previous step
  NetworkByteSwap () {
    // TODO: replace <class> and <var>
    exists( MacroInvocation m |
      m.getMacroName().regexpMatch("ntohs|ntohl|ntohll") |
      this = m.getExpr()
    )
  }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    // TODO
    source.asExpr() instanceof NetworkByteSwap 
  }
  override predicate isSink(DataFlow::Node sink) {
    // TODO
   exists(FunctionCall fc |fc.getTarget().getName() = "memcpy"  | 
   fc.getArgument(2) = sink.asExpr())
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
