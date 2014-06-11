From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: fix incorrect SW mode chipselect setting for
 BayTrail LPSS SPI
Date: Thu, 12 Jun 2014 00:42:12 +0100
Message-ID: <20140611234212.GR5099@sirena.org.uk>
References: <1402502222-19520-1-git-send-email-chiau.ee.chew@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kwyOAufsvjrbDa1R"
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chew Chiau Ee <chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402502222-19520-1-git-send-email-chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kwyOAufsvjrbDa1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 11, 2014 at 11:57:02PM +0800, Chew Chiau Ee wrote:

> It was observed that after module removal followed by insertion,
> the SW mode chipselect is not properly set. Thus causing transfer
> failure due to incorrect CS toggling.

> -	value &= ~SPI_CS_CONTROL_SW_MODE;
> +	orig = value &= ~SPI_CS_CONTROL_SW_MODE;
>  	writel(value, drv_data->ioaddr + offset + SPI_CS_CONTROL);
>  	value = readl(drv_data->ioaddr + offset + SPI_CS_CONTROL);
>  	if (value != orig) {

This is a *really* non-obvious fix, I'd have expected the original value
to be re-read from the hardware here rather than just tweaked, or at
least some comment explaining what's going on.  Possibly also saving to
a differently named temporary variable would do it but whatever I had to
go look at the context to figure out what was happening and even there I
was unclear.

--kwyOAufsvjrbDa1R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTmOlQAAoJELSic+t+oim9Wv8P/1Gz0KrR669OKT2VF81LbZY9
E4bFy442ARqHkro+hmUCOb+M2W5rah01S6e7GAzWlbWTnDoOQthFe3ei7t/yrhO3
hGTqvyx6Sca5vreAy7hAQ6YUFJAhI1XxydsrlzdjMXHnwGwvp36D/uRMrG0JUQ+e
TXiRfFZgRe2ezIsUa/R7rjaFGlCm0UBv3N5izVr2aifz5kvC1bqusx+XcmZDBuYu
ODpSKNvxerzcqVio+vtMgPoQlszmRbh5f2pupqlgcYTsU66zWRfz9SIrgJGEzUcN
Z1SKJAfQDb3LZUxO9YGlWYC0v6782Ol/FAnh2V3/9N0DxM0pgKb+ZhdTyCvF2/Fe
1KLyLLtk063149XJqATk5lt2Vbi2gvrPxDBq/gHZGdOcFqfL0zYbIyPZRzFmLLwc
Lnc0RR6hwzUZNdgXLkAQdcz6bY8zGOkVOgCJ436QSG14lJhtV4YZ/XkCogBBB9k6
XZjYp0WQKyCBGDe3NISSgbudvGrjfTg+bF4Bohx/69nWfFtU0v/dXLy/iSiESCdO
k4wUCKCJV1wqxoF6SXhzWdL8IYWcidArS9xKEYUh8ZbHqFCqzt09piNkccYaaKSy
a+OQJEl4hm7AgBGf1vcT9GCiDZzfOujAm3jamRqHUuEVYEpmTp8m7jBRS/1DrSAD
g4AoojhZtsg5mf0uaEuQ
=tqR6
-----END PGP SIGNATURE-----

--kwyOAufsvjrbDa1R--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
