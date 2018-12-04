From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Tue, 4 Dec 2018 19:43:26 +0100
Message-ID: <cebe44a3-80be-9091-e70b-acba6f3fff4f@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/03/2018 10:18 AM, Mason Yang wrote:
> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

What changed in this V2 ?

[...]

> +struct rpc_spi {
> +	struct clk *clk_rpc;
> +	void __iomem *base;
> +	struct {
> +		void __iomem *map;
> +		dma_addr_t dma;
> +		size_t size;
> +	} linear;

This is still here, see my review comments on the previous version.

> +	struct regmap *regmap;
> +	u32 cur_speed_hz;
> +	u32 cmd;
> +	u32 addr;
> +	u32 dummy;
> +	u32 smcr;
> +	u32 smenr;
> +	u32 xferlen;
> +	u32 totalxferlen;
> +	enum spi_mem_data_dir xfer_dir;
> +#ifdef CONFIG_RESET_CONTROLLER
> +	struct reset_control *rstc;
> +#endif
> +};
> +
> +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> +{
> +	int ret;
> +
> +	if (rpc->cur_speed_hz == freq)
> +		return 0;
> +
> +	ret = clk_set_rate(rpc->clk_rpc, freq);
> +	if (ret)
> +		return ret;
> +
> +	rpc->cur_speed_hz = freq;
> +	return ret;
> +}
> +
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	/*
> +	 * NOTE: The 0x260 are undocumented bits, but they must be set.
> +	 *	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	 *	0x0 : the delay is biggest,
> +	 *	0x1 : the delay is 2nd biggest,
> +	 *	0x3 or 0x6 is a recommended value.
> +	 */

Doesn't this vary by SoC ? I think H3 ES1.0 had different value here,
but I might be wrong.

> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(0x6) | 0x260);
> +
> +	/*
> +	 * NOTE: The 0x31511144 and 0x431 are undocumented bits,
> +	 *	 but they must be set for RPC_PHYOFFSET1 & RPC_PHYOFFSET2.
> +	 */
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1, 0x31511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x431);
> +
> +	regmap_write(rpc->regmap, RPC_SSLDR, RPC_SSLDR_SPNDL(7) |
> +				  RPC_SSLDR_SLNDL(7) | RPC_SSLDR_SCKDL(7));
> +}
> +
> +#ifdef CONFIG_RESET_CONTROLLER

Just make the driver depend on reset controller.

> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +	int i, ret;
> +
> +	ret = reset_control_reset(rpc->rstc);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < LOOP_TIMEOUT; i++) {
> +		ret = reset_control_status(rpc->rstc);
> +		if (ret == 0)
> +			return 0;
> +		usleep_range(0, 1);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +#else
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +	return -ETIMEDOUT;
> +}
> +#endif
> +
> +static int wait_msg_xfer_end(struct rpc_spi *rpc)
> +{
> +	u32 sts;
> +
> +	return regmap_read_poll_timeout(rpc->regmap, RPC_CMNSR, sts,
> +					sts & RPC_CMNSR_TEND, 0, USEC_PER_SEC);
> +}
> +
> +static u8 rpc_bits_xfer(u32 nbytes)
> +{
> +	if (nbytes > 4)
> +		nbytes = 4;

Use clamp() ?

> +
> +	return GENMASK(3, 4 - nbytes);

Nice ;-)

