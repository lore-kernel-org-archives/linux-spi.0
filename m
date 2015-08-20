From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/9] spi: sunxi: fix transfer timeout
Date: Thu, 20 Aug 2015 16:43:07 +0200
Message-ID: <20150820144307.GT30520@lukather>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="80Ds8Z/hZmemMosa"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB7OO26XAKGQEDIXE7AA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--80Ds8Z/hZmemMosa
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Aug 20, 2015 at 02:19:45PM -0000, Michal Suchanek wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
> 
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 10 +++++++++-
>  drivers/spi/spi-sun6i.c | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index fbb0a4d..48532ec 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -170,6 +170,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  {
>  	struct sun4i_spi *sspi = spi_master_get_devdata(master);
>  	unsigned int mclk_rate, div, timeout;
> +	unsigned int start, end, tx_time;
>  	unsigned int tx_len = 0;
>  	int ret = 0;
>  	u32 reg;
> @@ -279,9 +280,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
>  	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
>  
> +	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
> +	start = jiffies;
>  	timeout = wait_for_completion_timeout(&sspi->done,
> -					      msecs_to_jiffies(1000));
> +					      msecs_to_jiffies(tx_time));
> +	end = jiffies;
>  	if (!timeout) {
> +		dev_warn(&master->dev,
> +			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
> +			 dev_name(&spi->dev), tfr->len, speed,
> +			 jiffies_to_msecs(end - start), tx_time);

Timeout already contains the number of jiffies elapsed (and I'm not
sure anyone reading that message would get that the last number is
actually the maximum timeout).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--80Ds8Z/hZmemMosa--
