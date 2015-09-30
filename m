From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bitbang: switch to the generic implementation
 of transfer_one_message
Date: Wed, 30 Sep 2015 19:12:16 +0100
Message-ID: <20150930181216.GQ15635@sirena.org.uk>
References: <560AFF89.5000907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r/w8vo2lxBmCPGjQ"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <560AFF89.5000907-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--r/w8vo2lxBmCPGjQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 29, 2015 at 11:15:53PM +0200, Heiner Kallweit wrote:
> Change the bitbang driver to use the generic implementation of
> transfer_one_message. This simplifies the bitbang driver code and
> provides benefits like the statistics in the generic implementation.

Sorry, I actually have patch 1 but they weren't threaded together so got
separated by some other mail in my inbox.

--r/w8vo2lxBmCPGjQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDCX/AAoJECTWi3JdVIfQjtQH/RYv7/2Q41xwzVRYdJPWdP/3
FRUJpqU5GuDeSyvTEjZTJdEufQAViGaPjh9qXDhFbzjp8x1c6ZiftyV91sjVk5Ak
NZflbbGg88gXuaC5D8gUsIg1yr0M97W96Q6kyyBe6lcaMzz+O37Iapzk8SZXfx3A
lOrKkkZ3VOYCvf9BVDCZGFg+CLiTf7rVHnmh24K54vGaaEFTA2UIzwBjC7LlDHg6
Wvb0F35BtPWLaLGpFlvQJRvy4RzPXkmykgbUavWSBf4Yht540BIUoupzaFhfKX9t
MRcTj5ZvU57YdWdvYe9PWx4oGIKN7j6/968oHlHeMrpxMuzeo4p9DaLdF6upoWU=
=3+Vm
-----END PGP SIGNATURE-----

--r/w8vo2lxBmCPGjQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
