From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 9 Jan 2019 21:47:48 +0300
Message-ID: <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
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
In-Reply-To: <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/08/2019 07:16 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

   You now need to add:

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 787 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 794 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..81b4e04 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -544,6 +544,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_RENESAS_RPC_IF

   Since the driver is called without -IF suffix, I wouldn't use it in the
Kconfig name either, the following is enough:

> +	tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
> +	depends on ARCH_RENESAS || COMPILE_TEST

   Judging on the compilation error reported by the 0-day bot about readq(),
we now need to depend on 64BIT or something...

[...]
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f296270..3f2b2f9 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..1e57eb1
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,787 @@
[...]
> +#define RPC_CMNCR		0x0000	// R/W
> +#define RPC_CMNCR_MD		BIT(31)
> +#define RPC_CMNCR_SFDE		BIT(24) // undocumented bit but must be set
> +#define RPC_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
> +#define RPC_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
> +#define RPC_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
> +#define RPC_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
> +#define RPC_CMNCR_MOIIO_HIZ	(RPC_CMNCR_MOIIO0(3) | RPC_CMNCR_MOIIO1(3) | \
> +				 RPC_CMNCR_MOIIO2(3) | RPC_CMNCR_MOIIO3(3))
> +#define RPC_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) // undocumented bit
> +#define RPC_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) // undocumented bit

   Those are not exactly bits. I'd be happy with just // undocumented...

[...]
> +#define RPC_WBUF		0x8000	// Write Buffer
> +#define RPC_WBUF_SIZE		256	// Write Buffer size

   I wonder if the write buffer should be in a separate "reg" prop tuple...
Have you considered that?

[...]
> +static void rpc_spi_hw_init(struct rpc_spi *rpc)
> +{
> +	//
> +	// NOTE: The 0x260 are undocumented bits, but they must be set.
> +	//	RPC_PHYCNT_STRTIM is strobe timing adjustment bit,
> +	//	0x0 : the delay is biggest,
> +	//	0x1 : the delay is 2nd biggest,
> +	//	On H3 ES1.x, the value should be 0, while on others,
> +	//	the value should be 6.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL |
> +		     RPC_PHYCNT_STRTIM(6) | 0x260);
> +
> +	//
> +	// NOTE: The 0x1511144 are undocumented bits, but they must be set
> +	//       for RPC_PHYOFFSET1.
> +	//	 The 0x31 are undocumented bits, but they must be set
> +	//	 for RPC_PHYOFFSET2.
> +	//
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET1,
> +		     RPC_PHYOFFSET1_DDRTMG(3) | 0x1511144);
> +	regmap_write(rpc->regmap, RPC_PHYOFFSET2, 0x31 |
> +		     RPC_PHYOFFSET2_OCTTMG(4));

   I still would have preferred using regmap_update_bits() here...

[...]
> +static int rpc_spi_io_xfer(struct rpc_spi *rpc,
> +			   const void *tx_buf, void *rx_buf)
> +{
[...]
> +	} else if (rx_buf) {
> +		//
> +		// RPC-IF spoils the data for the commands without an address
> +		// phase (like RDID) in the manual mode, so we'll have to work
> +		// around this issue by using the external address space read
> +		// mode instead; we seem to be able to read 8 bytes at most in
> +		// this mode though...
> +		//
> +		if (!(smenr & RPC_SMENR_ADE(0xf))) {
> +			u32 nbytes = rpc->xferlen - pos;
> +			u64 tmp;
> +
> +			if (nbytes > 8)
> +				nbytes = 8;
> +
> +			regmap_update_bits(rpc->regmap, RPC_CMNCR,
> +					   RPC_CMNCR_MD, 0);
> +			regmap_write(rpc->regmap, RPC_DRCR, 0);
> +			regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
> +			regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +			regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
> +			regmap_write(rpc->regmap, RPC_DROPR, 0);
> +			regmap_write(rpc->regmap, RPC_DRENR, rpc->smenr &
> +				     ~RPC_SMENR_SPIDE(0xf));

   The 'smenr' filed needs a more universal name -- it's written to both SMENR and DRENR?

> +	} else {
> +		regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +		regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	return ret;

   We always return 0 here...

> +
> +out:

   I'd call this label error, since this is our error path...

> +	return reset_control_reset(rpc->rstc);
> +}
> +
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
[...]
> +	if (op->data.nbytes || (offs && len)) {
> +		if (op->data.dir == SPI_MEM_DATA_IN) {
> +			rpc->smcr = RPC_SMCR_SPIRE;
> +			rpc->xfer_dir = SPI_MEM_DATA_IN;
> +		} else if (op->data.dir == SPI_MEM_DATA_OUT) {
> +			rpc->smcr = RPC_SMCR_SPIWE;
> +			rpc->xfer_dir = SPI_MEM_DATA_OUT;
> +		}

   I asked for *switch* above...

[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
[...]
> +	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
> +
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +	regmap_write(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_CAL | 0x260 |
> +				  RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);

   regmap_update_bits()?

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

  Same here...

> +
> +	return len;
> +
> +out:

error:

> +	return reset_control_reset(rpc->rstc);
> +}
[...]

MBR, Sergei
