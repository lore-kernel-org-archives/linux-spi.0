From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: add spi controller master driver for Blackfin 6xx
	processor
Date: Thu, 6 Jun 2013 17:36:07 +0800
Message-ID: <CAHG8p1D8mXq_=3DOBsRMCyRQ9UpWOLbU4y0VYO7PzERxknO7ow@mail.gmail.com>
References: <1370295814-28723-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130603142809.GJ31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130603142809.GJ31367-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

2013/6/3 Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>:
> On Mon, Jun 03, 2013 at 05:43:34PM -0400, Scott Jiang wrote:
>
>> +#define START_STATE  ((void *)0)
>> +#define RUNNING_STATE        ((void *)1)
>> +#define DONE_STATE   ((void *)2)
>> +#define ERROR_STATE  ((void *)-1)
>
> This looks icky due to the casts.  Why not just store the state in the
> driver data for the device, it's not possible to have multiple messages
> active at once anyway?
>
Yes, I can move it to driver data. But struct spi_message has state field for
this message, I just want to make use of it.

>
>> +                     if (chip_info->control & ~bfin_ctl_reg) {
>> +                             dev_err(&spi->dev, "do not set bits "
>> +                                     "that the SPI framework manages\n");
>> +                             goto error;
>
> Don't split error messages over lines.
>
It outputs in one line.

>> +             if (chip->cs < MAX_CTRL_CS) {
>> +                     chip->ssel = (1 << chip->cs) << 8;
>> +                     ret = peripheral_request(ssel[spi->master->bus_num]
>> +                                     [chip->cs-1], dev_name(&spi->dev));
>> +                     if (ret) {
>> +                             dev_err(&spi->dev, "peripheral_request() error\n");
>> +                             goto error;
>> +                     }
>> +             } else {
>> +                     chip->cs_gpio = chip->cs - MAX_CTRL_CS;
>> +                     ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
>> +                                             dev_name(&spi->dev));
>> +                     if (ret) {
>> +                             dev_err(&spi->dev, "gpio_request_one() error\n");
>> +                             goto error;
>> +                     }
>> +             }
>> +             spi_set_ctldata(spi, chip);
>
> Why is all this resource allocation not being done in the probe()
> function?
>
You can't know the cs line that the spi device uses in probe()

>> +static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
>> +{
>> +     struct bfin_spi_master *drv_data = dev_id;
>> +     u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
>> +
>> +     clear_dma_irqstat(drv_data->tx_dma);
>> +     if (dma_stat & DMA_DONE)
>> +             drv_data->tx_num++;
>> +     if (dma_stat & DMA_ERR)
>> +             dev_err(&drv_data->master->dev,
>> +                             "spi tx dma error: %d\n", dma_stat);
>> +     bfin_write_and(&drv_data->regs->tx_control, ~SPI_TXCTL_TDR_NF);
>> +     return IRQ_HANDLED;
>> +}
>
> This doesn't check that it got a sane state from the hardware - what
> happens if neither DMA_DONE nor DMA_ERR is true?  I'd also expect us to
> fail the transfer if we get an error state.
>
DMA_DONE means correct, while DMA_ERR means error. Others only tell you
current status, so when DMA_ERR I output the whole register value to check what
error is.

>> +static int bfin_spi_suspend(struct device *dev)
>> +{
>> +     struct spi_master *master = dev_get_drvdata(dev);
>> +     struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
>> +
>> +     spi_master_suspend(master);
>> +
>> +     drv_data->control = bfin_read(&drv_data->regs->control);
>> +     drv_data->ssel = bfin_read(&drv_data->regs->ssel);
>> +
>> +     bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
>> +     bfin_write(&drv_data->regs->ssel, 0x0000FE00);
>> +     free_dma(drv_data->rx_dma);
>> +     free_dma(drv_data->tx_dma);
>
> Why free and reallocate the DMA over suspend?

It's a boot rom bug. If it starts from spi flash, it will polute spi
and dma status.

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
