From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT][PATCH 1/2] spi: s3c24xx: Add missing
 spi_master_{resume,suspend} calls to PM callbacks
Date: Fri, 7 Mar 2014 13:59:41 +0800
Message-ID: <20140307055941.GD13126@sirena.org.uk>
References: <1394003843.18343.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWYTdRocNKEnFB5K"
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394003843.18343.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MWYTdRocNKEnFB5K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 03:17:23PM +0800, Axel Lin wrote:
> This is required since commit 2025172e3280 "spi/bitbang: Use core message pump".
> spi-bitbang now uses core message pump, so it needs to call spi_master_suspend/
> spi_master_resume to start/stop the queue while suspend/resume.

Applied, thanks.

--MWYTdRocNKEnFB5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGWBEAAoJELSic+t+oim99iAP/3xl73G2KwbTlgRnmVlShEfW
EeMK47kt3fEC/vfu8P0pKrlGzYGPZH6wTF1/zNigGngI+34pw8nGSKuiBTJ2+IFd
ahTL+FlKdhGiFy6afnvCkmDfDEKZNBG4eex8SpcaHsAAXFUXuZEV3kfS85BgQo0S
JCxRfj10NUvcGUO31Jxu1xh+3W4VpyYAZdkaQ5LLpHlL7VobAvdQIr6eqH/aInUA
l5bO5vjrYngn6UxUnZUDSjw+BWzU9SV9zb9k9rnrKFjmBaDqC+AAO+aIzEOXk1xk
ywu4zeqOecKFe/fdmJSY+DI2wmceb9kitj+jpgnIVH193H9kW1BQVIfOIrTJs+kB
ul0bT5EhReYQ5rLzpsHEciGakjZysft100920lnaEAMKBhryivwyxVlzrhELIcxj
De6L3wgeCevhdIEQ2g9O8UlTxcAzRSy5zWgemtX4drWojVJlUdYM+Pm8YWUmc874
hkHbEc03CRmhLuAOvwTSglxPwShrkAksAMOeTLXElE+E9CkeU4FsWtqS9wndN1Og
WLnIMVXLkuwZF90BXJdrWXQjDIcSG0UTUl5pcA3y+dcxQxzDbhx/iGVlAH4ilXjf
VWyoBmYEUjr8IZ3UtNsz8LstuYvOydomAnXeLYhThwMRCSeYi9P+Sc/uMMEdb1WC
XHZ5Im5JlRgLLJ0nKnIu
=SYCt
-----END PGP SIGNATURE-----

--MWYTdRocNKEnFB5K--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
