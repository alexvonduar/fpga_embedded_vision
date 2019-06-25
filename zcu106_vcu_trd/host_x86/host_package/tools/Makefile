CC ?= gcc
LDFLAGS=-pthread
#all: reg_rw dma_to_device dma_from_device performance
all: reg_rw pcie_host_app

pcie_host_app: pcie_host_app.o
	$(CC) $(LDFLAGS) -lrt -o $@ $< -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGE_FILE_SOURCE

reg_rw: reg_rw.o
	$(CC) -o $@ $<

%.o: %.c
	$(CC) $(LDFLAGS) -c -std=c99 -o $@ $< -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -D_LARGE_FILE_SOURCE

clean:
	rm -rf reg_rw reg_rw*.o *.bin pcie_host_app pcie_host_app.o

