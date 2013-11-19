From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Tue, 19 Nov 2013 19:33:14 +0100
Message-ID: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

Here the patch for a spi_message_compile interface 
(as discussed in a separate thread).

Naming of the API is subject to discussion - instead of "compile" it could
also be "optimize" or "hint" or ...

The patch creates:
* 3 additional variables in spi_message
* 2 additional function pointers in spi_master
* spi_message_compile/uncompile using the above
* __spi_async modified, so that the "validation" step for the message
  does not run every time.

Here some measurements using my "standard" CAN test:
* runs on Raspberry Pi without over-clocking
* optimized mcp2515 driver with 3 Message chunks and callbacks running 
  in listen only mode
* CAN bus is running at 125kHz (not 500 as before to simulate "less" load 
  - 25% to be exact)
* single can device retransmitting single frame repeatedly. (every 2.1s there
  is a gap of 15ms when no traffic happens - device reboots after watchdog
  timeout)
* spi-bcm2835 stock kernel driver is used with patch to run message pump with 
  realtime priority.
* kernel 3.10.16 (foundation based, as the vanilla RPI kernel still misses 
  dmaengine, so it is easier to develop against this kernel)

Main metrics reported are taken with "vmstat 10 12"

spi-bcm2835 realtime=0, unpatched spi.h, mcp2515 without any "compiles":
Messages received: 178523
Messages in second HW buffer: 20
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 411516  14380  26436    0    0   588    19 1340  653 12 31 37 20
 0  0      0 411232  14388  26436    0    0     0     4 45880 9412  0 35 61  4
 0  0      0 411104  14388  26436    0    0     0     0 45843 9378  0 34 66  0
 0  0      0 411040  14388  26436    0    0     0     8 45803 9528  0 41 59  0
 0  0      0 410816  14396  26436    0    0     0     6 45703 9394  0 38 53  9
 0  0      0 410624  14396  26436    0    0     0     0 45623 9270  0 33 67  0
 0  0      0 410560  14396  26436    0    0     0     0 45793 9335  0 34 66  0
 0  0      0 410464  14396  26436    0    0     0     3 45786 9367  0 35 65  0
 0  0      0 410464  14396  26436    0    0     0     0 45741 9364  0 35 65  0
 0  0      0 410496  14396  26436    0    0     0     0 45772 9360  0 35 65  0
 0  0      0 410464  14396  26436    0    0     0     0 45731 9309  0 34 66  0
 0  0      0 410528  14396  26436    0    0     0     0 45726 9287  0 34 66  0

spi-bcm2835 realtime=1 unpatched spi.h, mcp2515 without any "compiles":
Messages received: 178031
Messages in second HW buffer: 4
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 411512  14408  26440    0    0    57     2 7223 1497  1  8 89  2
 0  0      0 411384  14416  26440    0    0     0     2 45815 9827  0 34 61  5
 0  0      0 411288  14416  26440    0    0     0     0 45778 9822  0 33 67  0
 0  0      0 411128  14416  26440    0    0     0     2 45630 9807  0 35 65  0
 0  0      0 411064  14424  26440    0    0     0     6 45705 10029  0 40 54  6
 0  0      0 411032  14424  26440    0    0     0     0 45628 9807  0 33 67  0
 0  0      0 410840  14424  26440    0    0     0     0 45611 9763  0 33 67  0
 0  0      0 410744  14424  26440    0    0     0     0 45544 9716  0 33 67  0
 0  0      0 410712  14424  26440    0    0     0     0 45574 9756  0 33 67  0
 0  0      0 410712  14424  26440    0    0     0     0 45660 9807  0 33 67  0
 0  0      0 410712  14424  26440    0    0     0     0 45494 9768  0 33 67  0
 0  0      0 410712  14424  26440    0    0     0     0 45549 9778  0 34 66  0

spi-bcm2835 realtime=0 patched spi.h, mcp2515 without any "compiles":
Messages received: 178378
Messages in second HW buffer: 6
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 355064  20460  71900    0    0   182    20 8400 1786 15 17 57 11
 0  0      0 355180  20468  71900    0    0     0     2 45380 8788  0 33 59  8
 0  0      0 355116  20468  71900    0    0     0     0 46032 8863  0 33 67  0
 1  0      0 355020  20468  71900    0    0     0     2 45768 8865  0 36 64  0
 0  0      0 354924  20476  71900    0    0     0     6 45749 8869  0 39 51 10
 0  0      0 354828  20476  71900    0    0     0     0 45452 8747  0 33 67  0
 0  0      0 354732  20476  71900    0    0     0     0 45644 8757  0 33 67  0
 0  0      0 354540  20476  71900    0    0     0     0 45404 8746  0 33 67  0
 0  0      0 354508  20476  71900    0    0     0     0 45678 8739  0 32 68  0
 0  0      0 354548  20476  71900    0    0     0     0 45959 8804  0 33 67  0
 0  0      0 354516  20476  71900    0    0     0     0 45984 8831  0 33 67  0
 0  0      0 354548  20476  71900    0    0     0     0 45925 8835  0 34 66  0

