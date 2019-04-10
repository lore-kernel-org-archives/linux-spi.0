From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Wed, 10 Apr 2019 13:56:12 +0100
Message-ID: <20190410125612.GR6106@sirena.org.uk>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
 <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--PPxI8paQBs33t8dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 02:51:36PM +0200, Flavio Suligoi wrote:
> With dw_dmac, sometimes the request of a DMA channel fails because
> the DMA driver is not ready, so an explicit dependency request
> is necessary.

While this isn't going to hurt anything and might actually help so it's
fine doesn't this also suggest that there's an issue with deferred probe
going on as well?

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt5+sACgkQJNaLcl1U
h9BN8Qf+M8pv+qvn+ML2aGV0KTB3Eifgjqx1GoYtmxwT6D/Qph4QE8YjFoBeIBBQ
gS73KJSjgLkRmqDTe7WHqxcqDAJIkry4MeeSPAAzfxInkaMih10aGTCNRsLZu7YT
1rysutG7WmictAhA2oxCrDOOayQgUM8dTTCpEsBAXyIGcavHVnjLgNJp4DEHSsZC
HaIOgTnzdbFdXYv/nBDp32uhVsYEmCiYJ+PEx6RY5HKpHauu+1S3qsZ5ccWuNKxp
I9jdvvjxTHA/IfR9fBZQZnj5uW8qxN7QHRAdEkV0P55KUrISQlHMdKqTT6nWXg2n
1HdFhz+hDYAVg3xb5DhsHPUIR+1Wog==
=LXu7
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--
