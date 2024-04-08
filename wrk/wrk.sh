# d = 1 (20 request)
# d = 5 (100 request)
# d = 15 (300 request)
# d = 25 (500 request)

# Get c=10
## disable instr
wrk -t1 -c10 -d1s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c10.txt
echo -e "\n" >> ./disable_instr/get_c10.txt
wrk -t1 -c10 -d5s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c10.txt
echo -e "\n" >> ./disable_instr/get_c10.txt
wrk -t1 -c10 -d15s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c10.txt
echo -e "\n" >> ./disable_instr/get_c10.txt
wrk -t1 -c10 -d25s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c10.txt
echo -e "\n" >> ./disable_instr/get_c10.txt
## enable instr
wrk -t1 -c10 -d1s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c10.txt
echo -e "\n" >> ./enable_instr/get_c10.txt
wrk -t1 -c10 -d5s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c10.txt
echo -e "\n" >> ./enable_instr/get_c10.txt
wrk -t1 -c10 -d15s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c10.txt
echo -e "\n" >> ./enable_instr/get_c10.txt
wrk -t1 -c10 -d25s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c10.txt
echo -e "\n" >> ./enable_instr/get_c10.txt

# Get c=100
## disable instr
wrk -t1 -c100 -d1s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c100.txt
echo -e "\n" >> ./disable_instr/get_c100.txt
wrk -t1 -c100 -d5s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c100.txt
echo -e "\n" >> ./disable_instr/get_c100.txt
wrk -t1 -c100 -d15s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c100.txt
echo -e "\n" >> ./disable_instr/get_c100.txt
wrk -t1 -c100 -d25s --script=get.lua --latency http://10.4.2.234:8000 >> ./disable_instr/get_c100.txt
echo -e "\n" >> ./disable_instr/get_c100.txt
## enable instr
wrk -t1 -c100 -d1s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c100.txt
echo -e "\n" >> ./enable_instr/get_c100.txt
wrk -t1 -c100 -d5s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c100.txt
echo -e "\n" >> ./enable_instr/get_c100.txt
wrk -t1 -c100 -d15s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c100.txt
echo -e "\n" >> ./enable_instr/get_c100.txt
wrk -t1 -c100 -d25s --script=get.lua --latency http://10.4.2.234:8000 >> ./enable_instr/get_c100.txt
echo -e "\n" >> ./enable_instr/get_c100.txt

# d = 1 (5 request)
# d = 3 (15 request)
# d = 5 (20 request)

# POST c=10
## disable instr
wrk -t1 -c10 -d1s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./disable_instr/post_c10.txt
echo -e "\n" >> ./disable_instr/post_c10.txt
wrk -t1 -c10 -d3s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./disable_instr/post_c10.txt
echo -e "\n" >> ./disable_instr/post_c10.txt
wrk -t1 -c10 -d5s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./disable_instr/post_c10.txt
echo -e "\n" >> ./disable_instr/post_c10.txt
## enable instr
wrk -t1 -c10 -d1s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./enable_instr/post_c10.txt
echo -e "\n" >> ./enable_instr/post_c10.txt
wrk -t1 -c10 -d3s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./enable_instr/post_c10.txt
echo -e "\n" >> ./enable_instr/post_c10.txt
wrk -t1 -c10 -d5s --script=post.lua --latency http://10.4.2.234:8000/api/reservation >> ./enable_instr/post_c10.txt
echo -e "\n" >> ./enable_instr/post_c10.txt
