From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 04/10] spi: bcm2835: Work around DONE bit erratum
Date: Wed, 11 Sep 2019 12:25:22 +0100
Message-ID: <20190911112522.GD2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
 <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8258217309464866912=="
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <7ceb98f154cdcf72c577615fa312df41adea5f47.1568187525.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============8258217309464866912==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qXCixuLMVvZDruUh"
Content-Disposition: inline


--qXCixuLMVvZDruUh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> Commit 3bd7f6589f67 ("spi: bcm2835: Overcome sglist entry length
> limitation") amended the BCM2835 SPI driver with support for DMA
> transfers whose buffers are not aligned to 4 bytes and require more than
> one sglist entry.

You said in the cover letter that this was at the start of the
series but it's actually patch 4 (or patch 3 in terms of the
order they were sent), and in any case it was already applied so
I'm not clear why you're resending it.  If there's any difference
=66rom the previous version please send an incremental fix for it
instead.

The entire series has arrived but it looks like this in my inbox:

    749 r T 09/11 Lukas Wunner    (1.6K) [PATCH v2 00/10] Speed up SPI simp=
lex t
    750 N T 09/11 Lukas Wunner    (4.0K) =E2=94=9C=E2=94=80>[PATCH v2 05/10=
] spi: bcm2835: Drop
    751 N T 09/11 Lukas Wunner    (3.5K) =E2=94=9C=E2=94=80>[PATCH v2 09/10=
] dmaengine: bcm2835:
    752 N T 09/11 Lukas Wunner    (3.6K) =E2=94=9C=E2=94=80>[PATCH v2 04/10=
] spi: bcm2835: Work
    753 N T 09/11 Lukas Wunner    ( 17K) =E2=94=9C=E2=94=80>[PATCH v2 07/10=
] spi: bcm2835: Speed
    754 N T 09/11 Lukas Wunner    (5.2K) =E2=94=9C=E2=94=80>[PATCH v2 06/10=
] spi: bcm2835: Cache
    755 N T 09/11 Lukas Wunner    (2.1K) =E2=94=9C=E2=94=80>[PATCH v2 02/10=
] dmaengine: bcm2835:
    756 N T 09/11 Lukas Wunner    (1.3K) =E2=94=9C=E2=94=80>[PATCH v2 01/10=
] dmaengine: bcm2835:
    757 N T 09/11 Lukas Wunner    (2.6K) =E2=94=9C=E2=94=80>[PATCH v2 03/10=
] spi: Guarantee cach
    758 N T 09/11 Lukas Wunner    (1.1K) =E2=94=9C=E2=94=80>[PATCH v2 08/10=
] dmaengine: bcm2835:
    759 N T 09/11 Lukas Wunner    (8.6K) =E2=94=94=E2=94=80>[PATCH v2 10/10=
] spi: bcm2835: Speed

which is really not good, the random ordering you're using when
you send things means that it's a hassle to even figure out that
I've got the entire series.  Please look into what you're doing
here, other people's patch serieses don't have this problem so
there must be something unusual with your tooling.

--qXCixuLMVvZDruUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl142aEACgkQJNaLcl1U
h9DfPAf+OYtqXMV5gYBzU4XTKR08XD1PV2nI4GT7e675+/MifpQk2bPDDqVQYYQw
lysfjslqQAmGX8aHnoyaPPIyiGkT1aCUG7j8DdqgWPdXPRoGWNnknhVc7Lwko5+v
9nOxr3Zft3KmhKr50btHGengwyNJNlZlhvEi4nSmwKYyJLR8+nK3HmvIHew+yABM
DppyiPrwx7Q4JNKYPj3zS8rz8vUUp0mUpdYv2e377jLilQYuhlvvP8DfADc52zhN
S0dXlGpjChPSBfzK/nM8mP+l8txFax/ERE/g7w9APK1gAJ/HUhniJp13Q1PFTNF3
AWYr1YSUDj94ktqrczb+BgyDd4YrrA==
=h6tk
-----END PGP SIGNATURE-----

--qXCixuLMVvZDruUh--


--===============8258217309464866912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============8258217309464866912==--
