-- Flashcard Database Export
-- Generated on 2025-11-15T10:23:15.441Z
-- Total Categories: 10
-- Total Flashcards: 299

-- Categories
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

-- Flashcards for Linux Commands (43 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (1, 'What command lists all files including hidden ones?', 'ls -la', 'easy', 'The -l flag provides long format with details, -a shows all files including hidden ones (starting with .)', NULL),
    (1, 'How do you find all files modified in the last 7 days?', 'find . -mtime -7', 'medium', 'The find command with -mtime -7 searches for files modified within the last 7 days. Use +7 for files older than 7 days.', NULL),
    (1, 'What command shows the last 50 lines of a log file and follows new additions?', 'tail -n 50 -f logfile.log', 'medium', 'tail -n 50 shows last 50 lines, -f (follow) mode continues to output new lines as they are added to the file.', NULL),
    (1, 'How do you check disk usage of all directories in human-readable format?', 'du -h --max-depth=1', 'easy', 'du (disk usage) with -h flag shows human-readable sizes (KB, MB, GB), --max-depth=1 limits to immediate subdirectories.', NULL),
    (1, 'What command searches for a pattern recursively in all files?', 'grep -r "pattern" .', 'easy', 'grep with -r flag searches recursively through all subdirectories from the current location (.)', NULL),
    (1, 'How do you change file permissions to rwxr-xr-x?', 'chmod 755 filename', 'easy', '755 means owner gets rwx (7), group gets r-x (5), others get r-x (5). Each digit is the sum of r=4, w=2, x=1.', NULL),
    (1, 'What command shows running processes in a tree hierarchy?', 'pstree', 'easy', 'pstree displays processes in a tree format showing parent-child relationships. Use ps aux for detailed list.', NULL),
    (1, 'How do you create a compressed tar archive?', 'tar -czf archive.tar.gz directory/', 'medium', '-c creates archive, -z compresses with gzip, -f specifies filename. Use -xzf to extract.', NULL),
    (1, 'What command finds files larger than 100MB?', 'find / -type f -size +100M

This command searches the entire filesystem (/) for regular files (-type f) larger than 100 megabytes (-size +100M). You can modify the starting path to narrow the search scope (e.g., find /home for just user directories) and change the size threshold using units like k (kilobytes), M (megabytes), or G (gigabytes). Add + for ''greater than'' or - for ''less than'' the specified size.', 'medium', 'The find command is essential for system administration, disk space management, and troubleshooting storage issues. Real-world use cases include: identifying large log files consuming disk space, locating old database backups for cleanup, finding media files for archival, or detecting unexpectedly large files during security audits.

Important considerations: Searching from root (/) requires sudo/root privileges and can be time-consuming on large filesystems. You can optimize by limiting the search path, excluding certain directories with -prune, or combining with other filters like modification time (-mtime) or file permissions. The command can be piped to other utilities like xargs, sort, or du for advanced processing of results.', '# Find files larger than 100MB in entire system
find / -type f -size +100M 2>/dev/null

# Find files larger than 100MB in home directory only
find /home -type f -size +100M

# Find files between 100MB and 1GB, show human-readable sizes
find /var -type f -size +100M -size -1G -exec ls -lh {} \;

# Find large files and sort by size
find /var/log -type f -size +50M -exec du -h {} \; | sort -rh

# Find large files modified in last 7 days
find /tmp -type f -size +100M -mtime -7

# Delete files larger than 500MB (use with caution!)
find /tmp -type f -size +500M -delete'),
    (1, 'How do you monitor system resource usage in real-time?', 'top', 'easy', 'top shows CPU, memory, and process information updated in real-time. Press q to quit, k to kill process. htop is a more user-friendly alternative.', NULL),
    (1, 'What command shows the path to an executable?', 'which command-name', 'easy', 'which searches PATH and returns the location of the executable. Use whereis for more comprehensive search including man pages.', NULL),
    (1, 'How do you count lines, words, and characters in a file?', 'wc filename', 'easy', 'wc (word count) shows lines, words, and bytes. Use -l for lines only, -w for words only, -c for bytes only.', NULL),
    (1, 'What command shows network connections and listening ports?', 'netstat -tulpn', 'medium', '-t shows TCP, -u shows UDP, -l shows listening, -p shows process, -n shows numeric addresses. Requires sudo for process info.', NULL),
    (1, 'How do you replace text in a file using sed?', 'sed -i ''s/old/new/g'' filename', 'hard', 'sed with -i edits in-place, s substitutes, g replaces all occurrences. Without -i, output goes to stdout.', NULL),
    (1, 'What command shows system boot messages?', 'The **`dmesg`** command displays the **kernel ring buffer**, which contains system boot messages, hardware detection events, and kernel-level diagnostic information. This command is essential for troubleshooting hardware issues, driver problems, and understanding the boot sequence.

**Common usage patterns:**
- `dmesg` - Display all kernel messages
- `dmesg | less` - Page through output for easier reading
- `dmesg | grep -i error` - Filter for error messages
- `dmesg -T` - Show human-readable timestamps
- `dmesg -w` - Watch new messages in real-time (follow mode)
- `dmesg -l err,warn` - Show only errors and warnings', 'easy', '**Real-world use cases:**

1. **Hardware troubleshooting** - When a USB device isn''t recognized, `dmesg` shows whether the kernel detected it and any errors during initialization

2. **Driver issues** - If a network card stops working after a kernel update, `dmesg` reveals driver loading failures or conflicts

3. **System crashes** - After an unexpected reboot, `dmesg` contains messages leading up to the crash, helping identify the root cause

4. **Boot problems** - When a system boots slowly or fails to mount drives, the boot messages show which services or devices are causing delays

**Important notes:**
- The ring buffer has *limited size* (typically 512KB-1MB), so older messages get overwritten
- Requires **root/sudo privileges** on many systems to view all messages
- Messages persist only until reboot unless using `journalctl` which logs them permanently
- The `-T` flag is crucial for correlating events with specific times
- Combined with `grep`, it becomes a powerful diagnostic tool: `dmesg | grep -i "usb\|error\|fail"`', '# Basic usage
dmesg

# Most useful troubleshooting commands
sudo dmesg -T | tail -50              # Last 50 messages with timestamps
sudo dmesg -T | grep -i error        # Find all errors
sudo dmesg -w                        # Watch for new messages (Ctrl+C to exit)

# Filter by facility level
sudo dmesg -l err                    # Show only errors
sudo dmesg -l err,warn               # Show errors and warnings

# Search for specific hardware
dmesg | grep -i usb                  # USB device messages
dmesg | grep -i eth                  # Network interface messages
dmesg | grep -i sda                  # Hard drive messages

# Clear the ring buffer (requires root)
sudo dmesg -C

# Save output for later analysis
dmesg -T > dmesg_output.txt'),
    (1, 'How do you find and kill a process by name?', 'pkill process-name', 'medium', 'pkill sends signal to processes by name. Add -9 for force kill. Alternative: ps aux | grep name | awk ''{print $2}'' | xargs kill', NULL),
    (1, 'What command shows the last 10 commands from history?', 'history 10', 'easy', 'history shows command history. Use !n to re-run command number n, !! for last command, !string for last command starting with string.', NULL),
    (1, 'How do you create a symbolic link?', 'ln -s /path/to/original /path/to/link', 'easy', 'Symbolic link (symlink) is a pointer to another file. -s creates soft link. Without -s creates hard link (direct inode reference).', NULL),
    (1, 'What command shows open files by a process?', 'lsof -p <pid>', 'medium', 'lsof (list open files) shows files, sockets, pipes. Use lsof -i to show network connections, lsof /path to show who''s using a file.', NULL),
    (1, 'How do you run a command immune to hangups?', 'nohup command &', 'medium', 'nohup makes command immune to SIGHUP (hangup signal). Output goes to nohup.out. & runs in background. Alternative: screen or tmux.', NULL),
    (1, 'What command shows file system disk space usage?', 'df -h', 'easy', 'df (disk free) shows disk space for mounted filesystems. -h for human-readable. Use df -i to check inode usage.', NULL),
    (1, 'How do you change file ownership?', 'chown user:group filename', 'easy', 'chown changes ownership. Can use just user or user:group. Add -R for recursive. Requires sudo for files you don''t own.', NULL),
    (1, 'What command displays or sets system hostname?', 'hostname', 'easy', 'hostname shows or sets system name. hostnamectl for systemd systems. /etc/hostname file persists across reboots.', NULL),
    (1, 'How do you compare two files line by line?', 'diff file1 file2', 'easy', 'diff shows differences between files. Use diff -u for unified format, diff -y for side-by-side. cmp for binary files.', NULL),
    (1, 'What command schedules a one-time task?', 'at time', 'medium', 'at schedules one-time execution. Example: echo "script.sh" | at 2:30 PM. atq lists pending, atrm removes. cron for recurring tasks.', NULL),
    (1, 'What is the difference between the tar command with -z and -j options?', 'The -z option compresses the archive using gzip compression, while the -j option compresses the archive using bzip2 compression. Gzip is generally faster but produces larger files, while bzip2 is slower but achieves better compression ratios.', 'medium', 'Both options add compression to tar archives, but they use different algorithms. Gzip (.gz) is the most common and faster option, while bzip2 (.bz2) provides better compression at the cost of speed. Choose based on your priority: speed vs. file size.', '# Using gzip compression
tar -czvf archive.tar.gz files/

# Using bzip2 compression
tar -cjvf archive.tar.bz2 files/'),
    (1, 'How would you extract files from a compressed tar.gz archive?', 'Use the command: tar -xzvf archive.tar.gz. The -x flag extracts files, -z handles gzip decompression, -v enables verbose output, and -f specifies the archive filename.', 'easy', 'Extraction is the reverse of creation. Replace -c (create) with -x (extract) while keeping the compression flag (-z for gzip) to properly decompress and extract the archive contents.', 'tar -xzvf archive.tar.gz

# Extract to specific directory
tar -xzvf archive.tar.gz -C /path/to/destination/'),
    (1, 'What happens to the original file when you use the gzip command on it?', 'The original file is replaced with a compressed version. The file is compressed and renamed with a .gz extension. For example, ''file.txt'' becomes ''file.txt.gz'' and the original uncompressed file is deleted.', 'easy', 'Unlike some compression tools, gzip does not keep the original file by default. To preserve the original file, you need to use the -k (keep) option: gzip -k file.txt', '# Original file is replaced
gzip file.txt
# Result: file.txt.gz (file.txt is deleted)

# Keep original file
gzip -k file.txt
# Result: both file.txt and file.txt.gz exist'),
    (1, 'How would you decompress a .gz file and what command option is used?', 'Use the command: gzip -d file.txt.gz. The -d option stands for decompress and will restore the original uncompressed file.', 'easy', 'The -d flag tells gzip to decompress rather than compress. Alternatively, you can use the gunzip command which is equivalent to gzip -d. After decompression, the .gz file is removed and replaced with the original file.', '# Method 1: using gzip with -d
gzip -d file.txt.gz

# Method 2: using gunzip
gunzip file.txt.gz

# Both produce: file.txt'),
    (1, 'What is the purpose of the -v option in tar commands and when would you use it?', 'The -v option enables verbose mode, which displays the names of files being processed during archive creation or extraction. It''s useful for monitoring progress, debugging, and confirming which files are included in the operation.', 'easy', 'Verbose mode provides real-time feedback about the tar operation. This is particularly helpful when working with large archives, troubleshooting issues, or when you need to verify specific files are being processed correctly.', '# Without verbose - no output
tar -czf archive.tar.gz files/

# With verbose - shows each file
tar -czvf archive.tar.gz files/
# Output:
# files/
# files/file1.txt
# files/file2.txt'),
    (1, 'How would you create a zip archive containing an entire directory and its subdirectories?', 'Use the command: zip -r archive.zip directory/. The -r option recursively includes all files and subdirectories within the specified directory.', 'medium', 'The -r (recursive) flag is essential when archiving directories with zip. Without it, only the directory structure would be added without the files inside subdirectories. This differs from tar which handles directories recursively by default.', '# Recursively zip a directory
zip -r archive.zip myproject/

# Without -r (wrong - misses subdirectory contents)
zip archive.zip myproject/

# Exclude specific files
zip -r archive.zip myproject/ -x ''*.log'''),
    (1, 'What is the difference between tar and zip commands for creating archives?', 'Tar creates tape archives and requires separate compression tools (gzip/bzip2) via options like -z or -j, while zip creates compressed archives in a single step. Tar is more common in Unix/Linux environments and preserves file permissions better, while zip is more universal across different operating systems.', 'medium', 'Tar (tape archive) was originally designed for sequential tape backups and bundles files without compression. Zip combines archiving and compression in one format. Tar with gzip (tar.gz or .tgz) is the standard in Linux, while zip is more compatible with Windows systems.', '# Tar with gzip (two-step process, one command)
tar -czvf archive.tar.gz files/

# Zip (archiving + compression in one)
zip -r archive.zip files/

# Tar preserves permissions, symbolic links better
# Zip is more cross-platform compatible'),
    (1, 'In a production environment, you need to backup a large directory structure efficiently. Which compression method would you choose and why?', 'For large directories, use tar with gzip (tar -czvf) for speed, or tar with bzip2 (tar -cjvf) for better compression. For production backups, gzip is typically preferred because it offers a good balance of compression ratio and speed, allowing faster backup completion times while still reducing storage requirements significantly.', 'hard', 'The choice depends on priorities: gzip is faster and adequate for most cases, bzip2 saves more space but takes longer, and modern alternatives like xz or zstd offer even better options. Consider backup windows, storage costs, and restore time requirements. For very large datasets, parallel compression tools like pigz can utilize multiple CPU cores.', '# Fast backup with gzip (recommended for most cases)
tar -czvf backup-$(date +%Y%m%d).tar.gz /data/

# Maximum compression with bzip2 (slower)
tar -cjvf backup-$(date +%Y%m%d).tar.bz2 /data/

# Parallel gzip for speed on multi-core systems
tar -c /data/ | pigz > backup-$(date +%Y%m%d).tar.gz'),
    (1, 'What command would you use to display all system information including kernel name, version, and hardware architecture in a single command?', '**`uname -a`** is the command that displays comprehensive system information in a single line.

The **`uname`** (Unix name) command retrieves system information from the kernel, and the **`-a`** (all) flag combines all available information fields into one output. This provides a complete snapshot of your system''s identity, including **kernel name**, **hostname**, **kernel release version**, **kernel build date/time**, **machine hardware architecture**, **processor type**, **hardware platform**, and **operating system**.

This command is particularly useful for **system administrators**, **DevOps engineers**, and during **troubleshooting sessions** when you need to quickly identify system specifications, verify compatibility requirements, or document environment details for bug reports.', 'easy', '## Real-World Use Cases

**System Diagnostics & Troubleshooting:**
- Quickly identify if you''re running a 32-bit or 64-bit system (`x86_64` vs `i686`)
- Verify kernel version when troubleshooting driver compatibility issues
- Check system architecture before installing software packages

**DevOps & Automation:**
- Scripts often use `uname` to detect the operating system and adjust behavior accordingly
- CI/CD pipelines use it to verify build environment specifications
- Configuration management tools (Ansible, Chef) use it for conditional logic

**Documentation & Support:**
- Essential information when filing bug reports or requesting technical support
- Documenting infrastructure for compliance or audit purposes
- Verifying production vs staging environment differences

## Individual Flags Breakdown

Instead of `-a`, you can use specific flags for targeted information:
- **`uname -s`**: Kernel name (Linux, Darwin, etc.)
- **`uname -n`**: Network node hostname
- **`uname -r`**: Kernel release version
- **`uname -v`**: Kernel version with build date
- **`uname -m`**: Machine hardware name (x86_64, arm64, etc.)
- **`uname -p`**: Processor type
- **`uname -i`**: Hardware platform
- **`uname -o`**: Operating system name

## Pro Tips

*Combine with other commands for specific needs:*
- Use `uname -r` alone when you only need kernel version for package installations
- Pipe to `awk` or `cut` to extract specific fields in scripts
- Common in Dockerfiles and provisioning scripts to ensure environment consistency', '# Display all system information
uname -a
# Output example:
# Linux myserver 5.15.0-56-generic #62-Ubuntu SMP Tue Nov 22 19:54:14 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

# Get only the kernel version (useful for scripting)
uname -r
# Output: 5.15.0-56-generic

# Get machine architecture (useful for package selection)
uname -m
# Output: x86_64

# Practical script example: Check if system is 64-bit
if [ "$(uname -m)" = "x86_64" ]; then
    echo "64-bit system detected"
else
    echo "32-bit system detected"
fi

# Store system info in a variable
SYS_INFO=$(uname -a)
echo "System: $SYS_INFO"'),
    (1, 'How would you check the disk space usage of all mounted filesystems in a human-readable format (GB, MB)?', 'df -h', 'easy', 'The df (disk free) command shows disk space usage of filesystems. The -h option converts the output to human-readable format using units like GB, MB, and KB instead of raw byte counts, making it easier to interpret.', 'df -h
# Output shows filesystem, size, used, available, use%, and mounted on'),
    (1, 'What is the difference between ''df'' and ''du'' commands, and when would you use each?', 'df shows disk space usage at the filesystem level (overall disk usage), while du estimates file and directory space usage at the file/directory level. Use df to check overall disk space availability, and du to find which directories or files are consuming space.', 'medium', 'df operates on mounted filesystems and shows total, used, and available space for entire partitions. du traverses directories and calculates actual disk usage of files and folders. In troubleshooting, you''d use df to identify if a disk is full, then use du to find what''s consuming the space.', 'df -h /home
du -sh /home/user/*
# df shows partition stats, du shows per-directory usage'),
    (1, 'How would you quickly find the total size of a specific directory without seeing subdirectory details?', 'du -sh directory/', 'medium', 'The du command with -s (summarize) displays only the total size, and -h (human-readable) formats it in KB/MB/GB. Without -s, du would show sizes for all subdirectories as well, which can be overwhelming for large directory trees.', 'du -sh /var/log/
# Output: 2.3G    /var/log/'),
    (1, 'What command would you use during an interview to check if a system is running out of memory, and what key metrics would you look for?', 'free -h. Key metrics to check: available memory, swap usage, and buffers/cache. High swap usage with low available memory indicates memory pressure.', 'medium', 'The free command displays memory usage including total, used, free, shared, buff/cache, and available memory. The -h flag makes it human-readable. In production systems, high swap usage combined with low available memory suggests the system needs more RAM or memory optimization.', 'free -h
# Check ''available'' column and ''Swap used''
# High swap + low available = memory pressure'),
    (1, 'If you need to diagnose system performance issues, which command would show how long the system has been running and the current load average?', 'uptime', 'easy', 'The uptime command displays the current time, how long the system has been running, number of logged-in users, and the load average for the past 1, 5, and 15 minutes. Load averages help identify if the system is overloaded - values higher than the number of CPU cores indicate potential performance issues.', 'uptime
# Output: 14:23:45 up 10 days, 3:24, 2 users, load average: 0.52, 0.58, 0.59'),
    (1, 'What command would you use to identify the CPU architecture, number of cores, and CPU model during system auditing?', 'lscpu', 'easy', 'lscpu gathers and displays CPU architecture information from /proc/cpuinfo in a structured format. It shows details like architecture (x86_64, ARM), CPU op-modes, cores per socket, threads per core, CPU model name, and cache sizes - essential for capacity planning and performance optimization.', 'lscpu
# Shows: Architecture, CPU(s), Thread(s) per core, Model name, CPU MHz, Caches'),
    (1, 'How would you list all PCI devices to check if a network card or graphics card is properly detected by the system?', 'lspci', 'easy', 'lspci lists all PCI (Peripheral Component Interconnect) devices connected to the system, including network cards, graphics cards, storage controllers, and USB controllers. This is useful for hardware troubleshooting to verify if devices are detected at the hardware level.', 'lspci
# To see more details:
lspci -v
# To filter for network cards:
lspci | grep -i network'),
    (1, 'What is the quickest way to verify if a USB device is recognized by the Linux system?', 'lsusb', 'easy', 'lsusb lists all USB devices connected to the system. It shows the bus number, device number, USB ID (vendor:product), and device name. This is the first step in troubleshooting USB device issues - if the device doesn''t appear in lsusb output, it''s either a hardware connection problem or the device is faulty.', 'lsusb
# Output: Bus 001 Device 003: ID 046d:c52b Logitech, Inc. Unifying Receiver
# For more details:
lsusb -v'),
    (1, 'In a troubleshooting scenario, you need to quickly identify which user account is running a script. Which command provides this information?', 'whoami', 'easy', 'whoami displays the username of the current effective user. This is particularly useful when troubleshooting permission issues, verifying service account context, or confirming successful user switching with su or sudo. It''s simpler than checking environment variables like $USER or running ''id'' command.', 'whoami
# Output: username
# Compare with: sudo whoami
# Output: root');

-- Flashcards for Git (25 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (2, 'How do you undo the last commit but keep the changes?', 'git reset --soft HEAD~1', 'medium', '--soft keeps changes staged, HEAD~1 refers to one commit before HEAD. Use --mixed to unstage or --hard to discard changes.', NULL),
    (2, 'What command shows the commit history in a compact one-line format?', 'The **`git log --oneline`** command displays the commit history in a compact format, showing each commit on a single line with an **abbreviated commit hash** (first 7 characters) and the **commit message**.

This is particularly useful when you need to:
- Quickly scan through project history without excessive detail
- Find specific commits by their messages
- Get an overview before performing operations like cherry-picking or rebasing
- Share a concise history summary with team members

You can enhance this command with additional flags like **`--graph`** for visual branch structure, **`--all`** to see all branches, and **`--decorate`** to show branch/tag references.', 'easy', 'The `--oneline` flag is one of the most frequently used Git log options in professional workflows because it transforms verbose commit information into a scannable format. Instead of showing full commit hashes, author details, dates, and multi-line messages, it condenses everything to essentials.

**Common real-world use cases:**

1. **Code reviews**: Quickly identify which commits are part of a feature branch
2. **Debugging**: Scan through recent changes to find when a bug was introduced
3. **Release planning**: Review what commits will be included in the next deployment
4. **Team standups**: Share a visual representation of your recent work

**Powerful combinations:**
- `git log --oneline --graph --all` - *Visual representation of entire repository history*
- `git log --oneline -n 10` - *Last 10 commits only*
- `git log --oneline --author="John"` - *Commits by specific author*
- `git log --oneline main..feature` - *Commits in feature branch not in main*

The abbreviated hash shown is still unique enough for most Git operations, and Git will auto-complete it when you use commands like `git show` or `git checkout`.', '# Basic compact history
git log --oneline
# Output:
# a1b2c3d Fix authentication bug
# e4f5g6h Add user profile feature
# i7j8k9l Update dependencies

# With visual branch structure
git log --oneline --graph --all
# Output:
# * a1b2c3d (HEAD -> main) Merge branch ''feature''
# |\  
# | * e4f5g6h (feature) Add user profile
# | * i7j8k9l Update UI components
# |/  
# * j1k2l3m Initial commit

# Last 5 commits with decorations
git log --oneline --decorate -5
# Output:
# a1b2c3d (HEAD -> main, origin/main) Fix bug
# e4f5g6h (tag: v1.2.0) Release version 1.2.0

# Compare branches
git log --oneline main..feature-branch'),
    (2, 'How do you rebase your current branch onto main?', 'To rebase your current branch onto main, use `git rebase main`. This command takes all commits from your current branch that aren''t in main, temporarily removes them, updates your branch to match main''s latest state, then reapplies your commits one by one on top.

Before rebasing, ensure your working directory is clean and you''ve fetched the latest changes with `git fetch origin main`. If conflicts occur during rebase, Git will pause and allow you to resolve them. After fixing conflicts, stage the changes with `git add` and continue with `git rebase --continue`. Use `git rebase --abort` to cancel and return to the pre-rebase state.', 'medium', 'Rebasing is preferred over merging in many workflows because it creates a linear, cleaner commit history without merge commits. This is especially valuable in team environments where a clear project timeline matters.

Real-world use case: You''re working on a feature branch for 3 days while your team merges 20 commits to main. Before creating a pull request, you rebase to incorporate those changes and ensure your feature works with the latest codebase. This prevents integration issues and makes code review easier.

Important caveat: Never rebase commits that have been pushed to a shared/public branch, as it rewrites history and will cause conflicts for other developers. Rebasing is safe for local branches or personal feature branches that haven''t been shared. For collaborative branches, use `git merge` instead.', '# Step 1: Fetch latest changes from remote
git fetch origin main

# Step 2: Switch to your feature branch (if not already on it)
git checkout feature-branch

# Step 3: Rebase onto main
git rebase main

# If conflicts occur:
# Step 4a: Resolve conflicts in your editor
# Step 4b: Stage resolved files
git add <resolved-files>

# Step 4c: Continue the rebase
git rebase --continue

# Or abort if needed
git rebase --abort

# Step 5: Force push to update remote feature branch (if already pushed)
git push --force-with-lease origin feature-branch'),
    (2, 'What command shows which commit and author last modified each line of a file?', 'git blame filename', 'easy', 'git blame annotates each line with the commit hash, author, and timestamp of the last modification.', NULL),
    (2, 'How do you create and switch to a new branch in one command?', 'git checkout -b branch-name', 'easy', 'The -b flag creates a new branch and switches to it. In Git 2.23+, you can also use: git switch -c branch-name', NULL),
    (2, 'How do you stash changes including untracked files?', 'git stash -u', 'medium', '-u includes untracked files in the stash. Use git stash pop to apply and remove stash, or git stash apply to keep it.', NULL),
    (2, 'What command shows the difference between two branches?', 'git diff branch1..branch2', 'medium', 'Shows differences between two branches. Use --name-only to see just filenames, or --stat for summary statistics.', NULL),
    (2, 'How do you amend the last commit message?', 'git commit --amend', 'easy', '--amend replaces the last commit with a new one. Add -m "new message" to change message without editor. WARNING: Don''t amend pushed commits.', NULL),
    (2, 'What command shows all branches including remotes?', 'git branch -a', 'easy', '-a shows all branches (local and remote). Use -r for remote only, -v for verbose with last commit info.', NULL),
    (2, 'How do you cherry-pick a commit from another branch?', 'git cherry-pick <commit-hash>', 'medium', 'Cherry-pick applies a specific commit to your current branch. Use -x to add source reference in commit message.', NULL),
    (2, 'What is the difference between merge and rebase?', 'Merge combines two branches by creating a new merge commit that ties together the histories of both branches, preserving the complete branching structure. Rebase moves or replays your commits on top of another branch, rewriting commit history to create a linear sequence. The key difference: merge preserves the true history of how development happened, while rebase rewrites history to appear as if all changes were made sequentially.', 'medium', 'Use merge when working on public/shared branches or when you want to preserve the context of when branches diverged and merged. It''s the safer option because it doesn''t alter existing commits. For example, merging a feature branch into main creates a merge commit showing when the feature was integrated.

Use rebase when working on private feature branches before pushing, or to clean up local commit history. It creates a cleaner, linear history that''s easier to follow. For instance, rebasing your feature branch onto the latest main before creating a pull request ensures your changes apply cleanly on top of the newest code.

Real-world scenario: You''re working on a feature branch for 3 days. Meanwhile, main has 10 new commits. With merge, you get all 10 commits plus your work plus a merge commit (showing parallel development). With rebase, your commits are replayed on top of those 10 commits as if you just started working today (linear history).

Critical rule: Never rebase commits that have been pushed to shared branches, as this rewrites history and causes conflicts for other developers.', '# MERGE: Preserves branch history
git checkout main
git merge feature-branch
# Creates a merge commit, history shows branching

# REBASE: Creates linear history
git checkout feature-branch
git rebase main
# Replays feature commits on top of main
# Then fast-forward merge:
git checkout main
git merge feature-branch

# Visual representation:
# MERGE:           REBASE:
#   A---B---C main    A---B---C---D''---E'' main
#    \       /                    (linear)
#     D---E feature'),
    (2, 'How do you undo changes to a specific file?', 'To undo changes to a specific file in Git, use:

**Modern approach (Git 2.23+):** `git restore <filename>` - This is the preferred, more intuitive command.

**Legacy approach:** `git checkout -- <filename>` - Still works but less clear in intent.

Both commands discard unstaged changes in your working directory and revert the file to match the last committed version (HEAD). Important: This operation is destructive and cannot be undone - your local changes will be permanently lost.', 'easy', 'Understanding how to undo file changes is critical for recovering from mistakes and managing your working directory.

**Common scenarios:**
- You made experimental changes that didn''t work out
- You accidentally modified a configuration file
- You want to start fresh with a clean version from the last commit

**Important distinctions:**
- `git restore <filename>` - Discards unstaged changes only
- `git restore --staged <filename>` - Unstages a file (removes from staging area but keeps changes)
- `git restore --source=HEAD~1 <filename>` - Restores from a specific commit

**Real-world example:** You''re debugging and added console.log() statements throughout app.js. After fixing the bug, instead of manually removing each log statement, you can restore the clean version from your last commit.

**Safety tip:** Before using restore/checkout, consider using `git diff <filename>` to review what changes you''re about to discard, or `git stash` if you might want those changes later.', '# Discard unstaged changes (modern way)
git restore app.js

# Discard unstaged changes (legacy way)
git checkout -- app.js

# Unstage a file but keep changes
git restore --staged app.js

# View changes before discarding
git diff app.js

# Discard all unstaged changes in current directory
git restore .

# Restore file from specific commit
git restore --source=abc123 app.js'),
    (2, 'What command shows which files are tracked by Git?', 'git ls-files', 'easy', 'Lists all files currently tracked by Git. Use git ls-files --others to see untracked files.', NULL),
    (2, 'How do you delete a remote branch?', 'git push origin --delete branch-name', 'medium', 'Deletes the branch from remote repository. Also works: git push origin :branch-name (push empty to branch)', NULL),
    (2, 'What command finds commits that introduced or removed a string?', 'git log -S "search-string"', 'hard', 'The -S option (pickaxe) finds commits that changed the number of occurrences of a string. Use -G for regex search.', NULL),
    (2, 'How do you view changes between working directory and staging area?', 'git diff', 'easy', 'git diff shows unstaged changes. git diff --staged shows staged changes. git diff HEAD shows all changes from last commit.', NULL),
    (2, 'What command shows remote repository URLs?', 'git remote -v', 'easy', '-v shows fetch and push URLs. git remote add name url adds new remote. git remote show origin for detailed info.', NULL),
    (2, 'How do you fetch and merge in one command?', 'git pull', 'easy', 'git pull = git fetch + git merge. Use git pull --rebase to rebase instead of merge. Specify branch: git pull origin main', NULL),
    (2, 'What is git reflog used for?', 'Shows history of HEAD movements, useful for recovering lost commits', 'hard', 'reflog tracks all reference updates even after rebases or resets. Use to recover "lost" commits. Entries expire after 90 days.', NULL),
    (2, 'How do you temporarily save work without committing?', 'git stash', 'medium', 'Stashes uncommitted changes. git stash pop applies and removes, git stash apply keeps stash. git stash list shows all stashes.', NULL),
    (2, 'What command removes untracked files?', 'git clean -fd', 'medium', '-f forces removal, -d removes directories. Add -n for dry run (preview). WARNING: This permanently deletes files!', NULL),
    (2, 'How do you show commits by a specific author?', 'git log --author="name"', 'medium', 'Filters commit history by author. Combine with other flags: git log --author="name" --since="2 weeks ago" --oneline', NULL),
    (2, 'What is the difference between merge --squash and regular merge?', 'Squash combines all commits into one; regular merge preserves individual commits', 'hard', 'Squash creates single commit with all changes, loses individual commit history. Useful for cleaning up feature branch history.', NULL),
    (2, 'How do you tag a specific commit?', 'git tag tag-name commit-hash', 'medium', 'Tags mark specific points in history (releases). Lightweight: git tag v1.0. Annotated: git tag -a v1.0 -m "message". Push: git push --tags', NULL),
    (2, 'What command shows the graph of branches?', 'git log --graph --oneline --all', 'medium', '--graph shows ASCII branch structure, --all includes all branches. Add --decorate to show branch/tag names.', NULL);

-- Flashcards for Kubernetes (33 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (3, 'What command gets all pods in all namespaces?', 'kubectl get pods --all-namespaces or kubectl get pods -A

Both commands display all pods across every namespace in your Kubernetes cluster. The -A flag is the shorthand version of --all-namespaces. The output shows pod name, ready status, restart count, age, and the namespace each pod belongs to. This is essential for getting a cluster-wide view of running workloads.', 'easy', 'This command is crucial for cluster administrators and DevOps engineers who need visibility across the entire cluster. By default, kubectl commands only show resources in the current namespace (or ''default'' if not specified), which can hide problems in other namespaces.

Common use cases include: troubleshooting cluster-wide issues (finding crashed pods anywhere), auditing resource usage across teams/projects (each using different namespaces), monitoring during deployments, and investigating performance issues. For example, if users report slow application response, you might run this command to check if any pods are in CrashLoopBackOff state in any namespace.

Pro tip: Combine with -o wide to see which nodes pods are running on, or add --watch to monitor pods in real-time. You can also use grep to filter results: kubectl get pods -A | grep -i error.', '# Basic command - shows all pods across all namespaces
kubectl get pods --all-namespaces

# Shorthand version (recommended)
kubectl get pods -A

# With additional details (node, IP)
kubectl get pods -A -o wide

# Watch for changes in real-time
kubectl get pods -A --watch

# Filter by status or name pattern
kubectl get pods -A | grep -E ''CrashLoop|Error''

# Formatted output with custom columns
kubectl get pods -A -o custom-columns=NAMESPACE:.metadata.namespace,NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName'),
    (3, 'How do you scale a deployment to 5 replicas?', 'To scale a deployment to 5 replicas, use: `kubectl scale deployment/my-deployment --replicas=5`. You can also use shorter syntax like `kubectl scale deploy my-deployment --replicas=5`. The command updates the deployment''s desired replica count, and Kubernetes automatically creates or terminates pods to match this number. You can verify the scaling with `kubectl get deployment my-deployment` or watch the changes in real-time using `kubectl get pods -w`.', 'easy', 'Scaling deployments is a fundamental Kubernetes operation for handling varying workloads. In production, you might scale up during peak hours (e.g., scaling a web application from 3 to 10 replicas during Black Friday sales) or scale down during off-peak times to save resources. The scaling operation is declarative - Kubernetes reconciles the current state with the desired state by gradually creating new pods or gracefully terminating excess ones. This ensures zero-downtime scaling for stateless applications. Alternative approaches include: editing the deployment YAML directly (`kubectl edit deployment my-deployment`), applying an updated manifest file, or using Horizontal Pod Autoscaler (HPA) for automatic scaling based on CPU/memory metrics. The scale command is immediate but pod creation time depends on factors like image pull time, resource availability, and readiness probes.', '# Scale deployment to 5 replicas
kubectl scale deployment/my-deployment --replicas=5

# Verify the scaling operation
kubectl get deployment my-deployment
# Output shows READY, UP-TO-DATE, AVAILABLE columns

# Watch pods being created/terminated in real-time
kubectl get pods -l app=my-app -w

# Scale using deployment manifest (alternative)
kubectl patch deployment my-deployment -p ''{"spec":{"replicas":5}}''

# Check rollout status
kubectl rollout status deployment/my-deployment'),
    (3, 'What is a Pod in Kubernetes?', 'A **Pod** is the smallest and most basic deployable unit in Kubernetes that represents a **single instance of a running process** in your cluster. A Pod encapsulates one or more containers (typically Docker containers), storage resources, a unique network IP, and options that govern how the container(s) should run.

While Pods *can* contain multiple containers, the most common pattern is **one container per Pod**. Multi-container Pods are used when containers are tightly coupled and need to share resources (e.g., a main application container with a sidecar logging container).

Pods are **ephemeral and disposable** by design—they can be created, destroyed, and replaced dynamically. In practice, you rarely create Pods directly; instead, you use higher-level controllers like **Deployments**, **StatefulSets**, or **DaemonSets** to manage them.', 'easy', '**Key Characteristics of Pods:**

- **Shared Network Namespace**: All containers in a Pod share the same IP address and port space, and can communicate via `localhost`
- **Shared Storage Volumes**: Containers can share data through mounted volumes
- **Co-located and Co-scheduled**: All containers in a Pod are always scheduled on the same node
- **Atomic Unit**: Pods are scaled up or down as a unit (you scale the number of Pods, not containers within a Pod)

**Real-World Use Cases:**

1. **Single Container Pod** (most common): A web server running NGINX or a microservice API
2. **Multi-Container Pod - Sidecar Pattern**: Main application container + logging agent (like Fluentd) that ships logs to a central system
3. **Multi-Container Pod - Ambassador Pattern**: Main container + proxy container that handles network communication
4. **Init Containers**: Special containers that run before app containers to perform setup tasks (e.g., database migrations)

**Important Interview Points:**

- Pods have a **lifecycle**: Pending → Running → Succeeded/Failed
- Each Pod gets a unique IP from the cluster''s Pod network (CIDR range)
- When a Pod dies, it''s replaced with a *new* Pod (new IP, new identity)
- For stateful applications requiring persistent identity, use **StatefulSets** instead of Deployments', '# Simple single-container Pod
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    ports:
    - containerPort: 80

---
# Multi-container Pod with sidecar pattern
apiVersion: v1
kind: Pod
metadata:
  name: app-with-sidecar
spec:
  containers:
  - name: main-app
    image: myapp:1.0
    ports:
    - containerPort: 8080
  - name: log-shipper
    image: fluentd:v1.14
    volumeMounts:
    - name: shared-logs
      mountPath: /var/log
  volumes:
  - name: shared-logs
    emptyDir: {}

# Common kubectl commands for Pods
# kubectl get pods
# kubectl describe pod <pod-name>
# kubectl logs <pod-name>
# kubectl exec -it <pod-name> -- /bin/bash'),
    (3, 'How do you view logs from a specific pod?', 'To view logs from a specific pod in Kubernetes, use the command `kubectl logs <pod-name>`. For pods with multiple containers, specify the container using `kubectl logs <pod-name> -c <container-name>`. You can follow logs in real-time with the `-f` flag, view logs from previously crashed containers with `--previous`, and limit log output using `--tail=<number>` or `--since=<time>` flags.', 'easy', 'Pod logs are essential for troubleshooting application issues, monitoring behavior, and debugging crashes in Kubernetes environments. In production scenarios, you might need to check logs when an application isn''t responding correctly, when pods are crash-looping, or when investigating performance issues. The `-f` (follow) flag is particularly useful during deployments to watch application startup in real-time. The `--previous` flag is critical for debugging crash loops, as it allows you to see what went wrong before the container restarted. For multi-container pods (like those using sidecar patterns with service meshes like Istio), specifying the container name with `-c` is necessary since each container has separate logs. Time-based filtering with `--since=1h` or `--since-time` helps narrow down issues to specific time windows, while `--tail=100` limits output for large log files.', '# Basic log viewing
kubectl logs my-pod

# Follow logs in real-time
kubectl logs my-pod -f

# Logs from specific container in multi-container pod
kubectl logs my-pod -c nginx-container

# View logs from crashed/previous container
kubectl logs my-pod --previous

# Last 100 lines of logs
kubectl logs my-pod --tail=100

# Logs from last hour
kubectl logs my-pod --since=1h

# Logs with timestamps
kubectl logs my-pod --timestamps=true

# All containers in a pod (Kubernetes 1.16+)
kubectl logs my-pod --all-containers=true'),
    (3, 'What command describes detailed information about a resource?', 'The **`kubectl describe`** command provides comprehensive, human-readable information about a specific Kubernetes resource, including its configuration, current state, related resources, and recent events.

The syntax is: **`kubectl describe <resource-type> <resource-name>`** or **`kubectl describe <resource-type>/<resource-name>`**

Key information returned includes:
- **Resource metadata** (name, namespace, labels, annotations)
- **Specification details** (desired state configuration)
- **Status information** (current state, conditions)
- **Events** (recent activity, errors, warnings)
- **Related resources** (volumes, services, endpoints)

This command is invaluable for **troubleshooting** as it shows the complete resource lifecycle and any issues that occurred.', 'easy', '**`kubectl describe`** is one of the most important debugging commands in Kubernetes. Unlike `kubectl get` which shows tabular summaries, `describe` provides a *detailed narrative* of what''s happening with a resource.

**Common use cases:**

1. **Troubleshooting pod failures** - The Events section shows why a pod failed to start (ImagePullBackOff, CrashLoopBackOff, insufficient resources)
2. **Checking resource allocation** - See actual CPU/memory requests and limits assigned
3. **Debugging networking issues** - View service endpoints and selector matches
4. **Investigating node problems** - Check node conditions, capacity, and allocated resources

**Practical scenarios:**
- When a pod won''t start, `describe` reveals if it''s due to missing secrets, failed health checks, or scheduling constraints
- For services not routing traffic correctly, it shows whether endpoints are being created
- When nodes are under pressure, it displays resource consumption and eviction warnings

**Pro tips:**
- Events are sorted chronologically and show the *last hour* of activity
- You can describe multiple resource types: `kubectl describe pods,services`
- Add `-n <namespace>` to target specific namespaces
- Events at the bottom are usually the most helpful for debugging', '# Basic usage - describe a specific pod
kubectl describe pod my-pod-123

# Describe using resource-type/name format
kubectl describe pod/my-pod-123

# Describe in a specific namespace
kubectl describe pod my-pod-123 -n production

# Describe multiple resources
kubectl describe pods my-pod-123 my-pod-456

# Describe all pods with a label
kubectl describe pods -l app=nginx

# Common resources to describe
kubectl describe node worker-node-1
kubectl describe service my-service
kubectl describe deployment my-app
kubectl describe pvc my-volume-claim

# Example output snippet (pod):
# Name:         my-pod-123
# Namespace:    default
# Status:       Running
# Containers:
#   nginx:
#     Image:        nginx:1.19
#     State:        Running
# Events:
#   Type    Reason     Age   Message
#   ----    ------     ----  -------
#   Normal  Scheduled  2m    Successfully assigned default/my-pod-123 to node-1
#   Normal  Pulling    2m    Pulling image "nginx:1.19"
#   Normal  Pulled     1m    Successfully pulled image
#   Normal  Created    1m    Created container nginx
#   Normal  Started    1m    Started container nginx'),
    (3, 'What is a Service in Kubernetes?', 'A **Service** in Kubernetes is an abstraction layer that provides a **stable network endpoint** to access a logical set of Pods. It acts as a load balancer with a **fixed IP address and DNS name** that remains constant, even as the underlying Pods are dynamically created, destroyed, or scaled.

Services solve the problem of **Pod ephemerality** - since Pods can have changing IP addresses and may be replaced at any time, Services provide a consistent way for applications to communicate with each other. They use **label selectors** to identify which Pods should receive traffic and automatically distribute requests across healthy Pod replicas.', 'easy', '**Why Services are Essential:**

In Kubernetes, Pods are ephemeral and can be created or destroyed frequently due to scaling, updates, or failures. Each Pod gets its own IP address, but these IPs change when Pods are recreated. Services solve this by providing a stable networking abstraction.

**Key Service Types:**

1. **ClusterIP** (default): Exposes the Service on an internal IP only accessible within the cluster - ideal for internal microservice communication
2. **NodePort**: Exposes the Service on each Node''s IP at a static port - useful for development or when you need external access without a load balancer
3. **LoadBalancer**: Creates an external load balancer (in cloud environments) - production-grade external access
4. **ExternalName**: Maps a Service to a DNS name - useful for integrating external services

**Real-World Use Cases:**

- **Microservices Communication**: A frontend service connecting to a backend API service without knowing individual Pod IPs
- **Database Access**: Applications connecting to a database StatefulSet through a stable Service endpoint
- **Blue-Green Deployments**: Switching traffic between different versions by updating Service selectors
- **Load Distribution**: Automatically balancing requests across multiple Pod replicas for high availability', '# Basic ClusterIP Service (internal access only)
apiVersion: v1
kind: Service
metadata:
  name: backend-service
spec:
  type: ClusterIP
  selector:
    app: backend  # Targets Pods with this label
    tier: api
  ports:
    - protocol: TCP
      port: 80        # Service port
      targetPort: 8080  # Pod port

---
# LoadBalancer Service (external access)
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  type: LoadBalancer
  selector:
    app: frontend
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000

---
# NodePort Service (external access via Node IP)
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: NodePort
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
      nodePort: 30080  # Accessible on <NodeIP>:30080'),
    (3, 'How do you execute a command inside a running pod?', 'kubectl exec -it pod-name -- command', 'easy', '-it provides interactive terminal. For multiple containers, add -c container-name. Example: kubectl exec -it my-pod -- /bin/bash', NULL),
    (3, 'What are the main types of Kubernetes Services?', 'ClusterIP, NodePort, LoadBalancer, and ExternalName', 'medium', 'ClusterIP (default) is internal only, NodePort exposes on node IP, LoadBalancer uses cloud provider, ExternalName maps to DNS.', NULL),
    (3, 'How do you create a ConfigMap from a file?', 'kubectl create configmap name --from-file=path/to/file', 'medium', 'ConfigMaps store non-sensitive configuration data. Use --from-literal for key-value pairs: kubectl create configmap name --from-literal=key=value', NULL),
    (3, 'What is a Namespace in Kubernetes?', 'A virtual cluster for organizing and isolating resources', 'easy', 'Namespaces provide scope for resource names and can have resource quotas. Default namespace is "default".', NULL),
    (3, 'How do you roll back a deployment to previous version?', 'kubectl rollout undo deployment/name', 'medium', 'Undo reverts to previous revision. Use --to-revision=N for specific version. Check history with: kubectl rollout history deployment/name', NULL),
    (3, 'What command applies a YAML configuration file?', 'kubectl apply -f filename.yaml', 'easy', 'apply creates or updates resources from YAML. Use -f for file, -k for kustomize directory, or - for stdin.', NULL),
    (3, 'What is a DaemonSet?', 'A controller that ensures all (or some) nodes run a copy of a Pod', 'medium', 'DaemonSets are typically used for node-level services like log collectors, monitoring agents, or network plugins.', NULL),
    (3, 'How do you get resource usage of nodes?', 'kubectl top nodes', 'easy', 'Shows CPU and memory usage of nodes. Requires Metrics Server. Use kubectl top pods for pod-level metrics.', NULL),
    (3, 'What is the difference between a Deployment and StatefulSet?', 'Deployments manage stateless apps; StatefulSets manage stateful apps with stable network identities', 'hard', 'StatefulSets provide ordered deployment, stable hostnames, and persistent storage per pod. Deployments treat pods as interchangeable.', NULL),
    (3, 'What is a ReplicaSet?', 'Ensures a specified number of pod replicas are running at any time', 'medium', 'Usually managed by Deployment. Maintains desired replica count, creates/deletes pods as needed. Selects pods using labels.', NULL),
    (3, 'How do you port-forward to a pod?', 'kubectl port-forward pod-name local-port:pod-port', 'easy', 'Creates tunnel from local machine to pod. Example: kubectl port-forward my-pod 8080:80 accesses pod port 80 on localhost:8080', NULL),
    (3, 'What is a PersistentVolumeClaim (PVC)?', 'A request for storage by a user', 'medium', 'PVC is a request, PV is the actual storage. Pod uses PVC, cluster binds PVC to available PV matching requirements.', NULL),
    (3, 'How do you edit a resource in-place?', 'kubectl edit <resource-type> <name>', 'easy', 'Opens resource in editor (vim/nano). Changes applied on save. Example: kubectl edit deployment my-app', NULL),
    (3, 'What is a Kubernetes Secret?', 'Object that stores sensitive data like passwords, tokens, or keys', 'easy', 'Base64 encoded (not encrypted). Mounted as files or environment variables. Use external secrets manager for production.', NULL),
    (3, 'How do you see resource usage of pods?', 'kubectl top pod', 'easy', 'Shows CPU and memory usage. Requires Metrics Server. Add --containers for per-container metrics, -n namespace for specific namespace.', NULL),
    (3, 'What is the difference between a Job and CronJob?', 'Job runs once to completion; CronJob runs Jobs on a schedule', 'medium', 'Job ensures pods successfully complete. CronJob uses cron syntax for scheduling. Example: backup jobs, batch processing.', NULL),
    (3, 'How do you drain a node for maintenance?', 'kubectl drain node-name --ignore-daemonsets', 'medium', 'Safely evicts all pods from node. --ignore-daemonsets skips DaemonSet pods. kubectl uncordon node-name to re-enable scheduling.', NULL),
    (3, 'What is an Ingress?', 'Manages external access to services, typically HTTP/HTTPS', 'medium', 'Provides load balancing, SSL termination, name-based virtual hosting. Requires Ingress Controller (nginx, traefik, etc.).', NULL),
    (3, 'How do you copy files from a pod to local machine?', 'kubectl cp pod-name:/path/to/file ./local-path', 'medium', 'Works both directions. For multi-container pods: kubectl cp pod-name:/path ./local -c container-name', NULL),
    (3, 'What is BGP (Border Gateway Protocol)?', 'Protocol that routes traffic between autonomous systems on the internet', 'hard', 'Path vector protocol. Exchanges routing information between ISPs. Policy-based routing. Critical for internet infrastructure.', NULL),
    (3, 'What is ETCDCTL?', 'The CLI tool used to interact with ETCD', 'easy', 'ETCDCTL is the command-line interface for managing and querying the ETCD distributed key-value store, which stores Kubernetes cluster state.', NULL),
    (3, 'What are the two API versions ETCDCTL supports?', 'Version 2 and Version 3', 'easy', 'ETCDCTL can interact with ETCD using either API version 2 or version 3. Each version has different commands and capabilities.', NULL),
    (3, 'What is the default ETCDCTL API version?', 'Version 2', 'medium', 'When the ETCDCTL_API environment variable is not set, ETCDCTL defaults to API version 2. This means version 3 commands won''t work without explicitly setting the version.', NULL),
    (3, 'How do you set ETCDCTL to use API version 3?', 'export ETCDCTL_API=3', 'easy', 'Set the environment variable ETCDCTL_API=3 to enable version 3 commands. Without this, version 3 commands like "snapshot save" and "get" will not work.', NULL),
    (3, 'Why does ETCDCTL require certificate files?', '**ETCDCTL requires certificate files to authenticate and establish secure TLS communication with the ETCD API server.** Since ETCD stores critical cluster state and configuration data (particularly in Kubernetes), it enforces **mutual TLS (mTLS) authentication** by default to prevent unauthorized access.

Without proper certificates, ETCDCTL commands will fail with authentication errors. The three required certificate files are:
- **`--cacert`**: Certificate Authority (CA) certificate to verify the server''s identity
- **`--cert`**: Client certificate to prove the client''s identity
- **`--key`**: Private key corresponding to the client certificate

This security mechanism ensures that only authenticated clients can read or modify the cluster''s data store, protecting against unauthorized access, data breaches, and tampering.', 'medium', '**Real-World Context:**

In production Kubernetes clusters, ETCD contains *all cluster state* including Secrets, ConfigMaps, Pod definitions, and authentication tokens. A compromised ETCD instance means complete cluster compromise. Therefore, **TLS authentication is mandatory**, not optional.

**Common Use Cases:**

1. **Backup Operations**: When backing up ETCD data, you must authenticate with certificates to access the cluster state
2. **Debugging Cluster Issues**: Checking ETCD health or retrieving specific keys requires authenticated access
3. **Disaster Recovery**: Restoring ETCD snapshots requires proper authentication to prevent unauthorized restoration
4. **Certificate Rotation**: During certificate updates, you need valid certificates to access ETCD and update configurations

**Certificate Location in Kubernetes:**

In most Kubernetes installations, ETCD certificates are stored at:
- **CA cert**: `/etc/kubernetes/pki/etcd/ca.crt`
- **Client cert**: `/etc/kubernetes/pki/etcd/server.crt`
- **Client key**: `/etc/kubernetes/pki/etcd/server.key`

**Important Note**: Without these certificates, even the root user on the ETCD server cannot access the database, demonstrating the strength of the security model.', '# Basic ETCDCTL command with required certificates
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  get / --prefix --keys-only

# Creating an ETCD snapshot (common backup scenario)
ETCDCTL_API=3 etcdctl snapshot save /backup/etcd-snapshot.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Checking ETCD cluster health
ETCDCTL_API=3 etcdctl endpoint health \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

# Without certificates, you''ll get an error like:
# Error: context deadline exceeded
# OR
# Error: x509: certificate signed by unknown authority'),
    (3, 'Where are ETCD certificate files typically located?', '/etc/kubernetes/pki/etcd/', 'medium', 'Certificate files are usually at /etc/kubernetes/pki/etcd/ including ca.crt (CA certificate), server.crt (server certificate), and server.key (server key).', NULL),
    (3, 'How do you execute ETCDCTL inside a Kubernetes etcd pod?', 'kubectl exec etcd-controlplane -n kube-system -- sh -c "ETCDCTL_API=3 etcdctl command"', 'hard', 'Use kubectl exec to run commands in the etcd pod. Must set ETCDCTL_API=3 and include certificate flags for authentication. The etcd pod typically runs in kube-system namespace.', NULL);

-- Flashcards for ArgoCD (25 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (4, 'What is GitOps?', 'A deployment methodology where Git serves as the single source of truth for declarative infrastructure and applications', 'easy', 'Changes are made via Git commits, and automated processes sync the desired state to the cluster.', NULL),
    (4, 'How do you sync an ArgoCD application from the CLI?', 'To sync an ArgoCD application from the CLI, use the command **`argocd app sync <app-name>`**. This triggers ArgoCD to reconcile the live cluster state with the desired state defined in Git.

Key sync options include:
- **`--force`**: Performs a hard refresh, bypassing ArgoCD''s normal sync optimization
- **`--prune`**: Removes resources that exist in the cluster but not in Git
- **`--dry-run`**: Previews what changes would be applied without executing them
- **`--async`**: Returns immediately without waiting for sync completion
- **`--resource`**: Syncs only specific resources (e.g., `--resource=Deployment:my-app`)', 'easy', '**Syncing is the core operation in ArgoCD** that applies your Git repository''s configuration to the Kubernetes cluster. When you run a sync command, ArgoCD compares the desired state (Git) with the actual state (cluster) and applies necessary changes.

**Common real-world scenarios:**

1. **Manual deployment after code review**: After merging a PR, you might manually sync to deploy changes immediately rather than waiting for automatic sync
2. **Force sync for stuck applications**: When resources are in an inconsistent state or have been manually modified in the cluster, `--force` bypasses the cache and reapplies everything
3. **Pruning orphaned resources**: Use `--prune` to clean up resources that were removed from Git but still exist in the cluster
4. **Selective resource updates**: In microservices architectures, you might sync only a specific Deployment or Service using `--resource` flags

**Best practices:**
- Always check application status with `argocd app get <app-name>` before syncing
- Use `--dry-run` in production to verify changes before applying
- Combine `--prune` with caution in production environments to avoid accidental deletions
- Monitor sync progress with `argocd app wait <app-name>` for synchronous operations', '# Basic sync
argocd app sync my-application

# Force sync with pruning (useful for stuck apps)
argocd app sync my-application --force --prune

# Dry-run to preview changes
argocd app sync my-application --dry-run

# Sync specific resources only
argocd app sync my-application \
  --resource=Deployment:backend \
  --resource=Service:backend

# Async sync and monitor separately
argocd app sync my-application --async
argocd app wait my-application --timeout 300

# Sync with selective sync (only out-of-sync resources)
argocd app sync my-application --strategy=apply'),
    (4, 'What are the three main sync strategies in ArgoCD?', 'Manual, Automatic, and Automated with self-heal', 'medium', 'Manual requires explicit sync, Automatic syncs on Git changes, Self-heal also reverts manual cluster changes.', NULL),
    (4, 'How do you view the sync status of all applications?', 'argocd app list', 'easy', 'Lists all applications with their sync status, health status, and repository details.', NULL),
    (4, 'What is the purpose of an ArgoCD Application resource?', 'It defines the relationship between a Git repository and a Kubernetes cluster destination', 'medium', 'Applications specify source repo, target cluster, sync policy, and which manifests to deploy.', NULL),
    (4, 'How do you get detailed information about an ArgoCD application?', 'argocd app get <app-name>', 'easy', 'Shows detailed status including sync state, health, last sync time, parameters, and resources deployed.', NULL),
    (4, 'What is auto-prune in ArgoCD?', 'Automatically deletes resources that no longer exist in Git', 'medium', 'When enabled, resources removed from Git are deleted from the cluster during sync. Useful but potentially dangerous.', NULL),
    (4, 'How do you create a new ArgoCD application from CLI?', 'argocd app create <name> --repo <repo-url> --path <path> --dest-server <server> --dest-namespace <namespace>', 'hard', 'Creates an Application resource. Can also use kubectl apply with Application YAML manifest.', NULL),
    (4, 'What does "OutOfSync" status mean in ArgoCD?', 'The live cluster state differs from the desired state in Git', 'easy', 'OutOfSync indicates drift. Can be caused by manual changes, Git commits not yet synced, or sync failures.', NULL),
    (4, 'How do you view the diff between Git and cluster?', 'argocd app diff <app-name>', 'medium', 'Shows differences between desired state (Git) and actual state (cluster). Useful before syncing.', NULL),
    (4, 'What is an ArgoCD ApplicationSet?', 'A template for generating multiple ArgoCD Applications automatically', 'hard', 'ApplicationSets use generators (Git, List, Cluster, etc.) to create Applications dynamically from templates.', NULL),
    (4, 'How do you hard refresh an application?', 'argocd app get <app-name> --hard-refresh', 'medium', 'Forces refresh of cached Git state. Useful when ArgoCD hasn''t detected recent Git changes.', NULL),
    (4, 'What is the sync-wave annotation used for?', 'Controls the order in which resources are synced', 'hard', 'argocd.argoproj.io/sync-wave: "N" - Lower numbers sync first. Used for dependency management (e.g., namespace before pods).', NULL),
    (4, 'How do you view ArgoCD application events?', 'kubectl describe application <app-name> -n argocd', 'medium', 'Applications are Kubernetes resources, so kubectl describe shows events. Or use argocd app get for ArgoCD-specific info.', NULL),
    (4, 'What is a sync hook in ArgoCD?', 'A resource that runs at specific points during sync (PreSync, Sync, PostSync, SyncFail)', 'hard', 'Hooks are annotated resources (usually Jobs) that run for tasks like DB migrations, notifications, or validation.', NULL),
    (4, 'What is auto-sync in ArgoCD?', 'Automatically syncs application when Git repository changes are detected', 'easy', 'Enabled in Application spec. Eliminates manual sync but requires careful testing. Can combine with automated pruning and self-heal.', NULL),
    (4, 'How do you delete an ArgoCD application?', 'argocd app delete <app-name>', 'easy', 'Deletes Application resource. Add --cascade to delete all deployed resources. Without --cascade, resources remain in cluster.', NULL),
    (4, 'What is the purpose of finalizers in ArgoCD?', 'Control application deletion behavior and resource cleanup', 'hard', 'resources-finalizer.argocd.argoproj.io ensures deployed resources are deleted. Remove finalizer to keep resources after app deletion.', NULL),
    (4, 'How do you view application logs in ArgoCD?', 'argocd app logs <app-name>', 'easy', 'Shows logs from application pods. Add --follow for streaming. Useful for debugging deployment issues.', NULL),
    (4, 'What is a sync retry in ArgoCD?', 'Automatic retry mechanism when sync fails', 'medium', 'Configurable backoff strategy. Helps with transient failures like webhook timeouts or temporary network issues.', NULL),
    (4, 'How do you rollback an ArgoCD application?', 'argocd app rollback <app-name> <revision>', 'medium', 'Syncs to a previous Git revision. View history with: argocd app history <app-name>. Alternative: revert Git commit and sync.', NULL),
    (4, 'What is resource health assessment?', 'ArgoCD evaluates if resources are healthy/progressing/degraded/suspended', 'medium', 'Built-in health checks for common resources. Custom health checks possible via ConfigMap. Shown in UI and CLI.', NULL),
    (4, 'How do you pause auto-sync temporarily?', 'argocd app set <app-name> --sync-policy none', 'medium', 'Disables auto-sync. Re-enable with: argocd app set <app-name> --sync-policy automated. Useful during maintenance.', NULL),
    (4, 'What is project in ArgoCD?', 'Logical grouping of applications with policies and restrictions', 'hard', 'Projects provide multi-tenancy. Define allowed sources (repos), destinations (clusters), and resource kinds. RBAC per project.', NULL),
    (4, 'How do you force refresh application cache?', 'argocd app get <app-name> --refresh', 'easy', 'Forces ArgoCD to query Git and cluster for latest state. Useful when changes aren''t detected. --hard-refresh for complete cache clear.', NULL);

-- Flashcards for Docker (25 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (5, 'What command builds a Docker image from a Dockerfile?', 'docker build -t image-name:tag .', 'easy', '-t tags the image with a name and optional version tag. The . specifies build context (current directory).', NULL),
    (5, 'How do you run a container in detached mode with port mapping?', 'docker run -d -p 8080:80 image-name', 'easy', '-d runs in background (detached), -p maps host port 8080 to container port 80.', NULL),
    (5, 'What is the difference between CMD and ENTRYPOINT in Dockerfile?', 'ENTRYPOINT sets the main command that always runs, CMD provides default arguments that can be overridden', 'medium', 'ENTRYPOINT + CMD together allow flexible container execution. ENTRYPOINT rarely changes, CMD provides defaults.', NULL),
    (5, 'How do you view logs from a running container?', 'docker logs container-id', 'easy', 'Add -f to follow logs in real-time, --tail N to show last N lines, --since to filter by timestamp.', NULL),
    (5, 'What command removes all stopped containers?', 'docker container prune', 'easy', 'Prune commands clean up unused resources. Add -a to remove all unused containers, not just stopped ones.', NULL),
    (5, 'How do you list all containers including stopped ones?', 'docker ps -a', 'easy', '-a shows all containers. Without it, only running containers are shown. Use --format for custom output.', NULL),
    (5, 'What command removes all stopped containers?', 'docker container prune', 'easy', 'Prune removes all stopped containers. Add -f to skip confirmation. Use docker system prune for containers, images, networks.', NULL),
    (5, 'How do you copy files from container to host?', 'docker cp container-name:/path/to/file /host/path', 'medium', 'Works both ways: container to host or host to container. Container can be running or stopped.', NULL),
    (5, 'What is the difference between CMD and ENTRYPOINT?', 'CMD provides default arguments that can be overridden; ENTRYPOINT sets the main command that cannot be overridden', 'hard', 'Use ENTRYPOINT for the main executable, CMD for default arguments. Both together: ENTRYPOINT + CMD arguments.', NULL),
    (5, 'How do you view logs from a container?', 'docker logs container-name', 'easy', 'Add -f to follow logs in real-time, --tail N to show last N lines, --since to filter by time.', NULL),
    (5, 'What command shows resource usage of running containers?', 'docker stats', 'easy', 'Shows CPU, memory, network I/O, and disk I/O for all running containers in real-time. Add container name for specific container.', NULL),
    (5, 'How do you create a volume for persistent data?', 'docker volume create volume-name', 'medium', 'Volumes persist data outside container lifecycle. Mount with: docker run -v volume-name:/path/in/container image', NULL),
    (5, 'What is a multi-stage build?', 'A Dockerfile with multiple FROM statements to create smaller final images', 'hard', 'Build artifacts in one stage, copy only needed files to final stage. Reduces image size and attack surface.', NULL),
    (5, 'How do you tag an image with multiple tags?', 'docker tag image-id name:tag1 && docker tag image-id name:tag2', 'medium', 'Or build with multiple -t flags: docker build -t name:tag1 -t name:tag2 . Tags are just references to same image.', NULL),
    (5, 'What command shows image layers and sizes?', 'docker history image-name', 'medium', 'Displays layer history showing commands that created each layer and their sizes. Useful for optimizing image size.', NULL),
    (5, 'What is the difference between ADD and COPY in Dockerfile?', 'COPY only copies files; ADD can also extract archives and fetch URLs', 'medium', 'Best practice: use COPY unless you need ADD''s extra features. ADD auto-extracts tar files, COPY is more explicit.', NULL),
    (5, 'How do you see all layers of an image?', 'docker image inspect image-name', 'medium', 'Shows detailed JSON including layers, config, environment. Use docker history for layer sizes and commands.', NULL),
    (5, 'What is a Docker network?', 'Virtual network for containers to communicate', 'medium', 'Types: bridge (default), host, none, custom. Containers on same network can communicate by name. Isolates container traffic.', NULL),
    (5, 'How do you limit container memory?', 'docker run -m 512m image-name', 'medium', '-m or --memory sets limit. Container killed if exceeded (OOMKilled). Use --memory-swap for swap limit.', NULL),
    (5, 'What is the difference between docker stop and docker kill?', 'stop sends SIGTERM then SIGKILL; kill sends SIGKILL immediately', 'medium', 'stop allows graceful shutdown (10s default). kill forces immediate termination. stop is safer for databases/services.', NULL),
    (5, 'How do you run a container in read-only mode?', 'docker run --read-only image-name', 'medium', 'Root filesystem is read-only. Use --tmpfs for writable temp directories. Security best practice to prevent malware writing files.', NULL),
    (5, 'What is Docker Compose?', 'Tool for defining and running multi-container applications using YAML', 'easy', 'docker-compose.yml defines services, networks, volumes. Commands: docker-compose up, down, ps, logs. Version 2+ integrates with Docker CLI.', NULL),
    (5, 'How do you inspect container processes?', 'docker top container-name', 'easy', 'Shows running processes inside container. Similar to ps command but for container. Useful for debugging.', NULL),
    (5, 'What is the difference between image and container?', 'Image is immutable template; container is running instance of an image', 'easy', 'Image is like a class, container is an instance. One image can create many containers. Containers add writable layer.', NULL),
    (5, 'How do you export and import images?', 'docker save -o file.tar image-name && docker load -i file.tar', 'medium', 'save/load for images. export/import for containers. save preserves layers and metadata, export flattens to single layer.', NULL);

-- Flashcards for Computer Science (24 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (6, 'What is the time complexity of binary search?', '**O(log n)** - logarithmic time complexity.

Binary search achieves this efficiency by **halving the search space** with each comparison. In a sorted array of `n` elements, it takes at most **log₂(n) comparisons** to find a target value or determine it doesn''t exist.

**Real-world impact**: For 1 million elements, binary search needs only ~20 comparisons (log₂(1,000,000) ≈ 20), compared to linear search''s potential 1 million comparisons.

**Critical requirement**: The data structure must be **sorted** beforehand, otherwise binary search cannot work correctly.', 'easy', 'Binary search''s **O(log n)** complexity comes from its **divide-and-conquer** strategy:

**How it works:**
1. Compare the target with the **middle element**
2. If target is smaller, eliminate the right half
3. If target is larger, eliminate the left half
4. Repeat on the remaining half until found or exhausted

**Mathematical proof**: Each iteration reduces search space by half:
- Iteration 1: n elements
- Iteration 2: n/2 elements
- Iteration 3: n/4 elements
- Iteration k: n/2^k elements

When n/2^k = 1, we''ve found our answer, so k = log₂(n)

**Real-world use cases:**
- **Database indexing**: Finding records in B-tree indexes
- **Version control**: Git uses binary search (`git bisect`) to find bug-introducing commits
- **Dictionary lookups**: Finding words in sorted dictionaries
- **Rate limiting**: Determining the optimal rate in binary exponential backoff

**Space complexity**: O(1) for iterative implementation, O(log n) for recursive (call stack depth)', '# Iterative Binary Search - O(log n) time, O(1) space
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    
    while left <= right:
        mid = left + (right - left) // 2  # Avoid overflow
        
        if arr[mid] == target:
            return mid  # Found at index mid
        elif arr[mid] < target:
            left = mid + 1  # Search right half
        else:
            right = mid - 1  # Search left half
    
    return -1  # Not found

# Example usage:
arr = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19]
print(binary_search(arr, 7))   # Output: 3
print(binary_search(arr, 10))  # Output: -1

# Complexity demonstration:
# Array size: 1,024 elements → Max comparisons: 10 (log₂(1024) = 10)
# Array size: 1,048,576 elements → Max comparisons: 20'),
    (6, 'What is a hash table collision?', 'A **hash table collision** occurs when two or more different keys produce the same hash value and map to the same index in the underlying array. This is inevitable due to the **pigeonhole principle**: with an infinite number of possible keys but a finite array size, multiple keys must eventually share the same slot.

For example, if `hash("John") = 5` and `hash("Jane") = 5`, both keys would attempt to occupy index 5, creating a collision. The hash table must have a strategy to handle this conflict while maintaining efficient lookups.', 'medium', '**Why collisions happen:**
- Hash functions map a large key space to a smaller index space
- Even good hash functions can''t guarantee unique indices for all inputs
- Load factor (n/m, where n = number of elements, m = array size) increases collision probability

**Common resolution strategies:**

**1. Chaining (Separate Chaining):**
- Each array index stores a linked list (or other data structure) of all elements that hash to that index
- **Pros:** Simple to implement, never runs out of space, deletion is straightforward
- **Cons:** Extra memory for pointers, cache performance degrades with long chains
- Used by: Java''s `HashMap`, Python''s `dict` (with modifications)

**2. Open Addressing (Probing):**
- All elements stored in the array itself; when collision occurs, probe for next available slot
- **Linear probing:** Check `(hash + 1) % m`, `(hash + 2) % m`, etc.
- **Quadratic probing:** Check `(hash + 1²) % m`, `(hash + 2²) % m`, etc.
- **Double hashing:** Use second hash function to determine probe sequence
- **Pros:** Better cache locality, no extra memory for pointers
- **Cons:** Clustering issues, table can fill up, deletion is complex

**Real-world impact:**
A hash table with 70% load factor and poor collision resolution can degrade from O(1) to O(n) lookup time. This is why Java''s `HashMap` automatically resizes when load factor exceeds 0.75.', '# Example: Hash collision demonstration
class HashTable:
    def __init__(self, size=10):
        self.size = size
        # Chaining: each slot is a list
        self.table = [[] for _ in range(size)]
    
    def hash_function(self, key):
        return hash(key) % self.size
    
    def insert(self, key, value):
        index = self.hash_function(key)
        # Check for collision
        for i, (k, v) in enumerate(self.table[index]):
            if k == key:
                self.table[index][i] = (key, value)  # Update
                return
        # Collision: append to chain
        self.table[index].append((key, value))
        print(f"Collision! ''{key}'' hashes to index {index}")
    
    def get(self, key):
        index = self.hash_function(key)
        # Search through chain at this index
        for k, v in self.table[index]:
            if k == key:
                return v
        raise KeyError(key)

# Demonstration
ht = HashTable(size=5)
ht.insert("apple", 100)   # hash to index, say 2
ht.insert("banana", 200)  # might hash to different index
ht.insert("melon", 300)   # might collide with "apple" at index 2!

print(ht.table)  # See the chains at each index'),
    (6, 'What is the difference between a stack and a queue?', 'Stack is LIFO (Last In First Out), Queue is FIFO (First In First Out)', 'easy', 'Stack operations: push/pop from top. Queue operations: enqueue at rear, dequeue from front.', NULL),
    (6, 'What is Big O notation?', '**Big O notation** is a mathematical notation that describes the **upper bound** (worst-case scenario) of an algorithm''s **time complexity** (execution time) or **space complexity** (memory usage) as the input size grows toward infinity. It expresses how an algorithm *scales* rather than its exact runtime.

Big O focuses on the **dominant term** and ignores constants and lower-order terms. For example, an algorithm with runtime `3n² + 5n + 10` is expressed as **O(n²)** because the `n²` term dominates as `n` grows large.

Common complexities from fastest to slowest:
- **O(1)**: Constant - array access by index
- **O(log n)**: Logarithmic - binary search
- **O(n)**: Linear - iterating through an array
- **O(n log n)**: Linearithmic - merge sort, quicksort (average)
- **O(n²)**: Quadratic - nested loops, bubble sort
- **O(2ⁿ)**: Exponential - recursive Fibonacci
- **O(n!)**: Factorial - generating all permutations', 'medium', 'Big O notation is crucial for **comparing algorithms** and making informed decisions about which approach to use based on expected input sizes. It helps predict how your code will perform as data scales from hundreds to millions of records.

**Real-world context:**
- A **O(1)** hash table lookup is ideal for a user authentication system checking millions of sessions
- A **O(n²)** bubble sort might be acceptable for sorting 10 items but would be disastrous for sorting 1 million items
- A **O(log n)** binary search on a sorted database of 1 billion records takes only ~30 operations versus 1 billion for linear search

**Interview tips:**
- Always analyze both time *and* space complexity
- Consider **best case**, **average case**, and **worst case** scenarios
- Recognize that **O(2n)** simplifies to **O(n)** (constants are dropped)
- Understand that **O(n + m)** cannot be simplified to **O(n)** because they''re different variables
- Be ready to optimize: can you reduce **O(n²)** to **O(n log n)** or **O(n)**?

**Common interview mistake:** Confusing Big O (upper bound/worst-case) with Big Omega (Ω - lower bound/best-case) and Big Theta (Θ - tight bound/average-case). Most interviews focus on Big O.', '# Examples of different Big O complexities

# O(1) - Constant: Same time regardless of input size
def get_first_element(arr):
    return arr[0]  # Single operation

# O(n) - Linear: Time grows proportionally with input
def find_max(arr):
    max_val = arr[0]
    for num in arr:  # n operations
        if num > max_val:
            max_val = num
    return max_val

# O(n²) - Quadratic: Nested loops
def bubble_sort(arr):
    for i in range(len(arr)):      # n iterations
        for j in range(len(arr)):  # n iterations each
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]

# O(log n) - Logarithmic: Divide input in half each step
def binary_search(arr, target):
    left, right = 0, len(arr) - 1
    while left <= right:
        mid = (left + right) // 2
        if arr[mid] == target:
            return mid
        elif arr[mid] < target:
            left = mid + 1  # Search right half
        else:
            right = mid - 1  # Search left half
    return -1

# O(2ⁿ) - Exponential: Doubles with each addition to input
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)  # Two recursive calls'),
    (6, 'What is the difference between depth-first and breadth-first search?', 'DFS explores as far as possible along each branch before backtracking; BFS explores all neighbors before moving to next level', 'medium', 'DFS uses a stack (or recursion), BFS uses a queue. Different use cases: DFS for paths, BFS for shortest paths.', NULL),
    (6, 'What is the difference between a stack and a queue?', '**Stack** operates on **LIFO (Last In, First Out)** principle - the most recently added element is removed first, like a stack of plates where you can only add or remove from the top.

**Queue** operates on **FIFO (First In, First Out)** principle - the first element added is the first one removed, like a line of people waiting where the person who arrived first gets served first.

**Key differences:**
- **Access points**: Stack has one access point (top), Queue has two (front and rear)
- **Operations**: Stack uses `push()` and `pop()`, Queue uses `enqueue()` and `dequeue()`
- **Time complexity**: Both offer O(1) for insertion and deletion
- **Use cases**: Stack for function calls and undo operations; Queue for task scheduling and breadth-first search', 'easy', '**Real-world Stack examples:**
- **Browser history**: Back button removes the most recent page visited
- **Function call stack**: Most recent function call must complete before returning to previous ones
- **Undo/Redo operations**: Last action is undone first
- **Expression evaluation**: Converting infix to postfix notation, validating balanced parentheses

**Real-world Queue examples:**
- **Print spooler**: Documents print in the order they were sent
- **CPU task scheduling**: Processes are handled in arrival order
- **Breadth-First Search (BFS)**: Processing graph nodes level by level
- **Message queues**: Handling requests in web servers (FIFO ensures fairness)

**Performance characteristics:**
- Both data structures provide **O(1)** time complexity for insertion and deletion when properly implemented
- **Stack**: Can be implemented using arrays (with resizing) or linked lists
- **Queue**: Best implemented with linked lists to avoid shifting elements; circular arrays also work well

**Interview tip:** Understanding when to use each structure is crucial. If the problem involves *backtracking, reversing, or nested structures*, think Stack. If it involves *ordering, scheduling, or level-by-level processing*, think Queue.', '# Stack Implementation (Python)
class Stack:
    def __init__(self):
        self.items = []
    
    def push(self, item):
        self.items.append(item)  # O(1)
    
    def pop(self):
        if not self.is_empty():
            return self.items.pop()  # O(1)
        return None
    
    def peek(self):
        return self.items[-1] if not self.is_empty() else None
    
    def is_empty(self):
        return len(self.items) == 0

# Queue Implementation (Python)
from collections import deque

class Queue:
    def __init__(self):
        self.items = deque()  # Efficient for both ends
    
    def enqueue(self, item):
        self.items.append(item)  # O(1) - add to rear
    
    def dequeue(self):
        if not self.is_empty():
            return self.items.popleft()  # O(1) - remove from front
        return None
    
    def peek(self):
        return self.items[0] if not self.is_empty() else None
    
    def is_empty(self):
        return len(self.items) == 0

# Usage Examples
stack = Stack()
stack.push(1)
stack.push(2)
stack.push(3)
print(stack.pop())  # Output: 3 (LIFO)

queue = Queue()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
print(queue.dequeue())  # Output: 1 (FIFO)'),
    (6, 'What is a hash table and what is its average time complexity?', 'A **hash table** (also called a **hash map**) is a data structure that implements an **associative array** abstract data type, storing key-value pairs and providing efficient data retrieval. It uses a **hash function** to compute an index (hash code) from a key, which determines where the corresponding value is stored in an underlying array.

**Average Time Complexity:**
- **Insert:** O(1)
- **Delete:** O(1)
- **Lookup/Search:** O(1)
- **Worst Case:** O(n) when many collisions occur

**Space Complexity:** O(n) where n is the number of key-value pairs stored.', 'medium', '**How Hash Tables Work:**

1. **Hash Function:** Takes a key as input and computes an integer index: `index = hash(key) % array_size`
2. **Storage:** The value is stored at the computed index in the underlying array
3. **Retrieval:** To find a value, hash the key again to get the index and retrieve directly

**Collision Resolution Strategies:**

- **Chaining:** Each array slot contains a linked list of all entries that hash to that index
- **Open Addressing:** Find another open slot using probing (linear, quadratic, or double hashing)
- **Load Factor:** Ratio of entries to array size; hash tables typically resize when load factor exceeds 0.7-0.75

**Real-World Use Cases:**

- **Database indexing:** Fast record lookup by primary key
- **Caching:** Browser caches, Redis, Memcached use hash tables internally
- **Symbol tables:** Compilers use hash tables to store variable names and references
- **Counting frequencies:** Word count in documents, character frequency analysis
- **Detecting duplicates:** Finding unique elements in O(n) time
- **Implementing Sets and Maps:** Python''s `dict` and `set`, Java''s `HashMap` and `HashSet`, JavaScript''s `Map` and `Object`

**Performance Considerations:**

- Good hash functions distribute keys uniformly to minimize collisions
- Poor hash functions or high load factors degrade performance toward O(n)
- Hash tables trade space for time efficiency', '# Python implementation of a simple hash table with chaining
class HashTable:
    def __init__(self, size=10):
        self.size = size
        self.table = [[] for _ in range(size)]  # List of buckets (chaining)
    
    def _hash(self, key):
        """Hash function: converts key to index"""
        return hash(key) % self.size
    
    def insert(self, key, value):
        """Insert or update key-value pair - O(1) average"""
        index = self._hash(key)
        # Check if key exists, update if found
        for i, (k, v) in enumerate(self.table[index]):
            if k == key:
                self.table[index][i] = (key, value)
                return
        # Key not found, append new pair
        self.table[index].append((key, value))
    
    def get(self, key):
        """Retrieve value by key - O(1) average"""
        index = self._hash(key)
        for k, v in self.table[index]:
            if k == key:
                return v
        raise KeyError(f"Key ''{key}'' not found")
    
    def delete(self, key):
        """Delete key-value pair - O(1) average"""
        index = self._hash(key)
        for i, (k, v) in enumerate(self.table[index]):
            if k == key:
                del self.table[index][i]
                return
        raise KeyError(f"Key ''{key}'' not found")

# Example usage
ht = HashTable()
ht.insert("name", "Alice")
ht.insert("age", 30)
ht.insert("city", "NYC")

print(ht.get("name"))  # Output: Alice
ht.delete("age")
print(ht.table)  # View internal structure'),
    (6, 'What is the time complexity of binary search?', 'O(log n)', 'easy', 'Binary search divides search space in half each iteration. Requires sorted array. Much faster than linear search O(n).', NULL),
    (6, 'What is a binary tree vs a binary search tree?', 'Binary tree has up to 2 children per node; BST has left < parent < right ordering property', 'medium', 'BST enables O(log n) search when balanced. Binary tree without ordering is just a structure constraint.', NULL),
    (6, 'What is dynamic programming?', '**Dynamic Programming (DP)** is an algorithmic optimization technique that solves complex problems by breaking them down into **overlapping subproblems**, solving each subproblem once, and **storing the results** to avoid redundant calculations. It''s applicable when a problem has:

1. **Optimal substructure**: The optimal solution can be constructed from optimal solutions of subproblems
2. **Overlapping subproblems**: The same subproblems are solved multiple times

DP uses either **top-down (memoization)** - recursion with caching, or **bottom-up (tabulation)** - iterative approach with a table. It trades *space complexity* for *time complexity*, transforming exponential time problems into polynomial time solutions.', 'hard', '**Real-World Applications:**

- **Fibonacci sequence**: Naive recursion is O(2^n), DP reduces it to O(n)
- **Shortest path algorithms**: Dijkstra''s, Floyd-Warshall for GPS navigation
- **Resource allocation**: Knapsack problem for budget optimization
- **String matching**: Edit distance for spell checkers, DNA sequence alignment
- **Game theory**: Chess engines evaluating optimal moves

**When to Use Dynamic Programming:**

- You''re calculating the same values repeatedly in recursion
- The problem asks for optimization (min/max/count)
- You can define the problem in terms of smaller subproblems
- Brute force solutions have overlapping calculations

**Top-Down vs Bottom-Up:**

- **Memoization (Top-Down)**: More intuitive, uses recursion, only solves needed subproblems, but has recursion overhead
- **Tabulation (Bottom-Up)**: More efficient, iterative, solves all subproblems, better space optimization possible

**Common DP Patterns:** Fibonacci-style (1D array), Grid traversal (2D array), Knapsack, Longest Common Subsequence (LCS), Palindrome problems', '# Example: Fibonacci - All three approaches

# 1. Naive Recursion - O(2^n) time, O(n) space
def fib_naive(n):
    if n <= 1:
        return n
    return fib_naive(n-1) + fib_naive(n-2)

# 2. Top-Down (Memoization) - O(n) time, O(n) space
def fib_memo(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        return n
    memo[n] = fib_memo(n-1, memo) + fib_memo(n-2, memo)
    return memo[n]

# 3. Bottom-Up (Tabulation) - O(n) time, O(n) space
def fib_tab(n):
    if n <= 1:
        return n
    dp = [0] * (n + 1)
    dp[1] = 1
    for i in range(2, n + 1):
        dp[i] = dp[i-1] + dp[i-2]
    return dp[n]

# 4. Space-Optimized Bottom-Up - O(n) time, O(1) space
def fib_optimized(n):
    if n <= 1:
        return n
    prev, curr = 0, 1
    for _ in range(2, n + 1):
        prev, curr = curr, prev + curr
    return curr

# Test: fib(10) = 55
print(f"Naive: {fib_naive(10)}")
print(f"Memo: {fib_memo(10)}")
print(f"Tab: {fib_tab(10)}")
print(f"Optimized: {fib_optimized(10)}")'),
    (6, 'What is the difference between depth-first and breadth-first search?', 'DFS explores as far as possible down each branch; BFS explores all neighbors before going deeper', 'medium', 'DFS uses stack (or recursion), BFS uses queue. DFS for path finding, BFS for shortest path in unweighted graphs.', NULL),
    (6, 'What is a linked list and when would you use it?', 'A data structure with nodes containing data and reference to next node; efficient for insertions/deletions', 'easy', 'O(1) insert/delete at known position, O(n) search. Use when frequent insertions/deletions, size unknown, or sequential access.', NULL),
    (6, 'What is the CAP theorem?', 'A distributed system can provide at most 2 of 3: Consistency, Availability, Partition tolerance', 'hard', 'Partition tolerance is required in distributed systems, so choose between consistency (CP) or availability (AP).', NULL),
    (6, 'What is quicksort and what is its average time complexity?', 'A divide-and-conquer sorting algorithm using a pivot element; O(n log n) average', 'medium', 'Partitions array around pivot, recursively sorts subarrays. Worst case O(n²) with bad pivot. In-place, not stable.', NULL),
    (6, 'What is a graph and name its types?', 'A collection of nodes (vertices) connected by edges; types: directed, undirected, weighted, unweighted', 'medium', 'Used for networks, maps, dependencies. Traversal: DFS, BFS. Common problems: shortest path, cycle detection, topological sort.', NULL),
    (6, 'What is memoization?', 'Optimization technique that stores function results to avoid repeated calculations', 'medium', 'Key technique in dynamic programming. Trade space for time. Useful for recursive functions with overlapping subproblems.', NULL),
    (6, 'What is the difference between process and thread?', 'Process is independent execution unit with own memory; thread shares memory within process', 'hard', 'Processes isolated, heavyweight. Threads lightweight, share address space. Threads enable parallelism without IPC overhead.', NULL),
    (6, 'What is a heap data structure?', 'A tree-based structure where parent nodes have priority over children (min-heap or max-heap)', 'medium', 'Used for priority queues. Root is minimum (min-heap) or maximum (max-heap). O(log n) insert/delete, O(1) find min/max.', NULL),
    (6, 'What is two-pointer technique?', 'Algorithm pattern using two pointers to iterate through data structure', 'medium', 'Common patterns: slow/fast pointers, opposite ends moving inward. Used for arrays, linked lists. Example: finding pairs, palindrome check.', NULL),
    (6, 'What is a trie data structure?', 'Tree-like structure for storing strings, where each path represents a word', 'hard', 'Also called prefix tree. Efficient for autocomplete, spell check, IP routing. O(m) operations where m is string length, not data size.', NULL),
    (6, 'What is greedy algorithm?', 'A **greedy algorithm** is a problem-solving approach that makes the **locally optimal choice** at each step with the hope of finding a **global optimum solution**. At every decision point, it selects the option that appears best at that moment without reconsidering previous choices.

**Key characteristics:**
- Makes **irrevocable decisions** - never backtracks or reconsiders earlier choices
- Requires a **greedy choice property** - local optimum leads to global optimum
- Exhibits **optimal substructure** - optimal solution contains optimal solutions to subproblems
- Generally has **better time complexity** (O(n log n) or O(n)) compared to dynamic programming

**Common applications:** Huffman coding, Dijkstra''s shortest path, Prim''s and Kruskal''s MST algorithms, activity selection, fractional knapsack, and coin change (with specific denominations).', 'medium', '**Real-world analogy:** Think of a greedy algorithm like taking a road trip where you always choose the road that looks fastest *right now*, without considering if it might lead you to a longer overall route. Sometimes this works perfectly (like on a highway system), sometimes it doesn''t (like in cities with traffic patterns).

**When greedy algorithms work:**
- **Activity Selection Problem** - Schedule maximum non-overlapping activities by always picking the one that ends earliest
- **Making Change** - With standard US coins (1¢, 5¢, 10¢, 25¢), always taking the largest coin works optimally
- **Huffman Encoding** - Building optimal prefix codes by merging least frequent characters first

**When greedy algorithms fail:**
- **0/1 Knapsack Problem** - Choosing items by value-to-weight ratio doesn''t guarantee optimal solution
- **Non-standard Coin Systems** - With coins like {1, 3, 4}, making 6 cents greedily gives {4,1,1} instead of optimal {3,3}
- **Graph coloring** - Greedily assigning colors may use more colors than necessary

**Why use greedy over dynamic programming?**
- **Simplicity** - Easier to implement and understand
- **Speed** - Better time complexity (no need to store intermediate results)
- **Space efficiency** - O(1) or O(log n) space vs O(n) or O(n²) for DP

**Interview tip:** Always verify if the greedy choice property holds by checking edge cases or providing a counterexample if it doesn''t work.', '# Example 1: Activity Selection (Classic Greedy Problem)
def activity_selection(start, finish):
    """
    Select maximum number of non-overlapping activities.
    Greedy choice: Always pick activity that finishes earliest.
    Time: O(n log n), Space: O(1)
    """
    # Sort by finish time
    activities = sorted(zip(start, finish), key=lambda x: x[1])
    selected = [activities[0]]
    last_finish = activities[0][1]
    
    for s, f in activities[1:]:
        if s >= last_finish:  # No overlap
            selected.append((s, f))
            last_finish = f
    
    return selected

# Example: [(1,3), (2,5), (4,7), (1,8), (5,9), (8,10)]
starts = [1, 2, 4, 1, 5, 8]
finishes = [3, 5, 7, 8, 9, 10]
print(activity_selection(starts, finishes))
# Output: [(1, 3), (4, 7), (8, 10)] - Maximum 3 activities

# Example 2: Coin Change (When Greedy Works)
def coin_change_greedy(amount, coins=[25, 10, 5, 1]):
    """
    Make change using minimum coins (works for standard US coins).
    Greedy choice: Always use largest coin possible.
    WARNING: Only optimal for certain coin systems!
    """
    result = []
    for coin in coins:
        while amount >= coin:
            result.append(coin)
            amount -= coin
    return result

print(coin_change_greedy(41))  # [25, 10, 5, 1] - Optimal

# Example 3: Fractional Knapsack (Greedy Works)
def fractional_knapsack(capacity, values, weights):
    """
    Maximize value in knapsack (can take fractions of items).
    Greedy choice: Take items with highest value/weight ratio.
    """
    items = [(v/w, v, w) for v, w in zip(values, weights)]
    items.sort(reverse=True)  # Sort by value/weight ratio
    
    total_value = 0
    for ratio, v, w in items:
        if capacity >= w:
            capacity -= w
            total_value += v
        else:
            total_value += capacity * ratio
            break
    return total_value

print(fractional_knapsack(50, [60, 100, 120], [10, 20, 30]))
# Output: 240.0 (take all of first two, 2/3 of third)'),
    (6, 'What is the difference between DFS and BFS for graphs?', 'DFS goes deep exploring one branch fully; BFS explores all neighbors before going deeper', 'medium', 'DFS: uses stack, better for paths, topological sort. BFS: uses queue, finds shortest path, good for level-order traversal.', NULL),
    (6, 'What is amortized time complexity?', 'Average time per operation over a sequence of operations', 'hard', 'Example: dynamic array resize is O(n) but amortized O(1) per insert. Averages expensive operations over many cheap ones.', NULL),
    (6, 'What is a deadlock and how to prevent it?', 'Situation where processes wait indefinitely for resources held by each other', 'hard', 'Four conditions: mutual exclusion, hold and wait, no preemption, circular wait. Prevent by breaking any condition, use timeouts.', NULL);

-- Flashcards for SRE & Observability (22 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (7, 'What are the three pillars of observability?', 'The three pillars of observability are **Logs**, **Metrics**, and **Traces**. Together, they provide comprehensive visibility into system behavior:

- **Logs**: Discrete, timestamped records of events that capture *what happened* in your system (errors, warnings, info messages). Example: "User 12345 failed login attempt at 2024-01-15 10:30:45"
- **Metrics**: Numerical measurements aggregated over time that show *how much* or *how many* (CPU usage, request rate, error count). Example: "API response time: 250ms (avg)"
- **Traces**: Distributed tracking of requests as they flow through multiple services, showing *where time is spent* and dependencies. Example: A single user request traveling through API Gateway → Auth Service → Database → Cache', 'easy', '**Real-World Application:**

Imagine debugging a slow checkout process in an e-commerce application:

1. **Metrics** alert you that the 95th percentile response time increased from 200ms to 2000ms
2. **Traces** reveal the payment service is the bottleneck, taking 1800ms of that time
3. **Logs** show specific error messages: "Database connection pool exhausted" with stack traces

**Why All Three Matter:**

- **Logs** alone generate massive volume and are expensive to analyze at scale
- **Metrics** alone show *something* is wrong but not *why* or *where*
- **Traces** alone don''t capture the detailed context of failures

**Industry Tools:**
- Logs: ELK Stack, Loki, Splunk, CloudWatch Logs
- Metrics: Prometheus, Mimir, VictoriaMetrics
- Traces: Jaeger, Zipkin, Tempo

**Interview Tip:** Emphasize that observability differs from monitoring—it''s about asking *new questions* of your system without deploying new code, not just tracking predefined metrics.', '# Example: Implementing all three pillars in a microservice

import logging
from prometheus_client import Counter, Histogram
from opentelemetry import trace

# LOGS: Structured logging
logger = logging.getLogger(__name__)

# METRICS: Define counters and histograms
request_count = Counter(''api_requests_total'', ''Total API requests'')
request_duration = Histogram(''api_request_duration_seconds'', ''Request duration'')

# TRACES: Get tracer instance
tracer = trace.get_tracer(__name__)

@request_duration.time()  # Metric timing
def process_order(order_id):
    # Trace: Create span for distributed tracing
    with tracer.start_as_current_span("process_order") as span:
        span.set_attribute("order.id", order_id)
        
        # Log: Record event details
        logger.info(f"Processing order {order_id}", 
                   extra={"order_id": order_id, "user_id": 12345})
        
        # Metric: Increment counter
        request_count.inc()
        
        try:
            # Business logic here
            result = validate_and_charge(order_id)
            logger.info(f"Order {order_id} completed successfully")
            return result
        except Exception as e:
            # Log error with context
            logger.error(f"Order {order_id} failed: {str(e)}", 
                        exc_info=True)
            span.set_status(trace.Status(trace.StatusCode.ERROR))
            raise'),
    (7, 'What is an SLI (Service Level Indicator)?', 'A **Service Level Indicator (SLI)** is a *quantitative measurement* that represents a specific aspect of a service''s performance or reliability from the user''s perspective. SLIs are the **foundational metrics** that directly measure service behavior and form the basis for calculating **Service Level Objectives (SLOs)**.

Common SLI categories include:
- **Availability**: Percentage of successful requests (e.g., `successful_requests / total_requests`)
- **Latency**: Response time measurements (e.g., 95th percentile latency < 200ms)
- **Throughput**: Requests processed per second
- **Error Rate**: Percentage of failed requests
- **Durability**: Data retention success rate

SLIs must be *measurable, meaningful, and aligned with user experience* rather than internal system metrics.', 'medium', '**Real-World Context:**

SLIs translate abstract service quality into concrete, measurable numbers. For example, an e-commerce platform might track:
- **Checkout API latency**: 99% of requests complete within 500ms
- **Search availability**: 99.9% of search queries return results successfully
- **Payment error rate**: Less than 0.1% of payment transactions fail

**Key Characteristics of Good SLIs:**
1. **User-centric**: Reflect actual user experience (not just server CPU usage)
2. **Measurable**: Can be consistently tracked via monitoring tools
3. **Actionable**: Changes indicate when service quality degrades
4. **Relevant**: Directly tied to business objectives

**SLI vs SLO vs SLA:**
- **SLI**: The actual measurement ("Our API had 99.95% availability last month")
- **SLO**: The target threshold ("We aim for 99.9% availability")
- **SLA**: The contractual promise with consequences ("We guarantee 99.5% or you get a refund")

**Practical Implementation:**
SLIs are typically calculated using time-series data from monitoring systems like Prometheus, Datadog, or CloudWatch. They should be aggregated over meaningful time windows (e.g., 28-day rolling windows) to smooth out transient issues while catching systemic problems.', '# Example: Calculating SLIs from monitoring data

# Availability SLI (success rate)
availability_sli = (
    sum(http_requests_total{status=~"2.."})
    / sum(http_requests_total)
) * 100
# Target: 99.9% availability

# Latency SLI (95th percentile)
latency_sli_p95 = histogram_quantile(
    0.95,
    rate(http_request_duration_seconds_bucket[5m])
)
# Target: < 200ms

# Error Rate SLI
error_rate_sli = (
    sum(rate(http_requests_total{status=~"5.."}[5m]))
    / sum(rate(http_requests_total[5m]))
) * 100
# Target: < 0.1%

# Python example: Computing SLI from logs
def calculate_availability_sli(requests):
    """Calculate availability SLI from request data"""
    total = len(requests)
    successful = sum(1 for r in requests if 200 <= r.status < 300)
    return (successful / total) * 100 if total > 0 else 0

# Usage
requests = fetch_last_hour_requests()
sli_value = calculate_availability_sli(requests)
print(f"Current availability SLI: {sli_value:.2f}%")'),
    (7, 'What is the difference between SLO and SLA?', '**SLO (Service Level Objective)** is an *internal target* that defines the desired reliability or performance level for a service, such as "99.9% uptime" or "API response time < 200ms for 95% of requests." It''s what your team *aims to achieve*.

**SLA (Service Level Agreement)** is an *external, legally-binding contract* between a service provider and customers that specifies guaranteed service levels with explicit **consequences** (refunds, credits, penalties) if those levels aren''t met.

**Key Relationship**: SLOs are typically set *stricter* than SLAs to provide a safety buffer. For example, if your SLA promises 99.5% uptime, you might set an internal SLO of 99.9% uptime to avoid breaching the contract.', 'medium', '**Real-World Example:**

Imagine a cloud storage company:
- **SLO**: Engineering team sets an internal goal of 99.95% availability (26 minutes downtime/year allowed)
- **SLA**: Customer contract guarantees 99.9% availability (8.76 hours downtime/year allowed) with 10% service credit if breached
- **SLI (Service Level Indicator)**: The *actual measured* uptime (e.g., 99.93% last month)

**Why the Buffer Matters:**
The gap between SLO (99.95%) and SLA (99.9%) gives teams an **error budget** to innovate, deploy changes, and handle unexpected issues without triggering customer penalties.

**Practical Use Cases:**
- **Monitoring & Alerting**: Teams set alerts when approaching SLO thresholds (e.g., 99.92% uptime) to take action *before* violating the SLA
- **Feature Development**: If you''ve "spent" your error budget (fallen below SLO), teams might pause risky deployments and focus on stability
- **Vendor Selection**: When choosing cloud providers, compare their SLAs to understand guaranteed service levels and compensation terms

**Common Metrics:**
- Availability/Uptime percentage
- Request latency (p50, p95, p99)
- Error rate thresholds
- Time to first response (support tickets)', '# Example: Calculating SLO compliance from monitoring data

# SLO: 99.9% of requests should complete in < 200ms
total_requests = 1000000
fast_requests = 998500  # Requests < 200ms

slo_compliance = (fast_requests / total_requests) * 100
print(f"SLO Compliance: {slo_compliance}%")  # Output: 99.85%

# Error budget calculation
slo_target = 99.9
error_budget_remaining = slo_compliance - slo_target
print(f"Error Budget: {error_budget_remaining}%")  # Output: -0.05%

if slo_compliance < slo_target:
    print("⚠️ SLO violated! Freeze risky deployments")
else:
    print("✅ Within SLO - safe to deploy")'),
    (7, 'What is an error budget?', 'An **error budget** is the maximum amount of **downtime, errors, or performance degradation** a service can experience within a given time period without violating its **Service Level Objective (SLO)**. It represents the acceptable level of unreliability and serves as a quantifiable metric that balances **innovation velocity** with **system reliability**.

The error budget is calculated as: **Error Budget = 1 - SLO**. For example, a **99.9% availability SLO** means an error budget of **0.1%**, which translates to approximately **43.2 minutes of allowable downtime per month** or **8.76 hours per year**.

Error budgets enable **data-driven decisions** about when to prioritize new features versus stability work. When the error budget is healthy, teams can move faster and take calculated risks. When depleted, teams focus on reliability improvements.', 'medium', '**Real-World Context:**

Error budgets originated at **Google** as a way to resolve conflicts between development teams (wanting to ship features quickly) and SRE teams (wanting to maintain stability). They transform reliability from a subjective debate into an **objective, measurable resource**.

**Practical Use Cases:**

- **Feature Release Decisions**: If 80% of your monthly error budget is consumed, you might delay a risky deployment until next month
- **Incident Response Priority**: A service with 5% error budget remaining gets higher priority for reliability work than one with 95% remaining
- **Team Autonomy**: Teams can self-manage risk within their error budget without requiring approval for every change
- **Change Velocity Control**: Some organizations implement **deployment freezes** when error budgets reach critical thresholds (e.g., <10% remaining)

**Calculation Examples:**

- **99.9% SLO (three nines)**: 0.1% error budget = ~43 minutes/month downtime
- **99.95% SLO**: 0.05% error budget = ~22 minutes/month downtime
- **99.99% SLO (four nines)**: 0.01% error budget = ~4.3 minutes/month downtime

**Common Policies:**

Organizations typically implement **error budget policies** that define actions when budgets are consumed, such as:
1. **>75% remaining**: Normal development velocity
2. **25-75% remaining**: Increased monitoring and code review rigor
3. **<25% remaining**: Focus shifts to reliability, feature freeze may be enacted
4. **Depleted**: Mandatory incident review and reliability improvements before new features', 'max(
  0,
  (
    0.001 -
    (
      sum(
        increase(traces_spanmetrics_calls_total{
          service_name="checkout",
          span_status_code="STATUS_CODE_ERROR"
        }[30d])
      )
      /
      sum(
        increase(traces_spanmetrics_calls_total{
          service_name="checkout"
        }[30d])
      )
    )
  )
  / 0.001
)'),
    (7, 'What is the RED method for monitoring microservices?', 'The **RED method** is a microservices monitoring framework that focuses on three key request-driven metrics: **Rate** (the number of requests per second your service is handling), **Errors** (the number or percentage of failed requests per second), and **Duration** (the distribution of response times, typically measured in percentiles like p50, p95, p99).

This method is particularly effective for **request-driven architectures** like REST APIs, gRPC services, and message queues. It provides a user-centric view of service health by focusing on *what matters to end users*: whether the service is available, responding quickly, and handling traffic appropriately. RED complements the **USE method** (Utilization, Saturation, Errors) which focuses on infrastructure resources.', 'medium', '**Why RED Method Matters:**

The RED method was popularized by Tom Wilkie at Grafana Labs as a practical approach to monitoring microservices. It helps answer three critical questions:

1. **Rate**: *How busy is my service?* - Measures throughput and helps identify traffic patterns, sudden spikes, or drops that might indicate problems
2. **Errors**: *Is my service failing?* - Tracks HTTP 5xx errors, exceptions, or failed operations to quickly identify reliability issues
3. **Duration**: *Is my service fast enough?* - Monitors latency distribution to ensure SLAs are met and users have good experience

**Real-World Use Cases:**

- **Incident Detection**: A sudden spike in error rate immediately alerts teams to investigate before users are significantly impacted
- **SLA Monitoring**: Track p99 duration to ensure 99% of requests complete within acceptable time thresholds
- **Capacity Planning**: Rising request rates help predict when to scale services horizontally
- **Deployment Validation**: Compare RED metrics before/after deployments to catch regressions

**Best Practices:**

- Track errors as *percentages* (error rate / total rate) for better context
- Use **percentiles** (p50, p95, p99) for duration instead of averages to avoid being misled by outliers
- Set up alerts when metrics deviate from normal baselines
- Tag metrics by service, endpoint, and environment for granular analysis', NULL),
    (7, 'What are the four golden signals of monitoring?', 'The **Four Golden Signals** are Google''s SRE framework for monitoring distributed systems:

1. **Latency**: Time taken to service a request (distinguish between successful and failed requests)
2. **Traffic**: Measure of demand on your system (requests per second, transactions per second, or I/O operations)
3. **Errors**: Rate of requests that fail (explicit failures like HTTP 500s, implicit failures like wrong content, or policy failures like violating SLAs)
4. **Saturation**: How "full" your service is (CPU, memory, disk I/O, network bandwidth utilization)

These signals provide a comprehensive view of system health and should be monitored together, not in isolation.', 'medium', 'The Four Golden Signals originate from Google''s **Site Reliability Engineering (SRE)** book and represent the minimum viable monitoring for any production system.

**Why these four signals matter:**

- **Latency** helps identify performance degradation *before* users complain. For example, if your API''s p99 latency spikes from 200ms to 2s, users will notice even if availability remains at 99.9%
- **Traffic** shows usage patterns and helps predict capacity needs. A sudden traffic spike might indicate a marketing campaign success, a DDoS attack, or viral content
- **Errors** directly impact user experience. Tracking error *budgets* (like 99.9% uptime = 0.1% error budget) helps balance feature velocity with reliability
- **Saturation** predicts impending failures. When CPU hits 80%, you need to scale *before* reaching 100% and causing cascading failures

**Real-world example:** An e-commerce site during Black Friday would monitor:
- Latency: Checkout API response times
- Traffic: Orders per minute
- Errors: Failed payment transactions
- Saturation: Database connection pool usage

**Best practices:**
- Set **alerts** on all four signals with appropriate thresholds
- Use **percentiles** (p50, p95, p99) for latency, not just averages
- Monitor saturation at *leading indicators* (70-80%) to prevent incidents
- Correlate signals together (high latency + high saturation = capacity issue)', '# Example: Implementing Four Golden Signals with Prometheus metrics

from prometheus_client import Counter, Histogram, Gauge
import time

# 1. LATENCY: Track request duration
request_duration = Histogram(
    ''http_request_duration_seconds'',
    ''HTTP request latency'',
    [''method'', ''endpoint'', ''status'']
)

# 2. TRAFFIC: Count total requests
request_count = Counter(
    ''http_requests_total'',
    ''Total HTTP requests'',
    [''method'', ''endpoint'']
)

# 3. ERRORS: Count failed requests
error_count = Counter(
    ''http_requests_errors_total'',
    ''Total HTTP errors'',
    [''method'', ''endpoint'', ''error_type'']
)

# 4. SATURATION: Track resource utilization
cpu_usage = Gauge(''cpu_usage_percent'', ''CPU usage percentage'')
memory_usage = Gauge(''memory_usage_percent'', ''Memory usage percentage'')

# Usage example
@request_duration.time()
def handle_request(method, endpoint):
    request_count.labels(method=method, endpoint=endpoint).inc()
    
    try:
        # Process request
        result = process_business_logic()
        return result
    except Exception as e:
        error_count.labels(
            method=method,
            endpoint=endpoint,
            error_type=type(e).__name__
        ).inc()
        raise

# Periodic saturation monitoring
def monitor_saturation():
    import psutil
    cpu_usage.set(psutil.cpu_percent())
    memory_usage.set(psutil.virtual_memory().percent)'),
    (7, 'What is an SLO (Service Level Objective)?', 'A **Service Level Objective (SLO)** is a *specific, measurable target* for the reliability and performance of a service, expressed as a threshold that an **SLI (Service Level Indicator)** must meet over a defined time period.

SLOs represent the **internal reliability goals** that engineering teams commit to achieving, typically expressed as a percentage (e.g., 99.9% availability) or as quantile-based targets (e.g., 95th percentile latency < 200ms). They define the acceptable boundary between happy and unhappy customers.

Key characteristics:
- **Quantifiable**: Based on measurable metrics (SLIs)
- **Time-bound**: Measured over specific windows (daily, weekly, monthly)
- **Realistic**: Should balance user satisfaction with engineering costs
- **Actionable**: Violations trigger specific responses (incident response, feature freeze)', 'medium', '**Real-world context**: Imagine an e-commerce platform where the SLI measures request success rate. The SLO might state: *"99.95% of API requests must succeed over a 30-day window."* This means the team has an **error budget** of 0.05%, allowing approximately 21 minutes of downtime per month.

**SLO vs SLA vs SLI hierarchy**:
- **SLI** (Service Level Indicator): The actual measurement (e.g., "98.7% of requests succeeded today")
- **SLO** (Service Level Objective): The internal target (e.g., "Must maintain ≥99.5% success rate")
- **SLA** (Service Level Agreement): The contractual promise with penalties (e.g., "We guarantee 99% uptime or you get credits")

**Practical use cases**:
1. **Availability SLO**: "99.9% of health check requests return 200 OK" - gives team ~43 minutes of allowed downtime monthly
2. **Latency SLO**: "95% of search queries complete within 300ms" - focuses on user experience
3. **Throughput SLO**: "System processes ≥10,000 transactions/second during peak hours"

**Why SLOs matter**:
- Define **error budgets** for planned risks (deployments, experiments)
- Prevent over-engineering (100% reliability is impossibly expensive)
- Provide objective criteria for operational decisions
- Balance feature velocity with reliability

**When SLOs are breached**, teams typically: pause feature launches, focus on reliability improvements, conduct post-mortems, and adjust on-call priorities.', '# Example: Calculating SLO compliance and error budget

# SLO Definition
SLO_TARGET = 99.9  # 99.9% success rate
TIME_WINDOW_DAYS = 30

# Sample metrics over 30 days
total_requests = 10_000_000
failed_requests = 15_000

# Calculate actual SLI
success_rate = ((total_requests - failed_requests) / total_requests) * 100
print(f"Current SLI: {success_rate:.3f}%")

# Check SLO compliance
is_compliant = success_rate >= SLO_TARGET
print(f"SLO Met: {is_compliant}")

# Calculate error budget
allowed_failures = total_requests * (1 - SLO_TARGET / 100)
error_budget_remaining = allowed_failures - failed_requests
error_budget_percent = (error_budget_remaining / allowed_failures) * 100

print(f"Error Budget Remaining: {error_budget_percent:.1f}%")
print(f"Allowed failures: {int(allowed_failures)}")
print(f"Actual failures: {failed_requests}")

# Output:
# Current SLI: 99.850%
# SLO Met: False
# Error Budget Remaining: -50.0%
# Allowed failures: 10000
# Actual failures: 15000'),
    (7, 'What is an error budget?', 'The allowed amount of downtime or errors before SLO is breached', 'hard', 'If SLO is 99.9%, error budget is 0.1%. Used to balance reliability vs feature velocity. No budget = feature freeze.', NULL),
    (7, 'What is the USE method?', 'Utilization, Saturation, Errors - for resource monitoring', 'medium', 'For each resource (CPU, memory, disk, network): check utilization (%), saturation (queue length), errors (error count).', NULL),
    (7, 'What is distributed tracing?', 'Tracking a request as it flows through multiple services in a microservices architecture', 'hard', 'Each service adds span to trace. Shows service dependencies, latency breakdown. Tools: Jaeger, Zipkin, OpenTelemetry.', NULL),
    (7, 'What is the difference between white-box and black-box monitoring?', 'White-box monitors internal state and metrics; black-box monitors from user perspective', 'medium', 'White-box: internal metrics like CPU, DB queries. Black-box: external probes testing actual user experience.', NULL),
    (7, 'What is Prometheus and how does it work?', 'A time-series database and monitoring system that scrapes metrics from targets at intervals', 'medium', 'Pull-based model. Targets expose /metrics endpoint. PromQL for querying. Alertmanager for alerts. Grafana for visualization.', NULL),
    (7, 'What is the difference between monitoring and observability?', 'Monitoring watches known failure modes; observability understands system from outputs', 'hard', 'Monitoring: predefined metrics/alerts. Observability: arbitrary questions about system state. Observability includes logs, metrics, traces.', NULL),
    (7, 'What is a percentile in performance metrics?', 'Value below which a percentage of observations fall', 'medium', 'p50 (median), p95, p99 commonly used. p99 = 99% of requests faster. Better than average for understanding user experience.', NULL),
    (7, 'What is alerting fatigue?', 'Desensitization to alerts due to too many false positives', 'easy', 'Causes: noisy alerts, low thresholds, alert storms. Solutions: better thresholds, alert grouping, runbook links, escalation.', NULL),
    (7, 'What is a runbook?', 'Step-by-step guide for handling operational tasks or incidents', 'easy', 'Documents procedures for common issues. Includes investigation steps, remediation actions, escalation paths. Reduces MTTR.', NULL),
    (7, 'What is mean time to recovery (MTTR)?', 'Average time to restore service after an incident', 'medium', 'Key reliability metric. Lower is better. Related: MTTD (detect), MTTF (failure), MTBF (between failures). Focus on detection and automation.', NULL),
    (7, 'What is cardinality in metrics?', 'Number of unique time series for a metric based on label combinations', 'hard', 'High cardinality (many unique labels) impacts performance and storage. Avoid user IDs in labels. Limit tag combinations.', NULL),
    (7, 'What is log aggregation?', 'Collecting logs from multiple sources into centralized system', 'medium', 'Benefits: centralized search, correlation, retention. Tools: ELK stack, Splunk, Loki. Challenges: volume, cost, sensitive data.', NULL),
    (7, 'What is synthetic monitoring?', '**Synthetic monitoring** is a *proactive* monitoring approach that uses **scripted simulations** to test application performance, availability, and functionality before real users encounter issues. Unlike reactive monitoring, it runs **automated tests at regular intervals** (e.g., every 5-15 minutes) from multiple geographic locations to simulate user interactions with your application.

Key characteristics include:
- **Predictable testing**: Runs on a defined schedule with consistent test scenarios
- **Global coverage**: Tests from multiple locations to detect regional issues
- **Early detection**: Identifies problems before they impact actual users
- **Baseline metrics**: Establishes performance benchmarks for SLA compliance

Commonly used for monitoring **APIs**, **website uptime**, **transaction flows** (login, checkout), and **critical user journeys**.', 'medium', '**Real-world use cases:**

1. **E-commerce checkout monitoring**: A retail company runs synthetic tests every 5 minutes to ensure the complete purchase flow (add to cart → checkout → payment → confirmation) works across different browsers and regions. This catches payment gateway failures before customers encounter them.

2. **API endpoint monitoring**: A SaaS platform uses synthetic monitors to test authentication endpoints, database queries, and third-party integrations continuously, measuring response times and error rates.

3. **Multi-region availability**: Netflix-style services deploy synthetic monitors from 20+ global locations to verify content delivery and streaming quality, detecting CDN or DNS issues in specific regions.

**Synthetic vs RUM comparison:**
- **Synthetic**: Controlled, predictable, catches issues 24/7 even during low-traffic periods, but doesn''t reflect actual user behavior
- **RUM**: Real user data, shows actual experience, but reactive (issues already affecting users) and depends on traffic volume

**Best practice**: Use both together—synthetic monitoring for *proactive alerting* and RUM for *understanding real user impact*. Popular tools include **Datadog Synthetics**, **Pingdom**, **New Relic Synthetics**, and **AWS CloudWatch Synthetics**.', '# Example: AWS CloudWatch Synthetic Canary (Python)
from aws_synthetics.selenium import synthetics_webdriver as webdriver
from aws_synthetics.common import synthetics_logger as logger

def verify_checkout_flow():
    # Initialize browser
    browser = webdriver.Chrome()
    browser.get(''https://example-shop.com'')
    
    try:
        # Step 1: Add item to cart
        add_button = browser.find_element_by_id(''add-to-cart'')
        add_button.click()
        logger.info(''Added item to cart'')
        
        # Step 2: Proceed to checkout
        browser.get(''https://example-shop.com/checkout'')
        assert ''Checkout'' in browser.title
        
        # Step 3: Verify payment page loads
        browser.find_element_by_id(''payment-form'')
        logger.info(''Checkout flow successful'')
        
        # Record metrics
        response_time = browser.execute_script(
            ''return performance.timing.loadEventEnd - performance.timing.navigationStart''
        )
        logger.info(f''Page load time: {response_time}ms'')
        
    finally:
        browser.quit()

# This runs every 5 minutes from multiple AWS regions'),
    (7, 'What is a service mesh?', 'A **service mesh** is a dedicated **infrastructure layer** that manages **service-to-service communication** in microservices architectures. It uses a **sidecar proxy pattern** (typically **Envoy**) deployed alongside each service instance to intercept and control network traffic without requiring code changes.

Key capabilities include:
- **Traffic management**: load balancing, circuit breaking, retries, timeouts, canary deployments
- **Security**: automatic mutual TLS (mTLS) encryption, certificate management, authorization policies
- **Observability**: distributed tracing, metrics collection, service dependency mapping
- **Resilience**: fault injection, health checks, failure recovery

The **control plane** (e.g., Istio''s Istiod) configures the **data plane** (sidecar proxies) to enforce policies consistently across all services.', 'medium', '**Real-world use case**: Imagine you have 50 microservices that need secure communication. Without a service mesh, you''d implement TLS, retries, and monitoring in *each service''s code*. With a service mesh, these capabilities are handled transparently by the infrastructure.

**Popular implementations**:
- **Istio**: Feature-rich, Kubernetes-native, backed by Google/IBM
- **Linkerd**: Lightweight, simpler to operate, CNCF graduated project
- **Consul Connect**: From HashiCorp, works across multiple platforms
- **AWS App Mesh**: Managed service for AWS environments

**When to use**:
- You have 10+ microservices with complex communication patterns
- Need uniform security policies (zero-trust networking)
- Require advanced traffic management (A/B testing, canary releases)
- Want centralized observability without instrumenting every service

**Trade-offs**:
- *Complexity*: Additional components to learn, configure, and troubleshoot
- *Performance overhead*: Extra network hop through sidecar proxy (typically 1-5ms latency)
- *Resource consumption*: Each sidecar uses CPU/memory
- *Operational burden*: Requires expertise to tune and maintain

**Alternative**: For simpler architectures, use a **library-based approach** (Spring Cloud, Netflix OSS) or **API gateway** for north-south traffic only.', '# Example: Istio traffic management for canary deployment
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: reviews-route
spec:
  hosts:
  - reviews
  http:
  - match:
    - headers:
        user-agent:
          regex: ''.*Mobile.*''
    route:
    - destination:
        host: reviews
        subset: v2
      weight: 100
  - route:
    - destination:
        host: reviews
        subset: v1
      weight: 90
    - destination:
        host: reviews
        subset: v2
      weight: 10  # 10% traffic to new version
---
# Apply mutual TLS for service-to-service encryption
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: production
spec:
  mtls:
    mode: STRICT  # Enforce mTLS for all services'),
    (7, 'What is on-call rotation?', '**On-call rotation** is a scheduled system where engineers take turns being the primary responder for production incidents, system outages, and critical alerts outside regular business hours. The on-call engineer is responsible for **acknowledging alerts**, **triaging incidents**, **coordinating responses**, and **escalating issues** when necessary.

Typical rotations last **1-2 weeks per engineer**, with teams rotating through a schedule that ensures **24/7 coverage**. Organizations use tools like **PagerDuty**, **Opsgenie**, or **VictorOps** to manage rotations, alert routing, and escalation policies. The goal is to balance system reliability needs with engineer well-being and work-life balance.', 'easy', '## Real-World Implementation

**Common Rotation Patterns:**
- **Follow-the-sun**: Teams in different time zones handle their local business hours
- **Weekly rotations**: Engineers rotate every 7 days to maintain context
- **Primary/Secondary**: Two-tier system where secondary takes over if primary doesn''t respond within 5-15 minutes
- **Business hours vs. 24/7**: Some teams only have on-call during weekdays

**Best Practices:**

1. **Fair Distribution**: Rotate evenly across team members with similar skill levels
2. **Manageable Alert Load**: Aim for <5 pages per night; excessive alerts indicate systemic issues requiring remediation
3. **Clear Escalation Paths**: Document who to contact for specialized systems (database, networking, security)
4. **Compensation**: Provide stipends ($500-2000/week), time off, or overtime pay
5. **Runbooks & Documentation**: Maintain updated playbooks for common incidents
6. **Post-Incident Reviews**: Hold blameless retrospectives to improve systems and reduce future pages

**Warning Signs of Burnout:**
- Engineers receiving >10 alerts per shift
- Frequent wake-ups during sleep hours
- Same issues repeatedly paging without resolution
- Lack of time to address root causes

**Example Scenario**: An e-commerce platform has 8 backend engineers. They implement a weekly rotation where each engineer is on-call from Monday 9 AM to the following Monday 9 AM. The engineer receives a $1,000 stipend and 1 comp day off. When the primary doesn''t acknowledge an alert within 10 minutes, it automatically escalates to the secondary, then to the engineering manager within another 10 minutes.', '# Example on-call rotation schedule configuration (PagerDuty-style YAML)

schedule:
  name: "Backend Engineering On-Call"
  time_zone: "America/New_York"
  rotation:
    type: "weekly"
    start_time: "2024-01-01T09:00:00"
    rotation_order:
      - user: "alice@company.com"
      - user: "bob@company.com"
      - user: "charlie@company.com"
      - user: "diana@company.com"

escalation_policy:
  name: "Production Escalation"
  rules:
    - level: 1
      targets: ["primary_on_call"]
      escalation_delay_minutes: 10
    - level: 2
      targets: ["secondary_on_call"]
      escalation_delay_minutes: 10
    - level: 3
      targets: ["engineering_manager"]
      escalation_delay_minutes: 5

alert_thresholds:
  critical:
    - service_down
    - error_rate > 5%
    - response_time > 5000ms
  warning:
    - disk_usage > 85%
    - memory_usage > 90%');

-- Flashcards for Networking (24 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (8, 'What is the difference between TCP and UDP?', 'TCP is connection-oriented and reliable; UDP is connectionless and faster but unreliable', 'easy', 'TCP guarantees delivery with error checking and retransmission. UDP is used for speed-critical applications like video streaming.', NULL),
    (8, 'What does DNS do?', 'Domain Name System translates human-readable domain names to IP addresses', 'easy', 'DNS is a distributed hierarchical system. Queries typically use UDP port 53. Results are often cached.', NULL),
    (8, 'What are the layers of the OSI model?', 'Physical, Data Link, Network, Transport, Session, Presentation, Application', 'medium', 'Mnemonic: "Please Do Not Throw Sausage Pizza Away". Each layer has specific protocols and responsibilities.', NULL),
    (8, 'What is a subnet mask?', 'A 32-bit number that divides an IP address into network and host portions', 'medium', 'Example: 255.255.255.0 (/24) means first 24 bits are network, last 8 bits are host addresses.', NULL),
    (8, 'What is the purpose of the ARP protocol?', 'Address Resolution Protocol maps IP addresses to MAC addresses on a local network', 'medium', 'ARP allows devices to discover the physical address (MAC) associated with an IP address on the same network segment.', NULL),
    (8, 'What is the difference between TCP and UDP?', 'TCP is connection-oriented with guaranteed delivery; UDP is connectionless with no guarantees', 'medium', 'TCP: reliable, ordered, slower (HTTP, SSH). UDP: fast, no overhead, allows packet loss (DNS, video streaming).', NULL),
    (8, 'What are the layers of the OSI model?', 'Physical, Data Link, Network, Transport, Session, Presentation, Application', 'hard', 'Mnemonic: Please Do Not Throw Sausage Pizza Away. Layer 1-7. TCP/IP model combines some layers.', NULL),
    (8, 'What is DNS and how does it work?', 'Domain Name System translates domain names to IP addresses using hierarchical lookups', 'medium', 'Client queries recursive resolver → root servers → TLD servers → authoritative nameserver. Cached at multiple levels.', NULL),
    (8, 'What is the difference between a hub, switch, and router?', 'Hub broadcasts to all ports; switch learns MAC addresses and forwards to specific port; router connects networks using IP', 'medium', 'Hub: Layer 1, dumb broadcast. Switch: Layer 2, MAC-based forwarding. Router: Layer 3, IP routing between networks.', NULL),
    (8, 'What is CIDR notation?', 'Classless Inter-Domain Routing notation for specifying IP address ranges (e.g., 192.168.1.0/24)', 'medium', '/24 means first 24 bits are network, last 8 bits are hosts (256 addresses). /16 = 65,536 addresses, /32 = single address.', NULL),
    (8, 'What is a subnet mask?', 'A 32-bit number that divides an IP address into network and host portions', 'medium', '255.255.255.0 = /24 subnet. ANDing IP with mask gives network address. Defines network size and number of hosts.', NULL),
    (8, 'What is ARP (Address Resolution Protocol)?', 'Protocol that maps IP addresses to MAC addresses on a local network', 'hard', 'Device broadcasts "Who has IP X?" on LAN. Device with that IP responds with MAC address. Cached in ARP table.', NULL),
    (8, 'What is the three-way handshake in TCP?', 'SYN → SYN-ACK → ACK - establishes TCP connection', 'medium', 'Client sends SYN, server responds SYN-ACK, client sends ACK. Establishes sequence numbers for reliable communication.', NULL),
    (8, 'What is NAT (Network Address Translation)?', 'Translates private IP addresses to public IP addresses for internet communication', 'medium', 'Allows multiple devices to share one public IP. Router maintains translation table. Types: SNAT (source), DNAT (destination).', NULL),
    (8, 'What is the difference between a stateful and stateless firewall?', 'Stateful tracks connection state; stateless examines each packet independently', 'hard', 'Stateful: knows if packet is part of established connection, more secure. Stateless: faster, simpler rules, less memory.', NULL),
    (8, 'What is a proxy server?', 'Intermediary server that forwards requests between client and server', 'medium', 'Forward proxy (client-side): privacy, caching. Reverse proxy (server-side): load balancing, SSL termination. Examples: Squid, nginx.', NULL),
    (8, 'What is SSL/TLS?', 'Cryptographic protocols for secure communication over networks', 'medium', 'SSL deprecated, TLS current. Provides encryption, authentication, integrity. Handshake establishes keys. Certificate verifies identity.', NULL),
    (8, 'What is the difference between port 80 and 443?', 'Port 80 is HTTP (unencrypted); port 443 is HTTPS (encrypted)', 'easy', 'Well-known ports. 80: plain HTTP. 443: HTTP over TLS/SSL. Modern web uses 443. Port 8080 common for HTTP alternatives.', NULL),
    (8, 'What is a VLAN?', 'Virtual LAN that segments a physical network into logical networks', 'hard', 'Separates broadcast domains. Improves security and performance. Tagged with VLAN ID (802.1Q). Switch ports assigned to VLANs.', NULL),
    (8, 'What is the purpose of the ping command?', 'Tests connectivity and measures round-trip time using ICMP echo', 'easy', 'Sends ICMP echo request, expects echo reply. Shows packet loss, latency. May be blocked by firewalls. IPv4: ping, IPv6: ping6', NULL),
    (8, 'What is a MAC address?', 'Hardware address uniquely identifying network interface (48-bit)', 'easy', 'Physical address burned into NIC. Format: 6 hex octets (00:1A:2B:3C:4D:5E). First 3 octets identify manufacturer (OUI).', NULL),
    (8, 'What is QoS (Quality of Service)?', 'Techniques to manage network resources and prioritize traffic', 'hard', 'Prioritizes critical traffic (VoIP, video) over bulk data. Mechanisms: traffic shaping, policing, queuing. Used in WANs, VoIP.', NULL),
    (8, 'What is the difference between IPv4 and IPv6?', 'IPv4 uses 32-bit addresses; IPv6 uses 128-bit addresses', 'medium', 'IPv4: 4.3 billion addresses, dotted decimal. IPv6: vast address space, colon-hex notation. IPv6 includes IPsec, no NAT needed.', NULL),
    (8, 'What is DHCP?', 'Dynamic Host Configuration Protocol that automatically assigns IP addresses', 'easy', 'Automates network configuration. DORA process: Discover, Offer, Request, Acknowledge. Leases addresses for time period.', NULL);

-- Flashcards for SQL (25 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (9, 'What is the difference between INNER JOIN and LEFT JOIN?', 'INNER JOIN returns only matching rows; LEFT JOIN returns all left table rows plus matches', 'easy', 'LEFT JOIN includes nulls for non-matching right table rows. RIGHT JOIN is the opposite.', NULL),
    (9, 'How do you find duplicate rows based on a column?', 'SELECT column, COUNT(*) FROM table GROUP BY column HAVING COUNT(*) > 1', 'medium', 'HAVING filters grouped results. GROUP BY aggregates rows. This pattern finds duplicates in any column.', NULL),
    (9, 'What does the EXPLAIN command do?', 'Shows the execution plan for a query, revealing how the database will execute it', 'medium', 'EXPLAIN helps identify performance issues like missing indexes, full table scans, or inefficient joins.', NULL),
    (9, 'What is the difference between WHERE and HAVING?', 'WHERE filters rows before grouping; HAVING filters after aggregation', 'medium', 'WHERE operates on individual rows. HAVING operates on grouped results and can use aggregate functions.', NULL),
    (9, 'What is a database index?', 'A data structure that improves query performance by allowing faster data retrieval', 'easy', 'Indexes speed up SELECT queries but slow down INSERT/UPDATE/DELETE. Trade-off between read and write performance.', NULL),
    (9, 'What is the difference between WHERE and HAVING?', 'WHERE filters rows before grouping; HAVING filters groups after grouping', 'medium', 'WHERE works on individual rows, HAVING works on aggregated results. Use WHERE for row conditions, HAVING for aggregate conditions.', NULL),
    (9, 'What is a primary key?', 'A column or set of columns that uniquely identifies each row in a table', 'easy', 'Must be unique and NOT NULL. Only one primary key per table. Auto-indexed for performance. Often uses AUTO_INCREMENT.', NULL),
    (9, 'What is the difference between INNER JOIN and LEFT JOIN?', 'INNER JOIN returns only matching rows; LEFT JOIN returns all left table rows plus matches', 'medium', 'INNER: intersection only. LEFT: all from left + matches from right (NULL for no match). Also: RIGHT JOIN, FULL OUTER JOIN.', NULL),
    (9, 'What is an index and why use it?', 'A data structure that improves query performance by allowing faster data retrieval', 'medium', 'Trade-off: faster SELECT queries vs slower INSERT/UPDATE/DELETE. Use on frequently queried columns. B-tree is common structure.', NULL),
    (9, 'What is a foreign key?', 'A column that references the primary key of another table, enforcing referential integrity', 'medium', 'Ensures values exist in referenced table. Prevents orphaned records. ON DELETE CASCADE/SET NULL defines behavior.', NULL),
    (9, 'What is the difference between DELETE and TRUNCATE?', 'DELETE removes rows one by one (can rollback); TRUNCATE drops and recreates table (faster, can''t rollback)', 'medium', 'DELETE fires triggers, can have WHERE clause, logs each row. TRUNCATE resets auto-increment, is DDL not DML.', NULL),
    (9, 'What is a transaction and what are ACID properties?', 'A unit of work that must be Atomic, Consistent, Isolated, Durable', 'hard', 'Atomic: all or nothing. Consistent: valid state. Isolated: concurrent transactions don''t interfere. Durable: persisted after commit.', NULL),
    (9, 'What is normalization?', 'Organizing database structure to reduce redundancy and improve data integrity', 'hard', '1NF: atomic values. 2NF: no partial dependencies. 3NF: no transitive dependencies. Higher forms exist but 3NF is common.', NULL),
    (9, 'What is a subquery?', 'A query nested inside another query', 'easy', 'Can be in SELECT, FROM, WHERE clauses. Use for complex filtering, derived tables, or EXISTS checks. Can impact performance.', NULL),
    (9, 'What is the difference between UNION and UNION ALL?', 'UNION removes duplicates; UNION ALL keeps all rows including duplicates', 'medium', 'UNION is slower (needs to check duplicates). UNION ALL is faster. Both require same number and compatible types of columns.', NULL),
    (9, 'What is a view in SQL?', 'Virtual table based on a SELECT query', 'medium', 'Simplifies complex queries, provides abstraction, security. Materialized views cache results. Updated views may have restrictions.', NULL),
    (9, 'What is the GROUP BY clause used for?', 'Groups rows sharing a property for aggregate functions', 'easy', 'Used with COUNT, SUM, AVG, MAX, MIN. Must include all non-aggregated columns. Filter groups with HAVING, not WHERE.', NULL),
    (9, 'What is a stored procedure?', 'Precompiled SQL code saved in database that can be reused', 'medium', 'Benefits: performance, security, code reuse. Can have parameters, logic, transactions. Language varies by DB (PL/SQL, T-SQL).', NULL),
    (9, 'What is the difference between CHAR and VARCHAR?', 'CHAR is fixed-length; VARCHAR is variable-length', 'easy', 'CHAR pads with spaces, faster for fixed sizes. VARCHAR saves space for variable data. Use CHAR for codes, VARCHAR for names.', NULL),
    (9, 'What is a trigger?', 'Automatically executed procedure in response to database events', 'hard', 'Events: INSERT, UPDATE, DELETE. Timing: BEFORE, AFTER. Use cases: audit logs, validation, cascading updates. Can impact performance.', NULL),
    (9, 'What is the purpose of EXPLAIN in SQL?', 'Shows query execution plan to help optimize performance', 'medium', 'Reveals indexes used, join methods, estimated costs. Use to identify slow queries, missing indexes. Syntax varies by database.', NULL),
    (9, 'What is a composite key?', 'Primary key consisting of two or more columns', 'medium', 'Used when single column can''t uniquely identify row. Example: order_id + product_id for line items. All columns required for uniqueness.', NULL),
    (9, 'What is SQL injection?', 'Security vulnerability where malicious SQL is inserted into queries', 'hard', 'Caused by unsanitized user input. Prevention: parameterized queries, prepared statements, input validation, ORMs. Critical security issue.', NULL),
    (9, 'What is the difference between RANK and DENSE_RANK?', 'RANK skips numbers after ties; DENSE_RANK doesn''t skip', 'hard', 'Both assign ranks to rows. RANK: 1,2,2,4. DENSE_RANK: 1,2,2,3. ROW_NUMBER always unique. Window functions.', NULL),
    (9, 'What is a clustered vs non-clustered index?', 'Clustered defines physical order of data; non-clustered is separate structure', 'hard', 'One clustered index per table (usually PK). Multiple non-clustered indexes possible. Clustered faster for range queries.', NULL);

-- Flashcards for System Design (53 cards)
INSERT INTO flashcards (category_id, question, answer, difficulty, explanation, code_snippet) VALUES
    (10, 'What is horizontal vs vertical scaling?', 'Horizontal: add more machines; Vertical: add more resources to existing machines', 'easy', 'Horizontal (scale out) is more flexible and fault-tolerant. Vertical (scale up) has hardware limits.', NULL),
    (10, 'What is CAP theorem?', 'A distributed system can only guarantee 2 of 3: Consistency, Availability, Partition tolerance', 'hard', 'In practice, partition tolerance is required, so choice is between Consistency (CP) or Availability (AP).', NULL),
    (10, 'What is the purpose of a load balancer?', 'Distributes incoming traffic across multiple servers to improve availability and performance', 'easy', 'Load balancers prevent overload, enable horizontal scaling, and provide failover. Types: Layer 4 (TCP) or Layer 7 (HTTP).', NULL),
    (10, 'What is database sharding?', 'Partitioning data across multiple databases to distribute load and improve scalability', 'medium', 'Each shard contains a subset of data. Sharding key determines data distribution. Adds complexity but enables massive scale.', NULL),
    (10, 'What is eventual consistency?', 'A consistency model where updates propagate to all nodes over time, but reads may return stale data', 'medium', 'Common in distributed systems prioritizing availability. Contrast with strong consistency which guarantees immediate consistency.', NULL),
    (10, 'What is horizontal vs vertical scaling?', 'Horizontal adds more machines; vertical adds more power to existing machine', 'easy', 'Horizontal (scale out): distributed, unlimited growth, complex. Vertical (scale up): simpler, hardware limits, single point of failure.', NULL),
    (10, 'What is a load balancer?', 'Distributes incoming network traffic across multiple servers to ensure availability and reliability', 'medium', 'Algorithms: round-robin, least connections, IP hash. Provides high availability, health checks, SSL termination. Layer 4 or Layer 7.', NULL),
    (10, 'What is database replication?', 'Copying data from one database to others for redundancy and performance', 'medium', 'Master-slave: writes to master, reads from replicas. Multi-master: writes to any. Trade-offs: consistency vs availability.', NULL),
    (10, 'What is eventual consistency?', 'A consistency model where data eventually becomes consistent across all nodes', 'hard', 'Prioritizes availability over immediate consistency. Common in distributed systems (DynamoDB, Cassandra). Conflicts resolved later.', NULL),
    (10, 'What is a CDN (Content Delivery Network)?', 'A distributed network of servers that delivers content from locations closest to users', 'medium', 'Caches static assets (images, CSS, JS) at edge locations worldwide. Reduces latency, bandwidth, and server load.', NULL),
    (10, 'What is the difference between caching and CDN?', 'Caching stores frequently accessed data in memory; CDN is geographically distributed content storage', 'medium', 'Cache: application-level (Redis, Memcached), dynamic data. CDN: network-level, static content, geographic distribution.', NULL),
    (10, 'What is database sharding?', 'Partitioning data across multiple databases to distribute load', 'hard', 'Horizontal partitioning by shard key (e.g., user_id % N). Improves scalability but adds complexity: cross-shard queries, rebalancing.', NULL),
    (10, 'What is the purpose of a message queue?', 'Asynchronous communication between services, decoupling producers and consumers', 'medium', 'Benefits: load leveling, fault tolerance, guaranteed delivery. Examples: RabbitMQ, Kafka, SQS. Trade-off: eventual processing.', NULL),
    (10, 'What is the difference between microservices and monolith?', 'Microservices split application into small independent services; monolith is a single deployable unit', 'medium', 'Microservices: independent scaling/deployment, complex networking. Monolith: simpler to develop, harder to scale, single deployment.', NULL),
    (10, 'What is idempotency and why is it important?', 'An operation that produces the same result no matter how many times it is performed', 'hard', 'Critical for retries and distributed systems. GET, PUT, DELETE are idempotent. POST usually is not. Use idempotency keys for POST.', NULL),
    (10, 'What is caching strategy and name common types?', 'Method to store and retrieve cached data; types: write-through, write-back, write-around, cache-aside', 'hard', 'Write-through: sync write to cache and DB. Write-back: async write. Write-around: skip cache. Cache-aside: app manages cache.', NULL),
    (10, 'What is the difference between SQL and NoSQL?', 'SQL is relational with schema; NoSQL is non-relational, schema-less', 'medium', 'SQL: ACID, joins, structured (Postgres, MySQL). NoSQL: flexible schema, horizontal scaling, eventual consistency (MongoDB, Cassandra).', NULL),
    (10, 'What is rate limiting?', 'Controlling the rate of requests to protect services from overload', 'medium', 'Algorithms: token bucket, leaky bucket, fixed/sliding window. Prevents abuse, ensures fair usage, protects resources.', NULL),
    (10, 'What is the purpose of an API gateway?', 'Single entry point for API requests providing routing, security, and rate limiting', 'medium', 'Functions: authentication, rate limiting, request routing, response aggregation, logging. Examples: Kong, AWS API Gateway.', NULL),
    (10, 'What is data replication vs data partitioning?', 'Replication copies data to multiple nodes; partitioning splits data across nodes', 'hard', 'Replication: redundancy, availability, read scaling. Partitioning: write scaling, distributes load. Often used together.', NULL),
    (10, 'What is a circuit breaker pattern?', 'Prevents cascading failures by stopping requests to failing services', 'hard', 'States: closed (normal), open (failing), half-open (testing). Fails fast instead of waiting. Provides fallback responses.', NULL),
    (10, 'What is the difference between push and pull in messaging?', 'Push sends data to consumers; pull has consumers request data', 'medium', 'Push: real-time, complex flow control. Pull: consumer-controlled rate, simpler. Examples: WebSockets (push), polling (pull).', NULL),
    (10, 'What is database indexing strategy?', 'Choosing which columns to index based on query patterns', 'hard', 'Index columns used in WHERE, JOIN, ORDER BY. Trade-off: read vs write performance. Monitor query plans, avoid over-indexing.', NULL),
    (10, 'What is the twelve-factor app methodology?', 'Best practices for building modern, scalable web applications', 'hard', 'Principles: codebase, dependencies, config, backing services, build/release/run, processes, port binding, concurrency, disposability, dev/prod parity, logs, admin processes.', NULL),
    (10, 'What is blue-green deployment?', 'Deployment strategy maintaining two identical environments, switching traffic between them', 'medium', 'Blue: current version. Green: new version. Test green, switch traffic, keep blue for rollback. Minimizes downtime, easy rollback.', NULL),
    (10, 'What are the main problems that pagination solves in large-scale system design?', 'Pagination solves four critical problems in large-scale systems:

1. **Server Resource Protection**: Prevents server overload by limiting the amount of data processed per request. Instead of querying millions of records, the server handles manageable chunks (e.g., 20-100 items), reducing CPU, memory, and database load.

2. **Client Stability**: Prevents client applications from crashing or freezing when attempting to render thousands of items simultaneously. Mobile apps especially benefit as they have limited memory.

3. **Network Efficiency**: Reduces bandwidth consumption by transferring only what''s needed. A user viewing page 1 doesn''t need pages 2-100 downloaded immediately.

4. **User Experience**: Creates responsive interfaces with fast initial load times. Users see results in milliseconds rather than waiting for complete datasets. This is crucial for engagement—studies show users abandon pages that take >3 seconds to load.', 'medium', '**Real-World Context:**

Consider **Twitter''s timeline**: Without pagination, loading your feed would mean fetching potentially *millions* of tweets, processing all relationships, likes, and media—causing catastrophic server load and client crashes.

With pagination (typically 20 tweets per request), Twitter:
- Queries only recent tweets from your network
- Loads images progressively as you scroll
- Maintains sub-second response times
- Supports billions of requests daily

**Common Pagination Patterns:**

- **Offset-based**: Simple but slow for large offsets (`LIMIT 20 OFFSET 1000` scans 1020 rows)
- **Cursor-based**: Efficient for feeds using `WHERE id > last_seen_id` (used by Twitter, Instagram)
- **Keyset pagination**: Uses indexed columns for consistent performance
- **Time-based**: For chronological data (`WHERE created_at < last_timestamp`)

**Interview Tip:** When discussing pagination, mention the **trade-offs**. Offset pagination is simple but doesn''t handle real-time data well (items can shift between pages). Cursor-based pagination handles insertions gracefully but makes "jump to page 5" difficult. This nuanced understanding impresses interviewers.', '# Offset-based pagination (simple but inefficient for large datasets)
GET /api/posts?page=2&limit=20
# Backend: SELECT * FROM posts LIMIT 20 OFFSET 20

# Cursor-based pagination (efficient, preferred for feeds)
GET /api/posts?limit=20&cursor=eyJpZCI6MTIzNH0
# Backend: SELECT * FROM posts WHERE id < 1234 ORDER BY id DESC LIMIT 20

# Response structure
{
  "data": [...],
  "pagination": {
    "next_cursor": "eyJpZCI6MTIxNH0",
    "has_more": true,
    "total": 15420  // optional, expensive to compute
  }
}

# Time-based pagination (for chronological data)
GET /api/messages?before=2024-01-15T10:30:00Z&limit=50
# Backend: SELECT * FROM messages 
#          WHERE created_at < ''2024-01-15T10:30:00Z'' 
#          ORDER BY created_at DESC LIMIT 50'),
    (10, 'Explain offset-based pagination and its primary performance drawback with an example.', 'Offset-based pagination uses a LIMIT and OFFSET to skip a certain number of rows and return the next set. For example: ''SELECT * FROM posts ORDER BY created_at DESC LIMIT 10 OFFSET 20''. The main drawback is that performance degrades with large offsets - if a user is on page 1,000, the database must scan and skip 10,000 rows before returning results, making it inefficient for deep pagination.', 'medium', 'This is a common interview topic because offset pagination is intuitive but has hidden scalability issues. Interviewers want to see if you understand that what seems simple can become a bottleneck at scale. This knowledge differentiates candidates who have dealt with real production systems.', 'SELECT * FROM posts ORDER BY created_at DESC LIMIT 10 OFFSET 20;'),
    (10, 'How does cursor-based pagination work and why is it more scalable than offset-based pagination?', 'Cursor-based pagination uses an encoded pointer representing the position of the last item returned. The API response includes a next_cursor for the subsequent request. It''s more scalable because it uses indexed fields to filter directly to the needed position rather than counting offsets. This provides consistent performance regardless of pagination depth.', 'medium', 'Cursor-based pagination is the industry standard for infinite scroll feeds. Understanding this pattern is crucial for interviews at companies like Facebook, Twitter, or Instagram. It demonstrates knowledge of how modern APIs maintain performance at scale.', 'GET /api/feed?limit=10&cursor=eyJpZCI6MTAwfQ=='),
    (10, 'Implement a cursor-based pagination function that returns posts with proper cursor encoding for the next page.', 'The function should: 1) Decode the cursor to get the last seen post''s timestamp and ID if provided, 2) Query posts using a WHERE clause with indexed fields (created_at, id) less than the cursor values, 3) Return posts with a next_cursor encoded from the last post''s attributes, or None if no more results exist.', 'hard', 'This tests your ability to implement cursor pagination in practice. The key insight is using composite conditions (timestamp, id) in the WHERE clause with indexed fields for efficient queries. This pattern is commonly asked in coding interviews for backend positions at companies building social feeds.', 'def get_feed(limit=10, cursor=None):
    if cursor:
        last_post = decode_cursor(cursor)
        query = """
            SELECT * FROM posts
            WHERE (created_at, id) < (:timestamp, :id)
            ORDER BY created_at DESC, id DESC
            LIMIT :limit
        """
    else:
        query = "SELECT * FROM posts ORDER BY created_at DESC, id DESC LIMIT :limit"
    
    posts = execute_query(query)
    next_cursor = encode_cursor({
        "timestamp": posts[-1].created_at,
        "id": posts[-1].id
    }) if posts else None
    
    return {
        "posts": posts,
        "pagination": {"next_cursor": next_cursor}
    }'),
    (10, 'What is keyset pagination and when is it particularly useful?', 'Keyset pagination uses specific field values (often timestamps) directly as pagination markers, such as ''GET /api/messages?limit=50&before=2024-03-15T00:00:00Z''. It''s particularly useful for time-series data like chat systems or activity feeds, especially when combined with database indexes on timestamp fields for optimal performance.', 'medium', 'Keyset pagination is a specialized optimization that shows deep understanding of database performance. It''s especially relevant for real-time systems where data is naturally ordered by time. Mentioning this in interviews demonstrates you can optimize beyond standard patterns.', 'CREATE INDEX idx_messages_timestamp ON messages(created_at DESC);'),
    (10, 'Compare the performance characteristics of offset vs cursor pagination using SQL examples. Why does offset pagination degrade?', 'Offset pagination (LIMIT 10 OFFSET 1000000) must scan 1 million rows even though it only returns 10, causing performance to degrade linearly with offset size. Cursor pagination (WHERE id < :last_seen_id LIMIT 10) uses an index to jump directly to the position, providing consistent O(1) seek time regardless of depth. The database can use the index to find the starting point without scanning previous rows.', 'hard', 'This question tests deep understanding of database internals and index usage. Strong candidates explain the difference between sequential scanning (offset) and index seeks (cursor). This knowledge is critical for senior positions where you need to make performance-critical architectural decisions.', '-- Bad: Performance degrades with offset
SELECT * FROM posts LIMIT 10 OFFSET 1000000

-- Good: Consistent performance with cursors
SELECT * FROM posts WHERE id < :last_seen_id LIMIT 10'),
    (10, 'What consistency issue can arise during pagination when new items are added, and which pagination strategy handles it best?', 'When new items are added to the dataset while a user is paginating, offset-based pagination can cause items to shift, leading to duplicates or skipped items across pages. Cursor-based pagination handles this elegantly by maintaining a consistent view - it marks a specific position in the dataset and continues from there regardless of new items added before that position.', 'medium', 'This is a subtle but important consideration in system design. It tests whether you think about edge cases and real-world scenarios. In production systems like social feeds, content is constantly being added, so this consistency guarantee is crucial for good user experience.', NULL),
    (10, 'Design an API response structure for paginated data that includes helpful metadata for clients.', 'A well-designed pagination response should include: 1) A ''data'' field with the actual results, 2) A ''pagination'' object containing ''next_cursor'' for the next request, 3) A ''has_more'' boolean indicating if more results exist. This structure provides clients with all information needed to implement seamless pagination without additional requests.', 'medium', 'Good API design is a key interview topic. This question tests whether you think about the client experience and API usability. Including metadata like ''has_more'' prevents clients from making unnecessary requests when they''ve reached the end of results.', '{
  "data": [
    /* posts */
  ],
  "pagination": {
    "next_cursor": "eyJpZCI6MTAwfQ==",
    "has_more": true
  }
}'),
    (10, 'In a system design interview, how would you justify choosing cursor-based pagination for a social media feed versus offset pagination for an admin dashboard?', 'For a social media feed, choose cursor-based pagination because: users scroll through thousands of posts requiring consistent performance at any depth, data changes frequently requiring consistency guarantees, and page numbers aren''t meaningful. For an admin dashboard, offset pagination is acceptable because: dataset sizes are smaller, users need specific page numbers for navigation, performance at moderate offsets is sufficient, and implementation is simpler.', 'hard', 'This question tests your ability to make context-appropriate architectural decisions and articulate tradeoffs - a key skill in system design interviews. Strong candidates don''t just know different approaches but can explain when and why to use each based on specific requirements, scale, and user experience considerations.', NULL),
    (10, 'What is the primary difference between API keys and JWTs in terms of authentication scope?', 'API keys authenticate applications (not users), while JWTs authenticate users and can contain user-specific claims like roles and permissions. API keys identify which service is making requests, whereas JWTs provide user context and authorization information.', 'easy', 'This is a fundamental distinction that affects how you design authentication. API keys are for service-to-service authentication and rate limiting, while JWTs are for user authentication in distributed systems.', NULL),
    (10, 'Explain the main scaling challenge with session-based authentication and how it can be addressed.', 'Sessions require server-side storage, creating a horizontal scaling bottleneck because each server traditionally maintains its own session store in memory. When a user''s subsequent request hits a different server (common with load balancers), that server won''t have access to the session data, causing authentication failures.

This challenge is addressed through three main approaches: (1) Sticky sessions - routing users to the same server, which limits true scalability and creates single points of failure; (2) Centralized session storage using Redis or Memcached, allowing any server to access any session; (3) Token-based authentication (JWT), eliminating server-side storage entirely by encoding user data in the token itself.

The centralized storage approach is most common in production systems, but it introduces a critical dependency - if Redis goes down, all sessions become inaccessible. This requires implementing Redis clustering, replication, and failover strategies to maintain high availability.', 'medium', 'In real-world scenarios, companies like Reddit, GitHub, and Netflix have all dealt with this challenge when scaling from single-server to distributed architectures. Reddit specifically documented their migration from in-memory sessions to Redis-backed sessions to handle millions of concurrent users.

The problem becomes apparent when you deploy multiple application servers behind a load balancer. User A logs in and their session is stored on Server 1. The next request from User A might be routed to Server 2, which has no knowledge of that session, forcing them to log in again - creating a poor user experience.

Modern architectures increasingly favor stateless authentication (JWT/OAuth) over sessions for microservices, as it eliminates the shared storage dependency entirely. However, session-based auth with Redis remains popular for monolithic applications and scenarios requiring immediate session invalidation (like security-sensitive applications where you need to revoke access instantly).', '// Problem: In-memory sessions don''t scale
const session = require(''express-session'');
app.use(session({
  secret: ''key'',
  resave: false,
  saveUninitialized: true
  // Sessions stored in memory - lost when server restarts
}));

// Solution: Centralized Redis session store
const RedisStore = require(''connect-redis'')(session);
const redis = require(''redis'');
const redisClient = redis.createClient({
  host: ''redis-cluster.example.com'',
  port: 6379,
  password: process.env.REDIS_PASSWORD
});

app.use(session({
  store: new RedisStore({ client: redisClient }),
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: { 
    secure: true,
    maxAge: 86400000 // 24 hours
  }
}));

// Now all servers share session data via Redis
// User can hit any server and remain authenticated'),
    (10, 'What is the JWT revocation problem and what are the common solutions?', 'Since JWTs are self-contained and validated cryptographically without database lookups, they cannot be immediately invalidated like sessions. Common solutions include: (1) using short expiration times (5-15 minutes for high-risk apps, 15-60 minutes for typical web apps) with refresh tokens, and (2) maintaining token blacklists for critical scenarios like logout or security incidents.', 'hard', 'This is a critical security consideration when choosing JWTs. The stateless nature that makes them scalable also makes them harder to revoke, requiring careful TTL design and potential hybrid approaches.', NULL),
    (10, 'How does GitHub''s API rate limiting demonstrate the practical use of API keys?', 'GitHub provides 5,000 requests per hour for authenticated requests with valid API keys, compared to only 60 requests per hour for anonymous requests. This shows how API keys enable per-application rate limiting and usage tracking.', 'easy', 'This demonstrates a key use case for API keys: differentiating between applications and enforcing appropriate resource limits based on application identity.', 'GET /v1/charges
Authorization: Bearer sk_test_[EXAMPLE_KEY_REDACTED]'),
    (10, 'What security measures should be implemented for session cookies in high-security applications like banking?', 'Banking applications should implement: (1) short session timeouts (15 minutes), (2) secure cookie flags including HttpOnly (prevents JavaScript access), Secure (HTTPS only), and SameSite (CSRF protection), and (3) immediate session invalidation on suspicious activity detection.', 'medium', 'These measures form defense-in-depth for session security. Each flag addresses different attack vectors: HttpOnly prevents XSS token theft, Secure prevents MITM attacks, and SameSite prevents CSRF attacks.', NULL),
    (10, 'When validating JWTs, what additional checks must be performed beyond signature verification?', 'Beyond signature verification, services must: (1) fetch and validate against public keys (JWKS) for signature verification, (2) validate the issuer (iss claim), (3) validate the audience (aud claim), (4) check expiration (exp claim) with clock skew tolerance, and (5) verify the token hasn''t been issued too far in the past (nbf claim).', 'hard', 'Simply verifying a signature is insufficient. These additional checks prevent token misuse across different services, replay attacks, and time-based vulnerabilities.', NULL),
    (10, 'What is a hybrid authentication approach and why do production systems use them?', 'Hybrid approaches combine multiple authentication methods for different use cases. For example, GitHub uses personal access tokens for REST API access, opaque OAuth tokens for authorization, and sessions for their web interface. This optimizes each authentication method for its specific requirements rather than forcing a single solution.', 'medium', 'Real-world systems rarely use a single authentication pattern. Different clients (web, mobile, API) and different security requirements benefit from different authentication strategies.', NULL),
    (10, 'Compare the immediate revocation capabilities of API keys, sessions, and JWTs.', 'Sessions offer excellent immediate revocation by deleting server-side session data. API keys offer easy revocation if server-checked against a database or cache. JWTs have complex revocation because they''re self-contained and validated locally—requiring either short TTLs with refresh tokens or maintaining blacklists.', 'medium', 'This comparison is critical for security decisions. If immediate revocation is a requirement (e.g., compromised credentials), sessions or server-validated API keys are preferable to JWTs.', NULL),
    (10, 'Why should JWT tokens prefer role IDs over large permission sets, and what should be kept in sessions?', 'JWT tokens should use role IDs instead of large permission sets to avoid token bloat, which increases bandwidth and storage requirements. Sessions should store lightweight state like user ID, role IDs, and CSRF tokens, while referencing larger data from profile stores. This reduces memory pressure and simplifies invalidation.', 'medium', 'Token size directly impacts performance. Large JWTs increase network overhead on every request. Keeping sessions small improves cache efficiency and reduces the cost of session invalidation.', NULL),
    (10, 'Based on the decision factors table, which authentication pattern would you choose for a microservices architecture with mobile clients, and why?', 'JWT would be the best choice because it offers stateless authentication with local verification, excellent horizontal scaling without shared storage dependencies, and embedded user context. While it has complex revocation, this can be managed with appropriate TTLs (15-60 minutes for web, longer for mobile) and refresh token strategies. Sessions would require shared storage across all microservices, creating coupling and a critical dependency.', 'hard', 'This tests understanding of practical architecture decisions. Microservices benefit from stateless authentication to avoid tight coupling, and mobile clients benefit from longer-lived tokens to reduce authentication overhead.', NULL),
    (10, 'What is the key difference between RPS and QPS, and why do engineers often monitor QPS more closely in system design?', 'RPS (Requests Per Second) measures the total number of all requests received by a server, including static resources and dynamic content. QPS (Queries Per Second) specifically measures database queries executed per second. Engineers monitor QPS more closely because databases are often the most constrained part of the system, while stateless services handling web requests are easier to scale.', 'easy', 'Understanding this distinction is crucial for system design interviews. While RPS gives a broader picture of overall system load, QPS helps identify database bottlenecks, which are typically harder to scale than stateless application servers. Many engineers use these terms interchangeably in practice.', NULL),
    (10, 'You''re designing a system for a startup expecting 50 QPS. What architecture and technology stack would you recommend and why?', 'For 50 QPS (Low QPS: 1-100), a monolithic architecture is sufficient. Technology stack: Simple backend frameworks like Django (Python) or Express.js (Node.js), relational databases like PostgreSQL or MySQL, and single-instance infrastructure like AWS EC2 or DigitalOcean Droplet. This approach avoids unnecessary complexity while meeting the performance requirements.', 'medium', 'This tests the ability to match system requirements to appropriate architecture. Over-engineering at this stage wastes resources. The classic LAMP/LEMP stack (Linux, Apache/Nginx, MySQL, PHP/Python) or similar simple stacks are proven solutions for this scale.', NULL),
    (10, 'What architectural changes should be implemented when scaling from 100 QPS to 500 QPS (Medium QPS range)?', 'Transition from monolithic to modular/microservices architecture for independent scaling. Implement database strategies like sharding, replication, or read replicas. Add caching layer using Redis or Memcached. Use horizontal scaling with containerization (Docker) and orchestration tools (Kubernetes). Implement load balancing to distribute traffic efficiently.', 'medium', 'This range represents a critical transition point where simple vertical scaling becomes insufficient. The key is identifying and addressing bottlenecks through decoupling, caching, and horizontal scaling rather than just adding more CPU/RAM to a single server.', NULL),
    (10, 'For a system handling 50,000 QPS (High QPS), what are the essential architectural components you would implement?', 'Essential components include: (1) Fully implemented microservices for independent deployment and scaling, (2) Event-driven architecture with message queues like Kafka for buffering and decoupling, (3) Distributed data stores like Cassandra or MongoDB, (4) Heavy in-memory caching (Redis/Memcached) to reduce database load, (5) Container orchestration with Kubernetes, (6) Advanced load balancing, and (7) Real-time data streaming systems.', 'hard', 'At this scale, the architecture must be highly distributed and resilient. Message queues are critical for handling traffic spikes and preventing cascade failures. Caching becomes essential to prevent overwhelming the database layer. This is typical for large e-commerce platforms during peak events.', NULL),
    (10, 'Compare the database strategies needed for Medium QPS (100-1,000) versus High QPS (1,000-100,000) systems.', 'Medium QPS: Use read replicas for MySQL/PostgreSQL, implement basic caching with Redis, consider vertical scaling of database instances, and use simple sharding if needed. High QPS: Implement distributed databases (Cassandra, MongoDB), extensive multi-layer caching, horizontal sharding strategies, message queues for write buffering, and consider CQRS (Command Query Responsibility Segregation) patterns to separate read and write operations.', 'hard', 'This question tests understanding of progressive database scaling strategies. The key difference is that Medium QPS can still use traditional relational databases with optimization, while High QPS typically requires moving to distributed, NoSQL databases designed for horizontal scaling, along with more sophisticated data management patterns.', NULL),
    (10, 'What are the key architectural patterns required for Very High QPS (100,000+) systems like Netflix or Facebook?', 'Key patterns include: (1) Globally replicated databases across regions for low latency, (2) Multi-region deployments across multiple data centers, (3) Edge computing using CDNs to run code closer to users, (4) Serverless architecture for automatic scaling, (5) Multi-cloud environments for redundancy, (6) Extensive caching at multiple layers (browser, CDN, application, database), and (7) Advanced monitoring and auto-scaling mechanisms.', 'hard', 'At this scale, even small inefficiencies cause severe issues. The architecture must be globally distributed with redundancy at every level. Geographic distribution becomes critical for both performance (latency) and reliability (disaster recovery). Companies like Netflix pioneered many of these patterns, including chaos engineering to ensure resilience.', NULL),
    (10, 'Why do engineers say ''QPS'' when they often mean ''RPS'' in practice, and what should you clarify in a system design interview?', 'Engineers use QPS colloquially because databases are often the bottleneck and primary concern in system scaling. In interviews, you should clarify: (1) Whether the discussion is about total system requests (RPS) or database queries (QPS), (2) The ratio between RPS and QPS (one request might generate multiple queries), (3) Read vs write ratios, and (4) Whether static content is included in the metrics, as this affects CDN and caching strategies.', 'medium', 'This demonstrates practical communication skills essential in interviews. Understanding the context and clarifying terminology shows systems thinking. The RPS-to-QPS ratio is crucial for capacity planning: a single user request might trigger multiple database queries, or might hit cache and trigger zero queries.', NULL),
    (10, 'Design a caching strategy for a system transitioning from Medium QPS (500) to High QPS (5,000). What layers and technologies would you implement?', 'Implement multi-layer caching: (1) Browser caching for static assets (Cache-Control headers), (2) CDN caching for global content delivery, (3) Application-level caching with Redis for frequently accessed data (user sessions, product catalogs), (4) Database query caching for expensive queries, (5) Cache invalidation strategy (TTL-based or event-driven), (6) Cache warming for predictable access patterns, and (7) Circuit breakers to prevent cache stampede during failures.', 'hard', 'Effective caching is critical for scaling from medium to high QPS. Each layer serves different purposes: CDN reduces origin server load, application cache reduces database queries, and database cache optimizes query execution. The strategy must also handle cache invalidation and consistency to prevent serving stale data.', '// Example Redis caching pattern
const getCachedData = async (key) => {
  // Try cache first
  let data = await redis.get(key);
  
  if (data) {
    return JSON.parse(data);
  }
  
  // Cache miss - fetch from database
  data = await database.query(key);
  
  // Store in cache with TTL
  await redis.setex(key, 3600, JSON.stringify(data));
  
  return data;
};'),
    (10, 'In a system design interview, you''re told a service handles 10,000 QPS. What follow-up questions should you ask to properly design the system?', 'Critical follow-up questions: (1) Is this peak or average QPS? What''s the traffic pattern? (2) What''s the read-to-write ratio? (3) What''s the acceptable latency (p50, p95, p99)? (4) Are there geographic distribution requirements? (5) What''s the data size and growth rate? (6) What are the consistency requirements (eventual vs strong consistency)? (7) What''s the acceptable downtime/SLA? (8) Are there specific compliance or security requirements? (9) What''s the budget/cost constraint?', 'medium', 'This demonstrates that QPS alone is insufficient for system design. Traffic patterns matter: 10,000 QPS steady is different from spiky traffic. Read-heavy systems need different architectures than write-heavy ones. Latency requirements determine caching aggressiveness. These questions show mature systems thinking essential for senior engineering roles.', NULL);

