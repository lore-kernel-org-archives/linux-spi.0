From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/16] spi: txx9: Use transfer speed unconditionally
Date: Wed, 16 Sep 2015 20:52:37 +0100
Message-ID: <20150916195237.GS12027@sirena.org.uk>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mCHMtb9bRkCkp66g"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mCHMtb9bRkCkp66g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 04:26:13PM +0300, Jarkko Nikula wrote:
> SPI core validates the transfer speed and defaults to spi->max_speed_hz in
> case the transfer speed is not set.

Please don't send large collections of unrelated changes as a single
series - this isn't one change done to a lot of drivers, this is a bunch
of unrelated changes.  Having things grouped into a patch series affects
how they get handled and reviewed, if this is misleading it can get in
the way (eg, not reading patches after one that has problems).

--mCHMtb9bRkCkp66g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+ciEAAoJECTWi3JdVIfQRSEH/0qZv4yiyOg98wTPEa/h8RDH
PuP25zLxxpnyzCGRv5G+gpuVh9fixFW7UPPfkOlhI2KqPidF5dNVyiLJr51WZZp6
M2PzkOUjFKA3eclQWRl/WX3SnCE4In0Df/vkEoDkDEAKvVp/3KJNRpc34luUnSk4
qJAUKYntEk18ogtF8xii3IKF7ej2K69vRxlVrUi4LkPpTfRUs1iRSXLIfQ+n4E20
5jIwCrNMjvM+6qWey1lUNh3Ffv81eWP8Q7Jth9FfPIPlt3VHVXG5OsXnHEDzQmna
tNCRhxLsw+MlKXDRllPbB7yaXUA/+OEK7N+wu73hyDwhqtuTo5pzGs8zOWWsMWE=
=QV4S
-----END PGP SIGNATURE-----

--mCHMtb9bRkCkp66g--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