> +}
> +
> +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> +			   const void *tx_buf, void *rx_buf)
> +{
> +	u32 smenr, smcr, data, pos = 0;
> +	int ret = 0;
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +				  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +				  RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0x0);
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
> +
> +	if (tx_buf) {
> +		smenr = rpc->smenr;
> +
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;
> +
> +			regmap_write(rpc->regmap, RPC_SMWDR0,
> +				     *(u32 *)(tx_buf + pos));

*(u32 *) cast is probably not needed , fix casts globally.

> +			if (nbytes > 4) {
> +				nbytes = 4;
> +				smcr = rpc->smcr |
> +				       RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
> +			} else {
> +				smcr = rpc->smcr | RPC_SMCR_SPIE;
> +			}
> +
> +			regmap_write(rpc->regmap, RPC_SMENR, smenr);
> +			regmap_write(rpc->regmap, RPC_SMCR, smcr);
> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			pos += nbytes;
> +			smenr = rpc->smenr & ~RPC_SMENR_CDE &
> +					     ~RPC_SMENR_ADE(0xf);
> +		}
> +	} else if (rx_buf) {
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;
> +
> +			if (nbytes > 4)
> +				nbytes = 4;
> +
> +			regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +			regmap_write(rpc->regmap, RPC_SMCR,
> +				     rpc->smcr | RPC_SMCR_SPIE);
> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			regmap_read(rpc->regmap, RPC_SMRDR0, &data);
> +			memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
> +			pos += nbytes;
> +			regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +			regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +			regmap_write(rpc->regmap, RPC_SMADR, rpc->addr + pos);
> +		}
> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;
> +out:
> +	return rpc_spi_do_reset(rpc);
> +}
> +
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(spi->master);
> +
> +	rpc->cmd = RPC_SMCMR_CMD(op->cmd.opcode);
> +	rpc->smenr = RPC_SMENR_CDE |
> +		     RPC_SMENR_CDB(fls(op->cmd.buswidth >> 1));
> +	rpc->totalxferlen = 1;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +	rpc->xferlen = 0;
> +	rpc->addr = 0;
> +
> +	if (op->addr.nbytes) {
> +		rpc->smenr |= RPC_SMENR_ADB(fls(op->addr.buswidth >> 1));
> +		if (op->addr.nbytes == 4)
> +			rpc->smenr |= RPC_SMENR_ADE(0xf);
> +		else
> +			rpc->smenr |= RPC_SMENR_ADE(0x7);
> +
> +		if (offs && len)
> +			rpc->addr = *(u32 *)offs;
> +		else
> +			rpc->addr = op->addr.val;
> +		rpc->totalxferlen += op->addr.nbytes;
> +	}
> +
> +	if (op->dummy.nbytes) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);
> +		rpc->totalxferlen += op->dummy.nbytes;
> +	}
> +
> +	if (op->data.nbytes || (offs && len)) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			rpc->smcr = RPC_SMCR_SPIRE;
> +			rpc->xfer_dir = SPI_MEM_DATA_IN;
> +		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			rpc->smcr = RPC_SMCR_SPIWE;
> +			rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +		}
> +
> +		if (offs && len) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +					(*(u32 *)len)) | RPC_SMENR_SPIDB
> +					(fls(op->data.buswidth >> 1));

Fix the *(u32 *)

> +			rpc->xferlen = *(u32 *)len;
> +			rpc->totalxferlen += *(u32 *)len;
> +		} else {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +					(op->data.nbytes)) | RPC_SMENR_SPIDB
> +					(fls(op->data.buswidth >> 1));

Drop parenthesis around fls()

> +
> +			rpc->xferlen = op->data.nbytes;
> +			rpc->totalxferlen += op->data.nbytes;
> +		}
> +	}
> +}
> +
> +static bool rpc_spi_mem_supports_op(struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{
> +	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
> +	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4)
> +		return false;
> +
> +	if (op->addr.nbytes > 4)

Merge this into previous conditional statement.

> +		return false;
> +
> +	return true;
> +}
> +
> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +				       u64 offs, size_t len, void *buf)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +	int ret;
> +
> +	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +		return -EINVAL;
> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_SFDE |
> +		     RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +		     RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RBURST(0x1f) |
> +		     RPC_DRCR_RBE);
> +	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC);
> +	regmap_write(rpc->regmap, RPC_DROPR, 0);
> +	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);
> +	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
> +
> +	memcpy_fromio(buf, rpc->linear.map + desc->info.offset + offs, len);
> +
> +	return len;
> +}
> +
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +	int ret;
> +
> +	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +		return -EINVAL;
> +
> +	if (WARN_ON(len > RPC_WBUF_SIZE))
> +		return -EIO;
> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_write(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD | RPC_CMNCR_SFDE |
> +				  RPC_CMNCR_MOIIO_HIZ | RPC_CMNCR_IOFV_HIZ |
> +				  RPC_CMNCR_BSZ(0));
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
> +				  RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
> +
> +	memcpy_toio(rpc->base + RPC_WBUF, buf, len);
> +
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMADR, offs);
> +	regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +	regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +	ret = wait_msg_xfer_end(rpc);
> +	if (ret)
> +		goto out;
> +
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	return len;
> +out:
> +	return rpc_spi_do_reset(rpc);
> +}
> +
> +static int rpc_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +
> +	if (desc->info.offset + desc->info.length > U32_MAX)
> +		return -ENOTSUPP;
> +
> +	if (!rpc_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
> +		return -ENOTSUPP;
> +
> +	if (!rpc->linear.map &&
> +	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
> +		return -ENOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int rpc_spi_mem_exec_op(struct spi_mem *mem,
> +			       const struct spi_mem_op *op)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(mem->spi->master);
> +	int ret;
> +
> +	ret = rpc_spi_set_freq(rpc, mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(mem->spi, op, NULL, NULL);
> +
> +	ret = rpc_spi_io_xfer(rpc,
> +			      op->data.dir == SPI_MEM_DATA_OUT ?
> +			      op->data.buf.out : NULL,
> +			      op->data.dir == SPI_MEM_DATA_IN ?
> +			      op->data.buf.in : NULL);
> +
> +	return ret;
> +}
> +
> +static const struct spi_controller_mem_ops rpc_spi_mem_ops = {
> +	.supports_op = rpc_spi_mem_supports_op,
> +	.exec_op = rpc_spi_mem_exec_op,
> +	.dirmap_create = rpc_spi_mem_dirmap_create,
> +	.dirmap_read = rpc_spi_mem_dirmap_read,
> +	.dirmap_write = rpc_spi_mem_dirmap_write,
> +};
> +
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };
> +	u32 i, xfercnt, xferpos = 0;
> +
> +	rpc->totalxferlen = 0;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (t->tx_buf) {
> +			xfer[xferpos].tx_buf = t->tx_buf;
> +			xfer[xferpos].tx_nbits = t->tx_nbits;
> +		}
> +
> +		if (t->rx_buf) {
> +			xfer[xferpos].rx_buf = t->rx_buf;
> +			xfer[xferpos].rx_nbits = t->rx_nbits;
> +		}
> +
> +		if (t->len) {
> +			xfer[xferpos++].len = t->len;
> +			rpc->totalxferlen += t->len;
> +		}
> +
> +		if (list_is_last(&t->transfer_list, &msg->transfers)) {
> +			if (xferpos > 1 && t->rx_buf) {
> +				rpc->xfer_dir = SPI_MEM_DATA_IN;
> +				rpc->smcr = RPC_SMCR_SPIRE;
> +			} else if (xferpos > 1 && t->tx_buf) {
> +				rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +				rpc->smcr = RPC_SMCR_SPIWE;
> +			}
> +		}
> +	}
> +
> +	xfercnt = xferpos;
> +	rpc->xferlen = xfer[--xferpos].len;
> +	rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);

