From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: rcar: Use devm_spi_register_master()
Date: Mon, 9 Dec 2013 18:00:11 +0000
Message-ID: <20131209180011.GN29268@sirena.org.uk>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
 <002e01cef0af$9e0a6ef0$da1f4cd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qqPjTi0+PkGx+WSu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Laurent Pinchart' <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002e01cef0af$9e0a6ef0$da1f4cd0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qqPjTi0+PkGx+WSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 04, 2013 at 02:13:50PM +0900, Jingoo Han wrote:
> Use devm_spi_register_master() to make cleanup paths simpler.

Applied, thanks.

--qqPjTi0+PkGx+WSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpgUoAAoJELSic+t+oim9SkwP/RvyKVCMgB8yICsUe2vDvC4t
K65nQGyjEzvbebI66/4PAsNOrvodLmUJ6A5ml3qP2VbJTao1PPHczmrZZv+JZnrf
C/hpZjW5aeF3EKNXN418CkqUpYOHUB/T6S+tKLiN+UgrX6SQzL3Q6rfT6fNOKOMN
yAIs029AE2O8aFAWESySdHdVlQ/knUgOhvirVzpmfw31KD0bwjARU7+gh2ZibHOS
wHF4wjLKVf1Jic8AwbZ788b6hGPhEGnvPv9yfouQrf/N6Ml2Cu1+yp3aI0s440uG
3lPpN85RDHRczLfznpU1zfomY32DEysKQtJUkmWUAMXKhFf+JOFbEm53+NuDIs5g
+MuZmMKl0Y5Pr221nlsRhiv8HYzW2DsWJ3VYGpFU3jUe8i8LIQoaNOLhCxv7uTDB
OvRceQMxmvqpgO0JltMr53F1kkD3gbRM6ah6W+ClL5zcvcLhnY8nvdjtrSHWSHA/
wm4wFBZZ4U/o5zzLBZuAfj2/pUxSDBxxIzXy/06CwQUh69l4yy3dt6gozrwOGYrA
jXlEAsDJsGCcYN+ISQOGEMViH7fs17722zY6xpZxOYW5KBAAXdhA0Pu0gWPDeKIt
7zHHnGtOE12OlQATxdn1UZE+EUsxkxACykQ5loZMGxAC3OSXKnoMQidkywHCU9T+
SidFmWue9BLTuYqaf3mQ
=nrL6
-----END PGP SIGNATURE-----

--qqPjTi0+PkGx+WSu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
