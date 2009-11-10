From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: Re: [PATCH v4] xilinx_spi: Splitted into
 generic, of and platform driver, added support for DS570
Date: Tue, 10 Nov 2009 17:19:36 +0100
Message-ID: <4AF99298.9020207@mocean-labs.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	John Linn <John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40911091321w187fe85fl4e6d9f36f5966f34-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Grant Likely wrote:
> Oops, I replied to the original version, but missed the subsequent
> versions.  Looks like some of my comments still apply though.
> Overall, the patch changes too many things all at once.  You should
> look at splitting it up.  At the very least the io accessor changes
> should be done in a separate patch.
> =

> On Mon, Sep 28, 2009 at 7:22 AM, Richard R=F6jfors
> <richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org> wrote:
>> @@ -227,6 +227,21 @@ config SPI_XILINX
>>          See the "OPB Serial Peripheral Interface (SPI) (v1.00e)"
>>          Product Specification document (DS464) for hardware details.
>>
>> +         Or for the DS570, see "XPS Serial Peripheral Interface (SPI) (=
v2.00b)"
>> +
>> +config SPI_XILINX_OF
>> +       tristate "Xilinx SPI controller OF device"
>> +       depends on SPI_XILINX && XILINX_VIRTEX
>> +       help
>> +         This is the OF driver for the SPI controller IP from the Xilin=
x EDK.
>> +
>> +config SPI_XILINX_PLTFM
>> +       tristate "Xilinx SPI controller platform device"
>> +       depends on SPI_XILINX
>> +       help
>> +         This is the platform driver for the SPI controller IP
>> +         from the Xilinx EDK.
>> +
> =

> Personally, I don't think it is necessary to present these options to
> the user.  I think they can be auto-selected depending on CONFIG_OF
> and CONFIG_PLATFORM.

Sure that can be changed, I prefer to to that in an incremental patch after=
 this one.

> =

>> +struct xilinx_spi {
>> +       /* bitbang has to be first */
>> +       struct spi_bitbang bitbang;
>> +       struct completion done;
>> +       struct resource mem; /* phys mem */
>> +       void __iomem    *regs;  /* virt. address of the control register=
s */
>> +       u32 irq;
>> +       u8 *rx_ptr;             /* pointer in the Tx buffer */
>> +       const u8 *tx_ptr;       /* pointer in the Rx buffer */
>> +       int remaining_bytes;    /* the number of bytes left to transfer =
*/
>> +       /* offset to the XSPI regs, these might vary... */
>> +       u8 bits_per_word;
>> +       bool big_endian;        /* The device could be accessed big or l=
ittle
>> +                                * endian
>> +                                */
>> +};
>> +
> =

> Why is the definition of xilinx_spi moved?

I liked the idea of heaving the struct defined in the top of the file.

>>  /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (=
v1.00e)
>>  * Product Specification", DS464
>>  */
>> -#define XSPI_CR_OFFSET         0x62    /* 16-bit Control Register */
>> +#define XSPI_CR_OFFSET         0x60    /* Control Register */
>>
>>  #define XSPI_CR_ENABLE         0x02
>>  #define XSPI_CR_MASTER_MODE    0x04
>> @@ -40,8 +53,9 @@
>>  #define XSPI_CR_RXFIFO_RESET   0x40
>>  #define XSPI_CR_MANUAL_SSELECT 0x80
>>  #define XSPI_CR_TRANS_INHIBIT  0x100
>> +#define XSPI_CR_LSB_FIRST      0x200
>>
>> -#define XSPI_SR_OFFSET         0x67    /* 8-bit Status Register */
>> +#define XSPI_SR_OFFSET         0x64    /* Status Register */
>>
>>  #define XSPI_SR_RX_EMPTY_MASK  0x01    /* Receive FIFO is empty */
>>  #define XSPI_SR_RX_FULL_MASK   0x02    /* Receive FIFO is full */
>> @@ -49,8 +63,8 @@
>>  #define XSPI_SR_TX_FULL_MASK   0x08    /* Transmit FIFO is full */
>>  #define XSPI_SR_MODE_FAULT_MASK        0x10    /* Mode fault error */
>>
>> -#define XSPI_TXD_OFFSET                0x6b    /* 8-bit Data Transmit R=
egister */
>> -#define XSPI_RXD_OFFSET                0x6f    /* 8-bit Data Receive Re=
gister */
>> +#define XSPI_TXD_OFFSET                0x68    /* Data Transmit Registe=
r */
>> +#define XSPI_RXD_OFFSET                0x6C    /* Data Receive Register=
 */