spi-bcm2835 realtime=1 patched spi.h, mcp2515 without any "compiles":
Messages received: 177648
Messages in second HW buffer: 6
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 355456  20488  71908    0    0   116    13 11779 2372 10 15 68  7
 0  0      0 355296  20496  71908    0    0     0     2 45963 8916  0 35 61  3
 0  0      0 355168  20496  71908    0    0     0     0 45879 8913  0 35 65  0
 0  0      0 355104  20496  71908    0    0     0     2 45803 8880  0 36 64  0
 0  0      0 355008  20504  71908    0    0     0     8 45352 8888  0 41 48 11
 0  0      0 354880  20504  71908    0    0     0     0 45424 8846  0 36 64  0
 0  0      0 354816  20504  71908    0    0     0     0 45247 8804  0 34 66  0
 0  0      0 354720  20504  71908    0    0     0     0 45532 8824  0 35 65  0
 0  0      0 354688  20504  71908    0    0     0     0 45553 8826  0 36 64  0
 0  0      0 354720  20504  71908    0    0     0     0 45490 8834  0 34 66  0
 0  0      0 354688  20504  71908    0    0     0     0 45673 8880  0 35 65  0
 0  0      0 354688  20504  71908    0    0     0     0 45041 8674  0 34 66  0

spi-bcm2835 realtime=0 patched spi.h, mcp2515 with "compile":
Messages received: 178493
Messages in second HW buffer: 38
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 353868  20792  73116    0    0    74     9 15549 3084  8 16 71  5
 0  0      0 353804  20800  73116    0    0     0     2 45717 9051  0 32 63  5
 0  0      0 353676  20800  73116    0    0     0     0 45844 9044  0 33 67  0
 0  0      0 353620  20800  73116    0    0     0     1 45829 9120  0 36 64  0
 0  0      0 353588  20804  73116    0    0     0     2 45885 9164  0 37 58  5
 0  0      0 353460  20804  73116    0    0     0     0 45737 9070  0 32 68  0
 0  0      0 353364  20804  73116    0    0     0     0 45752 9056  0 31 69  0
 0  0      0 353204  20804  73116    0    0     0     0 45847 9078  0 33 67  0
 0  0      0 353140  20804  73116    0    0     0     0 45629 9035  0 33 67  0
 0  0      0 353108  20804  73116    0    0     0     0 45677 9052  0 32 68  0
 0  0      0 353140  20804  73116    0    0     0     0 45692 9025  0 33 67  0
 0  0      0 353172  20804  73116    0    0     0     0 45687 9023  0 33 67  0

spi-bcm2835 realtime=1 patched spi.h, mcp2515 with "compile":
Messages received: 177623
Messages in second HW buffer: 3
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 0  0      0 353964  20760  73112    0    0    87    10 13506 2687  9 15 70  6
 0  0      0 353836  20768  73112    0    0     0     2 45629 8960  0 34 63  4
 0  0      0 353740  20768  73112    0    0     0     0 45360 8920  0 33 67  0
 0  0      0 353676  20768  73112    0    0     0     2 45660 9033  0 35 65  0
 0  0      0 353580  20776  73112    0    0     0     6 45714 9007  0 36 57  6
 0  0      0 353452  20776  73112    0    0     0     0 45489 8897  0 32 68  0
 0  0      0 353292  20776  73112    0    0     0     0 45615 8976  0 33 67  0
 0  0      0 353164  20776  73112    0    0     0     0 45467 8942  0 34 66  0
 0  0      0 353164  20776  73112    0    0     0     0 45464 8933  0 32 68  0
 0  0      0 353196  20776  73112    0    0     0     0 45535 8937  0 33 67  0
 0  0      0 353196  20776  73112    0    0     0     0 45329 8916  0 33 67  0
 0  0      0 353228  20776  73112    0    0     0     0 45610 8953  0 33 67  0

So in summary:
* there is no regression in performance with the patch
* The improved locking does not show any real difference between 
  installations, but then we would nto be expecting an interrupt while running
  spi_async (at least not with this driver).
* there is a slight indication that System CPU values are slightly lower as we 
  have 31% and 32% System CPU that we have not seen in the tests prior to 
  applying the patch. This is thus related to the optimization of avoiding the
  repeated message checks in case of an optimized driver.

So this has a slightly positive impact on overall performance.
we could add a means to optimize all those spi_write/read/write_then_read
calls by compiling them. But that depends still on what we want to implement.

