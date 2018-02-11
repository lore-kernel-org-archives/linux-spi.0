From: Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Sun, 11 Feb 2018 16:17:06 +0100
Message-ID: <20180211161706.31d0bdc8@xps13>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-5-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205232120.5851-5-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris,

On Tue,  6 Feb 2018 00:21:18 +0100, Boris Brezillon
<boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> 
> The spi_mem interface is meant to replace the spi_flash_read() one.
> Implement the ->exec_op() method so that we can smoothly get rid of the
> old interface.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/spi/spi-ti-qspi.c | 85 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index c24d9b45a27c..40cac3ef6cc9 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -434,12 +434,10 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
>  	return 0;
>  }
>  
> -static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi,
> -				     struct spi_flash_read_message *msg)
> +static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi, loff_t offs,
> +				     void *to, size_t readsize)
>  {
> -	size_t readsize = msg->len;
> -	void *to = msg->buf;
> -	dma_addr_t dma_src = qspi->mmap_phys_base + msg->from;
> +	dma_addr_t dma_src = qspi->mmap_phys_base + offs;
>  	int ret = 0;
>  
>  	/*
> @@ -507,13 +505,14 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
>  	qspi->mmap_enabled = false;
>  }
>  
> -static void ti_qspi_setup_mmap_read(struct spi_device *spi,
> -				    struct spi_flash_read_message *msg)
> +static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
> +				    u8 data_nbits, u8 addr_width,
> +				    u8 dummy_bytes)
>  {
>  	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
> -	u32 memval = msg->read_opcode;
> +	u32 memval = opcode;
>  
> -	switch (msg->data_nbits) {
> +	switch (data_nbits) {
>  	case SPI_NBITS_QUAD:
>  		memval |= QSPI_SETUP_RD_QUAD;
>  		break;
> @@ -524,8 +523,8 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi,
>  		memval |= QSPI_SETUP_RD_NORMAL;
>  		break;
>  	}
> -	memval |= ((msg->addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
> -		   msg->dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
> +	memval |= ((addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
> +		   dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
>  	ti_qspi_write(qspi, memval,
>  		      QSPI_SPI_SETUP_REG(spi->chip_select));
>  }
> @@ -546,13 +545,15 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
>  
>  	if (!qspi->mmap_enabled)
>  		ti_qspi_enable_memory_map(spi);
> -	ti_qspi_setup_mmap_read(spi, msg);
> +	ti_qspi_setup_mmap_read(spi, msg->read_opcode, msg->data_nbits,
> +				msg->addr_width, msg->dummy_bytes);
>  
>  	if (qspi->rx_chan) {
>  		if (msg->cur_msg_mapped)
>  			ret = ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
>  		else
> -			ret = ti_qspi_dma_bounce_buffer(qspi, msg);
> +			ret = ti_qspi_dma_bounce_buffer(qspi, msg->from,
> +							msg->buf, msg->len);
>  		if (ret)
>  			goto err_unlock;
>  	} else {
> @@ -566,6 +567,62 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
>  	return ret;
>  }
>  
> +static int ti_qspi_exec_mem_op(struct spi_mem *mem,
> +			       const struct spi_mem_op *op)
> +{
> +	struct ti_qspi *qspi = spi_master_get_devdata(mem->spi->master);
> +	int i, ret = 0;
> +	u32 from = 0;
> +
> +	/* Only optimize read path. */
> +	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
> +	    !op->addr.nbytes || op->addr.nbytes > 4)
> +		return -ENOTSUPP;
> +
> +	for (i = 0; i < op->addr.nbytes; i++) {
> +		from <<= 8;
> +		from |= op->addr.buf[i];
> +	}
> +
> +	/* Address exceeds MMIO window size, fall back to regular mode. */

I don't understand how do you fall back to regular mode? Moreover if the
purpose of adding this function is to remove spi_flash_read().

> +	if (from > 0x4000000)
> +		return -ENOTSUPP;
> +
> +	mutex_lock(&qspi->list_lock);
> +
> +	if (!qspi->mmap_enabled)
> +		ti_qspi_enable_memory_map(mem->spi);
> +	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
> +				op->addr.nbytes, op->dummy.nbytes);
> +
> +	if (qspi->rx_chan) {
> +		struct sg_table sgt;
> +
> +		if (!virt_addr_valid(op->data.buf.in) &&
> +		    !spi_controller_dma_map_mem_op_data(mem->spi->master, op,
> +							&sgt)) {
> +			ret = ti_qspi_dma_xfer_sg(qspi, sgt, from);
> +			spi_controller_dma_unmap_mem_op_data(mem->spi->master,
> +							     op, &sgt);
> +		} else {
> +			ret = ti_qspi_dma_bounce_buffer(qspi, from,
> +							op->data.buf.in,
> +							op->data.nbytes);
> +		}
> +	} else {
> +		memcpy_fromio(op->data.buf.in, qspi->mmap_base + from,
> +			      op->data.nbytes);
> +	}
> +
> +	mutex_unlock(&qspi->list_lock);
> +
> +	return ret;
> +}
> +
> +static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
> +	.exec_op = ti_qspi_exec_mem_op,
> +};
> +
>  static int ti_qspi_start_transfer_one(struct spi_master *master,
>  		struct spi_message *m)
>  {
> @@ -673,6 +730,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
>  				     SPI_BPW_MASK(8);
>  	master->spi_flash_read = ti_qspi_spi_flash_read;
> +	master->mem_ops = &ti_qspi_mem_ops;
>  
>  	if (!of_property_read_u32(np, "num-cs", &num_cs))
>  		master->num_chipselect = num_cs;
> @@ -785,6 +843,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  				 PTR_ERR(qspi->mmap_base));
>  			qspi->mmap_base = NULL;
>  			master->spi_flash_read = NULL;
> +			master->mem_ops = NULL;
>  		}
>  	}
>  	qspi->mmap_enabled = false;



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
