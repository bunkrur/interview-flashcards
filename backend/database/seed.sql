-- Seed data for flashcard application

-- Insert categories (excluding React and JavaScript as requested)
INSERT INTO categories (name, slug, description, color, icon) VALUES
    ('Linux Commands', 'linux-commands', 'Essential Linux/Unix command line operations and utilities', '#FFA500', '🐧'),
    ('Git', 'git', 'Version control commands, workflows, and best practices', '#F05032', '📚'),
    ('Kubernetes', 'kubernetes', 'Container orchestration concepts, kubectl commands, and architecture', '#326CE5', '☸️'),
    ('ArgoCD', 'argocd', 'GitOps continuous delivery tool for Kubernetes', '#EF7B4D', '🚀'),
    ('Docker', 'docker', 'Containerization concepts, Docker commands, and best practices', '#2496ED', '🐳'),
    ('Computer Science', 'computer-science', 'Algorithms, data structures, time complexity, and fundamentals', '#9B59B6', '🎓'),
    ('SRE & Observability', 'sre-observability', 'Site Reliability Engineering, monitoring, logging, and metrics', '#E74C3C', '📊'),
    ('Networking', 'networking', 'Network protocols, concepts, and troubleshooting', '#16A085', '🌐'),
    ('SQL', 'sql', 'Database queries, optimization, and design patterns', '#00758F', '🗄️'),
    ('System Design', 'system-design', 'Architecture patterns, scalability, and design trade-offs', '#34495E', '🏗️');

-- Sample flashcards for Linux Commands
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (1, 'What command lists all files including hidden ones?', 'ls -la', 'easy', 'The -l flag provides long format with details, -a shows all files including hidden ones (starting with .)'),
    (1, 'How do you find all files modified in the last 7 days?', 'find . -mtime -7', 'medium', 'The find command with -mtime -7 searches for files modified within the last 7 days. Use +7 for files older than 7 days.'),
    (1, 'What command shows the last 50 lines of a log file and follows new additions?', 'tail -n 50 -f logfile.log', 'medium', 'tail -n 50 shows last 50 lines, -f (follow) mode continues to output new lines as they are added to the file.'),
    (1, 'How do you check disk usage of all directories in human-readable format?', 'du -h --max-depth=1', 'easy', 'du (disk usage) with -h flag shows human-readable sizes (KB, MB, GB), --max-depth=1 limits to immediate subdirectories.'),
    (1, 'What command searches for a pattern recursively in all files?', 'grep -r "pattern" .', 'easy', 'grep with -r flag searches recursively through all subdirectories from the current location (.)');

-- Sample flashcards for Git
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (2, 'How do you undo the last commit but keep the changes?', 'git reset --soft HEAD~1', 'medium', '--soft keeps changes staged, HEAD~1 refers to one commit before HEAD. Use --mixed to unstage or --hard to discard changes.'),
    (2, 'What command shows the commit history in a compact one-line format?', 'git log --oneline', 'easy', '--oneline flag shows abbreviated commit hash and message on a single line. Add --graph for visual branch structure.'),
    (2, 'How do you rebase your current branch onto main?', 'git rebase main', 'medium', 'Rebasing replays your commits on top of main branch. Use git rebase --continue after resolving conflicts.'),
    (2, 'What command shows which commit and author last modified each line of a file?', 'git blame filename', 'easy', 'git blame annotates each line with the commit hash, author, and timestamp of the last modification.'),
    (2, 'How do you create and switch to a new branch in one command?', 'git checkout -b branch-name', 'easy', 'The -b flag creates a new branch and switches to it. In Git 2.23+, you can also use: git switch -c branch-name');

-- Sample flashcards for Kubernetes
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (3, 'What command gets all pods in all namespaces?', 'kubectl get pods --all-namespaces', 'easy', 'or use -A as shorthand: kubectl get pods -A. This shows pods across all namespaces in your cluster.'),
    (3, 'How do you scale a deployment to 5 replicas?', 'kubectl scale deployment/my-deployment --replicas=5', 'easy', 'The scale command adjusts the number of pod replicas. Changes take effect immediately.'),
    (3, 'What is a Pod in Kubernetes?', 'The smallest deployable unit that can contain one or more containers', 'easy', 'Pods share network namespace and storage volumes. They are ephemeral and typically managed by higher-level controllers.'),
    (3, 'How do you view logs from a specific pod?', 'kubectl logs pod-name', 'easy', 'Add -f to follow logs in real-time. Use -c container-name for multi-container pods. --previous shows logs from crashed containers.'),
    (3, 'What command describes detailed information about a resource?', 'kubectl describe <resource-type> <resource-name>', 'easy', 'describe shows detailed info including events. Example: kubectl describe pod my-pod-123');

-- Sample flashcards for ArgoCD
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (4, 'What is GitOps?', 'A deployment methodology where Git serves as the single source of truth for declarative infrastructure and applications', 'easy', 'Changes are made via Git commits, and automated processes sync the desired state to the cluster.'),
    (4, 'How do you sync an ArgoCD application from the CLI?', 'argocd app sync <app-name>', 'easy', 'Sync triggers ArgoCD to apply the latest Git state to the cluster. Add --force for hard refresh.'),
    (4, 'What are the three main sync strategies in ArgoCD?', 'Manual, Automatic, and Automated with self-heal', 'medium', 'Manual requires explicit sync, Automatic syncs on Git changes, Self-heal also reverts manual cluster changes.'),
    (4, 'How do you view the sync status of all applications?', 'argocd app list', 'easy', 'Lists all applications with their sync status, health status, and repository details.'),
    (4, 'What is the purpose of an ArgoCD Application resource?', 'It defines the relationship between a Git repository and a Kubernetes cluster destination', 'medium', 'Applications specify source repo, target cluster, sync policy, and which manifests to deploy.');

-- Sample flashcards for Docker
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (5, 'What command builds a Docker image from a Dockerfile?', 'docker build -t image-name:tag .', 'easy', '-t tags the image with a name and optional version tag. The . specifies build context (current directory).'),
    (5, 'How do you run a container in detached mode with port mapping?', 'docker run -d -p 8080:80 image-name', 'easy', '-d runs in background (detached), -p maps host port 8080 to container port 80.'),
    (5, 'What is the difference between CMD and ENTRYPOINT in Dockerfile?', 'ENTRYPOINT sets the main command that always runs, CMD provides default arguments that can be overridden', 'medium', 'ENTRYPOINT + CMD together allow flexible container execution. ENTRYPOINT rarely changes, CMD provides defaults.'),
    (5, 'How do you view logs from a running container?', 'docker logs container-id', 'easy', 'Add -f to follow logs in real-time, --tail N to show last N lines, --since to filter by timestamp.'),
    (5, 'What command removes all stopped containers?', 'docker container prune', 'easy', 'Prune commands clean up unused resources. Add -a to remove all unused containers, not just stopped ones.');

-- Sample flashcards for Computer Science
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (6, 'What is the time complexity of binary search?', 'O(log n)', 'easy', 'Binary search halves the search space each iteration, resulting in logarithmic time complexity.'),
    (6, 'What is a hash table collision?', 'When two different keys hash to the same index in the hash table', 'easy', 'Common resolution strategies include chaining (linked lists) and open addressing (probing).'),
    (6, 'What is the difference between a stack and a queue?', 'Stack is LIFO (Last In First Out), Queue is FIFO (First In First Out)', 'easy', 'Stack operations: push/pop from top. Queue operations: enqueue at rear, dequeue from front.'),
    (6, 'What is Big O notation?', 'A mathematical notation describing the upper bound of an algorithm''s time or space complexity', 'easy', 'It describes worst-case performance as input size grows. Common: O(1), O(log n), O(n), O(n²), O(2ⁿ).'),
    (6, 'What is the difference between depth-first and breadth-first search?', 'DFS explores as far as possible along each branch before backtracking; BFS explores all neighbors before moving to next level', 'medium', 'DFS uses a stack (or recursion), BFS uses a queue. Different use cases: DFS for paths, BFS for shortest paths.');

