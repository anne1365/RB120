=begin
HTTP Discussion 9/9

On Chrome you can right click and Inpect the elements on the page. Within  the Inspect tool, navigate to the Network tab. 

OSI TCP/IP Models:
Mental models: russian doll, letter & mailman

What is HTTP? 
HyperText Transfer Protocol. It is a protocol at the application layer. Devices need a way to communicate and they need rules. These rules are called protocols. The method is important for the request and the status is important for the response. The browser (client) makes a request to the server and the server has a response. 

Default pathway: 

Parts of the URL:
https://reddit.com/search/?q=programming
  https = 
  reddit.com = hostname
  /search/ = path
  ?q=programming = query string
  ? = start of query string
  q = parameter name
  =programming = parameter value
  
HTTP Request/Response Cycle:
1. Type in URL
2. Browsers issues GET request to server
3. The server responds with the HTML
4. Client's browser will then render the HTML

Within an HTTP request:
Method: GET
Path: 
Cookies: a unique identifier that allows the server to simulate state. A cookie is a session id that's stored on the client's browser. 

What is state?
The web is inherently stateless. Each HTTP request is independent of the other. A cookie is stored in our browser and each time we make a request to the server, the server recognizes the user and sends the data from the most recent visit. 

LS171 Assessment Study Guide

Answer all of the questions with concise answers. Most require a one or two sentence answer.
Use appropriate terminology in your answers.
Use your own words. Copied-and-pasted answers make it difficult to determine how well you've internalized the content.

The Internet
Have a broad understanding of what the internet is and how it works
How do the first 3 layers enable 
Understand the characteristics of the physical network, such as latency and bandwidth
Have a basic understanding of how lower-level protocols operate
Know what an IP address is and what a port number is
Have an understanding of how DNS works
Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model

TCP & UDP
Have a clear understanding of the TCP and UDP protocols, their similarities and differences
Have a broad understanding of the three-way handshake and its purpose
Have a broad understanding of flow control and congestion avoidance

URLs
Be able to identify the components of a URL, including query strings
Be able to construct a valid URL
Have an understanding of what URL encoding is and when it might be used

HTTP and the Request/Response Cycle
Be able to explain what HTTP requests and responses are, and identify the components of each
Be able to describe the HTTP request/response cycle
Be able to explain what status codes are, and provide examples of different status code types
Understand what is meant by 'state' in the context of the web, and be able to explain some techniques that are used to simulate state
Explain the difference between GET and POST, and know when to choose each

Security
Have an understanding of various security risks that can affect HTTP, and be able to outline measures that can be used to mitigate against these risks
Be aware of the different services that TLS can provide, and have a broad understanding of each of those services

=end