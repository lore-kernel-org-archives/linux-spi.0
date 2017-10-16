From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Date: Mon, 16 Oct 2017 12:05:19 +0100
Message-ID: <20171016110519.gosljzrxy6dgvvjo@sirena.co.uk>
References: <20171016102758.22444-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vobztala3ev3lotw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171016102758.22444-1-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vobztala3ev3lotw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 16, 2017 at 12:27:58PM +0200, Lucas Stach wrote:
> On systems where some controllers get a dynamic ID assigned and some have
> a fixed number from DT, the current implemention might run into an IDR

Please don't resubmit patches that have already been applied, you should
submit patches against current code in the tree you're expecting things
to be applied to.  If any updates are needed to a patch that's already
been applied you should submit incremental patches which make those
updates.  This avoids having to change published git commits which could
cause problems for people working against git.

--vobztala3ev3lotw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnkkm8ACgkQJNaLcl1U
h9DIngf+Ku3aXUQwj5s6ZtAv4mPY4Z2S+QYOrPdUQ/cLjtqUGj2++cy3J9oTeofc
+Fzvoiv5+NSB97dOof9WvDca/RH2NYfqAmK4cKec5Py6ViKvPxnYvPGW5BiCThix
LzTKr+lQFSoUmdFSwHz86oz+LL2dhC9YvQC9Wxall69do3O936H+kHjempapzL0D
Tw2xs3vPZMKaxfk200o1hQ2VFAw3hQftoJrOqrYUoq76US42z3piKQi39xrw/VIt
mKKMXYIVDPYoMrXMsURWeh3w1jxbm7H7Yo8OBagNCAMp3CtOavw/jcVfRKXV4B/4
9YZOlU56wsBKsNLEh5swudkAaao8GQ==
=WIwr
-----END PGP SIGNATURE-----

--vobztala3ev3lotw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
