From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Fri, 7 Dec 2018 21:17:58 +0300
Message-ID: <0bd07d30-1c0a-ef5b-24ae-dcae3c4721ce@cogentembedded.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, boris.brezillon@bootlin.com,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543828720-18345-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

   I'd already started the v2 driver review before you posted v3, so here goes...

On 12/03/2018 12:18 PM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..ac9094e
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,808 @@
[...]
> +#define RPC_CMNCR		0x0000	/* R/W */
> +#define RPC_CMNCR_MD		BIT(31)
> +#define RPC_CMNCR_SFDE		BIT(24)

   This bit is undocumented as of the gen3 manual v1.0. I'd like this to be reflected
in a comment...

[...]
> +#define RPC_CMNCR_IO3FV(val)	(((val) & 0x3) << 14)
> +#define RPC_CMNCR_IO2FV(val)	(((val) & 0x3) << 12)

   These 2 are also undocumented.

[...]
> +#define RPC_CMNCR_CPHAT		BIT(6)
> +#define RPC_CMNCR_CPHAR		BIT(5)
> +#define RPC_CMNCR_SSLP		BIT(4)
> +#define RPC_CMNCR_CPOL		BIT(3)

   And these 4...

> +#define RPC_DRCR		0x000C	/* R/W */
> +#define RPC_DRCR_SSLN		BIT(24)
> +#define RPC_DRCR_RBURST(v)	(((v) & 0x1F) << 16)

   More like ((v) - 1), like in another register...

> +#define RPC_DRCR_RCF		BIT(9)
> +#define RPC_DRCR_RBE		BIT(8)
> +#define RPC_DRCR_SSLE		BIT(0)
[...]
> +#define RPC_DREAR		0x0014	/* R/W */
> +#define RPC_DREAR_EAC		BIT(0)

   The manual says it takes bits 0 to 2...

[...]
> +#define RPC_SMADR		0x0028	/* R/W */
> +#define RPC_SMOPR		0x002C	/* R/W */
> +#define RPC_SMOPR_OPD0(o)	(((o) & 0xFF) << 0)
> +#define RPC_SMOPR_OPD1(o)	(((o) & 0xFF) << 8)
> +#define RPC_SMOPR_OPD2(o)	(((o) & 0xFF) << 16)
> +#define RPC_SMOPR_OPD3(o)	(((o) & 0xFF) << 24)

  You either go in descending or ascending order, not both. :-)

[...]
> +#define RPC_PHYCNT		0x007C	/* R/W */
> +#define RPC_PHYCNT_CAL		BIT(31)
> +#define PRC_PHYCNT_OCTA_AA	BIT(22)
> +#define PRC_PHYCNT_OCTA_SA	BIT(23)
> +#define PRC_PHYCNT_EXDS		BIT(21)
> +#define RPC_PHYCNT_OCT		BIT(20)
> +#define RPC_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
> +#define RPC_PHYCNT_WBUF2	BIT(4)
> +#define RPC_PHYCNT_WBUF		BIT(2)
> +#define RPC_PHYCNT_MEM(v)	(((v) & 0x3) << 0)

   The manual calls this field PHYMEM...

[...]
> +#define LOOP_TIMEOUT		1024

   It's more like TIMEOUT_LOOPS. :-)

[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	/*
> +	 * NOTE: The 0x260 are undocumented bits, but they must be set.
> +	 *	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	 *	0x0 : the delay is biggest,
> +	 *	0x1 : the delay is 2nd biggest,
> +	 *	0x3 or 0x6 is a recommended value.
> +	 */
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +				  RPC_PHYCNT_STRTIM(0x6) | 0x260);
> +
> +	/*
> +	 * NOTE: The 0x31511144 and 0x431 are undocumented bits,
> +	 *	 but they must be set for RPC_PHYOFFSET1 & RPC_PHYOFFSET2.
> +	 */
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1, 0x31511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x431);

   0x400 is actually documented, bits 0..7 are read only and default to 0x31...

> +#ifdef CONFIG_RESET_CONTROLLER
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

   Are you serious? :-)

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
[...]
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

   Just 0, please.

> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_SMADR, rpc->addr);
> +
> +	if (tx_buf) {
> +		smenr = rpc->smenr;
> +
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;

   One space before '-' is enough. :-)

> +
> +			regmap_write(rpc->regmap, RPC_SMWDR0,
> +				     *(u32 *)(tx_buf + pos));

   Ugh... what about the data endianness?

