From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: davinci: Initialize dspi->done before any possible use of it
Date: Tue, 12 Dec 2017 10:16:30 +0000
Message-ID: <20171212101630.GB16323@sirena.org.uk>
References: <20171212101048.28278-1-michele.dionisio@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michele Dionisio <michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212101048.28278-1-michele.dionisio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 11:10:47AM +0100, Michele Dionisio wrote:

> On SOC with multiple cpu (like omal l138) it is possible that spi periferic is already initialized when this module is loaded and it is possible to recieve interrupt when the modules is not sully initialized.

Please include descriptions of what your patches are doing like this one
in the changelog of the patch as covered in SubmittingPatches.

Please also fix your mail client to word wrap within paragraphs at
something substantially less than 80 columns.  Doing this makes your
messages much easier to read and reply to.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlovrH0ACgkQJNaLcl1U
h9BoDAf+PFhkgYaJOWs33dRtBv/kj+mkRvlPohQlXzpabfUkL9OgCa4ru9C2QlXj
O/o602Ykk/szGKo0uuxZmD4e/d1hQwxi+XLttQ88MSKUCm5A/jV9zWwt30Q02Zof
ZTkVsvP2IhgQ3xD+smKVyLeZU4GIrWoP/sq/PtBd7LppaG4984lEALSe0IHsiphx
Nay1HxycGgPhhh7/AYV/DPFGJBVjk62R2opRInVMMGe0YyvirkHk/LAXyfhkNPPv
y4dhRQITxOBkRxNhJy6mAwmIcFVmrwwoYvm8wyiFbNJkl+4E6kED8S5wTloHKCv8
qYk1b6WCFWGKwXkxY1dlgyfqf3srxw==
=sFpH
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
