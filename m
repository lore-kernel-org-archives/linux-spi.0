From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v8 02/11] spi: add ti-ssp spi master driver
Date: Mon, 17 Jan 2011 13:31:56 -0700
Message-ID: <20110117203156.GA31753@angua.secretlab.ca>
References: <1295291725-32509-1-git-send-email-cyril@ti.com>
	<1295291725-32509-3-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1295291725-32509-3-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 17, 2011 at 02:15:16PM -0500, Cyril Chemparathy wrote:
> This patch adds an SPI master implementation that operates on top of an
> underlying TI-SSP port.
> 
> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  drivers/spi/Kconfig        |   10 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/ti-ssp-spi.c   |  402 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti_ssp.h |    6 +
>  4 files changed, 419 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/ti-ssp-spi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 78f9fd0..7f0ed2a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -336,6 +336,16 @@ config SPI_TEGRA
>  	help
>  	  SPI driver for NVidia Tegra SoCs
>  
> +config SPI_TI_SSP
> +	tristate "TI Sequencer Serial Port - SPI Support"
> +	depends on MFD_TI_SSP
> +	help
> +	  This selects an SPI master implementation using a TI sequencer
> +	  serial port.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ti-ssp-spi.
> +
>  config SPI_TOPCLIFF_PCH
>  	tristate "Topcliff PCH SPI Controller"
>  	depends on PCI
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 8bc1a5a..595e5b8 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
>  obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx_hw.o
>  obj-$(CONFIG_SPI_S3C64XX)		+= spi_s3c64xx.o
>  obj-$(CONFIG_SPI_TEGRA)			+= spi_tegra.o
> +obj-$(CONFIG_SPI_TI_SSP)		+= ti-ssp-spi.o
>  obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi_topcliff_pch.o
>  obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
>  obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
> diff --git a/drivers/spi/ti-ssp-spi.c b/drivers/spi/ti-ssp-spi.c
> new file mode 100644
> index 0000000..ee22795
> --- /dev/null
> +++ b/drivers/spi/ti-ssp-spi.c
> @@ -0,0 +1,402 @@
> +/*
> + * Sequencer Serial Port (SSP) based SPI master driver
> + *
> + * Copyright (C) 2010 Texas Instruments Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mfd/ti_ssp.h>
> +
> +#define MODE_BITS	(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH)
> +
> +struct ti_ssp_spi {
> +	struct spi_master		*master;
> +	struct device			*dev;
> +	spinlock_t			lock;
> +	struct list_head		msg_queue;
> +	struct completion		complete;
> +	bool				shutdown;
> +	struct workqueue_struct		*workqueue;
> +	struct work_struct		work;
> +	u8				mode, bpw;
> +	int				cs_active;
> +	u32				pc_en, pc_dis, pc_wr, pc_rd;
> +	void				(*select)(int cs);
> +};
> +
> +static u32 ti_ssp_spi_rx(struct ti_ssp_spi *hw)
> +{
> +	u32 ret;
> +
> +	ti_ssp_run(hw->dev, hw->pc_rd, 0, &ret);
> +	return ret;
> +}
> +
> +static void ti_ssp_spi_tx(struct ti_ssp_spi *hw, u32 data)
> +{
> +	ti_ssp_run(hw->dev, hw->pc_wr, data << (32 - hw->bpw), NULL);
> +}
> +
> +static int ti_ssp_spi_txrx(struct ti_ssp_spi *hw, struct spi_message *msg,
> +		       struct spi_transfer *t)
> +{
> +	int count;
> +
> +	if (hw->bpw <= 8) {
> +		u8		*rx = t->rx_buf;
> +		const u8	*tx = t->tx_buf;
> +
> +		for (count = 0; count < t->len; count += 1) {
> +			if (t->tx_buf)
> +				ti_ssp_spi_tx(hw, *tx++);
> +			if (t->rx_buf)
> +				*rx++ = ti_ssp_spi_rx(hw);
> +		}
> +	} else if (hw->bpw <= 16) {
> +		u16		*rx = t->rx_buf;
> +		const u16	*tx = t->tx_buf;
> +
> +		for (count = 0; count < t->len; count += 2) {
> +			if (t->tx_buf)
> +				ti_ssp_spi_tx(hw, *tx++);
> +			if (t->rx_buf)
> +				*rx++ = ti_ssp_spi_rx(hw);
> +		}
> +	} else {
> +		u32		*rx = t->rx_buf;
> +		const u32	*tx = t->tx_buf;
> +
> +		for (count = 0; count < t->len; count += 4) {
> +			if (t->tx_buf)
> +				ti_ssp_spi_tx(hw, *tx++);
> +			if (t->rx_buf)
> +				*rx++ = ti_ssp_spi_rx(hw);
> +		}
> +	}
> +
> +	msg->actual_length += count; /* bytes transferred */
> +
> +	dev_dbg(&msg->spi->dev, "xfer %s%s, %d bytes, %d bpw, count %d%s\n",
> +		t->tx_buf ? "tx" : "", t->rx_buf ? "rx" : "", t->len,
> +		hw->bpw, count, (count < t->len) ? " (under)" : "");
> +
> +	return (count < t->len) ? -EIO : 0; /* left over data */
> +}
> +
> +static void ti_ssp_spi_chip_select(struct ti_ssp_spi *hw, int cs_active)
> +{
> +	cs_active = !!cs_active;
> +	if (cs_active == hw->cs_active)
> +		return;
> +	ti_ssp_run(hw->dev, cs_active ? hw->pc_en : hw->pc_dis, 0, NULL);
> +	hw->cs_active = cs_active;
> +}
> +
> +#define __SHIFT_OUT(bits)	(SSP_OPCODE_SHIFT | SSP_OUT_MODE | \
> +				 cs_en | clk | SSP_COUNT((bits) * 2 - 1))
> +#define __SHIFT_IN(bits)	(SSP_OPCODE_SHIFT | SSP_IN_MODE  | \
> +				 cs_en | clk | SSP_COUNT((bits) * 2 - 1))
> +
> +static int ti_ssp_spi_setup_transfer(struct ti_ssp_spi *hw, u8 bpw, u8 mode)
> +{
> +	int error, idx = 0;
> +	u32 seqram[16];
> +	u32 cs_en, cs_dis, clk;
> +	u32 topbits, botbits;
> +
> +	mode &= MODE_BITS;
> +	if (mode == hw->mode && bpw == hw->bpw)
> +		return 0;
> +
> +	cs_en  = (mode & SPI_CS_HIGH) ? SSP_CS_HIGH : SSP_CS_LOW;
> +	cs_dis = (mode & SPI_CS_HIGH) ? SSP_CS_LOW  : SSP_CS_HIGH;
> +	clk    = (mode & SPI_CPOL)    ? SSP_CLK_HIGH : SSP_CLK_LOW;
> +
> +	/* Construct instructions */
> +
> +	/* Disable Chip Select */
> +	hw->pc_dis = idx;
> +	seqram[idx++] = SSP_OPCODE_DIRECT | SSP_OUT_MODE | cs_dis | clk;
> +	seqram[idx++] = SSP_OPCODE_STOP   | SSP_OUT_MODE | cs_dis | clk;
> +
> +	/* Enable Chip Select */
> +	hw->pc_en = idx;
> +	seqram[idx++] = SSP_OPCODE_DIRECT | SSP_OUT_MODE | cs_en | clk;
> +	seqram[idx++] = SSP_OPCODE_STOP   | SSP_OUT_MODE | cs_en | clk;
> +
> +	/* Reads and writes need to be split for bpw > 16 */
> +	topbits = (bpw > 16) ? 16 : bpw;
> +	botbits = bpw - topbits;
> +
> +	/* Write */
> +	hw->pc_wr = idx;
> +	seqram[idx++] = __SHIFT_OUT(topbits) | SSP_ADDR_REG;
> +	if (botbits)
> +		seqram[idx++] = __SHIFT_OUT(botbits)  | SSP_DATA_REG;
> +	seqram[idx++] = SSP_OPCODE_STOP | SSP_OUT_MODE | cs_en | clk;
> +
> +	/* Read */
> +	hw->pc_rd = idx;
> +	if (botbits)
> +		seqram[idx++] = __SHIFT_IN(botbits) | SSP_ADDR_REG;
> +	seqram[idx++] = __SHIFT_IN(topbits) | SSP_DATA_REG;
> +	seqram[idx++] = SSP_OPCODE_STOP | SSP_OUT_MODE | cs_en | clk;
> +
> +	error = ti_ssp_load(hw->dev, 0, seqram, idx);
> +	if (error < 0)
> +		return error;
> +
> +	error = ti_ssp_set_mode(hw->dev, ((mode & SPI_CPHA) ?
> +					  0 : SSP_EARLY_DIN));
> +	if (error < 0)
> +		return error;
> +
> +	hw->bpw = bpw;
> +	hw->mode = mode;
> +
> +	return error;
> +}
> +
> +static void ti_ssp_spi_work(struct work_struct *work)
> +{
> +	struct ti_ssp_spi *hw = container_of(work, struct ti_ssp_spi, work);
> +
> +	spin_lock(&hw->lock);
> +
> +	 while (!list_empty(&hw->msg_queue)) {
> +		struct spi_message	*m;
> +		struct spi_device	*spi;
> +		struct spi_transfer	*t = NULL;
> +		int			status = 0;
> +
> +		m = container_of(hw->msg_queue.next, struct spi_message,
> +				 queue);
> +
> +		list_del_init(&m->queue);
> +
> +		spin_unlock(&hw->lock);
> +
> +		spi = m->spi;
> +
> +		if (hw->select)
> +			hw->select(spi->chip_select);
> +
> +		list_for_each_entry(t, &m->transfers, transfer_list) {
> +			int bpw = spi->bits_per_word;
> +			int xfer_status;
> +
> +			if (t->bits_per_word)
> +				bpw = t->bits_per_word;
> +
> +			if (ti_ssp_spi_setup_transfer(hw, bpw, spi->mode) < 0)
> +				break;
> +
> +			ti_ssp_spi_chip_select(hw, 1);
> +
> +			xfer_status = ti_ssp_spi_txrx(hw, m, t);
> +			if (xfer_status < 0)
> +				status = xfer_status;
> +
> +			if (t->delay_usecs)
> +				udelay(t->delay_usecs);
> +
> +			if (t->cs_change)
> +				ti_ssp_spi_chip_select(hw, 0);
> +		}
> +
> +		ti_ssp_spi_chip_select(hw, 0);
> +		m->status = status;
> +		m->complete(m->context);
> +
> +		spin_lock(&hw->lock);
> +	}
> +
> +	if (hw->shutdown)
> +		complete(&hw->complete);
> +
> +	spin_unlock(&hw->lock);
> +}
> +
> +static int ti_ssp_spi_setup(struct spi_device *spi)
> +{
> +	if (spi->bits_per_word > 32)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ti_ssp_spi_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> +	struct ti_ssp_spi	*hw;
> +	struct spi_transfer	*t;
> +	int			error = 0;
> +
> +	m->actual_length = 0;
> +	m->status = -EINPROGRESS;
> +
> +	hw = spi_master_get_devdata(spi->master);
> +
> +	if (list_empty(&m->transfers) || !m->complete)
> +		return -EINVAL;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (t->len && !(t->rx_buf || t->tx_buf)) {
> +			dev_err(&spi->dev, "invalid xfer, no buffer\n");
> +			return -EINVAL;
> +		}
> +
> +		if (t->len && t->rx_buf && t->tx_buf) {
> +			dev_err(&spi->dev, "invalid xfer, full duplex\n");
> +			return -EINVAL;
> +		}
> +
> +		if (t->bits_per_word > 32) {
> +			dev_err(&spi->dev, "invalid xfer width %d\n",
> +				t->bits_per_word);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	spin_lock(&hw->lock);
> +	if (hw->shutdown) {
> +		error = -ESHUTDOWN;
> +		goto error_unlock;
> +	}
> +	list_add_tail(&m->queue, &hw->msg_queue);
> +	queue_work(hw->workqueue, &hw->work);
> +error_unlock:
> +	spin_unlock(&hw->lock);
> +	return error;
> +}
> +
> +static int __devinit ti_ssp_spi_probe(struct platform_device *pdev)
> +{
> +	const struct ti_ssp_spi_data *pdata;
> +	struct ti_ssp_spi *hw;
> +	struct spi_master *master;
> +	struct device *dev = &pdev->dev;
> +	int error = 0;
> +
> +	pdata = dev->platform_data;
> +	if (!pdata) {
> +		dev_err(dev, "platform data not found\n");
> +		return -EINVAL;
> +	}
> +
> +	master = spi_alloc_master(dev, sizeof(struct ti_ssp_spi));
> +	if (!master) {
> +		dev_err(dev, "cannot allocate SPI master\n");
> +		return -ENOMEM;
> +	}
> +
> +	hw = spi_master_get_devdata(master);
> +	platform_set_drvdata(pdev, hw);
> +
> +	hw->master = master;
> +	hw->dev = dev;
> +	hw->select = pdata->select;
> +
> +	spin_lock_init(&hw->lock);
> +	init_completion(&hw->complete);
> +	INIT_LIST_HEAD(&hw->msg_queue);
> +	INIT_WORK(&hw->work, ti_ssp_spi_work);
> +
> +	hw->workqueue = create_singlethread_workqueue(dev_name(dev));
> +	if (!hw->workqueue) {
> +		error = -ENOMEM;
> +		dev_err(dev, "work queue creation failed\n");
> +		goto error_wq;
> +	}
> +
> +	error = ti_ssp_set_iosel(hw->dev, pdata->iosel);
> +	if (error < 0) {
> +		dev_err(dev, "io setup failed\n");
> +		goto error_iosel;
> +	}
> +
> +	master->bus_num		= pdev->id;
> +	master->num_chipselect	= pdata->num_cs;
> +	master->mode_bits	= MODE_BITS;
> +	master->flags		= SPI_MASTER_HALF_DUPLEX;
> +	master->setup		= ti_ssp_spi_setup;
> +	master->transfer	= ti_ssp_spi_transfer;
> +
> +	error = spi_register_master(master);
> +	if (error) {
> +		dev_err(dev, "master registration failed\n");
> +		goto error_reg;
> +	}
> +
> +	return 0;
> +
> +error_reg:
> +error_iosel:
> +	destroy_workqueue(hw->workqueue);
> +error_wq:
> +	spi_master_put(master);
> +	return error;
> +}
> +
> +static int __devexit ti_ssp_spi_remove(struct platform_device *pdev)
> +{
> +	struct ti_ssp_spi *hw = platform_get_drvdata(pdev);
> +	int error;
> +
> +	hw->shutdown = 1;
> +	while (!list_empty(&hw->msg_queue)) {
> +		error = wait_for_completion_interruptible(&hw->complete);
> +		if (error < 0) {
> +			hw->shutdown = 0;
> +			return error;
> +		}
> +	}
> +	destroy_workqueue(hw->workqueue);
> +	spi_unregister_master(hw->master);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ti_ssp_spi_driver = {
> +	.probe		= ti_ssp_spi_probe,
> +	.remove		= __devexit_p(ti_ssp_spi_remove),
> +	.driver		= {
> +		.name	= "ti-ssp-spi",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init ti_ssp_spi_init(void)
> +{
> +	return platform_driver_register(&ti_ssp_spi_driver);
> +}
> +module_init(ti_ssp_spi_init);
> +
> +static void __exit ti_ssp_spi_exit(void)
> +{
> +	platform_driver_unregister(&ti_ssp_spi_driver);
> +}
> +module_exit(ti_ssp_spi_exit);
> +
> +MODULE_DESCRIPTION("SSP SPI Master");
> +MODULE_AUTHOR("Cyril Chemparathy");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ti-ssp-spi");
> diff --git a/include/linux/mfd/ti_ssp.h b/include/linux/mfd/ti_ssp.h
> index 021fe09..dbb4b43 100644
> --- a/include/linux/mfd/ti_ssp.h
> +++ b/include/linux/mfd/ti_ssp.h
> @@ -32,6 +32,12 @@ struct ti_ssp_data {
>  	struct ti_ssp_dev_data	dev_data[2];
>  };
>  
> +struct ti_ssp_spi_data {
> +	unsigned long	iosel;
> +	int		num_cs;
> +	void		(*select)(int cs);
> +};
> +
>  /*
>   * Sequencer port IO pin configuration bits.  These do not correlate 1-1 with
>   * the hardware.  The iosel field in the port data combines iosel1 and iosel2,
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Protect Your Site and Customers from Malware Attacks
> Learn about various malware tactics and how to avoid them. Understand 
> malware threats, the impact they can have on your business, and how you 
> can protect your company and customers by using code signing.
> http://p.sf.net/sfu/oracle-sfdevnl
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
