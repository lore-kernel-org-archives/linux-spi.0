From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/9] spi: sun4i: add DMA support
Date: Thu, 20 Aug 2015 11:58:50 -0700
Message-ID: <20150820185850.GQ12027@sirena.org.uk>
References: <cover.1440080122.git.hramrach@gmail.com>
 <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach@gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ngPZezdD7QsvFaqQ"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB7OG3CXAKGQE5LX2IAI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ccf776869b0d7fe2c78bcc41d6cd1896bf732296.1440080122.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 02:19:46PM -0000, Emilio L=C3=B3pez wrote:

> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
> +		/* The receive transfer should be the last one to finish */
> +		dma_wait_for_async_tx(desc_rx);

What if it's a transmit only transfer?  We'll fall over to this...

> +	} else {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	}

...which manually reads data from the FIFO which doesn't seem like what
we want, won't it conflict with the DMA?

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1iNlAAoJECTWi3JdVIfQFLIH/2UXA3usybggQn4ENf6HmiFe
Us53J220IBIlDI+tKxxrI/lZUSkz2NDHjloYOirVPgdQWnuCcHNXoIE8iOM314cy
2dBweYIVJoeXZqyJuzqxENYdyNPcHTyuywtEJ8KoacyHwk7803oSfDSzMSwrMBN7
QuPH3CO9rmeFXSk6zhsugK250SE0CZpjlux+rOKKK6SXeRwcNqBQuL8qv83vmgJw
ApX3NC7LI+btSVcfkQKFb14h1gHwNXeP/c2xOujvFefNeqhVb+TBHegac9JszzNm
zihH6pVn3xloJeCKuU0Hgo2htSbSCnnzZ24zDqx7JHMlND0kpe7dMn9vIjIMOys=
=VnTT
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
