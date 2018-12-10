From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Mon, 10 Dec 2018 11:41:15 +0100
Message-ID: <20181210114115.3f3c1958@bbrezillon>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 10 Dec 2018 10:35:35 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> >>> +
> >>> +static int nxp_fspi_exec_op(struct spi_mem *mem, const struct
> >>> +spi_mem_op *op) {
> >>> +	struct nxp_fspi *f = spi_controller_get_devdata(mem->spi->master);
> >>> +	int err = 0;
> >>> +
> >>> +	mutex_lock(&f->lock);
> >>> +
> >>> +	/* Wait for controller being ready. */
> >>> +	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
> >>> +				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
> >>> +	WARN_ON(err);
> >>> +
> >>> +	nxp_fspi_select_mem(f, mem->spi);
> >>> +
> >>> +	nxp_fspi_prepare_lut(f, op);
> >>> +	/*
> >>> +	 * If we have large chunks of data, we read them through the AHB bus
> >>> +	 * by accessing the mapped memory. In all other cases we use
> >>> +	 * IP commands to access the flash.
> >>> +	 */
> >>> +	if (op->data.nbytes > (f->devtype_data->rxfifo - 4) &&
> >>> +	    op->data.dir == SPI_MEM_DATA_IN) {
> >>> +		nxp_fspi_read_ahb(f, op);
> >>> +	} else {
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_fill_txfifo(f, op);
> >>> +
> >>> +		err = nxp_fspi_do_op(f, op);
> >>> +
> >>> +		/* Invalidate the data in the AHB buffer. */
> >>> +		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
> >>> +			nxp_fspi_invalid(f);  
> >>
> >> E.g. in case of an erase operation or a NAND load page operation, the
> >> invalidation is not triggered, but flash/buffer contents have changed.
> >> So I'm not sure if this is enough...  
> > Ok, would change this and have invalidate for all operations.  
> 
> Maybe you can find out the correct way through testing with NOR and NAND.

Or just invalidate the buffer every time you're doing a read through the
AHB. This should always work.

I also think we should quickly move to a model where AHB accesses are
reserved for dirmap, and regular spi-mem op are limited to non-ahb
reads.