-- Sample flashcards for SRE & Observability
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (7, 'What are the three pillars of observability?', 'Logs, Metrics, and Traces', 'easy', 'Logs provide detailed event records, Metrics show aggregated measurements, Traces track requests across services.'),
    (7, 'What is an SLI (Service Level Indicator)?', 'A quantitative measure of a service''s behavior, such as request latency or error rate', 'medium', 'SLIs are the raw measurements used to calculate SLOs. Examples: 95th percentile latency, success rate.'),
    (7, 'What is the difference between SLO and SLA?', 'SLO is an internal target for service performance; SLA is a contractual agreement with consequences', 'medium', 'SLO (Service Level Objective) sets internal goals. SLA (Service Level Agreement) has legal/financial penalties.'),
    (7, 'What is an error budget?', 'The allowed amount of downtime or errors before violating an SLO', 'medium', 'Calculated as (1 - SLO). For 99.9% SLO, error budget is 0.1%, allowing ~43 min downtime/month.'),
    (7, 'What is the RED method for monitoring microservices?', 'Rate, Errors, and Duration', 'medium', 'Rate: requests per second. Errors: failed requests per second. Duration: response time distribution.');

-- Sample flashcards for Networking
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (8, 'What is the difference between TCP and UDP?', 'TCP is connection-oriented and reliable; UDP is connectionless and faster but unreliable', 'easy', 'TCP guarantees delivery with error checking and retransmission. UDP is used for speed-critical applications like video streaming.'),
    (8, 'What does DNS do?', 'Domain Name System translates human-readable domain names to IP addresses', 'easy', 'DNS is a distributed hierarchical system. Queries typically use UDP port 53. Results are often cached.'),
    (8, 'What are the layers of the OSI model?', 'Physical, Data Link, Network, Transport, Session, Presentation, Application', 'medium', 'Mnemonic: "Please Do Not Throw Sausage Pizza Away". Each layer has specific protocols and responsibilities.'),
    (8, 'What is a subnet mask?', 'A 32-bit number that divides an IP address into network and host portions', 'medium', 'Example: 255.255.255.0 (/24) means first 24 bits are network, last 8 bits are host addresses.'),
    (8, 'What is the purpose of the ARP protocol?', 'Address Resolution Protocol maps IP addresses to MAC addresses on a local network', 'medium', 'ARP allows devices to discover the physical address (MAC) associated with an IP address on the same network segment.');

-- Sample flashcards for SQL
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (9, 'What is the difference between INNER JOIN and LEFT JOIN?', 'INNER JOIN returns only matching rows; LEFT JOIN returns all left table rows plus matches', 'easy', 'LEFT JOIN includes nulls for non-matching right table rows. RIGHT JOIN is the opposite.'),
    (9, 'How do you find duplicate rows based on a column?', 'SELECT column, COUNT(*) FROM table GROUP BY column HAVING COUNT(*) > 1', 'medium', 'HAVING filters grouped results. GROUP BY aggregates rows. This pattern finds duplicates in any column.'),
    (9, 'What does the EXPLAIN command do?', 'Shows the execution plan for a query, revealing how the database will execute it', 'medium', 'EXPLAIN helps identify performance issues like missing indexes, full table scans, or inefficient joins.'),
    (9, 'What is the difference between WHERE and HAVING?', 'WHERE filters rows before grouping; HAVING filters after aggregation', 'medium', 'WHERE operates on individual rows. HAVING operates on grouped results and can use aggregate functions.'),
    (9, 'What is a database index?', 'A data structure that improves query performance by allowing faster data retrieval', 'easy', 'Indexes speed up SELECT queries but slow down INSERT/UPDATE/DELETE. Trade-off between read and write performance.');

-- Sample flashcards for System Design
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (10, 'What is horizontal vs vertical scaling?', 'Horizontal: add more machines; Vertical: add more resources to existing machines', 'easy', 'Horizontal (scale out) is more flexible and fault-tolerant. Vertical (scale up) has hardware limits.'),
    (10, 'What is CAP theorem?', 'A distributed system can only guarantee 2 of 3: Consistency, Availability, Partition tolerance', 'hard', 'In practice, partition tolerance is required, so choice is between Consistency (CP) or Availability (AP).'),
    (10, 'What is the purpose of a load balancer?', 'Distributes incoming traffic across multiple servers to improve availability and performance', 'easy', 'Load balancers prevent overload, enable horizontal scaling, and provide failover. Types: Layer 4 (TCP) or Layer 7 (HTTP).'),
    (10, 'What is database sharding?', 'Partitioning data across multiple databases to distribute load and improve scalability', 'medium', 'Each shard contains a subset of data. Sharding key determines data distribution. Adds complexity but enables massive scale.'),
    (10, 'What is eventual consistency?', 'A consistency model where updates propagate to all nodes over time, but reads may return stale data', 'medium', 'Common in distributed systems prioritizing availability. Contrast with strong consistency which guarantees immediate consistency.');
-- Additional flashcards to expand the learning database
-- Run this after seed.sql to add 100 more flashcards (10 per category)

-- Additional Linux Commands flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (1, 'How do you change file permissions to rwxr-xr-x?', 'chmod 755 filename', 'easy', '755 means owner gets rwx (7), group gets r-x (5), others get r-x (5). Each digit is the sum of r=4, w=2, x=1.'),
    (1, 'What command shows running processes in a tree hierarchy?', 'pstree', 'easy', 'pstree displays processes in a tree format showing parent-child relationships. Use ps aux for detailed list.'),
    (1, 'How do you create a compressed tar archive?', 'tar -czf archive.tar.gz directory/', 'medium', '-c creates archive, -z compresses with gzip, -f specifies filename. Use -xzf to extract.'),
    (1, 'What command finds files larger than 100MB?', 'find / -type f -size +100M', 'medium', 'find with -size +100M finds files larger than 100 megabytes. Use -100M for smaller than 100MB.'),
    (1, 'How do you monitor system resource usage in real-time?', 'top', 'easy', 'top shows CPU, memory, and process information updated in real-time. Press q to quit, k to kill process. htop is a more user-friendly alternative.'),
    (1, 'What command shows the path to an executable?', 'which command-name', 'easy', 'which searches PATH and returns the location of the executable. Use whereis for more comprehensive search including man pages.'),
    (1, 'How do you count lines, words, and characters in a file?', 'wc filename', 'easy', 'wc (word count) shows lines, words, and bytes. Use -l for lines only, -w for words only, -c for bytes only.'),
    (1, 'What command shows network connections and listening ports?', 'netstat -tulpn', 'medium', '-t shows TCP, -u shows UDP, -l shows listening, -p shows process, -n shows numeric addresses. Requires sudo for process info.'),
    (1, 'How do you replace text in a file using sed?', 'sed -i ''s/old/new/g'' filename', 'hard', 'sed with -i edits in-place, s substitutes, g replaces all occurrences. Without -i, output goes to stdout.'),
    (1, 'What command shows system boot messages?', 'dmesg', 'easy', 'dmesg displays kernel ring buffer messages from boot and hardware events. Use dmesg | less to page through output.');

