From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Move checking chip_select for SC18IS602
 to sc18is602_setup
Date: Tue, 11 Feb 2014 17:04:07 +0000
Message-ID: <20140211170407.GT13533@sirena.org.uk>
References: <1392123257.1351.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZEZlOQeSr/zV9d3"
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392123257.1351.9.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VZEZlOQeSr/zV9d3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2014 at 08:54:17PM +0800, Axel Lin wrote:
> So it will be checked when spi device is added onto the spi bus.
> spi_add_device() calls spi_setup() which then calls spi->master->setup().
> No need to check it every time sc18is602_transfer_one() is called.

Applied, thanks.

--VZEZlOQeSr/zV9d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+lgEAAoJELSic+t+oim926cP/2N2OBqQp+4xnjK0t+oBfERO
9IBGp/1/Bt1Ti9ySDntiEwydr9Z1k2Ip4CgrBvOLC9R20c8xxh7UHfSPzkaU+BsA
wUJ8e6CcuWg3fvLs9IqwxItNBv8oZPbx2qzHJJK7TOoEf5yAVzVZ2GCRqa9sw3Wv
4d3LYj6lcUTlnQmLUlqouLHI/teKvk9R10LHuIIdfXCDMZr0lCiJUzLFzSwFO9TD
M9b4v3ifYWgVsEUKW+uaqOv5gtIgcnSi5sJUyDN2ylntr5HNIyMwmLsNpSGhhSLU
aySfVXjyGu9n3mqExosmEhaerFqm0Azno03GrQAdgeN+yy/aMyAtv5j4Ekgea1tS
vv0fP3uDznr/UsxgPtVIeHDsaJ8ne1fBp7VLX6r91UcfjNBi1jiajZTEycA3d/zd
kwpgfkQtlJX36/jvxu8bxY6LQXWBKow7JnDpP3ZjWv/2OEMclP0siQutj6VcNc9j
4Z1MZYilqTQzXa297tBSs5SSxSAwMYLY8rCa2nlfRxF2OXQT0dZl4clIa+tjE1/y
oQGBicekwgbHfO2DXYTEUA18xHfpwxTVNBtJmtqxUaUAVGJYpTfivIwBj9zpfjeb
bzDBm6j6irPNm3e1+3q99KwWg8cmNY6ZhFFRtjovczUvaEgEncbOtLBZND4z1pPr
R03CO1jV2Ut4fhOBKl7S
=xbAs
-----END PGP SIGNATURE-----

--VZEZlOQeSr/zV9d3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
