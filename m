From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: ARM: bcm2835: DMA driver + spi_optimize_message - some questions/info
Date: Wed, 2 Apr 2014 18:06:11 +0200
Message-ID: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

I have finished a first fully working revision of the DMA-only driven
SPI bus driver for the BCM2835 which is now quite efficient with
regards to CPU-resources.

But to make the most out of it it will require that the real device drivers
are also optimized for thru-put to avoid unnecessarily rerun some
computations/transformations. 

These "optimizations" are mostly:
* use spi_messages that are created on the heap and do not need to
  get setup/torn down after each invocation (typically on the stack)
* use the (previously discussed) optimize interface to "fix" spi_messages
  in such a way that minimal of processing needs to get done prior to
  submission to DMA (translation to dma, verify if all parameters are valid)
  - patch against 3.13 below
* thinking of how to schedule transfers in such a way that while a complete
  callback is being processed more transfers are already scheduled and can
  run making the best use of the time available.
And they apply mostly to drivers that potentially generate a high number
of SPI messages in a short period of time.

With this we can "reduce" a sequence of typically 7-10 
commands to the device down to 3 spi_messages of which the first 2 are
scheduled one after the other (note that this requires locking, so that no
race condition can occur on callback, which I found out the hard way may
happen even in a GPIO irq handler getting interrupted by a DMA irq handling
the callback) and then optimize them once avoiding the need to
verify/transform the messages 1000 times per second.

This means that there are (typically) no visible gaps between the
the 3 spi_messages and that the SPI clock is running with minimal "gaps".

For an image of this optimized case as seen by a logic analyser,
please see here:
http://www.raspberrypi.org/forums/download/file.php?id=6335.

For comparisson here also an image showing the PIO in kernel spi_bcm2835
driver: http://www.raspberrypi.org/forums/download/file.php?id=6332

For example a sequence with 10 transfers with a total of 53 bytes
to/from the
device at 8MHz bus speed takes 84us, which is fairly close to the 53us that
is be the ideal transfer time for 53 bytes (without taking CS (de)asserting
into account)

The way the drivers have been designed we are also minimizing the number of
interrupts - for such a "complex" transfer we have a total of only 4
interrupts per CAN-message (2 related to GPIO (generic+pin-specific) and
2 to trigger the complete callbacks for 2 of the 3 spi_messages)

As the original spi-bcm2835 PIO-driver is known to trigger a lot of
interrupts and consumes a lot of CPU (which is unfortunately not accounted
for in vmstat)
I also have done some tests to see how much time is really left for
other work by user processes.

So I have taken the following scenario:
* CAN bus at 250khz
* running at 100% utilization with extended frames and 8 bytes data
  (note that would mean an equivalent of 25% utilization on 1MHz CAN bus)
* resulting in 1532 CAN messages/second which means one message every 
  0.616ms
* running a compile of the spi-bcm2835 driver several times measuring
  with "time" focusing on real/elapsed time
* also observing via vmstat 10

This have been tested against the following scenarios:
* no SPI drivers loaded
* MCP2515 optimize disabled + spi-bcm2835 currently in kernel
* MCP2515 optimize enabled + spi-bcm2835 currently in kernel
* MCP2515 optimize disabled + spi-bcm2835dma
* MCP2515 optimize enabled + spi-bcm2835dma

The difference between 2 and 3 shows the "gain" of avoiding running
the _spi_async validations 4800 times per second.
while the difference between 3 and 4 shows the advantage of the
use of DMA scheduling - even with the overhead for the "creation"
of the DMA sequences on every call
and the difference between 4 and 5 shows how much can be the net-gain
when optimizing/preparing those SPI messages once.
And you can also compare all of them against an idle system (option 1)

So here the results:

driver         optimize real_compile interrupts/s irq2EOT
none                 NA          50s          300     N/A                
spi-bcm2835(=PIO)   off         120s        45000   293us
spi-bcm2835(=PIO)    on         115s        45000   290us 
spi-bcm2835dma      off          76s         6700   172us
spi-bcm2835dma       on          60s         6700    82us

(irq2EOT = time between IRQ line goes down and the CS goes high after the 
last transfer)

So you can see that the optimize makes a slight difference for PIO.
You can also see that the costly DMA setup (which adds latencies to the
initial scheduling of the first byte) is still a lot more CPU friendly
than all those interrupts when using PIO.