-- Additional Git flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (2, 'How do you stash changes including untracked files?', 'git stash -u', 'medium', '-u includes untracked files in the stash. Use git stash pop to apply and remove stash, or git stash apply to keep it.'),
    (2, 'What command shows the difference between two branches?', 'git diff branch1..branch2', 'medium', 'Shows differences between two branches. Use --name-only to see just filenames, or --stat for summary statistics.'),
    (2, 'How do you amend the last commit message?', 'git commit --amend', 'easy', '--amend replaces the last commit with a new one. Add -m "new message" to change message without editor. WARNING: Don''t amend pushed commits.'),
    (2, 'What command shows all branches including remotes?', 'git branch -a', 'easy', '-a shows all branches (local and remote). Use -r for remote only, -v for verbose with last commit info.'),
    (2, 'How do you cherry-pick a commit from another branch?', 'git cherry-pick <commit-hash>', 'medium', 'Cherry-pick applies a specific commit to your current branch. Use -x to add source reference in commit message.'),
    (2, 'What is the difference between merge and rebase?', 'Merge creates a merge commit preserving history; rebase replays commits creating linear history', 'hard', 'Merge is safer for public branches, rebase makes cleaner history but rewrites commit history.'),
    (2, 'How do you undo changes to a specific file?', 'git checkout -- filename', 'medium', 'Discards unstaged changes to a file, reverting to last commit. In Git 2.23+: git restore filename'),
    (2, 'What command shows which files are tracked by Git?', 'git ls-files', 'easy', 'Lists all files currently tracked by Git. Use git ls-files --others to see untracked files.'),
    (2, 'How do you delete a remote branch?', 'git push origin --delete branch-name', 'medium', 'Deletes the branch from remote repository. Also works: git push origin :branch-name (push empty to branch)'),
    (2, 'What command finds commits that introduced or removed a string?', 'git log -S "search-string"', 'hard', 'The -S option (pickaxe) finds commits that changed the number of occurrences of a string. Use -G for regex search.');

-- Additional Kubernetes flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (3, 'What is a Service in Kubernetes?', 'An abstraction that defines a logical set of Pods and a policy to access them', 'medium', 'Services provide stable IP addresses and DNS names for accessing Pods, even as Pods are created and destroyed.'),
    (3, 'How do you execute a command inside a running pod?', 'kubectl exec -it pod-name -- command', 'easy', '-it provides interactive terminal. For multiple containers, add -c container-name. Example: kubectl exec -it my-pod -- /bin/bash'),
    (3, 'What are the main types of Kubernetes Services?', 'ClusterIP, NodePort, LoadBalancer, and ExternalName', 'medium', 'ClusterIP (default) is internal only, NodePort exposes on node IP, LoadBalancer uses cloud provider, ExternalName maps to DNS.'),
    (3, 'How do you create a ConfigMap from a file?', 'kubectl create configmap name --from-file=path/to/file', 'medium', 'ConfigMaps store non-sensitive configuration data. Use --from-literal for key-value pairs: kubectl create configmap name --from-literal=key=value'),
    (3, 'What is a Namespace in Kubernetes?', 'A virtual cluster for organizing and isolating resources', 'easy', 'Namespaces provide scope for resource names and can have resource quotas. Default namespace is "default".'),
    (3, 'How do you roll back a deployment to previous version?', 'kubectl rollout undo deployment/name', 'medium', 'Undo reverts to previous revision. Use --to-revision=N for specific version. Check history with: kubectl rollout history deployment/name'),
    (3, 'What command applies a YAML configuration file?', 'kubectl apply -f filename.yaml', 'easy', 'apply creates or updates resources from YAML. Use -f for file, -k for kustomize directory, or - for stdin.'),
    (3, 'What is a DaemonSet?', 'A controller that ensures all (or some) nodes run a copy of a Pod', 'medium', 'DaemonSets are typically used for node-level services like log collectors, monitoring agents, or network plugins.'),
    (3, 'How do you get resource usage of nodes?', 'kubectl top nodes', 'easy', 'Shows CPU and memory usage of nodes. Requires Metrics Server. Use kubectl top pods for pod-level metrics.'),
    (3, 'What is the difference between a Deployment and StatefulSet?', 'Deployments manage stateless apps; StatefulSets manage stateful apps with stable network identities', 'hard', 'StatefulSets provide ordered deployment, stable hostnames, and persistent storage per pod. Deployments treat pods as interchangeable.');

-- Additional ArgoCD flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (4, 'How do you get detailed information about an ArgoCD application?', 'argocd app get <app-name>', 'easy', 'Shows detailed status including sync state, health, last sync time, parameters, and resources deployed.'),
    (4, 'What is auto-prune in ArgoCD?', 'Automatically deletes resources that no longer exist in Git', 'medium', 'When enabled, resources removed from Git are deleted from the cluster during sync. Useful but potentially dangerous.'),
    (4, 'How do you create a new ArgoCD application from CLI?', 'argocd app create <name> --repo <repo-url> --path <path> --dest-server <server> --dest-namespace <namespace>', 'hard', 'Creates an Application resource. Can also use kubectl apply with Application YAML manifest.'),
    (4, 'What does "OutOfSync" status mean in ArgoCD?', 'The live cluster state differs from the desired state in Git', 'easy', 'OutOfSync indicates drift. Can be caused by manual changes, Git commits not yet synced, or sync failures.'),
    (4, 'How do you view the diff between Git and cluster?', 'argocd app diff <app-name>', 'medium', 'Shows differences between desired state (Git) and actual state (cluster). Useful before syncing.'),
    (4, 'What is an ArgoCD ApplicationSet?', 'A template for generating multiple ArgoCD Applications automatically', 'hard', 'ApplicationSets use generators (Git, List, Cluster, etc.) to create Applications dynamically from templates.'),
    (4, 'How do you hard refresh an application?', 'argocd app get <app-name> --hard-refresh', 'medium', 'Forces refresh of cached Git state. Useful when ArgoCD hasn''t detected recent Git changes.'),
    (4, 'What is the sync-wave annotation used for?', 'Controls the order in which resources are synced', 'hard', 'argocd.argoproj.io/sync-wave: "N" - Lower numbers sync first. Used for dependency management (e.g., namespace before pods).'),
    (4, 'How do you view ArgoCD application events?', 'kubectl describe application <app-name> -n argocd', 'medium', 'Applications are Kubernetes resources, so kubectl describe shows events. Or use argocd app get for ArgoCD-specific info.'),
    (4, 'What is a sync hook in ArgoCD?', 'A resource that runs at specific points during sync (PreSync, Sync, PostSync, SyncFail)', 'hard', 'Hooks are annotated resources (usually Jobs) that run for tasks like DB migrations, notifications, or validation.');

