#script (python)
import random

graph = {1: [2,9],
2: [1,3,4,6],
3: [2,4,6,8],
4: [2,3,5,6],
5: [4,6],
6: [2,3,4,5,7],
7: [6,8,9],
8: [3,7,9],
9: [1,7,8]}

def getLinkage(X):   
    if X not in graph:
        return []
    linknode = []
    for node in graph[X]:
        linknode.append(node)
    return linknode

def link_exists(X,Y):
    if X not in graph:
        return 0
    for node in graph[X]:
        if node == Y:
            return 1
    return 0

def dfs(start):
    visited = {}
    stack =  [start]
    time = 0
    while stack:
        vertex = stack.pop()
        if vertex not in visited:
            visited.update({vertex: time})
            time = time + 1
            for node in graph[vertex]:
                if node not in visited:
                    stack.append(node)
    return visited

def barrier_exists(X,T):
    visit_dict = dfs(6)
    if X not in visit_dict:
        return 0
    if T == visit_dict[X]:
        return 1
    return 0
#end.
