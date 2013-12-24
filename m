From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] spi: rspi: Fix NULL pointer dereference on SH7757
Date: Tue, 24 Dec 2013 11:58:52 +0900
Message-ID: <20131224025852.GE22401@verge.net.au>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, Hiep Cao Minh <cm-hiep@jinso.co.jp>
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Dec 23, 2013 at 07:34:23PM +0100, Geert Uytterhoeven wrote:
> SH7757 doesn't pass platform data, in which case spi-rspi uses default
> parameters.
> 
> However, commit 5ce0ba88650f2606244a761d92e2b725f4ab3583 ("spi: rcar: add
> Renesas QSPI support on RSPI") added a new user of the platform data, but
> forgot to check for its validity first, causing a NULL pointer dereference
> on SH7757.
> 
> Add the missing check to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> This fixes a regression introduced in v3.13-rc1
> 
>  drivers/spi/spi-rspi.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index cfdbb422a40a..9e0301014f48 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -948,8 +948,9 @@ static int rspi_probe(struct platform_device *pdev)
>  	INIT_WORK(&rspi->ws, rspi_work);
>  	init_waitqueue_head(&rspi->wait);
>  
> -	master->num_chipselect = rspi_pd->num_chipselect;
> -	if (!master->num_chipselect)
> +	if (rspi_pd && rspi_pd->num_chipselect)
> +		master->num_chipselect = rspi_pd->num_chipselect;
> +	else
>  		master->num_chipselect = 2; /* default */
>  
>  	master->bus_num = pdev->id;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