-- Additional Docker flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (5, 'How do you list all containers including stopped ones?', 'docker ps -a', 'easy', '-a shows all containers. Without it, only running containers are shown. Use --format for custom output.'),
    (5, 'What command removes all stopped containers?', 'docker container prune', 'easy', 'Prune removes all stopped containers. Add -f to skip confirmation. Use docker system prune for containers, images, networks.'),
    (5, 'How do you copy files from container to host?', 'docker cp container-name:/path/to/file /host/path', 'medium', 'Works both ways: container to host or host to container. Container can be running or stopped.'),
    (5, 'What is the difference between CMD and ENTRYPOINT?', 'CMD provides default arguments that can be overridden; ENTRYPOINT sets the main command that cannot be overridden', 'hard', 'Use ENTRYPOINT for the main executable, CMD for default arguments. Both together: ENTRYPOINT + CMD arguments.'),
    (5, 'How do you view logs from a container?', 'docker logs container-name', 'easy', 'Add -f to follow logs in real-time, --tail N to show last N lines, --since to filter by time.'),
    (5, 'What command shows resource usage of running containers?', 'docker stats', 'easy', 'Shows CPU, memory, network I/O, and disk I/O for all running containers in real-time. Add container name for specific container.'),
    (5, 'How do you create a volume for persistent data?', 'docker volume create volume-name', 'medium', 'Volumes persist data outside container lifecycle. Mount with: docker run -v volume-name:/path/in/container image'),
    (5, 'What is a multi-stage build?', 'A Dockerfile with multiple FROM statements to create smaller final images', 'hard', 'Build artifacts in one stage, copy only needed files to final stage. Reduces image size and attack surface.'),
    (5, 'How do you tag an image with multiple tags?', 'docker tag image-id name:tag1 && docker tag image-id name:tag2', 'medium', 'Or build with multiple -t flags: docker build -t name:tag1 -t name:tag2 . Tags are just references to same image.'),
    (5, 'What command shows image layers and sizes?', 'docker history image-name', 'medium', 'Displays layer history showing commands that created each layer and their sizes. Useful for optimizing image size.');

-- Additional Computer Science flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (6, 'What is Big O notation?', 'A mathematical notation describing the upper bound of algorithm time/space complexity as input size grows', 'medium', 'O(1) constant, O(log n) logarithmic, O(n) linear, O(n log n) linearithmic, O(n²) quadratic, O(2ⁿ) exponential.'),
    (6, 'What is the difference between a stack and a queue?', 'Stack is LIFO (Last In First Out); Queue is FIFO (First In First Out)', 'easy', 'Stack: push/pop from top. Queue: enqueue at rear, dequeue from front. Stack for recursion/undo, queue for task scheduling.'),
    (6, 'What is a hash table and what is its average time complexity?', 'A data structure that maps keys to values using a hash function; O(1) average for insert/delete/lookup', 'medium', 'Hash function computes index from key. Collisions handled by chaining or open addressing. Worst case O(n) with many collisions.'),
    (6, 'What is the time complexity of binary search?', 'O(log n)', 'easy', 'Binary search divides search space in half each iteration. Requires sorted array. Much faster than linear search O(n).'),
    (6, 'What is a binary tree vs a binary search tree?', 'Binary tree has up to 2 children per node; BST has left < parent < right ordering property', 'medium', 'BST enables O(log n) search when balanced. Binary tree without ordering is just a structure constraint.'),
    (6, 'What is dynamic programming?', 'An optimization technique that solves complex problems by breaking them into overlapping subproblems and storing results', 'hard', 'Two approaches: top-down (memoization) and bottom-up (tabulation). Trades space for time by caching subproblem solutions.'),
    (6, 'What is the difference between depth-first and breadth-first search?', 'DFS explores as far as possible down each branch; BFS explores all neighbors before going deeper', 'medium', 'DFS uses stack (or recursion), BFS uses queue. DFS for path finding, BFS for shortest path in unweighted graphs.'),
    (6, 'What is a linked list and when would you use it?', 'A data structure with nodes containing data and reference to next node; efficient for insertions/deletions', 'easy', 'O(1) insert/delete at known position, O(n) search. Use when frequent insertions/deletions, size unknown, or sequential access.'),
    (6, 'What is the CAP theorem?', 'A distributed system can provide at most 2 of 3: Consistency, Availability, Partition tolerance', 'hard', 'Partition tolerance is required in distributed systems, so choose between consistency (CP) or availability (AP).'),
    (6, 'What is quicksort and what is its average time complexity?', 'A divide-and-conquer sorting algorithm using a pivot element; O(n log n) average', 'medium', 'Partitions array around pivot, recursively sorts subarrays. Worst case O(n²) with bad pivot. In-place, not stable.');

-- Additional SRE & Observability flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (7, 'What are the four golden signals of monitoring?', 'Latency, Traffic, Errors, and Saturation', 'medium', 'From Google SRE book. Latency: response time. Traffic: demand. Errors: failure rate. Saturation: resource utilization.'),
    (7, 'What is an SLO (Service Level Objective)?', 'A target value or range for a service level measured by an SLI', 'medium', 'Example: 99.9% of requests complete in <100ms. SLO is internal goal, SLA is external agreement with consequences.'),
    (7, 'What is the difference between metrics, logs, and traces?', 'Metrics are numerical measurements over time; logs are event records; traces follow requests across services', 'medium', 'Metrics for dashboards/alerts (Prometheus). Logs for debugging (ELK). Traces for distributed systems (Jaeger).'),
    (7, 'What is an error budget?', 'The allowed amount of downtime or errors before SLO is breached', 'hard', 'If SLO is 99.9%, error budget is 0.1%. Used to balance reliability vs feature velocity. No budget = feature freeze.'),
    (7, 'What is the RED method?', 'Rate, Errors, Duration - key metrics for request-driven services', 'medium', 'Rate: requests per second. Errors: error rate or count. Duration: latency percentiles (p50, p95, p99).'),
    (7, 'What is the USE method?', 'Utilization, Saturation, Errors - for resource monitoring', 'medium', 'For each resource (CPU, memory, disk, network): check utilization (%), saturation (queue length), errors (error count).'),
    (7, 'What is distributed tracing?', 'Tracking a request as it flows through multiple services in a microservices architecture', 'hard', 'Each service adds span to trace. Shows service dependencies, latency breakdown. Tools: Jaeger, Zipkin, OpenTelemetry.'),
    (7, 'What is a Service Level Indicator (SLI)?', 'A quantitative measure of a service level (e.g., latency, availability, error rate)', 'easy', 'SLIs are the actual measurements. SLOs are the targets for SLIs. Example SLI: % of requests completed in <100ms.'),
    (7, 'What is the difference between white-box and black-box monitoring?', 'White-box monitors internal state and metrics; black-box monitors from user perspective', 'medium', 'White-box: internal metrics like CPU, DB queries. Black-box: external probes testing actual user experience.'),
    (7, 'What is Prometheus and how does it work?', 'A time-series database and monitoring system that scrapes metrics from targets at intervals', 'medium', 'Pull-based model. Targets expose /metrics endpoint. PromQL for querying. Alertmanager for alerts. Grafana for visualization.');