> +
> +			if (nbytes > 4) {
> +				nbytes = 4;
> +				smcr = rpc->smcr |
> +				       RPC_SMCR_SPIE | RPC_SMCR_SSLKP;
> +			} else {
> +				smcr = rpc->smcr | RPC_SMCR_SPIE;
> +			}

   Please do this repeated part outside *if*:

			smcr = rpc->smcr | RPC_SMCR_SPIE;
			if (nbytes > 4) {
				nbytes = 4;
				smcr |= RPC_SMCR_SSLKP;
			}

[...]
> +	} else if (rx_buf) {
> +		while (pos < rpc->xferlen) {
> +			u32 nbytes = rpc->xferlen  - pos;

   Again, 1 space is enough...

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

   What?! The 'data' variable is not in a MMIO region, you can use plain memcpy().
Not sure about the endianness tho... 

[...]
> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);

   Er... what's this for?

> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;

   Need empty line here...

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

    Maybe ilog2()?

> +	rpc->totalxferlen = 1;
> +	rpc->xfer_dir = SPI_MEM_NO_DATA;
> +	rpc->xferlen = 0;
> +	rpc->addr = 0;
> +
> +	if (op->addr.nbytes) {
> +		rpc->smenr |= RPC_SMENR_ADB(fls(op->addr.buswidth >> 1));

   Again, ilog2()?

[...]
> +	if (op->data.nbytes || (offs && len)) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			rpc->smcr = RPC_SMCR_SPIRE;
> +			rpc->xfer_dir = SPI_MEM_DATA_IN;
> +		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			rpc->smcr = RPC_SMCR_SPIWE;
> +			rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +		}

  This code is asking for using *switch*...

> +
> +		if (offs && len) {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +					(*(u32 *)len)) | RPC_SMENR_SPIDB

   Unobvious line breaks...

> +					(fls(op->data.buswidth >> 1));

   ilog2()?

> +
> +			rpc->xferlen = *(u32 *)len;
> +			rpc->totalxferlen += *(u32 *)len;
> +		} else {
> +			rpc->smenr |= RPC_SMENR_SPIDE(rpc_bits_xfer
> +					(op->data.nbytes)) | RPC_SMENR_SPIDB
> +					(fls(op->data.buswidth >> 1));

   You can factor out a large part of this expression and calculate it before *if*...

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

   Hm, the manual doesn't mention 2-wire SPI mode...

> +		return false;
> +
> +	if (op->addr.nbytes > 4)
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

   RPC_DRCR_RBURST(32), please.

> +		     RPC_DRCR_RBE);
> +	regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC);
> +	regmap_write(rpc->regmap, RPC_DROPR, 0);
> +	regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr);

   Looks liky you need a more generic field name (like rpc->cmd)...

> +	regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
> +	regmap_write(rpc->regmap, RPC_DRDRENR, 0);
> +
> +	memcpy_fromio(buf, rpc->linear.map + desc->info.offset + offs, len);

   What if the read direct-mapped area is less than U32_MAX in size (and it will be,
according to your bindings)?

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

   Why not write 256 bytes and return w/that?

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

  Didn't understand this 2-write-buffers thing...

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

   Need empty line here.

> +out:
> +	return rpc_spi_do_reset(rpc);
> +}
[...]> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
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

   Why check 'xferpos' twice?

> +				rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +				rpc->smcr = RPC_SMCR_SPIWE;
> +			}
> +		}
> +	}
> +
> +	xfercnt = xferpos;
> +	rpc->xferlen = xfer[--xferpos].len;
> +	rpc->cmd = RPC_SMCMR_CMD(((u8 *)xfer[0].tx_buf)[0]);
> +	rpc->smenr = RPC_SMENR_CDE | RPC_SMENR_CDB(fls(xfer[0].tx_nbits >> 1));

   ilog2()?

> +	rpc->addr = 0;
> +
> +	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
> +		rpc->smenr |= RPC_SMENR_ADB(fls(xfer[1].tx_nbits >> 1));

   ilog2()?

> +		for (i = 0; i < xfer[1].len; i++)
> +			rpc->addr |= (u32)((u8 *)xfer[1].tx_buf)[i]
> +					<< (8 * (xfer[1].len - i - 1));

   Ugh, you need get_unaligned_*()...

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

   Ugh... don't want to repeat after Marek. :-)

[...]
> +static const struct regmap_config rpc_spi_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.fast_io = true,
> +	.max_register = RPC_WBUF + RPC_WBUF_SIZE,

   Ugh... 0x8100/4 regs, of which the majority isn't used... :-/

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
[...]
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rpc_regs");

   I'd suggest just "regs".

> +	rpc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(rpc->base))
> +		return PTR_ERR(rpc->base);
[...]
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

   No spi_master_put() here?

[...]

MBR, Sergei
