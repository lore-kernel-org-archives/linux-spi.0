From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi-pl022: Add missing return value update
Date: Mon, 13 Jun 2011 09:08:56 -0600
Message-ID: <20110613150856.GD18161@ponder.secretlab.ca>
References: <1307962426-19230-1-git-send-email-virupax.sadashivpetimath@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org
To: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1307962426-19230-1-git-send-email-virupax.sadashivpetimath@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 13, 2011 at 04:23:46PM +0530, Virupax Sadashivpetimath wrote:
> Return error on out of range cpsdvsr value.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>

It looks like this is a bug fix for v3.0, and probably for -stable too, correct?

g.

> ---
>  drivers/spi/spi-pl022.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 2541705..b3bd8d8 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1859,6 +1859,7 @@ static int pl022_setup(struct spi_device *spi)
>  	}
>  	if ((clk_freq.cpsdvsr < CPSDVR_MIN)
>  	    || (clk_freq.cpsdvsr > CPSDVR_MAX)) {
> +		status = -EINVAL;
>  		dev_err(&spi->dev,
>  			"cpsdvsr is configured incorrectly\n");
>  		goto err_config_params;
> -- 
> 1.7.4.3
> 