-- Additional Networking flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (8, 'What is the difference between TCP and UDP?', 'TCP is connection-oriented with guaranteed delivery; UDP is connectionless with no guarantees', 'medium', 'TCP: reliable, ordered, slower (HTTP, SSH). UDP: fast, no overhead, allows packet loss (DNS, video streaming).'),
    (8, 'What are the layers of the OSI model?', 'Physical, Data Link, Network, Transport, Session, Presentation, Application', 'hard', 'Mnemonic: Please Do Not Throw Sausage Pizza Away. Layer 1-7. TCP/IP model combines some layers.'),
    (8, 'What is DNS and how does it work?', 'Domain Name System translates domain names to IP addresses using hierarchical lookups', 'medium', 'Client queries recursive resolver → root servers → TLD servers → authoritative nameserver. Cached at multiple levels.'),
    (8, 'What is the difference between a hub, switch, and router?', 'Hub broadcasts to all ports; switch learns MAC addresses and forwards to specific port; router connects networks using IP', 'medium', 'Hub: Layer 1, dumb broadcast. Switch: Layer 2, MAC-based forwarding. Router: Layer 3, IP routing between networks.'),
    (8, 'What is CIDR notation?', 'Classless Inter-Domain Routing notation for specifying IP address ranges (e.g., 192.168.1.0/24)', 'medium', '/24 means first 24 bits are network, last 8 bits are hosts (256 addresses). /16 = 65,536 addresses, /32 = single address.'),
    (8, 'What is a subnet mask?', 'A 32-bit number that divides an IP address into network and host portions', 'medium', '255.255.255.0 = /24 subnet. ANDing IP with mask gives network address. Defines network size and number of hosts.'),
    (8, 'What is ARP (Address Resolution Protocol)?', 'Protocol that maps IP addresses to MAC addresses on a local network', 'hard', 'Device broadcasts "Who has IP X?" on LAN. Device with that IP responds with MAC address. Cached in ARP table.'),
    (8, 'What is the three-way handshake in TCP?', 'SYN → SYN-ACK → ACK - establishes TCP connection', 'medium', 'Client sends SYN, server responds SYN-ACK, client sends ACK. Establishes sequence numbers for reliable communication.'),
    (8, 'What is NAT (Network Address Translation)?', 'Translates private IP addresses to public IP addresses for internet communication', 'medium', 'Allows multiple devices to share one public IP. Router maintains translation table. Types: SNAT (source), DNAT (destination).'),
    (8, 'What is the difference between a stateful and stateless firewall?', 'Stateful tracks connection state; stateless examines each packet independently', 'hard', 'Stateful: knows if packet is part of established connection, more secure. Stateless: faster, simpler rules, less memory.');

-- Additional SQL flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (9, 'What is the difference between WHERE and HAVING?', 'WHERE filters rows before grouping; HAVING filters groups after grouping', 'medium', 'WHERE works on individual rows, HAVING works on aggregated results. Use WHERE for row conditions, HAVING for aggregate conditions.'),
    (9, 'What is a primary key?', 'A column or set of columns that uniquely identifies each row in a table', 'easy', 'Must be unique and NOT NULL. Only one primary key per table. Auto-indexed for performance. Often uses AUTO_INCREMENT.'),
    (9, 'What is the difference between INNER JOIN and LEFT JOIN?', 'INNER JOIN returns only matching rows; LEFT JOIN returns all left table rows plus matches', 'medium', 'INNER: intersection only. LEFT: all from left + matches from right (NULL for no match). Also: RIGHT JOIN, FULL OUTER JOIN.'),
    (9, 'What is an index and why use it?', 'A data structure that improves query performance by allowing faster data retrieval', 'medium', 'Trade-off: faster SELECT queries vs slower INSERT/UPDATE/DELETE. Use on frequently queried columns. B-tree is common structure.'),
    (9, 'What is a foreign key?', 'A column that references the primary key of another table, enforcing referential integrity', 'medium', 'Ensures values exist in referenced table. Prevents orphaned records. ON DELETE CASCADE/SET NULL defines behavior.'),
    (9, 'What is the difference between DELETE and TRUNCATE?', 'DELETE removes rows one by one (can rollback); TRUNCATE drops and recreates table (faster, can''t rollback)', 'medium', 'DELETE fires triggers, can have WHERE clause, logs each row. TRUNCATE resets auto-increment, is DDL not DML.'),
    (9, 'What is a transaction and what are ACID properties?', 'A unit of work that must be Atomic, Consistent, Isolated, Durable', 'hard', 'Atomic: all or nothing. Consistent: valid state. Isolated: concurrent transactions don''t interfere. Durable: persisted after commit.'),
    (9, 'What is normalization?', 'Organizing database structure to reduce redundancy and improve data integrity', 'hard', '1NF: atomic values. 2NF: no partial dependencies. 3NF: no transitive dependencies. Higher forms exist but 3NF is common.'),
    (9, 'What is a subquery?', 'A query nested inside another query', 'easy', 'Can be in SELECT, FROM, WHERE clauses. Use for complex filtering, derived tables, or EXISTS checks. Can impact performance.'),
    (9, 'What is the difference between UNION and UNION ALL?', 'UNION removes duplicates; UNION ALL keeps all rows including duplicates', 'medium', 'UNION is slower (needs to check duplicates). UNION ALL is faster. Both require same number and compatible types of columns.');

-- Additional System Design flashcards (10 more)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (10, 'What is horizontal vs vertical scaling?', 'Horizontal adds more machines; vertical adds more power to existing machine', 'easy', 'Horizontal (scale out): distributed, unlimited growth, complex. Vertical (scale up): simpler, hardware limits, single point of failure.'),
    (10, 'What is a load balancer?', 'Distributes incoming network traffic across multiple servers to ensure availability and reliability', 'medium', 'Algorithms: round-robin, least connections, IP hash. Provides high availability, health checks, SSL termination. Layer 4 or Layer 7.'),
    (10, 'What is database replication?', 'Copying data from one database to others for redundancy and performance', 'medium', 'Master-slave: writes to master, reads from replicas. Multi-master: writes to any. Trade-offs: consistency vs availability.'),
    (10, 'What is eventual consistency?', 'A consistency model where data eventually becomes consistent across all nodes', 'hard', 'Prioritizes availability over immediate consistency. Common in distributed systems (DynamoDB, Cassandra). Conflicts resolved later.'),
    (10, 'What is a CDN (Content Delivery Network)?', 'A distributed network of servers that delivers content from locations closest to users', 'medium', 'Caches static assets (images, CSS, JS) at edge locations worldwide. Reduces latency, bandwidth, and server load.'),
    (10, 'What is the difference between caching and CDN?', 'Caching stores frequently accessed data in memory; CDN is geographically distributed content storage', 'medium', 'Cache: application-level (Redis, Memcached), dynamic data. CDN: network-level, static content, geographic distribution.'),
    (10, 'What is database sharding?', 'Partitioning data across multiple databases to distribute load', 'hard', 'Horizontal partitioning by shard key (e.g., user_id % N). Improves scalability but adds complexity: cross-shard queries, rebalancing.'),
    (10, 'What is the purpose of a message queue?', 'Asynchronous communication between services, decoupling producers and consumers', 'medium', 'Benefits: load leveling, fault tolerance, guaranteed delivery. Examples: RabbitMQ, Kafka, SQS. Trade-off: eventual processing.'),
    (10, 'What is the difference between microservices and monolith?', 'Microservices split application into small independent services; monolith is a single deployable unit', 'medium', 'Microservices: independent scaling/deployment, complex networking. Monolith: simpler to develop, harder to scale, single deployment.'),
    (10, 'What is idempotency and why is it important?', 'An operation that produces the same result no matter how many times it is performed', 'hard', 'Critical for retries and distributed systems. GET, PUT, DELETE are idempotent. POST usually is not. Use idempotency keys for POST.');
-- Even more flashcards to further expand the learning database
-- Run this to add another 100 flashcards (10 more per category)

