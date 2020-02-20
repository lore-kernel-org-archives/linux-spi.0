From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] trivial fixes for fsl-spi and spidev
Date: Thu, 20 Feb 2020 16:47:52 +0000
Message-ID: <20200220164752.GC3926@sirena.org.uk>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pk6IbRAofICFmK5e"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Igor Opanyuk <igor.opanyuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200220141143.3902922-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:11:46PM +0000, Oleksandr Suvorov wrote:

> Oleksandr Suvorov (2):
>   spi: fsl-lpspi: remove unneeded array
>   spi: spidev: fix a max speed setting

Please don't merge unrelated changes into a patch series, at best it's
confusing at worst it can result in unrelated patches holding each other
up.

--Pk6IbRAofICFmK5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OuDcACgkQJNaLcl1U
h9B54wf8ChnpYtAo6GZoBiIyPR6xHM0A2f44wKWo1bk/+lN39rm75kZ2Y4c1iypV
stZLFnvLr6TnHyWlkj9oVczi+RkqaNQw7aksUnJPCi6fQkIl/2Cc9VwD1ur0Af5u
Oj+pZtQRnOsLkUdQY9rVSd8KRD1bJK8m2p30FpaHSv3Zj/TYvEwl9hoH6MEq6uuL
dbvWSiiIi0OArO1WEniGx0nOiwSYP6GMWLZXCy3vjp0QxLYc636VT2IkOuRdAwDf
CE4uRGHjmvry4CeZx2m0vus18GmiqMQwML+Q2QNFiu3wTb2tTYxbtBCmN6QMT2p+
6EEKD76g9d03RuDF5bsYmcHfCZWaJg==
=znQo
-----END PGP SIGNATURE-----

--Pk6IbRAofICFmK5e--
