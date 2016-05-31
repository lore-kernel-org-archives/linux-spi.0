From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Tue, 31 May 2016 14:08:28 +0100
Message-ID: <20160531130828.GB29837@sirena.org.uk>
References: <574D5C2B.1000400@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SHFFXbs3XlGSDX14"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <574D5C2B.1000400-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SHFFXbs3XlGSDX14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 05:40:59PM +0800, Chris Ruehl wrote:
> Hi,
>=20
> as imx6 using multiple burst to send data to spi slaves and drop the
> chipselect between the words by default my sensor NXP MPL115A1 wasn't
> working.

Please submit patches in the format covered in SubmittingPatches, I
can't take anything without a Signed-off-by.

--SHFFXbs3XlGSDX14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTYzLAAoJECTWi3JdVIfQ048H/Az05G4N7cFrBn/7fFYgO73d
+HZ5Rmi6FN2YjGWF9pO7pOjVrCHXCqM6gPOmbjP02aYB4v1Nj6AujZ6bz+9I/dHb
b2Bm8r20DyDT66kyuRrPBnSu9XI6zIyBnKCm6bM1ZejbI2myR/jb+GrUk85K21jv
zjhNkvQE3I/5nkeIoSQ7bKKyJ2fXjycCy5fhIHppjGp5SjDo19LKf/HW9ip1vSg+
KECZCNLlD4evJXf146CVtHMN8KoUahNAb8IYF/nUmWaD0n9jV++kZsN2anL1XBUs
XXq9dbI0eUY3z2mxDE4h4UYkbz+cPLITRZWW576/43iOnOX+Pm1I8FiPNT6SqBo=
=NjYc
-----END PGP SIGNATURE-----

--SHFFXbs3XlGSDX14--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
