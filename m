From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 7/7] dmaengine: intel-mid-dma: remove the driver
Date: Mon, 9 Mar 2015 18:11:51 +0000
Message-ID: <20150309181151.GN28806@sirena.org.uk>
References: <1425912531-23457-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425912531-23457-8-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m8RPluiNA7RIyL8J"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425912531-23457-8-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--m8RPluiNA7RIyL8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 04:48:51PM +0200, Andy Shevchenko wrote:
> Since the last and the only user of this driver is converted to use dw_dm=
ac we
> can remove driver from the tree.
>=20
> Moreover, besides the driver is unmaintained a long time, it serves for t=
he
> DesignWare DMA IP, for which we have already driver in the tree.
>=20
> Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied everything except this one, thanks.  I'm OK with applying this
if Vinod is - Vinod?

--m8RPluiNA7RIyL8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eJmAAoJECTWi3JdVIfQ/24H/i4aJtceGfzD2pY7zSkwq2rb
Gq+1whajgVGBn6mXWyHzO7j6SaXKdDKbFayUgc6bHryMS8lfv87AZb+nRUaFo5bs
Hqi7JHzKw5FjZH7kDngCWQKO7OYxvX+gR7gpA2cojq9fFoIMlcr6bXrdSQZTg5Qu
s+Qhy1nWQGCYaQPgZZEisK86yOiComqx3ZDF3qLS9lvLqEF2NAjo254uKJ7d6QXt
+KG370HHRXPJTTx0VW9ku+yUgrb3efiip5pfdubwJUv4qpTFdBUYKN0HETD0gt3i
vIGujGoAfvp65jt+/uUs0+07GWldfs6Cnh+fih9HNGeSgCKPtH+NJ3/lAPSlcKE=
=Iqlj
-----END PGP SIGNATURE-----

--m8RPluiNA7RIyL8J--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
