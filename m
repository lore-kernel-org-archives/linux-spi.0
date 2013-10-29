From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] spi: add Intel Mid SSP driver
Date: Tue, 29 Oct 2013 11:19:26 -0700
Message-ID: <1383070766.12439.13.camel@joe-AO722>
References: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, ning.li@intel.com,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Fei Yang <fei.yang@intel.com>
To: David Cohen <david.a.cohen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2013-10-29 at 11:05 -0700, David Cohen wrote:
> This patch adds driver for ssp spi interface on Intel Mid platform.

A few simple notes:

Please consider using checkpatch.

> ---
>  drivers/spi/Kconfig                   |   12 +
>  drivers/spi/Makefile                  |    1 +
>  drivers/spi/spi-intel-mid-ssp.c       | 1506 +++++++++++++++++++++++++++++++++
>  include/linux/spi/intel_mid_ssp_spi.h |  330 ++++++++

Shouldn't this include file be in the drivers/spi directory?

[]

> diff --git a/drivers/spi/spi-intel-mid-ssp.c b/drivers/spi/spi-intel-mid-ssp.c
[]
> +#ifdef DUMP_RX
> +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> +{

You could save a couple of later #ifdefs by
moving the #ifdef inside the function

static void dump_trailer(etc)
{
#ifdef DUMP_RX
	...
#endif
}

> +static int map_dma_buffers(struct ssp_drv_context *sspc)
> +{
[]
> +#ifdef DUMP_RX
> +		dump_trailer(&sspc->pdev->dev, sspc->tx, sspc->len, 16);
> +#endif

> +static void int_transfer_complete(struct ssp_drv_context *sspc)
> +{
[]
> +#ifdef DUMP_RX
> +	dump_trailer(dev, sspc->rx, sspc->len, 16);
> +#endif

> +static int setup(struct spi_device *spi)
> +{
[]
> +	if (!chip) {
> +		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
> +		if (!chip) {
> +			dev_err(&spi->dev,
> +			"failed setup: can't allocate chip data\n");

OOM messages aren't necessary as a generic OOM message
is already emitted along with a dump_stack();
