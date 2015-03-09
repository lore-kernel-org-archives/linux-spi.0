From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [RFC/PATCHv2 3/3] spi: dw-spi: Pointers select 16b vs. 32b DesignWare
 access
Date: Mon, 9 Mar 2015 13:01:10 -0500
Message-ID: <54FDDFE6.8010109@opensource.altera.com>
References: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>	<1425685594-26595-4-git-send-email-tthayer@opensource.altera.com> <CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Jiri Kosina <jkosina@suse.cz>, Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <dinguyen@opensource.altera.com>,
	Linux Documentation List <linux-doc@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<tthayer.linux@gmail.com>, Axel Lin <axel.lin@ingics.com>,
	<baruch@tkos.co.il>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kumar Gala <galak@codeaurora.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcceG2O+YCw4twBzC_2v9+XQRpfBxMqGXERi3amnj3rdA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 03/07/2015 01:52 PM, Andy Shevchenko wrote:
> On Sat, Mar 7, 2015 at 1:46 AM,  <tthayer@opensource.altera.com> wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Altera's Arria10 SoC interconnect requires a 32 bit write for APB
>> peripherals. The current spi-dw driver uses 16bit accesses in
>> some locations. Use function pointers to support 32 bit accesses
>> but retain legacy 16 bit access.
>>
>
> Thanks for this version. My comments below.
>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>>   drivers/spi/spi-dw-mmio.c |    7 ++++++-
>>   drivers/spi/spi-dw.c      |   29 +++++++++++++++++------------
>>   drivers/spi/spi-dw.h      |   12 ++++++++++++
>>   3 files changed, 35 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
>> index eb03e12..c4fe9e9 100644
>> --- a/drivers/spi/spi-dw-mmio.c
>> +++ b/drivers/spi/spi-dw-mmio.c
>> @@ -76,8 +76,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
>>
>>          num_cs = 4;
>>
>> -       if (pdev->dev.of_node)
>> +       if (pdev->dev.of_node) {
>>                  of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
>> +               if (of_property_read_bool(pdev->dev.of_node, "32bit_access")) {
>> +                       dws->read_w = dw_readw32;
>> +                       dws->write_w = dw_writew32;
>
> Can we use just  readw/writew (w/o underscores) as names for the accessors?
>

I tried this initially and got a namespace conflict with the readw & 
write2 macros.
macro writew passed 3 arguments, but takes just 2
macro readw passed 2 arguments, but takes just 1

>> +               }
>> +       }
>>
>>          dws->num_cs = num_cs;
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index c5fa2be..d008791 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -157,7 +157,7 @@ static inline u32 tx_max(struct dw_spi *dws)
>>          u32 tx_left, tx_room, rxtx_gap;
>>
>>          tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
>> -       tx_room = dws->fifo_len - dw_readw(dws, DW_SPI_TXFLR);
>> +       tx_room = dws->fifo_len - dws->read_w(dws, DW_SPI_TXFLR);
>>
>>          /*
>>           * Another concern is about the tx/rx mismatch, we
>> @@ -178,7 +178,7 @@ static inline u32 rx_max(struct dw_spi *dws)
>>   {
>>          u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
>>
>> -       return min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR));
>> +       return min_t(u32, rx_left, dws->read_w(dws, DW_SPI_RXFLR));
>>   }
>>
>>   static void dw_writer(struct dw_spi *dws)
>> @@ -194,7 +194,7 @@ static void dw_writer(struct dw_spi *dws)
>>                          else
>>                                  txw = *(u16 *)(dws->tx);
>>                  }
>> -               dw_writew(dws, DW_SPI_DR, txw);
>> +               dws->write_w(dws, DW_SPI_DR, txw);
>>                  dws->tx += dws->n_bytes;
>>          }
>>   }
>> @@ -205,7 +205,7 @@ static void dw_reader(struct dw_spi *dws)
>>          u16 rxw;
>>
>>          while (max--) {
>> -               rxw = dw_readw(dws, DW_SPI_DR);
>> +               rxw = dws->read_w(dws, DW_SPI_DR);
>>                  /* Care rx only if the transfer's original "rx" is not null */
>>                  if (dws->rx_end - dws->len) {
>>                          if (dws->n_bytes == 1)
>> @@ -254,11 +254,11 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
>>
>>   static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>>   {
>> -       u16 irq_status = dw_readw(dws, DW_SPI_ISR);
>> +       u16 irq_status = dws->read_w(dws, DW_SPI_ISR);
>>
>>          /* Error handling */
>>          if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
>> -               dw_readw(dws, DW_SPI_ICR);
>> +               dws->read_w(dws, DW_SPI_ICR);
>>                  int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
>>                  return IRQ_HANDLED;
>>          }
>> @@ -283,7 +283,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>>   {
>>          struct spi_master *master = dev_id;
>>          struct dw_spi *dws = spi_master_get_devdata(master);
>> -       u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
>> +       u16 irq_status = dws->read_w(dws, DW_SPI_ISR) & 0x3f;
>>
>>          if (!irq_status)
>>                  return IRQ_NONE;
>> @@ -379,7 +379,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
>>                  cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
>>          }
>>
>> -       dw_writew(dws, DW_SPI_CTRL0, cr0);
>> +       dws->write_w(dws, DW_SPI_CTRL0, cr0);
>>
>>          /* Check if current transfer is a DMA transaction */
>>          dws->dma_mapped = map_dma_buffers(master, spi, transfer);
>> @@ -393,7 +393,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
>>           */
>>          if (!dws->dma_mapped && !chip->poll_mode) {
>>                  txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
>> -               dw_writew(dws, DW_SPI_TXFLTR, txlevel);
>> +               dws->write_w(dws, DW_SPI_TXFLTR, txlevel);
>>
>>                  /* Set the interrupt mask */
>>                  imask |= SPI_INT_TXEI | SPI_INT_TXOI |
>> @@ -516,11 +516,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
>>                  u32 fifo;
>>
>>                  for (fifo = 1; fifo < 256; fifo++) {
>> -                       dw_writew(dws, DW_SPI_TXFLTR, fifo);
>> -                       if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
>> +                       dws->write_w(dws, DW_SPI_TXFLTR, fifo);
>> +                       if (fifo != dws->read_w(dws, DW_SPI_TXFLTR))
>>                                  break;
>>                  }
>> -               dw_writew(dws, DW_SPI_TXFLTR, 0);
>> +               dws->write_w(dws, DW_SPI_TXFLTR, 0);
>>
>>                  dws->fifo_len = (fifo == 1) ? 0 : fifo;
>>                  dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
>> @@ -545,6 +545,11 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
>>          dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
>>          snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
>>
>> +       if (!dws->read_w)
>> +               dws->read_w = dw_readw;
>> +       if (!dws->write_w)
>> +               dws->write_w = dw_writew;
>> +
>>          ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
>>                          dws->name, master);
>>          if (ret < 0) {
>> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
>> index 855bfdd..1df09e2 100644
>> --- a/drivers/spi/spi-dw.h
>> +++ b/drivers/spi/spi-dw.h
>> @@ -141,6 +141,8 @@ struct dw_spi {
>>   #ifdef CONFIG_DEBUG_FS
>>          struct dentry *debugfs;
>>   #endif
>> +       u16 (*read_w)(struct dw_spi *dws, u32 offset);
>> +       void (*write_w)(struct dw_spi *dws, u32 offset, u16 val);
>>   };
>>
>>   static inline u32 dw_readl(struct dw_spi *dws, u32 offset)
>> @@ -163,6 +165,16 @@ static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
>>          __raw_writew(val, dws->regs + offset);
>>   }
>>
>> +static inline u16 dw_readw32(struct dw_spi *dws, u32 offset)
>> +{
>> +       return (u16)__raw_readl(dws->regs + offset);
>> +}
>> +
>> +static inline void dw_writew32(struct dw_spi *dws, u32 offset, u16 val)
>> +{
>> +       __raw_writel((u32)val, dws->regs + offset);
>> +}
>> +
>
> So, does simple
> dws->readw = dw_readl;
> dws->writew = dw_writel;
>
> work for you?
>

Yes, but I get the macro conflict shown above and "assignment from 
incompatible pointer type" warnings. If I use the dws->read_w and 
dws->write_w names, I get the incompatible pointer type warnings but it 
works.

Thanks for reviewing.

>>   static inline void spi_enable_chip(struct dw_spi *dws, int enable)
>>   {
>>          dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
