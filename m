From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: sun4i: fix FIFO limit
Date: Mon, 30 May 2016 10:37:00 +0200
Message-ID: <20160530083700.GF4247@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <e315008b5e9dc3f1490507508fd2f6e94767dfbb.1464130597.git.hramrach@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLPXV65AKGQEHQN4U7I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <e315008b5e9dc3f1490507508fd2f6e94767dfbb.1464130597.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> When testing SPI without DMA I noticed that filling the FIFO on the
> spi controller causes timeout.
> 
> Always leave room for one byte in the FIFO.
> 
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Sending it to stable would be great (with a fixes tag too).

> 
> ---
> v2:
> use EMSGSIZE instead of EINVAL
> ---
>  drivers/spi/spi-sun4i.c | 8 ++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index fe63bbd..04f1b77 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -180,7 +180,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  
>  	/* We don't support transfer larger than the FIFO */
>  	if (tfr->len > SUN4I_FIFO_DEPTH)
> -		return -EINVAL;
> +		return -EMSGSIZE;

One new line here.

> +	if (tfr->tx_buf && tfr->len >= SUN4I_FIFO_DEPTH)
> +		return -EMSGSIZE;
>  
>  	reinit_completion(&sspi->done);
>  	sspi->tx_buf = tfr->tx_buf;
> @@ -271,7 +273,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
>  	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
>  
>  	/* Fill the TX FIFO */
> -	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	/* Filling the FIFO fully causes timeout for some reason
> +	 * at least on spi2 on A10s */

This is not the proper comment style and generate a warning with
checkpatch, please fix that (and merge the comment with the previous
comment).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--/aVve/J9H4Wl5yVO--