And finally the optimize with DMA gives us closer to "idle" time
measurements - the difference is in parts the time spent in the IRQ
handlers (GPIO and DMA), but also regarding the fact that the DMAs are
producing load on the memory bus reading those control-blocks
and have an impact on L2 Cache evictions.

Obviously this "optimization" is most important for drivers that are running
spi_messages at high rates, as there the gain becomes most significant.
But it also applies to spi_messages where we transfer say 4096 bytes.

On the BCM2835 an SPI-interrupt gets triggered in PIO mode every 12 bytes
so that the interrupt handler can read and fill the FIFO before it there is
an overrun - so for those 4096 bytes we would need to handle 341 interrupts.
Assuming 8MHz BUS rate we would ideally transfer this in 0.04 seconds.

So transferring 1 MByte of data would take exactly one second and trigger
83252 interrupts - that is lots of interrupts!

By comparison the DMA driver would (in the unoptimized case) maybe take 30us
at the start of the transfer to create the DMAs to issue and then run with a
single interrupt at the end of the transfer (but on the bcm2835 it would
need to limit itself to 32 transfers of 32K each, but still a single IRQ).

In the optimized case we would run the transfer within 9us from issuing the
spi_async call.

Note that those usec measurements have been taken by "poking" GPIOs to
up/down via writel and measuring the pin-changes via a logic-analyzer as
logging via kprint kills performance and does not allow for insight over
longer periods of time.

So I hope these measurements convince you that the optimize patch below is
"worth" adding - it also includes a means for the device driver to
"vary" some parts of the spi message (source, destination, length, speed,
delay_usec), which [wc]ould change between invocations of spi_async.

As for the spi-bcm2835dma driver itself:
it is still work in progress, but I am having some questions with regards to
submitting it - some of it has to do with designing it in such a way that
parts of it may at some point may in the future get incorporated into the
spi-framework.

So some facts:
* driver still does not fully follow coding styles
* not all vary cases are not all handled correctly and fixing those requires
* it allows the use of ANY GPIO as CS not the limit of effective 2 CS
  exposed by the hardware.
  this actually started as a workaround for a buggy CS implementation in
  the HW block which might take CS up for a few 100th of a usec creating
  hickups with some devices (which only shows up when programming the
  SPI-registers via DMA transfers), but the step from making 2 GPIO work
  to make all GPIO work as CS is not really complicated...
* right now I am not really using dma-engine, as it is too CPU intensive
  setting a complex SPI message up (a typical read+write SPI message takes
  typically 21 DMA transfers)
* instead I started a new dma-fragment interface that has:
** dma_links, which are probably similar to some structures in dma_engine
** dma_fragments, which are chains of dma_links and/or dma_fragments
   the structure of which does not change and the data inside only changes
   in a few places
** dma_fragment_caches, which are caches of fragments which can get reused
   quickly without heavy setup overhead (this avoids mallocs,
   dma_pool_fetch)
   these caches also are responsible for creating fragments if needed and
   tearing them down
   there are also fetch and merge methods to create compound dma_fragments
   for final scheduling
 * there are also some "common" spi_dma_fragment parts that could easily
  get merged into the spi-core.
* there is some provision to see if an spi message contains is of a
  single/double transfer type and in those cases take an "optimized"
  spi_message (done by the driver) instead and fill it with the data
  from the submitted spi_message and make use of all those "vary" cases.
  this would reduce the DMA creation cost for those synchronous transfers
  (spi_write_then_read, spi_write, spi_read), but this is not fully in place
* per HW-document it requires 2 DMAs to handle the full transfer, but as per
  interrupt latencies unfortunately we require a 3rd DMA channel which only
  triggers the interrupt to schedule complete (the DMA needs to be "idle"
  long enough for the kernel to detect which IRQ source was responsible for
  the wakeup, so using TX-DMA is not an option, as the kernel is sometimes
  too slow to handle the interrupt before the next TX transfer is scheduled
  in the pipelined DMA case)
* currently tested with a focus on the CAN controller mcp2515 (minor testing
  with other devices)

In the end I have the following "distinct" fragments and caches for
each of those:
* spi_merged_fragment: an empty fragment used from cache into which all
  the below fragments get merged (avoids calls to malloc,... to be fast)
* spi_setup: setup SPI registers for the next transfer includes:
** setting clock
** enabling SPI-HW+resetting FIFOs
** CS assert
** preparing TX-DMA channel
  - on bcm2835 a total of 6 DMAs
