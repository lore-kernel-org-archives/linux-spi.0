From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 2/2] memory: add Renesas RPC-IF driver
Date: Wed, 11 Dec 2019 10:58:53 +0100
Message-ID: <60952c5ac36510ff5be0733b15352828e0f2e41f.camel@pengutronix.de>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
         <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4db876ed-1ccc-e3be-311d-30cd52f40259@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Sergei,

On Tue, 2019-12-10 at 22:39 +0300, Sergei Shtylyov wrote:
[...]
> --- /dev/null
> +++ linux/drivers/memory/renesas-rpc-if.c
> @@ -0,0 +1,590 @@
[...]
> +int rpcif_io_xfer(struct rpcif *rpc)
> +{
[...]
> +	default:
> +		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
> +		regmap_write(rpc->regmap, RPCIF_SMCR,
> +			     rpc->smcr | RPCIF_SMCR_SPIE);
> +		ret = wait_msg_xfer_end(rpc);
> +		if (ret)
> +			goto err_out;
> +	}
> +
> +exit:
> +	pm_runtime_put(rpc->dev);
> +	return ret;
> +
> +err_out:
> +	ret = reset_control_reset(rpc->rstc);

If wait_msg_xfer_end() returned an error, but the reset succeeds, this
will cause rpcif_io_xfer() to report success as well. I suspect you do
not want to overwrite ret at this point.

> +	rpcif_hw_init(rpc, rpc->bus_size == 2);
> +	goto exit;
> +}
> +EXPORT_SYMBOL(rpcif_io_xfer);

regards
Philipp
