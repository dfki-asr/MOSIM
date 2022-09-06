namespace java de.mosim.mmi.agent
namespace netstd MMIStandard
namespace py MMIStandard.agent
namespace cpp MMIStandard


struct MRDFGraph {
  1:string ContentType,
  2:string Graph
}

service MAJANService {
	string CreateAgent(1:string name, 2:string templateAgent, 3:MRDFGraph knowledge),
	bool DeleteAgent(1:string agentName),
	string ExecuteAgent(1:string agentName, 2:string endpoint, 3:MRDFGraph content),
  void ReceiveAsync(1:string actionID, 2:i32 answer)
}
