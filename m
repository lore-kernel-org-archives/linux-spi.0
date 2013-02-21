From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2] spi: tegra114: add spi driver
Date: Thu, 21 Feb 2013 12:15:15 -0700
Message-ID: <51267243.7090102@wwwdotorg.org>
References: <1361430631-18894-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com,
	broonie@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	linux-tegra@vger.kernel.org, swarren@nvidia.com
To: Laxman Dewangan <ldewangan@nvidia.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1361430631-18894-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 02/21/2013 12:10 AM, Laxman Dewangan wrote:
> Add SPI driver for NVIDIA's Tegra114 SPI controller. This controller
> is different than the older SoCs SPI controller in internal design as
> well as register interface.

Looks good. Just a couple of nits mentioned below, then,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

Note: There are a few minor diffs between this file and
spi-tegra20-slink.c. It might be worth eliminating as many as possible,
perhaps in a followon patch.

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt

> +NVIDIA Tegra114 SPI controller.
> +
> +Required properties:
> +- compatible : should be "nvidia,tegra114-spi".
> +- reg: Should contain SPI registers location and length.
> +- interrupts: Should contain SPI interrupts.
> +- nvidia,dma-request-selector : The Tegra DMA controller's phandle and
> +  request selector for this SPI controller.

The binding should specify that a clock named "spi" needs to be
provided, using the standard properties in ../clock/clock-bindings.txt

> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile

>  obj-$(CONFIG_SPI_SIRF)		+= spi-sirf.o
>  obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
>  obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
> +obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o

While Tegra114 is newer, it should really be listed before the Tegra20
entries, since the Makefile is alpha-numerically sorted right now I believe.

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c

> +static struct platform_driver tegra_spi_driver = {
> +	.driver = {
> +		.name		= "spi-tegra114",
> +		.owner		= THIS_MODULE,
> +		.pm		= &tegra_spi_pm_ops,
> +		.of_match_table	= of_match_ptr(tegra_spi_of_match),

No need to use of_match_ptr() there; just use the raw value since
CONFIG_OF is guaranteed to be enabled.
