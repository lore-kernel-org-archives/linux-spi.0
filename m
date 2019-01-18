From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Fri, 18 Jan 2019 22:43:24 +0300
Message-ID: <f4665653-503c-e1a1-a211-b8b322225bd6@cogentembedded.com>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
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
In-Reply-To: <1547790855-22120-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/18/2019 08:54 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..692c760
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,800 @@
[...]
> +#define RPC_DRENR		0x001C	// R/W
> +#define RPC_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
> +#define RPC_DRENR_OCDB(o)	(((o) & 0x3) << 28)
> +#define RPC_DRENR_ADB(o)	(((o) & 0x3) << 24)
> +#define RPC_DRENR_OPDB(o)	(((o) & 0x3) << 20)
> +#define RPC_DRENR_SPIDB(o)	(((o) & 0x3) << 16)

   Manual v1.00 calls it DRDB, not SPIDB.

[...]
> +#define RPC_SMENR		0x0030	// R/W
> +#define RPC_SMENR_CDB(o)	(((o) & 0x2) << 30)
> +#define RPC_SMENR_OCDB(o)	(((o) & 0x2) << 28)
> +#define RPC_SMENR_ADB(o)	(((o) & 0x2) << 24)
> +#define RPC_SMENR_OPDB(o)	(((o) & 0x2) << 20)
> +#define RPC_SMENR_SPIDB(o)	(((o) & 0x2) << 16)

   Ugh, s/0x2/0x3/! :-/

[...]
> +#define RPC_SMDRENR		0x0064	// R/W
> +#define RPC_SMDRENR_HYPE	(0x5 << 12)

   s/0x5/0x7/, and this is a field, not value.

[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct resource *res;
> +	struct rpc_spi *rpc;
> +	const struct regmap_config *regmap_config;
> +	struct device_node *rpc_if;
> +	int ret;
> +
> +	rpc_if = of_find_compatible_node(pdev->dev.of_node, NULL,
> +					 "jedec,spi-nor");

   I doubt that this is a correct function to check for the child node's
"compatible" prop...

[...]
> +	regmap_config = &rpc_spi_regmap_config;

   Doesn't look like this variable is needed...

> +	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
> +					    regmap_config);
> +	if (IS_ERR(rpc->regmap)) {
> +		dev_err(&pdev->dev, "failed to init regmap %ld for rpc-spi\n",

   How about:

		dev_err(&pdev->dev, "failed to init regmap for rpc-spi, error %ld\n",

[...]
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_master failed\n");

   You forgot to update the message. :-)

[...]

MBR, Sergei
