From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Sun, 22 Nov 2015 13:19:02 +0000
Message-ID: <20151122131902.GO26072@sirena.org.uk>
References: <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk>
 <56507B3B.4080608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AKkMM/tm2Mk6Yn/s"
Cc: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56507B3B.4080608-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AKkMM/tm2Mk6Yn/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 21, 2015 at 03:10:03PM +0100, Heiner Kallweit wrote:

> As you say this visibility of the master structure is unfortunate:
> What could be a (maybe long-term) better way to propagate restrictions
> that can't be handled transparently in the core like max message size
> and SPI NOR to protocol drivers?

The point is that the spi_master structure is not opaque to users (with
a consumer/provider split like modern APIs have).  We'd have to
reorganise the headers and provide accessors in the client API to handle
this.

--AKkMM/tm2Mk6Yn/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUcDFAAoJECTWi3JdVIfQfc0H/iEnvT/um+QY2bDzVv98FiPA
kAGO8kuESNm2aibpDS3TJ9aH9gHQhovuvQ32UnBI1PXyKXC4iV6eBYzfLI69KL+L
caCoz+MnNx+wy5PrKFpCdjAbrIxaKqMr8RtkBrBTvTtyVhWYyllPeAkQ+P0rLuCT
91nkngC5jlT4T9Yi9gdFossuhti9uiCScy5n+dv7yB/cTvZWt1Tcfz9Q2HEhHU6W
LBq4zdRlDr4yF2wNps1wKIe6yQ4DT4dlc4Ay8GMDY3KU2RwoylHVLl7C9xG2pUAu
RjQQGefILuOAmUVb05MVlBhWAIAuDP2nCCe1jM85TkteeMslxF0zD/Rxz6wJNj8=
=dH+2
-----END PGP SIGNATURE-----

--AKkMM/tm2Mk6Yn/s--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