>>
>>  #define XSPI_SSR_OFFSET                0x70    /* 32-bit Slave Select R=
egister */
>>
>> @@ -70,43 +84,72 @@
>>  #define XSPI_INTR_TX_UNDERRUN          0x08    /* TxFIFO was underrun */
>>  #define XSPI_INTR_RX_FULL              0x10    /* RxFIFO is full */
>>  #define XSPI_INTR_RX_OVERRUN           0x20    /* RxFIFO was overrun */
>> +#define XSPI_INTR_TX_HALF_EMPTY                0x40    /* TxFIFO is hal=
f empty */
>>
>>  #define XIPIF_V123B_RESETR_OFFSET      0x40    /* IPIF reset register */
>>  #define XIPIF_V123B_RESET_MASK         0x0a    /* the value to write */
>>
>> -struct xilinx_spi {
>> -       /* bitbang has to be first */
>> -       struct spi_bitbang bitbang;
>> -       struct completion done;
>> +/* to follow are some functions that does little of big endian read and
>> + * write depending on the config of the device.
>> + */
>> +static inline void xspi_write8(struct xilinx_spi *xspi, u32 offs, u8 va=
l)
>> +{
>> +       iowrite8(val, xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
>> +}
>>
>> -       void __iomem    *regs;  /* virt. address of the control register=
s */
>> +static inline void xspi_write16(struct xilinx_spi *xspi, u32 offs, u16 =
val)
>> +{
>> +       if (xspi->big_endian)
>> +               iowrite16be(val, xspi->regs + offs + 2);
>> +       else
>> +               iowrite16(val, xspi->regs + offs);
>> +}
>>
>> -       u32             irq;
>> +static inline void xspi_write32(struct xilinx_spi *xspi, u32 offs, u32 =
val)
>> +{
>> +       if (xspi->big_endian)
>> +               iowrite32be(val, xspi->regs + offs);
>> +       else
>> +               iowrite32(val, xspi->regs + offs);
>> +}
>>
>> -       u32             speed_hz; /* SCK has a fixed frequency of speed_=
hz Hz */
>> +static inline u8 xspi_read8(struct xilinx_spi *xspi, u32 offs)
>> +{
>> +       return ioread8(xspi->regs + offs + ((xspi->big_endian) ? 3 : 0));
>> +}
>>
>> -       u8 *rx_ptr;             /* pointer in the Tx buffer */
>> -       const u8 *tx_ptr;       /* pointer in the Rx buffer */
>> -       int remaining_bytes;    /* the number of bytes left to transfer =
*/
>> -};
>> +static inline u16 xspi_read16(struct xilinx_spi *xspi, u32 offs)
>> +{
>> +       if (xspi->big_endian)
>> +               return ioread16be(xspi->regs + offs + 2);
>> +       else
>> +               return ioread16(xspi->regs + offs);
>> +}
>> +
>> +static inline u32 xspi_read32(struct xilinx_spi *xspi, u32 offs)
>> +{
>> +       if (xspi->big_endian)
>> +               return ioread32be(xspi->regs + offs);
>> +       else
>> +               return ioread32(xspi->regs + offs);
>> +}
> =

> Ah, you changed these to functions instead of macros.  I like.
> However, as you suggested elsewhere in this thread, you could change
> these to callbacks and then eliminate the if/else statements.  I think
> that is the approach you should use.  I don't think you need to worry
> about it being slower.  Any extra cycles for jumping to a callback
> will be far dwarfed by the number of cycles it takes to complete an
> SPI transfer.

Sure that can be updated. I prefer to do that in an incremental patch, woul=
d be great to get this
big one merged first.

--Richard

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
