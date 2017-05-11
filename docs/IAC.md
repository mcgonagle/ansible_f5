# Infrastructure as Code Principles, Practices, and Patterns

## Principles of Infrastructure as Code
  
* Modularity – Our services should be small and simple –think at the level of the simplest 
  Free-standing, useful component.

* Cooperation – Our design should discourage overlap of services, and should encourage other people and services to use our service in a way which fosters continuous improvement of our design and implementation.

* Composability – Our services should be like building blocks – we should be able to build complete, complex systems by integrating them.

* Extensibility – Our services should be asy to modify, enhance, and improve in response to new demands. 

* Flexibility – We should build our services using tools that provide unlimited power to ensure we have the (theoretical) ability to solve even the most complicate of problems. 

* Repeatability-Our services should produce the same results, in the same way, with the same inputs every time. 

* Declaration-We should specifiy our services in terms of what we want to do, not how we want to do it. 

* Abstraction – We should not worry about the details of the implementation, and think at the level of the component and its function. 

* Idempotence – Our service should only be configured when required – action should only be taken once.

* Convergence – Convergence our servers should take responsibility for their own state being in line with policy; over time, the overall system will tend to correctness. 

## Practices

* Repeatability – Because we’re building systems in a high level programming language, and committing our code, we start to become more confident that our systems are ordered and repeatable. With that same inputs, the same code should produce the same outputs. This means we can now be confident (and ensure on a regular basis) that what we believe will recreate our environment really will do that.
 
* Automation – We already have mature tools for deploying applications written in modern programming languages., and the very act of abstracting out infrastructures brings us the benefits of automation. 

* Agility – The discipline of source code management and version control means we have the ability to roll forwards or backwards to a known state. In the event of a problem, we can go to the commit logs and identify what changed and who changed it. This brings down the average time to fix problems and encourages root cause analysis. 

* Scalability – Repeatability plus automation makes scalability much easier, especially when combined with the rapid hardware provisioning that the cloud provides. 

* Reassurance – The fact that the architecture, design, and implementation of our infrastructure is modeled in code means we that we can automatically have documentation. Any programmer can look at the source code and see at a glance who the systems work. This is a welcome change from the common scenario in which only a s single sysadmin or architect holds the understanding of how the system hangs together. That is risky- this person is now able to hold the organization ransom, and should they leave or become ill, the company is endangered. 

* Disaster Recovery – In the event of a catastrophic event that wipes out the production systems, if your entire infrastructure has been broken down into modular components and described as code, recovery is as simple as provisioning new compute power, restoring from backup, and deploying the infrastructure and application code. What may have been a business ending event in the old paradigm of custom-built, partially automated infrastructure becomes a manageable few hour outage, potentially delivering competitive value over those organizations suffering from the same external influecnes, but without the power and flexibility brought about by infrastructure as code. 

## Patterns
* Design – Our infrastructure code should seek to be simple, iterative, and we should avoid feature creep

* Collective Ownership – All members of the team should be involved in the design and writing of infrastructure as code and, wherever possible, code should be written in pairs. 

* Code Review – The team should be set up in a such a way as to both pair frequently and to see regular notifications of when changes are made.

* Code Standards – Infrastructure code should follow the same community standards as the Ruby world, where standards and patterns have grown up around the configuration management framework, these should be adhered to.

* Refactoring – 

* Testing -
