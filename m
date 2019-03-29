From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v9 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
Date: Fri, 29 Mar 2019 11:43:45 +0100
Message-ID: <1e0107a8-164c-7978-f2d0-2dd3430cc2b9@gmail.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553847606-18122-2-git-send-email-masonccyang@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  drivers/mfd/Kconfig             |   9 +++
>  drivers/mfd/Makefile            |   1 +
>  drivers/mfd/renesas-rpc.c       | 140 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/renesas-rpc.h | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 304 insertions(+)
>  create mode 100644 drivers/mfd/renesas-rpc.c
>  create mode 100644 include/linux/mfd/renesas-rpc.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0ce2d8d..a870e12 100644
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
> +	  controller which provides either SPI host controller or HyperFlash.
> +	  You have to select individual components under the corresponding menu.
> +
>  config MFD_RT5033
>  	tristate "Richtek RT5033 Power Management IC"
>  	depends on I2C
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b4569ed7..4a49699 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -183,6 +183,7 @@ obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+= intel_quark_i2c_gpio.o
>  obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
>  obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
>  obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
> +obj-$(CONFIG_MFD_RENESAS_RPC)	+= renesas-rpc.o
>  obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
>  obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
>  obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
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
> +	regmap_reg_range(RPC_SMWDR0, RPC_SMWDR0),
> +	regmap_reg_range(RPC_CMNSR, RPC_CMNSR),
> +};

Isn't SMWDR1 volatile too ? And SMRDR1 too ?

[...]
-- 
Best regards,
Marek Vasut
