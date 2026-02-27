# linked-list and array comparision
- linear datastructure made of nodes. (a node could be : data + pointer to next node)
- linked list is not contiguous (unlike arrays)
- insertion and deletion is more efficient (because in arrays, since it is contiguous if we remove a value from the middle 
	we have to shift the rightside elements to the left)
- BUT we can only access sequentially (but in arrays we can do random access using indices)
- dynamic resizing (unlike arrays, they are allocated as a whole)

- USE LL WHEN:
	- frequent insertion/deletion (cuz efficient)
	- dynamic size needed (cuz only pointers)
	- to implement stack, queue, graph 

# singly linked list
- head points to first node. 
- the pointers in each node point to next node
- final node's pointer has nullptr (value ku NULL ; pointers ku nullptr)

- class contains 
	- integer for data
	- pointer for next node (of datatype of node itself)

	- a constructor which takes argument of data
		- this->data = data;
		- this->next = nullptr;

	- 