Is the cast needed ?

> +	rpc->smenr = RPC_SMENR_CDE | RPC_SMENR_CDB(fls(xfer[0].tx_nbits >> 1));
> +	rpc->addr = 0;
> +
> +	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
> +		rpc->smenr |= RPC_SMENR_ADB(fls(xfer[1].tx_nbits >> 1));
> +		for (i = 0; i < xfer[1].len; i++)
> +			rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
> +					<< (8 * (xfer[1].len - i - 1));
> +
> +		if (xfer[1].len == 4)
> +			rpc->smenr |= RPC_SMENR_ADE(0xf);
> +		else
> +			rpc->smenr |= RPC_SMENR_ADE(0x7);
> +	}
> +
> +	switch (xfercnt) {
> +	case 2:
> +		if (xfer[1].rx_buf) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +				      (xfer[1].len)) | RPC_SMENR_SPIDB(fls
> +				      (xfer[1].rx_nbits >> 1));
> +		} else if (xfer[1].tx_buf) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +				      (xfer[1].len)) | RPC_SMENR_SPIDB(fls
> +				      (xfer[1].tx_nbits >> 1));
> +		}
> +		break;
> +
> +	case 3:
> +		if (xfer[2].len && xfer[2].rx_buf && !xfer[2].tx_buf) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +				      (xfer[2].len)) | RPC_SMENR_SPIDB(fls
> +				      (xfer[2].rx_nbits >> 1));

It seems this SMENR pattern repeats itself throughout the driver, can
this be improved / deduplicated ?

