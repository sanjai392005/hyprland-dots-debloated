- [intro to grpc](https://grpc.io/docs/what-is-grpc/introduction/)
- [concepts, architecture and lifecycle](https://grpc.io/docs/what-is-grpc/core-concepts/)

- is a rpc framework by google
- used to call methods on remote server as if it were local functions
- used for distributed applications and services

# overview
- gRPC is based around the idea of defining a service, specifying the methods that can be called remotely with their parameters and return types.
- server : 
	- implements this interface
	- runs server to handle client calls
- client:
	- stub: client-side object that acts as proxy for server
	- the proto requests and reponse from adn to the client goes via this stub

- the client and server can be written in any supported languages

# protocol buffers
- serialisation:
	-  serialization is the process of turning in memory objects in a program into something that can be written to a disk/transferrable.
	-  deserialization is then the process of parsing that file contents into something the program can understand & use
	-  for example, saving a game state and details (ie a structured data) as a JSON. or storing a image as a JPG

- protocol buffer is a tool used to serialise structured data
- its an alternative to JSON
- JSON is used to serialise into a text-based format to transmit it
- proto is used to serialise into a binary to transmit it

## steps:
1. creating a text file with .proto extension
2. data is structured as "messages"
	- its basically a Structure that is a schema (format) for the object we are about to serialise

	-   ```
	    message Person {
	      string name = 1;
	      int32 id = 2;
	      bool has_ponycopter = 3;
	    }
		``` 

3. use the protoc compiler on the .proto file
	- this will automatically write the boilerplate class that has methods to:
		-  access the fields in the message
		- serialise and deserialise the message
	
4. write the "services"
	- the methods that the client can call along with the message used for those calls.
	 (methods that the client uses that does stuff with the "message")

	- ```
		service Greeter {
		  rpc SayHello (HelloRequest) returns (HelloReply) {} // this grpc service uses HelloReq and Reply messages
		}
		
		message HelloRequest {
		  string name = 1;
		}
		
		message HelloReply {
		  string message = 1;
		}
	  ```
