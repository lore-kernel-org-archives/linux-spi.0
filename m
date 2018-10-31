From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v2 5/7] mtd: devices: m25p80: Use the spi-mem dirmap API
Date: Wed, 31 Oct 2018 10:28:04 +0000
Message-ID: <VI1PR04MB57269B26A682B1FCFAC4E6F399CD0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <20181030133638.3322-1-boris.brezillon@bootlin.com>
 <20181030133638.3322-6-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 Cyrille Pitchen <cyrille.pitchen@microchip.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@microchip.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>, Mark Brown
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian
 Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>,
 Richard Weinberger <richard@nod.at>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181030133638.3322-6-boris.brezillon@bootlin.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 30, 2018 7:07 PM
> To: Mark Brown <broonie@kernel.org>; linux-spi@vger.kernel.org; David
> Woodhouse <dwmw2@infradead.org>; Brian Norris
> <computersforpeace@gmail.com>; Boris Brezillon
> <boris.brezillon@bootlin.com>; Marek Vasut <marek.vasut@gmail.com>;
> Richard Weinberger <richard@nod.at>; linux-mtd@lists.infradead.org
> Cc: Vignesh R <vigneshr@ti.com>; Cyrille Pitchen
> <cyrille.pitchen@microchip.com>; Tudor Ambarus
> <tudor.ambarus@microchip.com>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Frieder Schrempf
> <frieder.schrempf@exceet.de>; Miquel Raynal <miquel.raynal@bootlin.com>
> Subject: [PATCH v2 5/7] mtd: devices: m25p80: Use the spi-mem dirmap API
> 
> Make use of the spi-mem direct mapping API to let advanced controllers
> optimize read/write operations when they support direct mapping.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v2:
> - Rename the dirmap fields
> - Return directly after calling dirmap_read/write() and let the spi-nor
>   framework call us again if those functions returned less than the
>   requested length
> ---
>  drivers/mtd/devices/m25p80.c | 142 ++++++++++++++++++++++-------------
>  1 file changed, 89 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index c4a1d04b8c80..55cf3b2e1dc1 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -31,6 +31,10 @@
>  struct m25p {
>  	struct spi_mem		*spimem;
>  	struct spi_nor		spi_nor;
> +	struct {
> +		struct spi_mem_dirmap_desc *rdesc;
> +		struct spi_mem_dirmap_desc *wdesc;
> +	} dirmap;
>  };
> 
>  static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len) @@ -
> 85,31 +89,8 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to,
> size_t len,
>  			    const u_char *buf)
>  {
>  	struct m25p *flash = nor->priv;
> -	struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(nor-
> >program_opcode, 1),
> -				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
> -				   SPI_MEM_OP_NO_DUMMY,
> -				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
> -	int ret;
> -
> -	/* get transfer protocols. */
> -	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
> -	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
> -	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
> -
> -	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor-
> >sst_write_second)
> -		op.addr.nbytes = 0;
> -
> -	ret = spi_mem_adjust_op_size(flash->spimem, &op);
> -	if (ret)
> -		return ret;
> -	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
> -
> -	ret = spi_mem_exec_op(flash->spimem, &op);
> -	if (ret)
> -		return ret;
> 
> -	return op.data.nbytes;
> +	return spi_mem_dirmap_write(flash->dirmap.wdesc, to, len, buf);
>  }
> 
>  /*
> @@ -120,39 +101,66 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t
> from, size_t len,
>  			   u_char *buf)
>  {
>  	struct m25p *flash = nor->priv;
> -	struct spi_mem_op op =
> -			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode,
> 1),
> -				   SPI_MEM_OP_ADDR(nor->addr_width, from,
> 1),
> -				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
> -				   SPI_MEM_OP_DATA_IN(len, buf, 1));
> -	size_t remaining = len;
> -	int ret;
> +
> +	return spi_mem_dirmap_read(flash->dirmap.rdesc, from, len, buf); }
> +
> +static int m25p_create_write_dirmap(struct m25p *flash) {
> +	struct spi_nor *nor = &flash->spi_nor;
> +	struct spi_mem_dirmap_info info = {
> +		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor-
> >program_opcode, 1),
> +				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 1),
> +				      SPI_MEM_OP_NO_DUMMY,
> +				      SPI_MEM_OP_DATA_OUT(0, NULL, 1)),
> +		.offset = 0,
> +		.length = flash->spi_nor.mtd.size,
> +	};
> +	struct spi_mem_op *op = &info.op_tmpl;
> 
>  	/* get transfer protocols. */
> -	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
> -	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
> -	op.dummy.buswidth = op.addr.buswidth;
> -	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
> +	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor-
> >write_proto);
> +	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor-
> >write_proto);
> +	op->dummy.buswidth = op->addr.buswidth;
> +	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor-
> >write_proto);
> 
> -	/* convert the dummy cycles to the number of bytes */
> -	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> +	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor-
> >sst_write_second)
> +		op->addr.nbytes = 0;
> 
> -	while (remaining) {
> -		op.data.nbytes = remaining < UINT_MAX ? remaining :
> UINT_MAX;
> -		ret = spi_mem_adjust_op_size(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	flash->dirmap.wdesc = spi_mem_dirmap_create(flash->spimem, &info);
> +	if (IS_ERR(flash->dirmap.wdesc))
> +		return PTR_ERR(flash->dirmap.wdesc);
> 
> -		ret = spi_mem_exec_op(flash->spimem, &op);
> -		if (ret)
> -			return ret;
> +	return 0;
> +}
> 
> -		op.addr.val += op.data.nbytes;
> -		remaining -= op.data.nbytes;
> -		op.data.buf.in += op.data.nbytes;
> -	}
> +static int m25p_create_read_dirmap(struct m25p *flash) {
> +	struct spi_nor *nor = &flash->spi_nor;
> +	struct spi_mem_dirmap_info info = {
> +		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor-
> >read_opcode, 1),
> +				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 1),
> +				      SPI_MEM_OP_DUMMY(nor->read_dummy,
> 1),
> +				      SPI_MEM_OP_DATA_IN(0, NULL, 1)),
> +		.offset = 0,
> +		.length = flash->spi_nor.mtd.size,

