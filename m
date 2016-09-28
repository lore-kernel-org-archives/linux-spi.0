From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: pxa2xx: Add support for GPIO descriptor chip
 selects
Date: Wed, 28 Sep 2016 09:50:20 -0700
Message-ID: <20160928165020.ua46onz5oitv6qbj@sirena.org.uk>
References: <20160928130452.51831-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phmh2huzriszvxzg"
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160928130452.51831-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--phmh2huzriszvxzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2016 at 04:04:52PM +0300, Mika Westerberg wrote:
> The driver uses custom chip_info coming from platform data for chip selects
> implemented as GPIOs. If the system lacks board files setting up the
> platform data, it is not possible to use GPIOs as chip selects.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--phmh2huzriszvxzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6/TMAAoJECTWi3JdVIfQpNoH/2sTEIoKe6JYkZ0x/TyS50Hx
oJYa9JIyhpl8VbuzaHWhoKGxTF2V6DUmMeKOfIdgLKocS3eV1A80kRGbIdib6Kc2
rRG3IeaF4AARJbMndfyG6C6HFL7/LXGuEcAE4TuTWzvTwI2VU/t9cR7gLsEL8zyJ
CpQtSVu4+r1HGw20LmPsuUeJj46AOD1W5vM6mGlXLVwcK7wdY7uF4LR4d9QACCqH
MW7bBMXGQV0oZLBlYwomiY3u+FZPzdgM980/miSm78HfsyIA7RRLGhZBT8GY5bIJ
0WYshbZrt2WfUrbheiZdp5Ph9Zv1t3YjB+jMbIwLXcwo2MBMLcX+6JTQphWZBfw=
=ux2v
-----END PGP SIGNATURE-----

--phmh2huzriszvxzg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
