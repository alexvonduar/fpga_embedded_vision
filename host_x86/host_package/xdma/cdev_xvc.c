/*
 * This file is part of the Xilinx DMA IP Core driver for Linux
 *
 * Copyright (c) 2016-present,  Xilinx, Inc.
 * All rights reserved.
 *
 * This source code is licensed under both the BSD-style license (found in the
 * LICENSE file in the root directory of this source tree) and the GPLv2 (found
 * in the COPYING file in the root directory of this source tree).
 * You may select, at your option, one of the above-listed licenses.
 */

#define pr_fmt(fmt)     KBUILD_MODNAME ":%s: " fmt, __func__

#include "xdma_cdev.h"
#include "cdev_xvc.h"

/*
 * character device file operations for control bus (through control bridge)
 */
static ssize_t char_ctrl_read(struct file *fp, char __user *buf, size_t count,
		loff_t *pos)
{
	struct xdma_cdev *xcdev = (struct xdma_cdev *)fp->private_data;
	struct xdma_dev *xdev;
	void *reg;
	u32 w;
	int rv;

	rv = xcdev_check(__func__, xcdev, 0);
	if (rv < 0)
		return rv;	
	xdev = xcdev->xdev;

	/* only 32-bit aligned and 32-bit multiples */
	if (*pos & 3)
		return -EPROTO;
	/* first address is BAR base plus file position offset */
	reg = xdev->bar[xcdev->bar] + *pos;
	//w = read_register(reg);
	w = ioread32(reg);
	dbg_sg("char_ctrl_read(@%p, count=%ld, pos=%d) value = 0x%08x\n", reg,
		(long)count, (int)*pos, w);
	rv = copy_to_user(buf, &w, 4);
	if (rv)
		dbg_sg("Copy to userspace failed but continuing\n");

	*pos += 4;
	return 4;
}

static ssize_t char_ctrl_write(struct file *file, const char __user *buf,
			size_t count, loff_t *pos)
{
	struct xdma_cdev *xcdev = (struct xdma_cdev *)file->private_data;
	struct xdma_dev *xdev;
	void *reg;
	u32 w;
	int rv;

	rv = xcdev_check(__func__, xcdev, 0);
	if (rv < 0)
		return rv;	
	xdev = xcdev->xdev;

	/* only 32-bit aligned and 32-bit multiples */
	if (*pos & 3)
		return -EPROTO;

	/* first address is BAR base plus file position offset */
	reg = xdev->bar[xcdev->bar] + *pos;
	rv = copy_from_user(&w, buf, 4);
	if (rv) {
		pr_info("copy from user failed %d/4, but continuing.\n", rv);
	}

	dbg_sg("char_ctrl_write(0x%08x @%p, count=%ld, pos=%d)\n", w, reg,
		(long)count, (int)*pos);
	//write_register(w, reg);
	iowrite32(w, reg);
	*pos += 4;
	return 4;
}

/* maps the PCIe BAR into user space for memory-like access using mmap() */
int user_bridge_mmap(struct file *file, struct vm_area_struct *vma)
{
	struct xdma_dev *xdev;
	struct xdma_cdev *xcdev = (struct xdma_cdev *)file->private_data;
	unsigned long off;
	unsigned long phys;
	unsigned long vsize;
	unsigned long psize;
	int rv;

	rv = xcdev_check(__func__, xcdev, 0);
	if (rv < 0)
		return rv;	
	xdev = xcdev->xdev;

	off = vma->vm_pgoff << PAGE_SHIFT;
	/* BAR physical address */
	phys = pci_resource_start(xdev->pdev, xcdev->bar) + off;
	vsize = vma->vm_end - vma->vm_start;
	/* complete resource */
	psize = pci_resource_end(xdev->pdev, xcdev->bar) -
		pci_resource_start(xdev->pdev, xcdev->bar) + 1 - off;

	dbg_sg("mmap(): xcdev = 0x%08lx\n", (unsigned long)xcdev);
	dbg_sg("mmap(): cdev->bar = %d\n", xcdev->bar);
	dbg_sg("mmap(): xdev = 0x%p\n", xdev);
	dbg_sg("mmap(): pci_dev = 0x%08lx\n", (unsigned long)xdev->pdev);

	dbg_sg("off = 0x%lx\n", off);
	dbg_sg("start = 0x%llx\n",
		(unsigned long long)pci_resource_start(xdev->pdev,
		xcdev->bar));
	dbg_sg("phys = 0x%lx\n", phys);

	if (vsize > psize)
		return -EINVAL;
	/*
	 * pages must not be cached as this would result in cache line sized
	 * accesses to the end point
	 */
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
	/*
	 * prevent touching the pages (byte access) for swap-in,
	 * and prevent the pages from being swapped out
	 */
	vma->vm_flags |= VMEM_FLAGS;
	/* make MMIO accessible to user space */
	rv = io_remap_pfn_range(vma, vma->vm_start, phys >> PAGE_SHIFT,
			vsize, vma->vm_page_prot);
	dbg_sg("vma=0x%p, vma->vm_start=0x%lx, phys=0x%lx, size=%lu = %d\n",
		vma, vma->vm_start, phys >> PAGE_SHIFT, vsize, rv);

	if (rv)
		return -EAGAIN;
	return 0;
}


/*
 * character device file operations for the XVC
 */
static const struct file_operations xvc_fops = {
        .owner = THIS_MODULE,
        .open = char_open,
        .release = char_close,
		.read = char_ctrl_read,
		.write = char_ctrl_write,
		.mmap = user_bridge_mmap,
};

void cdev_xvc_init(struct xdma_cdev *xcdev)
{
	xcdev->bar = 0;
	cdev_init(&xcdev->cdev, &xvc_fops);
}
