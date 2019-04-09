From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Tue, 9 Apr 2019 23:07:13 +0300
Message-ID: <a2dc294f-f2a1-2469-1f44-db67f9b8cc10@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..037f273
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
[...]
[...]
> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +					u64 offs, size_t len, const void *buf)
> +{
> +	struct rpc_spi *rpc =
> +			spi_controller_get_devdata(desc->mem->spi->controller);
> +	int ret;
> +
> +	if (offs + desc->info.offset + len > U32_MAX)
> +		return -EINVAL;
> +
> +	if (len > RPC_WBUF_SIZE)
> +		len = RPC_WBUF_SIZE;
> +
> +	ret = rpc_spi_set_freq(rpc, desc->mem->spi->max_speed_hz);
> +	if (ret)
> +		return ret;
> +
> +	rpc_spi_mem_set_prep_op_cfg(desc->mem->spi,
> +				    &desc->info.op_tmpl, &offs, &len);
> +
> +	regmap_update_bits(rpc->regmap, RPC_CMNCR, RPC_CMNCR_MD, RPC_CMNCR_MD);
> +
> +	regmap_write(rpc->regmap, RPC_SMDRENR, 0);
> +
> +	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF);
> +
> +	memcpy_toio(rpc->wbuf, buf, len);

   Wait, doesn't the manual say that the whole 256-byte buffer should be
filled?  I think that short chunks have to be written w/o WBUF (done, in fact,
by the HF driver).

> +
> +	regmap_write(rpc->regmap, RPC_SMCMR, rpc->cmd);
> +	regmap_write(rpc->regmap, RPC_SMADR, offs);
> +	regmap_write(rpc->regmap, RPC_SMENR, rpc->smenr);
> +	regmap_write(rpc->regmap, RPC_SMCR, rpc->smcr | RPC_SMCR_SPIE);
> +	ret = wait_msg_xfer_end(rpc);
> +	if (ret)
> +		goto err_out;
> +
> +	regmap_write(rpc->regmap, RPC_DRCR, RPC_DRCR_RCF);
> +
> +	regmap_update_bits(rpc->regmap, RPC_PHYCNT, RPC_PHYCNT_STRTIM(7) |
> +			   RPC_PHYCNT_WBUF2 | RPC_PHYCNT_WBUF,
> +			   RPC_PHYCNT_STRTIM(6));
> +
> +	return len;
> +
> +err_out:
> +	return reset_control_reset(rpc->rstc);
> +}
[...]

MBR, Sergei