* spi_transfer: do a single transfer (in the BCM2835 if the transfer is NOT
  a multiple of 4, then after the transfer the FIFOS will have to be reset)
  - on bcm2835 a total of 2 DMAs (1 RX, 1 TX)
* spi_delay: if a single delay is configured then this does the delay in DMA
  - on bcm2835 a total of 1 DMAs
* spi_csdelay: if there is a cs_change then this is responsible for it -
  - it will also do a delay prior to CS-up and keeps CS deasserted for half
  a SPI clock cycle.
  - on bcm2835 a total of 3 DMAs (delay, CS-deassert,delay)
* trigger_interrupt: trigger an interrupt - typically to call complete
  - on bcm2835 a total of 3 DMAs (2 RX, 1IRQ DMA essentially just
  triggering the interrupt, but doing nothing else)
* marks the spi_message as finished (this actually copies the 1MHz clock
  counter of the BCM2835 to a location to mark it as finished - we would
  even have absolute timings when the transfer finished (same could be
  applied for start of spi_message) if the spi core would want to expose
  such information.
  - on bcm2835 a total of 1 DMAs

So a single read/write transfer is actually made up of the following:
* spi_merged_fragment containing:
** spi_setup    (6CBs)
** spi_transfer (2CBs)
** spi_csdelay  (3CBs)
** trigger_irq  (3CBs)
** finished     (1CBs)
so a total of 15 DMA transfers for a single SPI_message with one
spi_transfer.

Each additional transfer (without cs_change) adds an additional 6 CBs
If the number of transfers so far is a multiple of 4 (full words), then
this is reduced to an additional 2 CBs(=Control Block/dma_link)

I hope these look "generic enough" to be reusable...

There is also one question here with regards to semantics:
When do we need to call the "complete" method?
When we have received all the data or when the CS has been de-asserted
(after the delay_usec)?

The reason why I ask is because for optimizations some of the irq scheduling
latencies could get hidden by triggering the complete while CS is still
asserted.

Note that I decided to go with the approach of fetch from cache and merge
(where the cache functionality is hiding some of the work about releasing
the structures again) instead of having separate link/unlink methods that
need to get called explicitly (more method pointers in the structures,...)

The central pieces of bus_driver specific code for creating/scheduling the
DMA which corresponds to a spi_message with the above framework(s) looks
like this:
-----------------------------------------------------------------------------
struct spi_merged_dma_fragment *bcm2835dma_spi_message_to_dma_fragment(
        struct spi_message *msg, int flags, gfp_t gfpflags)
{
        struct spi_device *spi    = msg->spi;
        struct spi_master *master = spi->master;
        struct bcm2835dma_spi *bs = spi_master_get_devdata(master);

        struct spi_merged_dma_fragment *merged;
        struct spi_transfer *xfer;
        int err=0;
        int is_last;

        /* some optimizations - it might help if we knew the length... */
        /* check if we got a frame that is of a single transfer */
        if ( list_is_singular(&msg->transfers) ) {
                /* check if we got something in the structure we could
use */
        }

        /* fetch a merged fragment */
        merged = (typeof(merged))
                dma_fragment_cache_fetch(
                        &bs->fragment_merged,
                        gfpflags);
        if (! merged)
                return NULL;

        /* initialize some fields */
        merged->message       = msg;
        merged->transfer      = NULL;
        merged->last_transfer = NULL;
        merged->dma_fragment.link_head = NULL;
        merged->dma_fragment.link_tail = NULL;
        merged->complete_data = NULL;
        merged->needs_spi_setup = 1;
        /* now start iterating the transfers */
        list_for_each_entry(xfer, &msg->transfers, transfer_list) {
                /* check if we are the last in the list */
                is_last = list_is_last(&xfer->transfer_list,
                                        &msg->transfers);
                /* assign the current transfer */
                merged->transfer = xfer;
                /* do we need to reconfigure spi
                   compared to the last transfer */
                if (! merged->needs_spi_setup) {
                        if (merged->last_transfer->speed_hz
                                != xfer->speed_hz)
                                merged->needs_spi_setup = 1;
                        else if (merged->last_transfer->tx_nbits
                                != xfer->tx_nbits)
                                merged->needs_spi_setup = 1;
                        else if (merged->last_transfer->rx_nbits
                                != xfer->rx_nbits)
                                merged->needs_spi_setup = 1;
                        else if (merged->last_transfer->bits_per_word
                                != xfer->bits_per_word)
                                merged->needs_spi_setup = 1;
                }
                /* if we have no last_transfer,
                   then we need to setup spi */
                if (merged->needs_spi_setup) {
                        err = spi_merged_dma_fragment_merge_fragment_cache(
                                &bs->fragment_setup_spi,
                                merged,
                                gfpflags);
                        if (err)
                                goto error;
                        merged->needs_spi_setup = 0;
                }
                /* add transfer if the transfer length is not 0
                   or if we vary length */
                if ( (xfer->len)
                        /* || (xfer->vary & SPI_OPTIMIZE_VARY_LENGTH) */) {
                        /* schedule transfer */
                        err = spi_merged_dma_fragment_merge_fragment_cache(
                                &bs->fragment_transfer,
                                merged,
                                gfpflags);
                        if (err)
                                goto error;
                        /* set last transfer */
                        merged->last_transfer=xfer;
                }
                /* add cs_change with optional extra delay
                   if requested or last in sequence */
                if ((xfer->cs_change)||(is_last)) {
                        err = spi_merged_dma_fragment_merge_fragment_cache(
                                &bs->fragment_cs_deselect,
                                merged,
                                gfpflags);
                } else if ( (xfer->delay_usecs)
                        /* || (xfer->vary & SPI_OPTIMIZE_VARY_DELAY) */) {
                        /* or add a delay if requested */
                        err = spi_merged_dma_fragment_merge_fragment_cache(
                                &bs->fragment_delay,
                                merged,
                                gfpflags);
                }

                if (err)
                        goto error;
        }
        /* and add an interrupt if we got a callback to handle
         * if there is no callback, then we do not need to release it
         * immediately - even for prepared messages
         */
        if (msg->complete) {
                err=spi_merged_dma_fragment_merge_fragment_cache(
                        &bs->fragment_trigger_irq,
                        merged,
                        gfpflags);
                if (err)
                        goto error;
        }

        /* and the "end of transfer flag"
         * - must be the last to avoid races... */
        err=spi_merged_dma_fragment_merge_fragment_cache(
                &bs->fragment_message_finished,
                merged,
                gfpflags);
        if (err)
                goto error;

        /* reset transfers, as these are invalid by the time
         * we run the transforms */
        merged->transfer      = NULL;
        merged->last_transfer = NULL;

        /* and return it */
        return merged;

error:
        dev_printk(KERN_ERR,&spi->dev,
                "bcm2835dma_spi_message_to_dma_fragment: err=%i\n",
                err);
        spi_merged_dma_fragment_dump(
                merged,
                &msg->spi->dev,
                0,0,
                &bcm2835_dma_link_dump
                );
        return NULL;
}

static int bcm2835dma_spi_message_optimize(struct spi_message *message)
{
        message->state = bcm2835dma_spi_message_to_dma_fragment(
                message,
                0,
                GFP_ATOMIC);
        if (!message->state)
                return -ENOMEM;
        if (unlikely(debug_dma & DEBUG_DMA_OPTIMIZE)) {
                dev_printk(KERN_INFO,&message->spi->dev,
                        "Optimizing %pf %pf\n",message,message->state);
                if (debug_dma & DEBUG_DMA_OPTIMIZE_DUMP_FRAGMENT) {
                        spi_merged_dma_fragment_dump(message->state,
                                                &message->spi->dev,
                                                0,0,
                                                &bcm2835_dma_link_dump
                                );
                }
        }

        return 0;
}

static void bcm2835dma_spi_message_unoptimize(struct spi_message *msg)
{
        dma_fragment_release(msg->state);
        msg->state=NULL;
        if (unlikely(debug_dma&DEBUG_DMA_OPTIMIZE)) {
                dev_printk(KERN_INFO,&msg->spi->dev,
                        "Unoptimizing %pf\n",msg);
        }
}

static int bcm2835dma_spi_transfer(struct spi_device *spi,
                                struct spi_message *message)
{
        int err=0;
        struct spi_merged_dma_fragment *merged;
        struct spi_master *master = spi->master;
        struct bcm2835dma_spi *bs = spi_master_get_devdata(master);
        unsigned long flags;

        /* fetch DMA fragment */
#ifdef SPI_HAVE_OPTIMIZE
        if ((message->is_optimized) ) {
                merged = message->state;
        } else
#endif
        {
                merged = bcm2835dma_spi_message_to_dma_fragment(
                        message,
                        0,
                        GFP_ATOMIC);
                message->state = merged;
        }
        if (!merged)
                return -ENOMEM;
        /* assign some values */
        message->actual_length = 0;

        /* and execute the pre-transforms */
        err = spi_merged_dma_fragment_execute_pre_dma_transforms(
                merged,merged,GFP_ATOMIC);
        if (err)
                goto error;

        if (unlikely(debug_dma & DEBUG_DMA_ASYNC)) {
                dev_printk(KERN_INFO,&message->spi->dev,
                        "Scheduling Message %pf fragment %pf\n",
                        message,merged);
                if (debug_dma & DEBUG_DMA_ASYNC_DUMP_FRAGMENT) {
                        spi_merged_dma_fragment_dump(merged,
                                                &message->spi->dev,
                                                0,0,
                                                &bcm2835_dma_link_dump
                                );
                }
        }

        /* statistics on message submission */
        spin_lock_irqsave(&master->queue_lock,flags);
        bs->count_spi_messages++;
#ifdef SPI_HAVE_OPTIMIZE
        if ((message->is_optimized) )
                bs->count_spi_optimized_messages++;
#endif
        spin_unlock_irqrestore(&master->queue_lock,flags);

        /* and schedule it */
        if (merged) {
                bcm2835dma_schedule_dma_fragment(message);
        }

        /* and return */
        return 0;
error:
        dev_printk(KERN_ERR,&spi->dev,"spi_transfer_failed: %i",err);
        dma_fragment_release(&merged->dma_fragment);
        return -EPERM;
}

static int bcm2835dma_spi_probe(struct platform_device *pdev)
{
...
        master->transfer = bcm2835dma_spi_transfer;
#ifdef SPI_HAVE_OPTIMIZE
        if (use_optimize) {
                master->optimize_message =
                        bcm2835dma_spi_message_optimize;
                master->unoptimize_message =
                        bcm2835dma_spi_message_unoptimize;
        }
#endif
...
}

-----------------------------------------------------------------------------
The diff (against 3.13) to the framework to allow spi_optimize to work:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d745f95..24a54aa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1598,15 +1598,12 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-static int __spi_async(struct spi_device *spi, struct spi_message *message)
+static inline int __spi_verify(struct spi_device *spi,
+            struct spi_message *message)
 {
     struct spi_master *master = spi->master;
     struct spi_transfer *xfer;
 
-    message->spi = spi;
-
-    trace_spi_message_submit(message);
-
     if (list_empty(&message->transfers))
         return -EINVAL;
     if (!message->complete)
@@ -1705,9 +1702,28 @@ static int __spi_async(struct spi_device *spi,
struct spi_message *message)
                 return -EINVAL;
         }
     }
