From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 4/6] spi: ti-qspi: Implement the spi_mem interface
Date: Fri, 16 Feb 2018 11:25:54 +0100
Message-ID: <20180216112554.35f79e55@bbrezillon>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
        <20180205232120.5851-5-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205232120.5851-5-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue,  6 Feb 2018 00:21:18 +0100
Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:


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

As Vignesh just reported, it should be virt_addr_valid(op->data.buf.in)
and not !virt_addr_valid(op->data.buf.in).

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
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
