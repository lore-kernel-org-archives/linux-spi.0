From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] spi_imx.c: TRIVIAL mx25 & mx35 SPI_VER is 0.7
Date: Thu, 23 Dec 2010 12:01:53 -0700
Message-ID: <20101223190153.GC20384@angua.secretlab.ca>
References: <1293102730-32528-1-git-send-email-richard.genoud@gmail.com>
 <1293102730-32528-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293102730-32528-2-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 23, 2010 at 12:12:10PM +0100, Richard Genoud wrote:
> The check on cpu_is_mx25 and cpu_is_mx35 was made twice.
> This is obviously wrong.
> Anyway, this patch won't change the previous behaviour which is
> SPI_IMX_VER_0_7 for mx25 and mx35.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

applied, thanks.

g.

> ---
>  drivers/spi/spi_imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 793ae99..96be9d1 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -806,7 +806,7 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  		if (cpu_is_mx25() || cpu_is_mx35())
>  			spi_imx->devtype_data =
>  				spi_imx_devtype_data[SPI_IMX_VER_0_7];
> -		else if (cpu_is_mx25() || cpu_is_mx31() || cpu_is_mx35())
> +		else if (cpu_is_mx31())
>  			spi_imx->devtype_data =
>  				spi_imx_devtype_data[SPI_IMX_VER_0_4];
>  		else if (cpu_is_mx27() || cpu_is_mx21())
> -- 
> 1.7.1
> 