+    return 0;
+}
+
+static int __spi_async(struct spi_device *spi, struct spi_message *message)
+{
+    struct spi_master *master = spi->master;
+    int ret = 0;
+
+    trace_spi_message_submit(message);
+
+    if (message->is_optimized) {
+        if (spi != message->spi)
+            return -EINVAL;
+    } else {
+        message->spi = spi;
+        ret = __spi_verify(spi,message);
+        if (ret)
+            return ret;
+    }
 
     message->status = -EINPROGRESS;
-    return master->transfer(spi, message);
+    return spi->master->transfer(spi, message);
 }
 
 /**
@@ -1804,6 +1820,48 @@ int spi_async_locked(struct spi_device *spi,
struct spi_message *message)
 }
 EXPORT_SYMBOL_GPL(spi_async_locked);
 
+/**
+ * spi_message_optimize - optimize a message for repeated use minimizing
+ *   processing overhead
+ *
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers, including completion callback
+ * Context: can sleep
+ */
+int spi_message_optimize(struct spi_device *spi,
+            struct spi_message *message)
+{
+    int ret = 0;
+    if (message->is_optimized)
+        spi_message_unoptimize(message);
+
+    message->spi = spi;
+    ret = __spi_verify(spi,message);
+    if (ret)
+        return ret;
+
+    if (spi->master->optimize_message)
+        ret = spi->master->optimize_message(message);
+    if (ret)
+        return ret;
+
+    message->is_optimized = 1;
+
+    return 0;
+}
+EXPORT_SYMBOL_GPL(spi_message_optimize);
+
+void spi_message_unoptimize(struct spi_message *message)
+{
+    if (!message->is_optimized)
+        return;
+
+    if (message->spi->master->unoptimize_message)
+        message->spi->master->unoptimize_message(message);
+
+    message->is_optimized = 0;
+}
+EXPORT_SYMBOL_GPL(spi_message_unoptimize);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8c62ba7..5206038 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -287,6 +287,12 @@ static inline void spi_unregister_driver(struct
spi_driver *sdrv)
  *              spi_finalize_current_transfer() so the subsystem can issue
  *                the next transfer
  * @unprepare_message: undo any work done by prepare_message().
