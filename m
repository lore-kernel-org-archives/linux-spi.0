From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [patch] spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
Date: Tue, 31 Mar 2015 09:49:57 +0100
Message-ID: <20150331084957.GJ2869@sirena.org.uk>
References: <20150330103040.GB27144@mwanda>
 <1427712912.14897.441.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6pbVDqbvGaUSA62x"
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427712912.14897.441.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6pbVDqbvGaUSA62x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 01:55:12PM +0300, Andy Shevchenko wrote:
> On Mon, 2015-03-30 at 13:30 +0300, Dan Carpenter wrote:

> > @@ -791,6 +791,7 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
> >  	switch (drv_data->ssp_type) {
> >  	case QUARK_X1000_SSP:
> >  		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
> > +		break;
> >  	default:
> >  		clk_div = ssp_get_clk_div(drv_data, rate);

> It would be nice to have a break here as well, but I think we also may
> change this to if-else-if construction.

No.  Using if/else chains is an antipattern - think what happens when a
new hardware variant needs slightly different handling again.

--6pbVDqbvGaUSA62x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGl+0AAoJECTWi3JdVIfQfVsH/0vwJKEXq+s3I+NEiMoJtPZl
q+8NZMRmdP/IIzHtAh7+i2VmM7AhKGWk9SUrmE96hbvQlYedtV82GaCVnOuyxGx2
GfpoPNwm8tuPlZjKyhegWZfUvsi1fu9DlPXm6Q/n3yNLCERNixTA1fvD3VMLoWCN
CokTV3UBRqwgH+wFqtzwt/u+42RvZ2f66lqICJ/HJvvbJklQg0i7FQ1hBCZzC3w0
JOuvNyiRmT63s/WR7AD4/wDNDvigH3rMOZxH1w452ckAxULP9bS2JEUI79yfhe0E
+VcWEWFVsadmBOhcy8+SCEYLABPA5/ZMvlw3KwYCOxB77ddcavpRvwWCwb7BMtQ=
=W4x0
-----END PGP SIGNATURE-----

--6pbVDqbvGaUSA62x--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
