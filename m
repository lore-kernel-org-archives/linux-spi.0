From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] spi: add transfer_status() callback
Date: Tue, 17 Jan 2017 19:18:02 +0000
Message-ID: <20170117191802.cgbpnksly4vxamvu@sirena.org.uk>
References: <20170103172015.13052-1-hauke@hauke-m.de>
 <20170103172015.13052-2-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5ier5tlkwe657kyv"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170103172015.13052-2-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5ier5tlkwe657kyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 06:20:14PM +0100, Hauke Mehrtens wrote:
> This callback allows a driver to return the status of the SPI transfer
> which was asynchronously scheduled by transfer_one().
>=20
> Currently a call to spi_finalize_current_transfer() will mark the
> transfer as transferred successfully. To return an error it is only
> possible to not call spi_finalize_current_transfer() at all and let
> this time out and result in a timeout error. With this callback the
> driver gets asked about the status of the last transfer.

There's already an interface for that - set the status in the message
before notifying completion.

> In the Lantiq driver I want to use this to circumvent a strange
> hardware design in addition.

That's a separate thing...

--5ier5tlkwe657kyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh+bekACgkQJNaLcl1U
h9Dn/Qf+MWrjX5OpFWydlC2G6R200DQGZkwIitT+e7Cqa0NfuQ+WA/4kusOuXLPX
OPF1l7c9ubusRBkmhC0mw8+rc+C91tnfKohtfsDpWAJCiBdxv15403iUkd7LfnLx
cR77Vhk6rOAmy+CCg5Z1d9HVo1gG8wwxyPFkx+qszXx8ARr+VbY9xQFzdhCFsueR
IaoFkP8ou66v6T2rJr36hxFd+nTcScwjOISx5BI7v0oz+o/pJdFdjfHv/VKr+1CO
nG9drJaso5BlEhxmsGxJ6tsc0fgH4FSVV5EUEjyFNTImvwK5pmxRCQ84tCZqyVyH
3/wKPYQU9jNFELW/s3iMqneOjPE/nQ==
=5E8/
-----END PGP SIGNATURE-----

--5ier5tlkwe657kyv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