+ * @optimize_message: allow computation of optimizations of a spi message
+ *                    this may set up the corresponding DMA transfers
+ *                    or do other work that need not get computed every
+ *                    time a message gets executed
+ *                    Not called from interrupt context.
+ * @unoptimize_message: undo any work done by @optimize_message().
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *    number. Any individual value may be -ENOENT for CS lines that
  *    are not GPIOs (driven by the SPI controller itself).
@@ -412,7 +418,8 @@ struct spi_master {
                    struct spi_message *message);
     int (*unprepare_message)(struct spi_master *master,
                  struct spi_message *message);
-
+    int (*optimize_message)(struct spi_message *message);
+    void (*unoptimize_message)(struct spi_message *message);
     /*
      * These hooks are for drivers that use a generic implementation
      * of transfer_one_message() provied by the core.
@@ -506,6 +513,8 @@ extern struct spi_master *spi_busnum_to_master(u16
busnum);
  * @delay_usecs: microseconds to delay after this transfer before
  *    (optionally) changing the chipselect status, then starting
  *    the next transfer or completing this @spi_message.
+ * @vary: allows a driver to mark a SPI transfer as "modifyable" on the
+ *      specific pieces of information
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  *
  * SPI transfers always write the same number of bytes as they read.
@@ -584,6 +593,12 @@ struct spi_transfer {
     u8        bits_per_word;
     u16        delay_usecs;
     u32        speed_hz;
+#define SPI_OPTIMIZE_VARY_TX_BUF               (1<<0)
+#define SPI_OPTIMIZE_VARY_RX_BUF               (1<<1)
+#define SPI_OPTIMIZE_VARY_SPEED_HZ             (1<<2)
+#define SPI_OPTIMIZE_VARY_DELAY_USECS          (1<<3)
+#define SPI_OPTIMIZE_VARY_LENGTH               (1<<4)
+    u32             vary;
 
     struct list_head transfer_list;
 };
@@ -594,6 +609,9 @@ struct spi_transfer {
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *    addresses for each transfer buffer
+ * @is_optimized: if true, then the spi_message has been processed with
+ *      spi_message_optimize() - @state belongs to the spi-driver now
+ *      and may not get set by the driver
  * @complete: called to report transaction completions
  * @context: the argument to complete() when it's called
  * @actual_length: the total number of bytes that were transferred in all
@@ -622,6 +640,8 @@ struct spi_message {
     struct spi_device    *spi;
 
     unsigned        is_dma_mapped:1;
+#define SPI_HAVE_OPTIMIZE
+    unsigned                is_optimized:1;
 
     /* REVISIT:  we might want a flag affecting the behavior of the
      * last transfer ... allowing things like "read 16 bit length L"
@@ -655,6 +675,9 @@ static inline void spi_message_init(struct
spi_message *m)
     INIT_LIST_HEAD(&m->transfers);
 }
 
+int spi_message_optimize(struct spi_device *s,struct spi_message *m);
+void spi_message_unoptimize(struct spi_message *m);
+
 static inline void
 spi_message_add_tail(struct spi_transfer *t, struct spi_message *m)
 {

-----------------------------------------------------------------------------

So the questions are:
Are there any major questions on this design?
Does it look acceptable from a design perspective?
Is it generic enough that it might get used with other devices as well?
Do we need all those "VARY" cases or would we need to vary by more fields?
I still think that the optimize/unoptimize_message methods are quite similar
to prepare/unprepare_message so the question is if these can not get merged
into a single pair of methods.

Some of those influence the back-end parts that do the setup of the initial
and link-time transfers (which I have not shared yet and which need most
cleanup)

Also it influences the final design on vary in the which is still a bit more
complicated (and as mentioned not fully working at this moment).

As soon I have some guidance which way to go I will do a final cleanup and
and more documentation and share it in the form of patches...

Also the question is how I should initially submit those "generic" components.
Should I create a helper.h and helper.c with those components, so that they
can get split out later or should I keep them separate from the start.

Thanks,
       Martin

P.s: people interrested in the still "unfit" code as of now please look at
the out of tree driver at: https://github.com/msperl/spi-bcm2835

p.p.s: I hope the formatting of the email is fine - if not, then
apologies...


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
