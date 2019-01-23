From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 23 Jan 2019 21:04:26 +0300
Message-ID: <12af2632-491d-0e01-66c9-0ead4f9d985a@cogentembedded.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
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
In-Reply-To: <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello!

On 01/23/2019 10:09 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]
> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
> new file mode 100644
> index 0000000..0127f25
> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2018 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver

   Do we really support Octa?

> +//
> +// Authors:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
[...]
> +#include <asm/unaligned.h>
[...]
> +	} else if (rx_buf) {
> +		//
> +		// RPC-IF spoils the data for the commands without an address
> +		// phase (like RDID) in the manual mode, so we'll have to work
> +		// around this issue by using the external address space read
> +		// mode instead.
> +		//
> +		if (!(smenr & RPC_SMENR_ADE(0xf))) {
> +			regmap_update_bits(rpc->regmap, RPC_CMNCR,
> +					   RPC_CMNCR_MD, 0);
> +			regmap_write(rpc->regmap, RPC_DRCR,
> +				     RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);
> +			regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
> +			regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
> +			regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
> +			regmap_write(rpc->regmap, RPC_DROPR, 0);
> +			regmap_write(rpc->regmap, RPC_DRENR, smenr);
> +			memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);

   Just noticed: if rpc->dirmap is NULL (which is now allowed), we have a kernel oops
here. :-(

[...]
> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr;
> +	struct resource *res;
> +	struct rpc_spi *rpc;
> +	struct device_node *rpc_if;

   Don't think that's a good name. Why not call it 'flash'?

> +	int ret;
> +
> +	rpc_if = of_get_next_child(pdev->dev.of_node, NULL);
> +	if (!rpc_if) {
> +		dev_warn(&pdev->dev, "no spi-nor device node found\n");

   How about "no flash node found"?

> +		return -ENODEV;
> +	}
> +
> +	ret = of_device_is_compatible(rpc_if, "jedec,spi-nor");
> +	if (!ret) {
> +		dev_warn(&pdev->dev, "no compatible spi-nor device found\n");

   "no SPI-NOR device found"?

[...]
> +	ret = spi_register_controller(ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto err_put_ctlr;
> +	}
> +	return 0;
> +
> +err_put_ctlr:
> +	spi_controller_put(ctlr);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
[...]
> +static const struct of_device_id rpc_spi_of_ids[] = {
> +	{ .compatible = "renesas,r8a77995-rpc", },

   Why (if it has no differences with the generic gen3 value below)?
Please remove.

> +	{ .compatible = "renesas,rcar-gen3-rpc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
[...]

MBR, Sergei
