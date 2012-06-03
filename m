From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] spi-orion: remove uneeded spi_info
Date: Sun, 3 Jun 2012 16:54:19 -0400
Message-ID: <20120603205419.GK14756@titan.lakedaemon.net>
References: <1338754215-16022-1-git-send-email-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org,
	"open list:SPI SUBSYSTEM" <spi-devel-general@lists.sourceforge.net>,
	open list <linux-kernel@vger.kernel.org>
To: Michael Walle <michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338754215-16022-1-git-send-email-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 03, 2012 at 10:10:14PM +0200, Michael Walle wrote:
> This was formerly used to store the tclk value. Remove it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Jason Cooper <jason@lakedaemon.net>

> ---
>  drivers/spi/spi-orion.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index dfd04e9..2760450 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -45,7 +45,6 @@ struct orion_spi {
>  	void __iomem		*base;
>  	unsigned int		max_speed;
>  	unsigned int		min_speed;
> -	struct orion_spi_info	*spi_info;
>  	struct clk              *clk;
>  };
>  
> @@ -450,12 +449,9 @@ static int __init orion_spi_probe(struct platform_device *pdev)
>  	struct spi_master *master;
>  	struct orion_spi *spi;
>  	struct resource *r;
> -	struct orion_spi_info *spi_info;
>  	unsigned long tclk_hz;
>  	int status = 0;
>  
> -	spi_info = pdev->dev.platform_data;
> -
>  	master = spi_alloc_master(&pdev->dev, sizeof *spi);
>  	if (master == NULL) {
>  		dev_dbg(&pdev->dev, "master allocation failed\n");
> @@ -476,7 +472,6 @@ static int __init orion_spi_probe(struct platform_device *pdev)
>  
>  	spi = spi_master_get_devdata(master);
>  	spi->master = master;
> -	spi->spi_info = spi_info;
>  
>  	spi->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(spi->clk)) {
> -- 
> 1.7.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
