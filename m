From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 2/2] spi: sun4i: Add support for wait
 time between word transmissions
Date: Fri, 18 Dec 2015 12:16:27 +0100
Message-ID: <20151218111627.GM30359@lukather>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
 <1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBD7C2GZQKGQEEJAF2GQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1450352427-25350-3-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Thu, Dec 17, 2015 at 12:40:27PM +0100, Marcus Weseloh wrote:
> Modifies the sun4i SPI master driver to make use of the
> "spi-word-wait-ns" property. This specific SPI controller needs 3 clock
> cycles to set up the delay, which makes the minimum non-zero wait time
> on this hardware 4 clock cycles.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index f60a6d6..3b4f5f4 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of.h>
>  
>  #include <linux/spi/spi.h>
>  
> @@ -173,6 +174,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	unsigned int tx_len = 0;
>  	int ret = 0;
>  	u32 reg;
> +	int wait_clk = 0;
> +	int clk_ns = 0;
>  
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> @@ -261,6 +264,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  
>  	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
>  
> +	/*
> +	 * Setup wait time between words.
> +	 *
> +	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
> +	 * additional cycles to setup the wait counter, so the minimum delay
> +	 * time is 4 cycles.
> +	 */
> +	if (spi->word_wait_ns) {
> +		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);

You should use the actual rate of the clock returned by clk_get_rate
(or probably just use mclk_rate).

The clock driver might round the frequency to something else than what
was set in clk_set_rate, which would make your calculation here a bit
off.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--XbHSybK3LHOYQtWI--