Assumptions by default should be:
* is_dma_mapped is set
* no change to structure, length, speed, bits, delays are allowed.

We may think of adding either flags for "global" changes like:
* allow length of transfer to change
* allow the dma_address of the transfer to change (so still with 
  is_dma_mapped)
* allow the address of the transfer to change (would mean overhead for 
  mapping dma on a per call basis)

>From an optimization perspective it might be better to give "hints" to what 
may change per spi_transfer, so adding a "u32 compile_hint" to spi_transfer
might be preferable to make it work best.

Please review and comment.

Thanks,
	Martin

P.s: The patch itself - it is against 3.10.16, so it might not apply cleanly...

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 32b7bb1..8f1aede 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1346,7 +1346,18 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-static int __spi_async(struct spi_device *spi, struct spi_message *message)
+/**
+ * spi_message_verify - verifies if the spi message is supported
+ *   by the bus-master
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion callback
+ * Context: any (irqs may be blocked, etc)
+ *
+ * This call may be used in_irq and other contexts which can't sleep,
+ * as well as from task contexts which can sleep.
+ */
+extern int spi_message_verify(struct spi_device *spi,
+			struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
 	struct spi_transfer *xfer;
@@ -1388,6 +1399,20 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 		}
 	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_message_verify);
+
+static int __spi_async(struct spi_device *spi, struct spi_message *message)
+{
+	struct spi_master *master = spi->master;
+	int ret;
+
+	if (!message->is_compiled) {
+		ret=spi_message_verify(spi,message);
+		if (ret)
+			return ret;
+	}
 
 	message->spi = spi;
 	message->status = -EINPROGRESS;
@@ -1430,15 +1455,12 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 	unsigned long flags;
 
 	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
-
-	if (master->bus_lock_flag)
-		ret = -EBUSY;
-	else
-		ret = __spi_async(spi, message);
-
+	ret=master->bus_lock_flag;
 	spin_unlock_irqrestore(&master->bus_lock_spinlock, flags);
+	if (ret)
+		return -EBUSY;
 
-	return ret;
+	return __spi_async(spi, message);
 }
 EXPORT_SYMBOL_GPL(spi_async);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6ff26c8..cea622f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -378,6 +378,14 @@ struct spi_master {
 	int (*unprepare_transfer_hardware)(struct spi_master *master);
 	/* gpio chip select */
 	int			*cs_gpios;
+	/* compile (static) message handlers */
+	int (*message_compile)(struct spi_master *master,
+			struct spi_message *mesg,
+			u32 flags
+		);
+	void (*message_uncompile)(struct spi_master *master,
+				struct spi_message *mesg
+		);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -532,6 +540,12 @@ struct spi_transfer {
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
+ * @is_compiled: if true, then the message has been initialized
+ *      via spi_compile_message
+ * @compiled_flags: flags given when the message got compiled
+ *      via spi_message_compile
+ * @compiled_data: data owned by bus-master driver between
+ *      spi_message_compile and spi_message_uncompile
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
  * @actual_length: the total number of bytes that were transferred in all
@@ -561,6 +575,13 @@ struct spi_message {
 
 	unsigned		is_dma_mapped:1;
 
+	/* bus-driver owned data for initialized messages
+	 * between spi_message_compile and spi_message_uncompile
+	 */
+	unsigned                is_compiled:1;
+	u32                     compiled_flags;
+	void                    *compiled_data;
+
 	/* REVISIT:  we might want a flag affecting the behavior of the
 	 * last transfer ... allowing things like "read 16 bit length L"
 	 * immediately followed by "read L bytes".  Basically imposing
@@ -604,6 +625,41 @@ spi_transfer_del(struct spi_transfer *t)
 	list_del(&t->transfer_list);
 }
 
+extern int spi_message_verify(struct spi_device *spi,
+			struct spi_message *m);
+
+static inline int spi_message_compile(struct spi_device *spi,
+				struct spi_message *m,
+				u32 flags)
+{
+	int verify;
+	if (m->is_compiled)
+		return -EOPNOTSUPP;
+
+	if ((verify=spi_message_verify(spi,m)))
+		return verify;
+
+	m->is_compiled=1;
+	m->compiled_flags=flags;
+	m->compiled_data=NULL;
+
+	if (spi->master->message_compile)
+		return spi->master->message_compile(spi->master,m,flags);
+	else
+		return 0;
+}
+
+static inline void spi_message_uncompile(struct spi_device *spi,
+					struct spi_message *m)
+{
+	if (spi->master->message_uncompile)
+		spi->master->message_uncompile(spi->master,m);
+
+	m->is_compiled=0;
+	m->compiled_flags=0;
+	m->compiled_data=NULL;
+}
+
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