-- More Linux Commands flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (1, 'How do you find and kill a process by name?', 'pkill process-name', 'medium', 'pkill sends signal to processes by name. Add -9 for force kill. Alternative: ps aux | grep name | awk ''{print $2}'' | xargs kill'),
    (1, 'What command shows the last 10 commands from history?', 'history 10', 'easy', 'history shows command history. Use !n to re-run command number n, !! for last command, !string for last command starting with string.'),
    (1, 'How do you create a symbolic link?', 'ln -s /path/to/original /path/to/link', 'easy', 'Symbolic link (symlink) is a pointer to another file. -s creates soft link. Without -s creates hard link (direct inode reference).'),
    (1, 'What command shows open files by a process?', 'lsof -p <pid>', 'medium', 'lsof (list open files) shows files, sockets, pipes. Use lsof -i to show network connections, lsof /path to show who''s using a file.'),
    (1, 'How do you run a command immune to hangups?', 'nohup command &', 'medium', 'nohup makes command immune to SIGHUP (hangup signal). Output goes to nohup.out. & runs in background. Alternative: screen or tmux.'),
    (1, 'What command shows file system disk space usage?', 'df -h', 'easy', 'df (disk free) shows disk space for mounted filesystems. -h for human-readable. Use df -i to check inode usage.'),
    (1, 'How do you change file ownership?', 'chown user:group filename', 'easy', 'chown changes ownership. Can use just user or user:group. Add -R for recursive. Requires sudo for files you don''t own.'),
    (1, 'What command displays or sets system hostname?', 'hostname', 'easy', 'hostname shows or sets system name. hostnamectl for systemd systems. /etc/hostname file persists across reboots.'),
    (1, 'How do you compare two files line by line?', 'diff file1 file2', 'easy', 'diff shows differences between files. Use diff -u for unified format, diff -y for side-by-side. cmp for binary files.'),
    (1, 'What command schedules a one-time task?', 'at time', 'medium', 'at schedules one-time execution. Example: echo "script.sh" | at 2:30 PM. atq lists pending, atrm removes. cron for recurring tasks.');

-- More Git flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (2, 'How do you view changes between working directory and staging area?', 'git diff', 'easy', 'git diff shows unstaged changes. git diff --staged shows staged changes. git diff HEAD shows all changes from last commit.'),
    (2, 'What command shows remote repository URLs?', 'git remote -v', 'easy', '-v shows fetch and push URLs. git remote add name url adds new remote. git remote show origin for detailed info.'),
    (2, 'How do you fetch and merge in one command?', 'git pull', 'easy', 'git pull = git fetch + git merge. Use git pull --rebase to rebase instead of merge. Specify branch: git pull origin main'),
    (2, 'What is git reflog used for?', 'Shows history of HEAD movements, useful for recovering lost commits', 'hard', 'reflog tracks all reference updates even after rebases or resets. Use to recover "lost" commits. Entries expire after 90 days.'),
    (2, 'How do you temporarily save work without committing?', 'git stash', 'medium', 'Stashes uncommitted changes. git stash pop applies and removes, git stash apply keeps stash. git stash list shows all stashes.'),
    (2, 'What command removes untracked files?', 'git clean -fd', 'medium', '-f forces removal, -d removes directories. Add -n for dry run (preview). WARNING: This permanently deletes files!'),
    (2, 'How do you show commits by a specific author?', 'git log --author="name"', 'medium', 'Filters commit history by author. Combine with other flags: git log --author="name" --since="2 weeks ago" --oneline'),
    (2, 'What is the difference between merge --squash and regular merge?', 'Squash combines all commits into one; regular merge preserves individual commits', 'hard', 'Squash creates single commit with all changes, loses individual commit history. Useful for cleaning up feature branch history.'),
    (2, 'How do you tag a specific commit?', 'git tag tag-name commit-hash', 'medium', 'Tags mark specific points in history (releases). Lightweight: git tag v1.0. Annotated: git tag -a v1.0 -m "message". Push: git push --tags'),
    (2, 'What command shows the graph of branches?', 'git log --graph --oneline --all', 'medium', '--graph shows ASCII branch structure, --all includes all branches. Add --decorate to show branch/tag names.');

-- More Kubernetes flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (3, 'What is a ReplicaSet?', 'Ensures a specified number of pod replicas are running at any time', 'medium', 'Usually managed by Deployment. Maintains desired replica count, creates/deletes pods as needed. Selects pods using labels.'),
    (3, 'How do you port-forward to a pod?', 'kubectl port-forward pod-name local-port:pod-port', 'easy', 'Creates tunnel from local machine to pod. Example: kubectl port-forward my-pod 8080:80 accesses pod port 80 on localhost:8080'),
    (3, 'What is a PersistentVolumeClaim (PVC)?', 'A request for storage by a user', 'medium', 'PVC is a request, PV is the actual storage. Pod uses PVC, cluster binds PVC to available PV matching requirements.'),
    (3, 'How do you edit a resource in-place?', 'kubectl edit <resource-type> <name>', 'easy', 'Opens resource in editor (vim/nano). Changes applied on save. Example: kubectl edit deployment my-app'),
    (3, 'What is a Kubernetes Secret?', 'Object that stores sensitive data like passwords, tokens, or keys', 'easy', 'Base64 encoded (not encrypted). Mounted as files or environment variables. Use external secrets manager for production.'),
    (3, 'How do you see resource usage of pods?', 'kubectl top pod', 'easy', 'Shows CPU and memory usage. Requires Metrics Server. Add --containers for per-container metrics, -n namespace for specific namespace.'),
    (3, 'What is the difference between a Job and CronJob?', 'Job runs once to completion; CronJob runs Jobs on a schedule', 'medium', 'Job ensures pods successfully complete. CronJob uses cron syntax for scheduling. Example: backup jobs, batch processing.'),
    (3, 'How do you drain a node for maintenance?', 'kubectl drain node-name --ignore-daemonsets', 'medium', 'Safely evicts all pods from node. --ignore-daemonsets skips DaemonSet pods. kubectl uncordon node-name to re-enable scheduling.'),
    (3, 'What is an Ingress?', 'Manages external access to services, typically HTTP/HTTPS', 'medium', 'Provides load balancing, SSL termination, name-based virtual hosting. Requires Ingress Controller (nginx, traefik, etc.).'),
    (3, 'How do you copy files from a pod to local machine?', 'kubectl cp pod-name:/path/to/file ./local-path', 'medium', 'Works both directions. For multi-container pods: kubectl cp pod-name:/path ./local -c container-name');

-- More ArgoCD flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (4, 'What is auto-sync in ArgoCD?', 'Automatically syncs application when Git repository changes are detected', 'easy', 'Enabled in Application spec. Eliminates manual sync but requires careful testing. Can combine with automated pruning and self-heal.'),
    (4, 'How do you delete an ArgoCD application?', 'argocd app delete <app-name>', 'easy', 'Deletes Application resource. Add --cascade to delete all deployed resources. Without --cascade, resources remain in cluster.'),
    (4, 'What is the purpose of finalizers in ArgoCD?', 'Control application deletion behavior and resource cleanup', 'hard', 'resources-finalizer.argocd.argoproj.io ensures deployed resources are deleted. Remove finalizer to keep resources after app deletion.'),
    (4, 'How do you view application logs in ArgoCD?', 'argocd app logs <app-name>', 'easy', 'Shows logs from application pods. Add --follow for streaming. Useful for debugging deployment issues.'),
    (4, 'What is a sync retry in ArgoCD?', 'Automatic retry mechanism when sync fails', 'medium', 'Configurable backoff strategy. Helps with transient failures like webhook timeouts or temporary network issues.'),
    (4, 'How do you rollback an ArgoCD application?', 'argocd app rollback <app-name> <revision>', 'medium', 'Syncs to a previous Git revision. View history with: argocd app history <app-name>. Alternative: revert Git commit and sync.'),
    (4, 'What is resource health assessment?', 'ArgoCD evaluates if resources are healthy/progressing/degraded/suspended', 'medium', 'Built-in health checks for common resources. Custom health checks possible via ConfigMap. Shown in UI and CLI.'),
    (4, 'How do you pause auto-sync temporarily?', 'argocd app set <app-name> --sync-policy none', 'medium', 'Disables auto-sync. Re-enable with: argocd app set <app-name> --sync-policy automated. Useful during maintenance.'),
    (4, 'What is project in ArgoCD?', 'Logical grouping of applications with policies and restrictions', 'hard', 'Projects provide multi-tenancy. Define allowed sources (repos), destinations (clusters), and resource kinds. RBAC per project.'),
    (4, 'How do you force refresh application cache?', 'argocd app get <app-name> --refresh', 'easy', 'Forces ArgoCD to query Git and cluster for latest state. Useful when changes aren''t detected. --hard-refresh for complete cache clear.');

