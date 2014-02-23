From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: Replace msleep with usleep_range to get more
 accurate sleep time
Date: Sun, 23 Feb 2014 13:40:55 +0900
Message-ID: <20140223044055.GJ25940@sirena.org.uk>
References: <1392945318.4125.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ivyoJkJAGKloOgd+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392945318.4125.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ivyoJkJAGKloOgd+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2014 at 09:15:18AM +0800, Axel Lin wrote:
> Fixes below checkpatch warning:
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> +               msleep(10);

Applied, thanks, though really we don't care how long the delay is.

--ivyoJkJAGKloOgd+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXvOAAoJELSic+t+oim9ExwP/RjJckBoaRx3XHSu3XZtmY8q
PXDxf5caHcmrf80iR1MVSNs0Txrc3lBd3X5+sLF88j6rzaO3cdHZLy1Zcifkg/98
oYWblq9MGv+MHGsQhKuwSeeheVyiZehZQV6CSDNbU4QcXDzzpaKuyqSIqJdKeFYO
zV4QcgBnYG8zXBbNDs4Zpyk5uJpODdOCf1CaqQ+jhSeEZ65SfjTAhtD8OmDujclY
9xDTP40zzsTftrCm1Uw+HIhAGqDBUTGr6uAhJqAWAg+okHT4ZfYXR0RfHBDtvgwx
kIpUTyh7X/jq1jq4ouluYjaCb4Yop3dajAvdR2tvaVhIyB/FzfwMzhKIuWm/K+8i
TbE5jnQ5qhufcUKtit+DF1ptQuNvUp7r9Rf2Is7bzrsJ1Ml2VHA87tokKuttLkgv
szg3Jr1VFUrmn2Nhrc72X3WP+5IWmYVHaIyW82eCqVVpShG92GoLzcEsxgw/SMAX
092493C6brZ2MKzWj7BkfbpWYBMwzPYGm/wIntZu12kGIns5gLegR3KO6gUUS5kq
JTcfnT9OuNVBI5y9FtGceUkdT6M2zuNCfrSdV6z+PLJscZ2dp3UT3AFeet8rvnBk
eAF3fqDbmxu6WlfUooc6p2tdsHcNqqhdlMe+TTtSZPSsh0Q0NjHDU6zuRMgA0HOp
JjgXsUaqFHiEtCMyy0kl
=RRuU
-----END PGP SIGNATURE-----

--ivyoJkJAGKloOgd+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
