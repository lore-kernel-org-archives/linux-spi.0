From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 1/2] spi: Add Renesas R-Car Gen3 RPC SPI controller
 driver
Date: Thu, 13 Dec 2018 22:48:02 +0300
Message-ID: <557c8114-2819-7be3-21b8-02918aa89c04@cogentembedded.com>
References: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
 <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
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
In-Reply-To: <1544181199-3373-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/07/2018 02:13 PM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/spi/Kconfig           |   6 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-renesas-rpc.c | 776 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 783 insertions(+)
>  create mode 100644 drivers/spi/spi-renesas-rpc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7d3a5c9..54b40f8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..cec5669
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,776 @@
[...]
> +static int rpc_spi_do_reset(struct rpc_spi *rpc)
> +{
> +	int ret;
> +
> +	ret = reset_control_reset(rpc->rstc);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

   This degrades to:

{
	return reset_control_reset(rpc->rstc);
}

   So, we hardly need this function now...

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
> +				     get_unaligned((u32 *)(tx_buf + pos)));
> +
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

   Hm... our flash chip (Spansion S25FS512S) doesn't get detected; it sends
JEDEC ID bytes 0..3 repeatedly, unless I copy the SSLKP logic from the writing
branch above...

> +			ret = wait_msg_xfer_end(rpc);
> +			if (ret)
> +				goto out;
> +
> +			regmap_read(rpc->regmap, RPC_SMRDR0, &data);
> +			memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
> +			pos += nbytes;

   ... and it skips byte 4 unless I copy the code from the end of the writing
branch, clearing CDE/ADE. But even then the byte 4 reads as 0x03 instead of 0.

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
[...]

MBR, Sergei
