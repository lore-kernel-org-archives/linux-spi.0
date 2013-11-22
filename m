From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] added API: spi_message_compile/optimize/hint/...
Date: Fri, 22 Nov 2013 07:53:21 +0100
Message-ID: <39DEC004-10A1-47EF-9D77-276188D2580C@martin.sperl.org>
References: <0C7D5B1E-E561-4F52-BEA8-572EB0CA26A6@martin.sperl.org> <20131120112920.GX2674@sirena.org.uk> <05C64EF6-0F3B-4CBC-A462-45ED8F1564A7@martin.sperl.org> <20131120162449.GJ2674@sirena.org.uk> <9DE09AF6-AD13-45DE-A36F-BD65E619C342@martin.sperl.org> <20131121191004.GH8120@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131121191004.GH8120-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark!

Here the new version of the patch that now:
* applies against topic/core (and also got compiled)
* has the bus-driver-specific stuff left out (but comments where this
  would go)
* Driver hints are now only in spi_transfer 
* the optimize_hint bitfield is now a field of things that may change
  (as discussed)

See also a comment in code about the possible "generic" use of optimize:

In principle this code could also generically set up DMA mapping - especially
for platforms that do not have to do a bounce-buffer that they need to set up
and copy to/from before/after DMA. Also just allocating a bounce buffer just
once may also be possible optimization to reduce overhead.

This would make it easier to avoid the "unloved" dma interface (rx_dma/tx_dma)
for driver developers - they would just have to call spi_message_optimize
and stop caring about DMA-able addresses - it would be taken care of...

We could also make flags:
#define SPI_OPTIMIZE_ALLOCATE_RXBUFFER		(1<<6)
#define SPI_OPTIMIZE_ALLOCATE_TXBUFFER		(1<<7)
which would allocate the rx/tx buffers for the driver with the positive
side-effect that there is no more messing with dma_masks and such and
would avoid the requirement of mapping/unmapping before/after each DMA
transaction.
(would need to happen in the spi_validate function to be generic enough
and may require some capability hints from the dma framework of what it 
can support).

Martin

Signed-Off-By: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e40b236..6d1d773 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1680,6 +1680,53 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	return 0;
 }
 
+/**
+ * spi_message_optimize - analysis of the spi message
+ *	optimizing it for later use
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion
+ *	callback and optimization hints
+ * Context: can sleep
+ *
+ * This call optimizes the message for later efficient use.
+ * this may mean preparing DMA pattern for the bus in question.
+ *
+ * Between the optimize and unoptimize call the structure
+ * of the message may not get changed in any way
+ * unless explicitly stated in optimize_hints in the
+ * spi_transfer structure, which states explicitly which parts
+ * may change, so that the driver may make optimizations
+ * in handling these messages.
+ *
+ * For example: this may set up DMA mapping early without
+ * the driver having to provide rx_dma/tx_dma itself.
+ */
+
+int spi_message_optimize(struct spi_device *spi,
+			struct spi_message *m,
+			gfp_t flags)
+{
+	int ret;
+
+	if (m->is_optimized)
+		return -EOPNOTSUPP;
+
+	ret=__spi_validate(spi,m);
+	if (!ret) {
+		/* bus-driver specific call goes here */
+		m->is_optimized=1;
+	}
+
+	return ret;
+}
+
+void spi_message_unoptimize(struct spi_device *spi,
+			struct spi_message *m)
+{
+	/* bus-driver specific call goes here */
+	m->is_optimized=0;
+}
+
 static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
@@ -1726,9 +1773,11 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 	int ret;
 	unsigned long flags;
 
-	ret = __spi_validate(spi, message);
-	if (ret != 0)
-		return ret;
+	if (!message->is_optimized) {
+		ret = __spi_validate(spi, message);
+		if (ret != 0)
+			return ret;
+	}
 
 	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
 
@@ -1778,9 +1827,11 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 	int ret;
 	unsigned long flags;
 
-	ret = __spi_validate(spi, message);
-	if (ret != 0)
-		return ret;
+	if (!message->is_optimized) {
+		ret = __spi_validate(spi, message);
+		if (ret != 0)
+			return ret;
+	}
 
 	spin_lock_irqsave(&master->bus_lock_spinlock, flags);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba7..8fa010d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -506,6 +506,8 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @optimize_hints: bitmask to define which fields are not modified
+ *      after a call to spi_message_optimize
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  *
  * SPI transfers always write the same number of bytes as they read.
@@ -585,6 +587,15 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u32		speed_hz;
 
+#define SPI_OPTIMIZE_MAYCHANGE_TX_BUF		(1<<0)
+#define SPI_OPTIMIZE_MAYCHANGE_RX_BUF		(1<<1)
+	/* these bits apply also to tx_dma/rx_dma if set */
+#define SPI_OPTIMIZE_MAYCHANGE_LEN	       	(1<<2)
+#define SPI_OPTIMIZE_MAYCHANGE_DELAY		(1<<3)
+#define SPI_OPTIMIZE_MAYCHANGE_SPEED		(1<<4)
+#define SPI_OPTIMIZE_MAYCHANGE_BITS		(1<<5)
+	u32	       	optimize_hints;
+
 	struct list_head transfer_list;
 };
 
@@ -594,6 +605,10 @@ struct spi_transfer {
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
+ * @is_optimized: if true, then the message has been initialized via
+ *	spi_message_optimize - this is (re)set via spi_message_(un)optimize
+ * @optimize_data: data owned by the bus-driver after spi_message_optimize
+ *	is called
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
  * @actual_length: the total number of bytes that were transferred in all
@@ -623,6 +638,9 @@ struct spi_message {
 
 	unsigned		is_dma_mapped:1;
 
+	unsigned		is_optimized:1;
+	void			*optimize_data;
+
 	/* REVISIT:  we might want a flag affecting the behavior of the
 	 * last transfer ... allowing things like "read 16 bit length L"
 	 * immediately followed by "read L bytes".  Basically imposing
@@ -667,6 +685,13 @@ spi_transfer_del(struct spi_transfer *t)
 	list_del(&t->transfer_list);
 }
 
+extern int spi_message_optimize(struct spi_device *spi,
+				struct spi_message *m,
+				gfp_t flags);
+
+extern void spi_message_unoptimize(struct spi_device *spi,
+				struct spi_message *m);
+
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
