From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: Fix memory leak
Date: Tue, 1 Apr 2014 13:31:48 +0100
Message-ID: <20140401123148.GV2269@sirena.org.uk>
References: <1396168977.21905.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ecnwpyCrI1qOzEAD"
Cc: Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396168977.21905.6.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ecnwpyCrI1qOzEAD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 30, 2014 at 04:42:57PM +0800, Axel Lin wrote:
> mpc8xxx_spi_probe() has set master->cleanup = mpc8xxx_spi_cleanup,
> however current code overrides the setting in fsl_spi_probe() and set
> master->cleanup = fsl_spi_cleanup.
> Thus the memory allocated for cs is not freed anywhere.
> Convert to use devm_kzalloc to fix the memory leak.

Applied, thanks.

--ecnwpyCrI1qOzEAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOrGxAAoJELSic+t+oim9fdcP/RRiRE4adzaVtz1iWerqDX3/
f4dGbnlHIpsg0HTa7WBSArPL1u0gEVad4U98HXgJPmVNj4bifYouw+H2YZJSPnVz
9g9nj1JdFX26LXZyJC7OeGm06tjJ0pkJGmi0HGDqlRPlVV9FoiS3co4B0hWpQWLw
3aJm+j93w2VC9HWcuLEa6nN4Vv2aP3FnGhh4VZANjeZzG3myGmpQpwefOMHpXE+H
IeGQMnYwYMyMApC6mVELf/+LLd69gJfg7vww3IqbE1BNE6vUIytCAaSrp6FNb389
LqLkw5PezZ9cMOOcbp6KsufsXJTkZBu8HnS+i0YZYk4heLlKkZ9ldxd6ML3uyxdd
u9EhSikEReh8wpB3az7DY96kzmPsFRVDFTdueazXnyaBfdMRv3Gz3iDBg4SwIC0K
x0L91VmYZJ19n7oFPHjQU1vgsvuK4Y46fBXGU6EAT+BVOKwZbO77Xssw2tiqBb3b
EQRfsQBFGV2P0zfq7WCEJb18/nC1+FmXofp9+Cmi3yO6fHJe7QNLL59h2pGaiBxB
o0YXblGylPg4TwT/nBck+G7ZG/9Eqk0Fx3/TpkhpL7s7ufFEpgbs5EjXG0PGZ055
iosirP5aSqjWndCQaMWNp5YYMi0XvE8V/VFq5xY+na96WRkqpJi4gV5/TBS2xAA/
Ugr/Tu9QWHsNRl5ATQAj
=xfTS
-----END PGP SIGNATURE-----

--ecnwpyCrI1qOzEAD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
