import h5py
import numpy as np
import matplotlib.pyplot as plt

# set up the figure and axes
fig = plt.figure(figsize=(800, 600))
ax1 = fig.add_subplot(121, projection='3d')
ax2 = fig.add_subplot(122, projection='3d')

# fake data
_x = np.arange(6)
_y = np.arange(6)
_xx, _yy = np.meshgrid(_x, _y)
x, y = _xx.ravel(), _yy.ravel()

file1 = h5py.File('l2=1.h5','r')
top1 = file1["data"][:].ravel()
bottom = np.zeros_like(top1)
width = depth = 1

colors = plt.cm.jet(top1.flatten())
ax1.bar3d(x, y, bottom, width, depth, top1, shade=True,color=colors)
ax1.set_title('l2=1')
ax1.set_xlabel('p1')
ax1.set_ylabel('p2')

file2 = h5py.File('l2=2.h5','r')
top1 = file2["data"][:].ravel()


colors = plt.cm.jet(top1.flatten())
ax1.bar3d(x, y, bottom, width, depth, top1, shade=True,color=colors)
ax1.set_title('l2=1')
ax1.set_xlabel('p1')
ax1.set_ylabel('p2')
ax1.set_zlim3d(0,1)

ax2.bar3d(x, y, bottom, width, depth, top1, shade=True,color=colors)
ax2.set_title('l2=2')
ax2.set_xlabel('p1')
ax2.set_ylabel('p2')
ax2.set_zlim3d(0,1)

plt.show()