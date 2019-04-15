From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
Date: Mon, 15 Apr 2019 22:57:45 +0300
Message-ID: <935046cc-e2e5-b9b8-0c94-1be5ae604276@cogentembedded.com>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch name is somewhat misleading -- there's no "MFD controller".

On 04/15/2019 10:37 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 26ad646..7914349 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -978,6 +978,15 @@ config MFD_RDC321X
>  	  southbridge which provides access to GPIOs and Watchdog using the
>  	  southbridge PCI device configuration space.
>  
> +config MFD_RENESAS_RPC
> +	tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
> +	select MFD_CORE
> +	depends on ARCH_RENESAS
> +	help
> +	  This supports for Renesas R-Car Gen3 RPC-IF multifunction device

   "For" node needed here.

> +	  controller which provides either SPI host controller or HyperFlash.
> +	  You have to select individual components under the corresponding menu.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
[...]
> diff --git a/drivers/mfd/renesas-rpc.c b/drivers/mfd/renesas-rpc.c
> new file mode 100644
> index 0000000..a565f31
> --- /dev/null
> +++ b/drivers/mfd/renesas-rpc.c
> @@ -0,0 +1,128 @@
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

   Don't need this line any more...

> +};
> +
> +static const struct mfd_cell rpc_spi_ctlr = {
> +	.name = "rpc-spi",
> +	.of_compatible = "renesas,rcar-rpc-spi",

   ... and this too.

[...]
> +static int rpc_mfd_probe(struct platform_device *pdev)
> +{
> +	struct device_node *flash;
> +	const struct mfd_cell *cell;
> +	struct resource *res;
> +	struct rpc_mfd *rpc;
> +	void __iomem *base;
> +	int ret;
> +
> +	flash = of_get_next_child(pdev->dev.of_node, NULL);
> +	if (!flash) {
> +		dev_warn(&pdev->dev, "no flash node found\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_device_is_compatible(flash, "jedec,spi-nor");
> +	if (ret) {
> +		cell = &rpc_spi_ctlr;
> +	} else {
> +		ret = of_device_is_compatible(flash, "cfi-flash");
> +		if (ret) {
> +			cell = &rpc_hf_ctlr;
> +		} else {
> +			dev_warn(&pdev->dev, "no jedec spi/cfi device found\n");
> +			return -ENODEV;
> +		}
> +	}


   This definitely should look simpler, like below:

	if (of_device_is_compatible(flash, "jedec,spi-nor")) {
 		cell = &rpc_spi_ctlr;
	} else if (of_device_is_compatible(flash, "cfi-flash")) {
		cell = &rpc_hf_ctlr;
 	} else {
		dev_warn(&pdev->dev, "unknown flash type\n");
		return -ENODEV;
	}

[...]

> +	ret = devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
> +
> +	return ret;

	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);

[...]
> diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/renesas-rpc.h
> new file mode 100644
> index 0000000..61ada14
> --- /dev/null
> +++ b/include/linux/mfd/renesas-rpc.h
> @@ -0,0 +1,153 @@
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

   NAK. I have already told you that these #include's are only needed in the
drivers, not in this header.

   My idea is to contain all hardware manipulation in the MFD driver,
with SPI/HF drivers calling that code via a set of APIs declared in this header.
The registers (declared below) would end up only needed by that common MFD driver...

[...]

MBR, Sergei
