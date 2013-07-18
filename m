From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: support DUAL and QUAD[patch v1]
Date: Thu, 18 Jul 2013 09:58:16 +0800
Message-ID: <CAHSAbzP5jqHwCm0qhu=DiNzpP0swqWHsQ0=MnF+EKaSN22E5hg@mail.gmail.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
	<593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E85D0-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,



2013/7/16 Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org>:
>>
>> Hello Pekon,
>>
>> Gupta, Pekon wrote on 2013-07-16:
>> > >
>> > > Hi, Gupta
>> > >
>> > >
>> > > > [Pekon]: Instead of adding new fields you can use existing 'mode' field
>> to
>> > > > pass on the platform specific configurations. And if 'u8 mode' does not
>> > > > suffice you can increase it to 'u32'.
>> > > > #define QSPI_MODE       1 << 5; // just check which bit-fields are un-
>> used
>> > > > spi_board_info->mode |= QSPI_MODE;
>> > > >
>> > >
>> > > well, can dual and quad be regarded as a spi mode? if so, your comment
>> > > seems
>> > > to be right.
>> >
>> > Yes, Quad and Dual modes should be regarded as extension of SPI
>> protocol.
>> > - They follow the same basic principle of synchronous data transfer. Right ?
>> > - These modes are not adding any extra side-band | In-band signaling or
>> > controls to modify the protocol. They are just increasing the width of
>> >  data-channel for better throughput.
>> >
>> > with regards, pekon
>> >
>>
>> In general, yes. But I think, for the interface we have to take care of more
>> details.
>>
>> For example, what happens in the following situation:
>> We have a spi-controller, which supports the QSPI mode, and a spi-flash,
>> which fulfils
>> the requirements, but the board has not connected all signals?
>>
> [Pekon]: So, actual implementation should set QSPI_MODE based on both
> (1) device capabilities (detected in probe)
> (2) board-DT properties (this would take care of your other constrains)
>
>> And the interface for the slave-driver (like m25p80) should allow to specify
>> the transfer mode
>> for each spi_message.
>> This will be necessary, because it depends on the flash and mode, how each
>> phase of "cmd",
>> "address", and "data" will be transferred.
>>
> [Pekon]: Are you saying that same controller can send interleaved
> Quad-SPI and Single-SPI spi_messages to same device (here flash device)?
>
> Is it due to flash-device constrain that it accepts some flash-commands
> (like erase, etc) only on Single-wire-SPI, whereas  data transfers can be
> Performed on Quad-SPI mode ?
> In such case you need to add 'mode' field in struct spi_message, so that
> this information moves along with the spi_message in queue. And then
> when that message reaches spi_pump_message() and
> transfer_one_message() is called, then you can do needful configs.
>
> However, I still don't think you need to control 'QSPI_MODE' at granularity
> of spi_transfer level, because m25p80 flash-driver use spi_write() API to
> pass data to SPI driver, which internally creates a spi_message in each call.
>
> Following best explains use of spi_message in /include/linux/spi.h
> ---------------------------------------------------
> * A @spi_message is used to execute an atomic sequence of data transfers,
>  * each represented by a struct spi_transfer.  The sequence is "atomic"
>  * in the sense that no other spi_message may use that SPI bus until that
>  * sequence completes.  On some systems, many such sequences can execute as
>  * as single programmed DMA transfer.  On all systems, these messages are
>  * queued, and might complete after transactions to other devices.  Messages
>  * sent to a given spi_device are alway executed in FIFO order.
> ---------------------------------------------------
>
>
But in some cases, slave will use different mode(single,dual,quad) for
different spi_transfer in one spi_message. So I don't think that a
mode in spi_message can describe all the mode in one spi_message.I
have corrected the patch as below. @spi_master->mode_bit is the mode
master supports, @spi_device->mode is the slave work in, but the spi
slave still need to set the mode for the spi_transfer based on the
mode in @spi_device.
example:
if
@spi_device->mode = QUAD
then
cmd@spi_transfer->tx_nbits = SINGLE
addr@spi_transfer->tx_nbits = SINGLE
data@spi_transfer->tx_nbits = QUAD
our spi controller driver will deal with that in transfer_one_message().


>From 9ed7028f278ff744c301f11ea3ad6298d14b91e4 Mon Sep 17 00:00:00 2001
From: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 18 Jul 2013 09:23:44 +0800
Subject: [PATCH] spi: DUAL and QUAD support Signed-off-by: wangyuhang
 <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |   18 ++++++++++++++++++
 include/linux/spi/spi.h |   23 +++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 004b10f..36d2451 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -868,6 +868,14 @@ static void of_register_spi_devices(struct
spi_master *master)
  spi->mode |= SPI_CS_HIGH;
  if (of_find_property(nc, "spi-3wire", NULL))
  spi->mode |= SPI_3WIRE;
