From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi: spi-rspi: add dmaengine supporting
Date: Sat, 19 May 2012 22:37:25 -0600
Message-ID: <20120520043725.BE2C23E03B8@localhost>
References: <4F90F92C.5030001@renesas.com>
Cc: spi-devel-general@lists.sourceforge.net,
	SH-Linux <linux-sh@vger.kernel.org>
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <4F90F92C.5030001@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 20 Apr 2012 14:50:36 +0900, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds dmaengine supporting using sh_dma driver. The module
> receives data by DMAC, it also needs TX DMAC to generate SPI's clocks.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.

g.
> ---
>  about v2:
>   - fix dma unmapping
>   - add checking of the return value of dma_map_sg()
>   - modify labels in rspi_{send,receive}_dma()
>   - modify rspi_request_dma() for the dev_info()
> 
>  drivers/spi/spi-rspi.c   |  320 +++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/spi/rspi.h |   31 +++++
>  2 files changed, 345 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/spi/rspi.h
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 354f170..4894bde 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -31,7 +31,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/sh_dma.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spi/rspi.h>
> 
>  #define RSPI_SPCR		0x00
>  #define RSPI_SSLP		0x01
> @@ -141,6 +145,16 @@ struct rspi_data {
>  	spinlock_t lock;
>  	struct clk *clk;
>  	unsigned char spsr;
> +
> +	/* for dmaengine */
> +	struct sh_dmae_slave dma_tx;
> +	struct sh_dmae_slave dma_rx;
> +	struct dma_chan *chan_tx;
> +	struct dma_chan *chan_rx;
> +	int irq;
> +
> +	unsigned dma_width_16bit:1;
> +	unsigned dma_callbacked:1;
>  };
> 
>  static void rspi_write8(struct rspi_data *rspi, u8 data, u16 offset)
> @@ -265,11 +279,125 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
>  	return 0;
>  }
> 
> -static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
> -			    struct spi_transfer *t)
> +static void rspi_dma_complete(void *arg)
> +{
> +	struct rspi_data *rspi = arg;
> +
> +	rspi->dma_callbacked = 1;
> +	wake_up_interruptible(&rspi->wait);
> +}
> +
> +static int rspi_dma_map_sg(struct scatterlist *sg, void *buf, unsigned len,
> +			   struct dma_chan *chan,
> +			   enum dma_transfer_direction dir)
> +{
> +	sg_init_table(sg, 1);
> +	sg_set_buf(sg, buf, len);
> +	sg_dma_len(sg) = len;
> +	return dma_map_sg(chan->device->dev, sg, 1, dir);
> +}
> +
> +static void rspi_dma_unmap_sg(struct scatterlist *sg, struct dma_chan *chan,
> +			      enum dma_transfer_direction dir)
> +{
> +	dma_unmap_sg(chan->device->dev, sg, 1, dir);
> +}
> +
> +static void rspi_memory_to_8bit(void *buf, const void *data, unsigned len)
> +{
> +	u16 *dst = buf;
> +	const u8 *src = data;
> +
> +	while (len) {
> +		*dst++ = (u16)(*src++);
> +		len--;
> +	}
> +}
> +
> +static void rspi_memory_from_8bit(void *buf, const void *data, unsigned len)
> +{
> +	u8 *dst = buf;
> +	const u16 *src = data;
> +
> +	while (len) {
> +		*dst++ = (u8)*src++;
> +		len--;
> +	}
> +}
> +
> +static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
> +{
> +	struct scatterlist sg;
> +	void *buf = NULL;
> +	struct dma_async_tx_descriptor *desc;
> +	unsigned len;
> +	int ret = 0;
> +
> +	if (rspi->dma_width_16bit) {
> +		/*
> +		 * If DMAC bus width is 16-bit, the driver allocates a dummy
> +		 * buffer. And, the driver converts original data into the
> +		 * DMAC data as the following format:
> +		 *  original data: 1st byte, 2nd byte ...
> +		 *  DMAC data:     1st byte, dummy, 2nd byte, dummy ...
> +		 */
> +		len = t->len * 2;
> +		buf = kmalloc(len, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +		rspi_memory_to_8bit(buf, t->tx_buf, t->len);
> +	} else {
> +		len = t->len;
> +		buf = (void *)t->tx_buf;
> +	}
> +
> +	if (!rspi_dma_map_sg(&sg, buf, len, rspi->chan_tx, DMA_TO_DEVICE)) {
> +		ret = -EFAULT;
> +		goto end_nomap;
> +	}
> +	desc = dmaengine_prep_slave_sg(rspi->chan_tx, &sg, 1, DMA_TO_DEVICE,
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		ret = -EIO;
> +		goto end;
> +	}
> +
> +	/*
> +	 * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine will be
> +	 * called. So, this driver disables the IRQ while DMA transfer.
> +	 */
> +	disable_irq(rspi->irq);
> +
> +	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD, RSPI_SPCR);
> +	rspi_enable_irq(rspi, SPCR_SPTIE);
> +	rspi->dma_callbacked = 0;
> +
> +	desc->callback = rspi_dma_complete;
> +	desc->callback_param = rspi;
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(rspi->chan_tx);
> +
> +	ret = wait_event_interruptible_timeout(rspi->wait,
> +					       rspi->dma_callbacked, HZ);
> +	if (ret > 0 && rspi->dma_callbacked)
> +		ret = 0;
> +	else if (!ret)
> +		ret = -ETIMEDOUT;
> +	rspi_disable_irq(rspi, SPCR_SPTIE);
> +
> +	enable_irq(rspi->irq);
> +
> +end:
> +	rspi_dma_unmap_sg(&sg, rspi->chan_tx, DMA_TO_DEVICE);
> +end_nomap:
> +	if (rspi->dma_width_16bit)
> +		kfree(buf);
> +
> +	return ret;
> +}
> +
> +static void rspi_receive_init(struct rspi_data *rspi)
>  {
> -	int remain = t->len;
> -	u8 *data;
>  	unsigned char spsr;
> 
>  	spsr = rspi_read8(rspi, RSPI_SPSR);
> @@ -278,6 +406,15 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
>  	if (spsr & SPSR_OVRF)
>  		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
>  			    RSPI_SPCR);
> +}
> +
> +static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
> +			    struct spi_transfer *t)
> +{
> +	int remain = t->len;
> +	u8 *data;
> +
> +	rspi_receive_init(rspi);
> 
>  	data = (u8 *)t->rx_buf;
>  	while (remain > 0) {
> @@ -307,6 +444,120 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
>  	return 0;
>  }
> 
> +static int rspi_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
> +{
> +	struct scatterlist sg, sg_dummy;
> +	void *dummy = NULL, *rx_buf = NULL;
> +	struct dma_async_tx_descriptor *desc, *desc_dummy;
> +	unsigned len;
> +	int ret = 0;
> +
> +	if (rspi->dma_width_16bit) {
> +		/*
> +		 * If DMAC bus width is 16-bit, the driver allocates a dummy
> +		 * buffer. And, finally the driver converts the DMAC data into
> +		 * actual data as the following format:
> +		 *  DMAC data:   1st byte, dummy, 2nd byte, dummy ...
> +		 *  actual data: 1st byte, 2nd byte ...
> +		 */
> +		len = t->len * 2;
> +		rx_buf = kmalloc(len, GFP_KERNEL);
> +		if (!rx_buf)
> +			return -ENOMEM;
> +	 } else {
> +		len = t->len;
> +		rx_buf = t->rx_buf;
> +	}
> +
> +	/* prepare dummy transfer to generate SPI clocks */
> +	dummy = kzalloc(len, GFP_KERNEL);
> +	if (!dummy) {
> +		ret = -ENOMEM;
> +		goto end_nomap;
> +	}
> +	if (!rspi_dma_map_sg(&sg_dummy, dummy, len, rspi->chan_tx,
> +			     DMA_TO_DEVICE)) {
> +		ret = -EFAULT;
> +		goto end_nomap;
> +	}
> +	desc_dummy = dmaengine_prep_slave_sg(rspi->chan_tx, &sg_dummy, 1,
> +			DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc_dummy) {
> +		ret = -EIO;
> +		goto end_dummy_mapped;
> +	}
> +
> +	/* prepare receive transfer */
> +	if (!rspi_dma_map_sg(&sg, rx_buf, len, rspi->chan_rx,
> +			     DMA_FROM_DEVICE)) {
> +		ret = -EFAULT;
> +		goto end_dummy_mapped;
> +
> +	}
> +	desc = dmaengine_prep_slave_sg(rspi->chan_rx, &sg, 1, DMA_FROM_DEVICE,
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc) {
> +		ret = -EIO;
> +		goto end;
> +	}
> +
> +	rspi_receive_init(rspi);
> +
> +	/*
> +	 * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine will be
> +	 * called. So, this driver disables the IRQ while DMA transfer.
> +	 */
> +	disable_irq(rspi->irq);
> +
> +	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD, RSPI_SPCR);
> +	rspi_enable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
> +	rspi->dma_callbacked = 0;
> +
> +	desc->callback = rspi_dma_complete;
> +	desc->callback_param = rspi;
> +	dmaengine_submit(desc);
> +	dma_async_issue_pending(rspi->chan_rx);
> +
> +	desc_dummy->callback = NULL;	/* No callback */
> +	dmaengine_submit(desc_dummy);
> +	dma_async_issue_pending(rspi->chan_tx);
> +
> +	ret = wait_event_interruptible_timeout(rspi->wait,
> +					       rspi->dma_callbacked, HZ);
> +	if (ret > 0 && rspi->dma_callbacked)
> +		ret = 0;
> +	else if (!ret)
> +		ret = -ETIMEDOUT;
> +	rspi_disable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
> +
> +	enable_irq(rspi->irq);
> +
> +end:
> +	rspi_dma_unmap_sg(&sg, rspi->chan_rx, DMA_FROM_DEVICE);
> +end_dummy_mapped:
> +	rspi_dma_unmap_sg(&sg_dummy, rspi->chan_tx, DMA_TO_DEVICE);
> +end_nomap:
> +	if (rspi->dma_width_16bit) {
> +		if (!ret)
> +			rspi_memory_from_8bit(t->rx_buf, rx_buf, t->len);
> +		kfree(rx_buf);
> +	}
> +	kfree(dummy);
> +
> +	return ret;
> +}
> +
> +static int rspi_is_dma(struct rspi_data *rspi, struct spi_transfer *t)
> +{
> +	if (t->tx_buf && rspi->chan_tx)
> +		return 1;
> +	/* If the module receives data by DMAC, it also needs TX DMAC */
> +	if (t->rx_buf && rspi->chan_tx && rspi->chan_rx)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static void rspi_work(struct work_struct *work)
>  {
>  	struct rspi_data *rspi = container_of(work, struct rspi_data, ws);
> @@ -325,12 +576,18 @@ static void rspi_work(struct work_struct *work)
> 
>  		list_for_each_entry(t, &mesg->transfers, transfer_list) {
>  			if (t->tx_buf) {
> -				ret = rspi_send_pio(rspi, mesg, t);
> +				if (rspi_is_dma(rspi, t))
> +					ret = rspi_send_dma(rspi, t);
> +				else
> +					ret = rspi_send_pio(rspi, mesg, t);
>  				if (ret < 0)
>  					goto error;
>  			}
>  			if (t->rx_buf) {
> -				ret = rspi_receive_pio(rspi, mesg, t);
> +				if (rspi_is_dma(rspi, t))
> +					ret = rspi_receive_dma(rspi, t);
> +				else
> +					ret = rspi_receive_pio(rspi, mesg, t);
>  				if (ret < 0)
>  					goto error;
>  			}
> @@ -406,11 +663,58 @@ static irqreturn_t rspi_irq(int irq, void *_sr)
>  	return ret;
>  }
> 
> +static bool rspi_filter(struct dma_chan *chan, void *filter_param)
> +{
> +	chan->private = filter_param;
> +	return true;
> +}
> +
> +static void __devinit rspi_request_dma(struct rspi_data *rspi,
> +				       struct platform_device *pdev)
> +{
> +	struct rspi_plat_data *rspi_pd = pdev->dev.platform_data;
> +	dma_cap_mask_t mask;
> +
> +	if (!rspi_pd)
> +		return;
> +
> +	rspi->dma_width_16bit = rspi_pd->dma_width_16bit;
> +
> +	/* If the module receives data by DMAC, it also needs TX DMAC */
> +	if (rspi_pd->dma_rx_id && rspi_pd->dma_tx_id) {
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +		rspi->dma_rx.slave_id = rspi_pd->dma_rx_id;
> +		rspi->chan_rx = dma_request_channel(mask, rspi_filter,
> +						    &rspi->dma_rx);
> +		if (rspi->chan_rx)
> +			dev_info(&pdev->dev, "Use DMA when rx.\n");
> +	}
> +	if (rspi_pd->dma_tx_id) {
> +		dma_cap_zero(mask);
> +		dma_cap_set(DMA_SLAVE, mask);
> +		rspi->dma_tx.slave_id = rspi_pd->dma_tx_id;
> +		rspi->chan_tx = dma_request_channel(mask, rspi_filter,
> +						    &rspi->dma_tx);
> +		if (rspi->chan_tx)
> +			dev_info(&pdev->dev, "Use DMA when tx\n");
> +	}
> +}
> +
> +static void __devexit rspi_release_dma(struct rspi_data *rspi)
> +{
> +	if (rspi->chan_tx)
> +		dma_release_channel(rspi->chan_tx);
> +	if (rspi->chan_rx)
> +		dma_release_channel(rspi->chan_rx);
> +}
> +
>  static int __devexit rspi_remove(struct platform_device *pdev)
>  {
>  	struct rspi_data *rspi = dev_get_drvdata(&pdev->dev);
> 
>  	spi_unregister_master(rspi->master);
> +	rspi_release_dma(rspi);
>  	free_irq(platform_get_irq(pdev, 0), rspi);
>  	clk_put(rspi->clk);
>  	iounmap(rspi->addr);
> @@ -483,6 +787,9 @@ static int __devinit rspi_probe(struct platform_device *pdev)
>  		goto error3;
>  	}
> 
> +	rspi->irq = irq;
> +	rspi_request_dma(rspi, pdev);
> +
>  	ret = spi_register_master(master);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "spi_register_master error.\n");
> @@ -494,6 +801,7 @@ static int __devinit rspi_probe(struct platform_device *pdev)
>  	return 0;
> 
>  error4:
> +	rspi_release_dma(rspi);
>  	free_irq(irq, rspi);
>  error3:
>  	clk_put(rspi->clk);
> diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
> new file mode 100644
> index 0000000..900f0e3
> --- /dev/null
> +++ b/include/linux/spi/rspi.h
> @@ -0,0 +1,31 @@
> +/*
> + * Renesas SPI driver
> + *
> + * Copyright (C) 2012  Renesas Solutions Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + */
> +
> +#ifndef __LINUX_SPI_RENESAS_SPI_H__
> +#define __LINUX_SPI_RENESAS_SPI_H__
> +
> +struct rspi_plat_data {
> +	unsigned int dma_tx_id;
> +	unsigned int dma_rx_id;
> +
> +	unsigned dma_width_16bit:1;	/* DMAC read/write width = 16-bit */
> +};
> +
> +#endif
> -- 
> 1.7.1

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