I want to understand the sequence of calling up of this routine from drivers/mtd/spi-nor/spi-nor.c file.
Because till point of JedecID read and SFDP command read mtd.size is not being populated and having value as 0. This would make length as 0.

Did these read follow different path?

--
Regards
Yogesh Gaur

> +	};
> +	struct spi_mem_op *op = &info.op_tmpl;
> +
> +	/* get transfer protocols. */
> +	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
> +	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor-
> >read_proto);
> +	op->dummy.buswidth = op->addr.buswidth;
> +	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor-
> >read_proto);
> +
> +	/* convert the dummy cycles to the number of bytes */
> +	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
> +
> +	flash->dirmap.rdesc = spi_mem_dirmap_create(flash->spimem, &info);
> +	if (IS_ERR(flash->dirmap.rdesc))
> +		return PTR_ERR(flash->dirmap.rdesc);
> 
> -	return len;
> +	return 0;
>  }
> 
>  /*
> @@ -231,19 +239,47 @@ static int m25p_probe(struct spi_mem *spimem)
>  	if (ret)
>  		return ret;
> 
> -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> -				   data ? data->nr_parts : 0);
> +	ret = m25p_create_write_dirmap(flash);
> +	if (ret)
> +		return ret;
> +
> +	ret = m25p_create_read_dirmap(flash);
> +	if (ret)
> +		goto err_destroy_write_dirmap;
> +
> +	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> +				  data ? data->nr_parts : 0);
> +	if (ret)
> +		goto err_destroy_read_dirmap;
> +
> +	return 0;
> +
> +err_destroy_read_dirmap:
> +	spi_mem_dirmap_destroy(flash->dirmap.rdesc);
> +
> +err_destroy_write_dirmap:
> +	spi_mem_dirmap_destroy(flash->dirmap.wdesc);
> +
> +	return ret;
>  }
> 
> 
>  static int m25p_remove(struct spi_mem *spimem)  {
>  	struct m25p	*flash = spi_mem_get_drvdata(spimem);
> +	int ret;
> 
>  	spi_nor_restore(&flash->spi_nor);
> 
>  	/* Clean up MTD stuff. */
> -	return mtd_device_unregister(&flash->spi_nor.mtd);
> +	ret = mtd_device_unregister(&flash->spi_nor.mtd);
> +	if (ret)
> +		return ret;
> +
> +	spi_mem_dirmap_destroy(flash->dirmap.rdesc);
> +	spi_mem_dirmap_destroy(flash->dirmap.wdesc);
> +
> +	return 0;
>  }
> 
>  static void m25p_shutdown(struct spi_mem *spimem)
> --
> 2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
