From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v9 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
Date: Fri, 29 Mar 2019 18:12:43 +0300
Message-ID: <5cf42c96-183c-1edd-8397-1de6e3033f33@cogentembedded.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
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
In-Reply-To: <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]
> diff --git a/drivers/mfd/renesas-rpc.c b/drivers/mfd/renesas-rpc.c
> new file mode 100644
> index 0000000..c92bb74
> --- /dev/null
> +++ b/drivers/mfd/renesas-rpc.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF MFD driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#include <linux/mfd/renesas-rpc.h>
> +#include <linux/mfd/core.h>
> +
> +static const struct mfd_cell rpc_hf_ctlr = {
> +	.name = "rpc-hf",
> +	.of_compatible = "renesas,rcar-rpc-hf",
> +};
> +
> +static const struct mfd_cell rpc_spi_ctlr = {
> +	.name = "rpc-spi",
> +	.of_compatible = "renesas,rcar-rpc-spi",
> +};
> +
> +static const struct regmap_range rpc_mfd_volatile_ranges[] = {
> +	regmap_reg_range(RPC_SMRDR0, RPC_SMRDR0),

   regmap_reg_range((RPC_SMRDR0, RPC_SMRDR1), like Marek noted?

> +	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),

   regmap_reg_range((RPC_SMWDR0, RPC_SMWDR1)?

> +static int rpc_mfd_probe(struct platform_device *pdev)
> +{
> +	struct device_node *ctlr;
> +	const struct mfd_cell *cell;
> +	struct resource *res;
> +	struct rpc_mfd *rpc;
> +	int ret;
> +
> +	ctlr = of_get_next_child(pdev->dev.of_node, NULL);

    The child should be a CFI or JEDEC flash device, no virtual devices,
please.

[...]
> +	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rpc->rstc))
> +		return PTR_ERR(rpc->rstc);
> +
> +	platform_set_drvdata(pdev, rpc);
> +
> +	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> +
> +	return ret;

	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);

> +}
> +
> +static int rpc_mfd_remove(struct platform_device *pdev)
> +{
> +	mfd_remove_devices(&pdev->dev);

   Why, if you used devm_mfd_add_devices() in the probe method?

> +	return 0;
> +}
[...]
> diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/renesas-rpc.h
> new file mode 100644
> index 0000000..209e64f1
> --- /dev/null
> +++ b/include/linux/mfd/renesas-rpc.h
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
> +// Copyright (C) 2019 Macronix International Co., Ltd.
> +//
> +// R-Car Gen3 RPC-IF MFD driver
> +//
> +// Author:
> +//	Mason Yang <masonccyang@mxic.com.tw>
> +//
> +
> +#ifndef __MFD_RENESAS_RPC_H
> +#define __MFD_RENESAS_RPC_H
> +
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/log2.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

  Is any of these #include's used by the header itself? I don't think so...

> +
> +#define RPC_CMNCR		0x0000	// R/W

   Not sure we'd need the registers described in the public header after
we place the common RPC-IF code into the MFD driver. We'll see though...

[...]

MBR, Sergei