-- More Docker flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (5, 'What is the difference between ADD and COPY in Dockerfile?', 'COPY only copies files; ADD can also extract archives and fetch URLs', 'medium', 'Best practice: use COPY unless you need ADD''s extra features. ADD auto-extracts tar files, COPY is more explicit.'),
    (5, 'How do you see all layers of an image?', 'docker image inspect image-name', 'medium', 'Shows detailed JSON including layers, config, environment. Use docker history for layer sizes and commands.'),
    (5, 'What is a Docker network?', 'Virtual network for containers to communicate', 'medium', 'Types: bridge (default), host, none, custom. Containers on same network can communicate by name. Isolates container traffic.'),
    (5, 'How do you limit container memory?', 'docker run -m 512m image-name', 'medium', '-m or --memory sets limit. Container killed if exceeded (OOMKilled). Use --memory-swap for swap limit.'),
    (5, 'What is the difference between docker stop and docker kill?', 'stop sends SIGTERM then SIGKILL; kill sends SIGKILL immediately', 'medium', 'stop allows graceful shutdown (10s default). kill forces immediate termination. stop is safer for databases/services.'),
    (5, 'How do you run a container in read-only mode?', 'docker run --read-only image-name', 'medium', 'Root filesystem is read-only. Use --tmpfs for writable temp directories. Security best practice to prevent malware writing files.'),
    (5, 'What is Docker Compose?', 'Tool for defining and running multi-container applications using YAML', 'easy', 'docker-compose.yml defines services, networks, volumes. Commands: docker-compose up, down, ps, logs. Version 2+ integrates with Docker CLI.'),
    (5, 'How do you inspect container processes?', 'docker top container-name', 'easy', 'Shows running processes inside container. Similar to ps command but for container. Useful for debugging.'),
    (5, 'What is the difference between image and container?', 'Image is immutable template; container is running instance of an image', 'easy', 'Image is like a class, container is an instance. One image can create many containers. Containers add writable layer.'),
    (5, 'How do you export and import images?', 'docker save -o file.tar image-name && docker load -i file.tar', 'medium', 'save/load for images. export/import for containers. save preserves layers and metadata, export flattens to single layer.');

-- More Computer Science flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (6, 'What is a graph and name its types?', 'A collection of nodes (vertices) connected by edges; types: directed, undirected, weighted, unweighted', 'medium', 'Used for networks, maps, dependencies. Traversal: DFS, BFS. Common problems: shortest path, cycle detection, topological sort.'),
    (6, 'What is memoization?', 'Optimization technique that stores function results to avoid repeated calculations', 'medium', 'Key technique in dynamic programming. Trade space for time. Useful for recursive functions with overlapping subproblems.'),
    (6, 'What is the difference between process and thread?', 'Process is independent execution unit with own memory; thread shares memory within process', 'hard', 'Processes isolated, heavyweight. Threads lightweight, share address space. Threads enable parallelism without IPC overhead.'),
    (6, 'What is a heap data structure?', 'A tree-based structure where parent nodes have priority over children (min-heap or max-heap)', 'medium', 'Used for priority queues. Root is minimum (min-heap) or maximum (max-heap). O(log n) insert/delete, O(1) find min/max.'),
    (6, 'What is two-pointer technique?', 'Algorithm pattern using two pointers to iterate through data structure', 'medium', 'Common patterns: slow/fast pointers, opposite ends moving inward. Used for arrays, linked lists. Example: finding pairs, palindrome check.'),
    (6, 'What is a trie data structure?', 'Tree-like structure for storing strings, where each path represents a word', 'hard', 'Also called prefix tree. Efficient for autocomplete, spell check, IP routing. O(m) operations where m is string length, not data size.'),
    (6, 'What is greedy algorithm?', 'Makes locally optimal choice at each step hoping to find global optimum', 'medium', 'Not always optimal but often efficient. Examples: Dijkstra''s algorithm, Huffman coding. Simpler than dynamic programming.'),
    (6, 'What is the difference between DFS and BFS for graphs?', 'DFS goes deep exploring one branch fully; BFS explores all neighbors before going deeper', 'medium', 'DFS: uses stack, better for paths, topological sort. BFS: uses queue, finds shortest path, good for level-order traversal.'),
    (6, 'What is amortized time complexity?', 'Average time per operation over a sequence of operations', 'hard', 'Example: dynamic array resize is O(n) but amortized O(1) per insert. Averages expensive operations over many cheap ones.'),
    (6, 'What is a deadlock and how to prevent it?', 'Situation where processes wait indefinitely for resources held by each other', 'hard', 'Four conditions: mutual exclusion, hold and wait, no preemption, circular wait. Prevent by breaking any condition, use timeouts.');

-- More SRE & Observability flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (7, 'What is the difference between monitoring and observability?', 'Monitoring watches known failure modes; observability understands system from outputs', 'hard', 'Monitoring: predefined metrics/alerts. Observability: arbitrary questions about system state. Observability includes logs, metrics, traces.'),
    (7, 'What is a percentile in performance metrics?', 'Value below which a percentage of observations fall', 'medium', 'p50 (median), p95, p99 commonly used. p99 = 99% of requests faster. Better than average for understanding user experience.'),
    (7, 'What is alerting fatigue?', 'Desensitization to alerts due to too many false positives', 'easy', 'Causes: noisy alerts, low thresholds, alert storms. Solutions: better thresholds, alert grouping, runbook links, escalation.'),
    (7, 'What is a runbook?', 'Step-by-step guide for handling operational tasks or incidents', 'easy', 'Documents procedures for common issues. Includes investigation steps, remediation actions, escalation paths. Reduces MTTR.'),
    (7, 'What is mean time to recovery (MTTR)?', 'Average time to restore service after an incident', 'medium', 'Key reliability metric. Lower is better. Related: MTTD (detect), MTTF (failure), MTBF (between failures). Focus on detection and automation.'),
    (7, 'What is cardinality in metrics?', 'Number of unique time series for a metric based on label combinations', 'hard', 'High cardinality (many unique labels) impacts performance and storage. Avoid user IDs in labels. Limit tag combinations.'),
    (7, 'What is log aggregation?', 'Collecting logs from multiple sources into centralized system', 'medium', 'Benefits: centralized search, correlation, retention. Tools: ELK stack, Splunk, Loki. Challenges: volume, cost, sensitive data.'),
    (7, 'What is synthetic monitoring?', 'Proactive monitoring using simulated transactions or user flows', 'medium', 'Tests system availability and performance from external perspective. Complements real user monitoring (RUM). Catches issues before users.'),
    (7, 'What is a service mesh?', 'Infrastructure layer providing service-to-service communication, observability, and security', 'hard', 'Examples: Istio, Linkerd. Features: traffic management, mutual TLS, observability. Trade-off: complexity vs capabilities.'),
    (7, 'What is on-call rotation?', 'Schedule where engineers take turns being responsible for incidents', 'easy', 'Best practices: fair rotation, manageable load, escalation paths, retrospectives. On-call compensation, avoid burnout.');

