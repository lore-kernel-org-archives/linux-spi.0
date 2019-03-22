From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v8 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Fri, 22 Mar 2019 20:43:28 +0300
Message-ID: <75c4642b-536e-f596-158d-387a63a5f6c5@cogentembedded.com>
References: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
 <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548658158-5460-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/28/2019 09:49 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   I've just found an error due to which my flash couldn't be read.

[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..ea12017
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,804 @@
[...]
> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +					const struct spi_mem_op *op,
> +					u64 *offs, size_t *len)
> +{
> +	struct rpc_spi *rpc = spi_controller_get_devdata(spi->controller);

> +	if (op->dummy.nbytes) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(op->dummy.nbytes);

   SMDMCR.DMCYC is in bits -- you forgot to multiply by 8.

> +		rpc->totalxferlen += op->dummy.nbytes;
> +	}[...]
> +static void rpc_spi_transfer_setup(struct rpc_spi *rpc,
> +				   struct spi_message *msg)
> +{
> +	struct spi_transfer *t, xfer[4] = { };
> +	u32 i, xfercnt, xferpos = 0;
[...]
> +	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
> +		rpc->smenr |= RPC_SMENR_DME;
> +		rpc->dummy = RPC_SMDMCR_DMCYC(xfer[2].len);

    Here as well, I guess.

[...]

MBR, Sergei
