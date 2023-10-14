import time
import random
import threading

# IDEA: Acquire a semaphore. If blocked, make sure the second semaphore is released.
# This way, when the semaphore causing the block is released, the other one is
# acquired and the thread can run

"""
class Philosopher(thread, first, second):
    def __init__():
        self.thread = thread
        self.first = first
        self.second = second
"""

"""
def print_process_id():
    name = threading.current_thread().name.split(' ')[0]
    print(name, "PID:", os.getpid())
    read_shared_resources(name)
"""

def philosopher(i):
    while True:
        time.sleep(random.randint(3, 6)) # Think
        safe_acquire(semaphores[i], semaphores[(i + 1) % len(semaphores)])
        print("Philosopher {} is eating".format(i))
        semaphores[i].release()
        semaphores[(i + 1) % len(semaphores)].release()


    

def main():
    # philosopher in position k takes resources in positions k and k+1
    #philosophers = [threading.Thread(target=print_process_id).start() for i in range(5)]
    # Should actually start philosophers in the simulation


    #philosophers = [Philosopher(threading.Thread(target=print_process_id, k, true_idx(k+1))) for k in range(5)]

    global semaphores
    semaphores = [threading.Semaphore() for i in range(5)]

    for i in range(5):
        threading.Thread(target=philosopher(i)).start()
    
    #states = [0 for i in range(5)] Doesn't seem necessary in the end

    # Simulate a deadlock
    # Maybe should actually randomly make philosophers eat.
    # Also, should have a function instead of a class for a philosopher.

def safe_acquire(first, second):
    if first.acquire():
        # Release the first semaphore if acquiring the second would block.
        # Then, get blocked with the second one and finally acquire first.
        if not second.acquire(blocking=False):
            first.release()
            # Go blocked
            safe_acquire(second, first)
	
if __name__ == "__main__":
    main()



    """
    # k = idx of philosopher
    k_next = true_idx(k+1)

    if state[k] != 1 and true_idx(k_next) != 1
	semaphores[k].acquire()
	semaphores[k_next].acquire()
   """