> +		} else if (xfer[2].len && xfer[2].tx_buf && !xfer[2].rx_buf) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +				      (xfer[2].len)) | RPC_SMENR_SPIDB(fls
> +				      (xfer[2].tx_nbits >> 1));
> +		}
> +		break;
> +
> +	case 4:
> +		if (xfer[2].len && xfer[2].tx_buf) {
> +			rpc->smenr |= RPC_SMENR_DME;
> +			rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);
> +		}
> +
> +		if (xfer[3].len && xfer[3].rx_buf) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +				      (xfer[3].len)) | RPC_SMENR_SPIDB(fls
> +				      (xfer[3].rx_nbits >> 1));
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +}
> +
> +static int rpc_spi_xfer_message(struct rpc_spi *rpc, struct spi_transfer *t)
> +{
> +	int ret;
> +
> +	ret = rpc_spi_set_freq(rpc, t->speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	ret = rpc_spi_io_xfer(rpc,
> +			      rpc->xfer_dir == SPI_MEM_DATA_OUT ?
> +			      t->tx_buf : NULL,
> +			      rpc->xfer_dir == SPI_MEM_DATA_IN ?
> +			      t->rx_buf : NULL);
> +
> +	return ret;
> +}
> +
> +static int rpc_spi_transfer_one_message(struct spi_master *master,
> +					struct spi_message *msg)
> +{
> +	struct rpc_spi *rpc = spi_master_get_devdata(master);
> +	struct spi_transfer *t;
> +	int ret;
> +
> +	rpc_spi_transfer_setup(rpc, msg);
> +
> +	list_for_each_entry(t, &msg->transfers, transfer_list) {
> +		if (!list_is_last(&t->transfer_list, &msg->transfers))
> +			continue;
> +		ret = rpc_spi_xfer_message(rpc, t);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	msg->status = 0;
> +	msg->actual_length = rpc->totalxferlen;
> +out:
> +	spi_finalize_current_message(master);
> +	return 0;
> +}
> +
> +static const struct regmap_range rpc_spi_volatile_ranges[] = {
> +	regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),
> +	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),

Why is SMWDR volatile ?

> +	regmap_reg_range(RPC_CMNSR, RPC_CMNSR),
> +};
> +
> +static const struct regmap_access_table rpc_spi_volatile_table = {
> +	.yes_ranges	= rpc_spi_volatile_ranges,
> +	.n_yes_ranges	= ARRAY_SIZE(rpc_spi_volatile_ranges),
> +};
> +
> +static const struct regmap_config rpc_spi_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +	.max_register = RPC_WBUF + RPC_WBUF_SIZE,
> +	.volatile_table = &rpc_spi_volatile_table,
> +};
> +
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_master *master;
> +	struct resource *res;
> +	struct rpc_spi *rpc;
> +	const struct regmap_config *regmap_config;
> +	int ret;
> +
> +	master = spi_alloc_master(&pdev->dev, sizeof(struct rpc_spi));

sizeof(*rpc)

> +	if (!master)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, master);
> +
> +	rpc = spi_master_get_devdata(master);
> +
> +	master->dev.of_node = pdev->dev.of_node;
> +
> +	rpc->clk_rpc = devm_clk_get(&pdev->dev, "clk_rpc");
> +	if (IS_ERR(rpc->clk_rpc))
> +		return PTR_ERR(rpc->clk_rpc);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rpc_regs");
> +	rpc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rpc->base))
> +		return PTR_ERR(rpc->base);
> +
> +	regmap_config = &rpc_spi_regmap_config;
> +	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
> +					    regmap_config);
> +	if (IS_ERR(rpc->regmap)) {
> +		dev_err(&pdev->dev, "failed to init regmap %ld for rpc-spi\n",
> +			PTR_ERR(rpc->regmap));
> +		return PTR_ERR(rpc->regmap);
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> +	rpc->linear.map = devm_ioremap_resource(&pdev->dev, res);
> +	if (!IS_ERR(rpc->linear.map)) {
> +		rpc->linear.dma = res->start;
> +		rpc->linear.size = resource_size(res);
> +	} else {
> +		rpc->linear.map = NULL;
> +	}
> +
> +	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rpc->rstc))
> +		return PTR_ERR(rpc->rstc);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	master->auto_runtime_pm = true;
> +
> +	master->num_chipselect = 1;
> +	master->mem_ops = &rpc_spi_mem_ops;
> +	master->transfer_one_message = rpc_spi_transfer_one_message;
> +
> +	master->bits_per_word_mask = SPI_BPW_MASK(8);
> +	master->mode_bits = SPI_CPOL | SPI_CPHA |
> +			SPI_RX_DUAL | SPI_TX_DUAL |
> +			SPI_RX_QUAD | SPI_TX_QUAD;
> +
> +	rpc_spi_hw_init(rpc);
> +
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");

Knowing the return value would be useful.

> +		goto err_put_master;
> +	}
> +	return 0;
> +
> +err_put_master:
> +	spi_master_put(master);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int rpc_spi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +	spi_unregister_master(master);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rpc_spi_of_ids[] = {
> +	{ .compatible = "renesas,r8a77995-rpc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rpc_spi_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	return spi_master_suspend(master);

Won't the SPI NOR lose state across suspend ? Is that a problem ?

> +}
> +
> +static int rpc_spi_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +
> +	return spi_master_resume(master);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(rpc_spi_pm_ops, rpc_spi_suspend, rpc_spi_resume);
> +#define DEV_PM_OPS	(&rpc_spi_pm_ops)
> +#else
> +#define DEV_PM_OPS	NULL
> +#endif
> +
> +static struct platform_driver rpc_spi_driver = {
> +	.probe = rpc_spi_probe,
> +	.remove = rpc_spi_remove,
> +	.driver = {
> +		.name = "rpc-spi",
> +		.of_match_table = rpc_spi_of_ids,
> +		.pm = DEV_PM_OPS,
> +	},
> +};
> +module_platform_driver(rpc_spi_driver);
> +
> +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
> +MODULE_DESCRIPTION("Renesas R-Car Gen3 RPC SPI controller driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best regards,
Marek Vasut