-- More Networking flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (8, 'What is a proxy server?', 'Intermediary server that forwards requests between client and server', 'medium', 'Forward proxy (client-side): privacy, caching. Reverse proxy (server-side): load balancing, SSL termination. Examples: Squid, nginx.'),
    (8, 'What is SSL/TLS?', 'Cryptographic protocols for secure communication over networks', 'medium', 'SSL deprecated, TLS current. Provides encryption, authentication, integrity. Handshake establishes keys. Certificate verifies identity.'),
    (8, 'What is the difference between port 80 and 443?', 'Port 80 is HTTP (unencrypted); port 443 is HTTPS (encrypted)', 'easy', 'Well-known ports. 80: plain HTTP. 443: HTTP over TLS/SSL. Modern web uses 443. Port 8080 common for HTTP alternatives.'),
    (8, 'What is a VLAN?', 'Virtual LAN that segments a physical network into logical networks', 'hard', 'Separates broadcast domains. Improves security and performance. Tagged with VLAN ID (802.1Q). Switch ports assigned to VLANs.'),
    (8, 'What is the purpose of the ping command?', 'Tests connectivity and measures round-trip time using ICMP echo', 'easy', 'Sends ICMP echo request, expects echo reply. Shows packet loss, latency. May be blocked by firewalls. IPv4: ping, IPv6: ping6'),
    (3, 'What is BGP (Border Gateway Protocol)?', 'Protocol that routes traffic between autonomous systems on the internet', 'hard', 'Path vector protocol. Exchanges routing information between ISPs. Policy-based routing. Critical for internet infrastructure.'),
    (8, 'What is a MAC address?', 'Hardware address uniquely identifying network interface (48-bit)', 'easy', 'Physical address burned into NIC. Format: 6 hex octets (00:1A:2B:3C:4D:5E). First 3 octets identify manufacturer (OUI).'),
    (8, 'What is QoS (Quality of Service)?', 'Techniques to manage network resources and prioritize traffic', 'hard', 'Prioritizes critical traffic (VoIP, video) over bulk data. Mechanisms: traffic shaping, policing, queuing. Used in WANs, VoIP.'),
    (8, 'What is the difference between IPv4 and IPv6?', 'IPv4 uses 32-bit addresses; IPv6 uses 128-bit addresses', 'medium', 'IPv4: 4.3 billion addresses, dotted decimal. IPv6: vast address space, colon-hex notation. IPv6 includes IPsec, no NAT needed.'),
    (8, 'What is DHCP?', 'Dynamic Host Configuration Protocol that automatically assigns IP addresses', 'easy', 'Automates network configuration. DORA process: Discover, Offer, Request, Acknowledge. Leases addresses for time period.');

-- More SQL flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (9, 'What is a view in SQL?', 'Virtual table based on a SELECT query', 'medium', 'Simplifies complex queries, provides abstraction, security. Materialized views cache results. Updated views may have restrictions.'),
    (9, 'What is the GROUP BY clause used for?', 'Groups rows sharing a property for aggregate functions', 'easy', 'Used with COUNT, SUM, AVG, MAX, MIN. Must include all non-aggregated columns. Filter groups with HAVING, not WHERE.'),
    (9, 'What is a stored procedure?', 'Precompiled SQL code saved in database that can be reused', 'medium', 'Benefits: performance, security, code reuse. Can have parameters, logic, transactions. Language varies by DB (PL/SQL, T-SQL).'),
    (9, 'What is the difference between CHAR and VARCHAR?', 'CHAR is fixed-length; VARCHAR is variable-length', 'easy', 'CHAR pads with spaces, faster for fixed sizes. VARCHAR saves space for variable data. Use CHAR for codes, VARCHAR for names.'),
    (9, 'What is a trigger?', 'Automatically executed procedure in response to database events', 'hard', 'Events: INSERT, UPDATE, DELETE. Timing: BEFORE, AFTER. Use cases: audit logs, validation, cascading updates. Can impact performance.'),
    (9, 'What is the purpose of EXPLAIN in SQL?', 'Shows query execution plan to help optimize performance', 'medium', 'Reveals indexes used, join methods, estimated costs. Use to identify slow queries, missing indexes. Syntax varies by database.'),
    (9, 'What is a composite key?', 'Primary key consisting of two or more columns', 'medium', 'Used when single column can''t uniquely identify row. Example: order_id + product_id for line items. All columns required for uniqueness.'),
    (9, 'What is SQL injection?', 'Security vulnerability where malicious SQL is inserted into queries', 'hard', 'Caused by unsanitized user input. Prevention: parameterized queries, prepared statements, input validation, ORMs. Critical security issue.'),
    (9, 'What is the difference between RANK and DENSE_RANK?', 'RANK skips numbers after ties; DENSE_RANK doesn''t skip', 'hard', 'Both assign ranks to rows. RANK: 1,2,2,4. DENSE_RANK: 1,2,2,3. ROW_NUMBER always unique. Window functions.'),
    (9, 'What is a clustered vs non-clustered index?', 'Clustered defines physical order of data; non-clustered is separate structure', 'hard', 'One clustered index per table (usually PK). Multiple non-clustered indexes possible. Clustered faster for range queries.');

-- More System Design flashcards
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation) VALUES
    (10, 'What is caching strategy and name common types?', 'Method to store and retrieve cached data; types: write-through, write-back, write-around, cache-aside', 'hard', 'Write-through: sync write to cache and DB. Write-back: async write. Write-around: skip cache. Cache-aside: app manages cache.'),
    (10, 'What is the difference between SQL and NoSQL?', 'SQL is relational with schema; NoSQL is non-relational, schema-less', 'medium', 'SQL: ACID, joins, structured (Postgres, MySQL). NoSQL: flexible schema, horizontal scaling, eventual consistency (MongoDB, Cassandra).'),
    (10, 'What is rate limiting?', 'Controlling the rate of requests to protect services from overload', 'medium', 'Algorithms: token bucket, leaky bucket, fixed/sliding window. Prevents abuse, ensures fair usage, protects resources.'),
    (10, 'What is the purpose of an API gateway?', 'Single entry point for API requests providing routing, security, and rate limiting', 'medium', 'Functions: authentication, rate limiting, request routing, response aggregation, logging. Examples: Kong, AWS API Gateway.'),
    (10, 'What is data replication vs data partitioning?', 'Replication copies data to multiple nodes; partitioning splits data across nodes', 'hard', 'Replication: redundancy, availability, read scaling. Partitioning: write scaling, distributes load. Often used together.'),
    (10, 'What is a circuit breaker pattern?', 'Prevents cascading failures by stopping requests to failing services', 'hard', 'States: closed (normal), open (failing), half-open (testing). Fails fast instead of waiting. Provides fallback responses.'),
    (10, 'What is the difference between push and pull in messaging?', 'Push sends data to consumers; pull has consumers request data', 'medium', 'Push: real-time, complex flow control. Pull: consumer-controlled rate, simpler. Examples: WebSockets (push), polling (pull).'),
    (10, 'What is database indexing strategy?', 'Choosing which columns to index based on query patterns', 'hard', 'Index columns used in WHERE, JOIN, ORDER BY. Trade-off: read vs write performance. Monitor query plans, avoid over-indexing.'),
    (10, 'What is the twelve-factor app methodology?', 'Best practices for building modern, scalable web applications', 'hard', 'Principles: codebase, dependencies, config, backing services, build/release/run, processes, port binding, concurrency, disposability, dev/prod parity, logs, admin processes.'),
    (10, 'What is blue-green deployment?', 'Deployment strategy maintaining two identical environments, switching traffic between them', 'medium', 'Blue: current version. Green: new version. Test green, switch traffic, keep blue for rollback. Minimizes downtime, easy rollback.');