+ if (of_find_property(nc, "spi-tx-dual", NULL))
+ spi->mode |= SPI_TX_DUAL;
+ if (of_find_property(nc, "spi-tx-quad", NULL))
+ spi->mode |= SPI_TX_QUAD;
+ if (of_find_property(nc, "spi-rx-dual", NULL))
+ spi->mode |= SPI_RX_DUAL;
+ if (of_find_property(nc, "spi-rx-quad", NULL))
+ spi->mode |= SPI_RX_QUAD;

  /* Device speed */
  prop = of_get_property(nc, "spi-max-frequency", &len);
@@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
  /* help drivers fail *cleanly* when they need options
  * that aren't supported with their current master
  */
+ if (((spi->mode >> 8) & 0x03) == 0x03 ||
+ ((spi->mode >> 10) & 0x03) == 0x03) {
+ dev_err(&spi->dev,
+ "setup: can not select dual and quad at the same time\n");
+ return -EINVAL;
+ }
  bad_bits = spi->mode & ~spi->master->mode_bits;
  if (bad_bits) {
  dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
@@ -1376,6 +1390,10 @@ static int __spi_async(struct spi_device *spi,
struct spi_message *message)
  xfer->bits_per_word = spi->bits_per_word;
  if (!xfer->speed_hz)
  xfer->speed_hz = spi->max_speed_hz;
+ if (!xfer->tx_nbits)
+ xfer->tx_nbits = SPI_NBITS_SINGLE;
+ if (!xfer->rx_nbits)
+ xfer->rx_nbits = SPI_NBITS_SINGLE;
  }

  message->spi = spi;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38c2b92..e9ba1cf 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -74,7 +74,7 @@ struct spi_device {
  struct spi_master *master;
  u32 max_speed_hz;
  u8 chip_select;
- u8 mode;
+ u16 mode;
 #define SPI_CPHA 0x01 /* clock phase */
 #define SPI_CPOL 0x02 /* clock polarity */
 #define SPI_MODE_0 (0|0) /* (original MicroWire) */
@@ -87,6 +87,10 @@ struct spi_device {
 #define SPI_LOOP 0x20 /* loopback mode */
 #define SPI_NO_CS 0x40 /* 1 dev/bus, no chipselect */
 #define SPI_READY 0x80 /* slave pulls low to pause */
+#define SPI_TX_DUAL 0x100 /* transmit with 2 wires */
+#define SPI_TX_QUAD 0x200 /* transmit with 4 wires */
+#define SPI_RX_DUAL 0x400 /* receive with 2 wires */
+#define SPI_RX_QUAD 0x800 /* receive with 4 wires */
  u8 bits_per_word;
  int irq;
  void *controller_state;
@@ -437,6 +441,10 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * @rx_buf: data to be read (dma-safe memory), or NULL
  * @tx_dma: DMA address of tx_buf, if @spi_message.is_dma_mapped
  * @rx_dma: DMA address of rx_buf, if @spi_message.is_dma_mapped
+ * @tx_nbits: number of bits used for writting, if 0 default
+ * (SPI_NBITS_SINGLE = 0x01) is used.
+ * @rx_nbits: number of bits used for reading, if 0 default
+ * (SPI_NBITS_SINGLE = 0x01) is used.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -491,6 +499,11 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * by the results of previous messages and where the whole transaction
  * ends when the chipselect goes intactive.
  *
+ * When SPI can transfer in 1x,2x or 4x. It can get this tranfer information
+ * from device through @tx_nbits and @rx_nbits. In Bi-direction, these
+ * two should both be set. User can set transfer mode with SPI_NBITS_SINGLE(1x)
+ * SPI_NBITS_DUAL(2x) and SPI_NBITS_QUAD(4x) to support these three transfer.
+ *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
  * Zero-initialize every field you don't set up explicitly, to
@@ -511,6 +524,12 @@ struct spi_transfer {
  dma_addr_t rx_dma;

  unsigned cs_change:1;
+ u8 bitwidth;
+ u8 tx_nbits;
+ u8 rx_nbits;
+#define SPI_NBITS_SINGLE 0x01; /* 1bit transfer */
+#define SPI_NBITS_DUAL 0x02; /* 2bits transfer */
+#define SPI_NBITS_QUAD 0x03; /* 4bits transfer */
  u8 bits_per_word;
  u16 delay_usecs;
  u32 speed_hz;
@@ -858,7 +877,7 @@ struct spi_board_info {
  /* mode becomes spi_device.mode, and is essential for chips
  * where the default of SPI_CS_HIGH = 0 is wrong.
  */
- u8 mode;
+ u16 mode;

  /* ... may need additional spi_device chip config data here.
  * avoid stuff protocol drivers can set; but include stuff
--
1.7.9.5

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
