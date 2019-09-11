From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Date: Wed, 11 Sep 2019 11:47:21 +0100
Message-ID: <20190911104721.GX2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1795843313686695934=="
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1568187525.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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


--===============1795843313686695934==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sBvc846/5FzkyDmz"
Content-Disposition: inline


--sBvc846/5FzkyDmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 12:15:30PM +0200, Lukas Wunner wrote:
> Extend the BCM2835 SPI driver to handle simplex transfers internally,
> thereby reducing their latency and CPU usage and obviating the need to
> have the SPI core convert to full-duplex via SPI_CONTROLLER_MUST_TX/RX.

Whatever you're doing to send these is still not sending the
patches in order:

    779 N T 09/11 Lukas Wunner    (1.6K) [PATCH v2 00/10] Speed up SPI simp=
lex t
    780 N T 09/11 Lukas Wunner    (2.1K) =E2=94=9C=E2=94=80>[PATCH v2 02/10=
] dmaengine: bcm2835:
    781 N T 09/11 Lukas Wunner    (1.3K) =E2=94=9C=E2=94=80>[PATCH v2 01/10=
] dmaengine: bcm2835:
    782 N T 09/11 Lukas Wunner    (2.6K) =E2=94=9C=E2=94=80>[PATCH v2 03/10=
] spi: Guarantee cac

--sBvc846/5FzkyDmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl140LYACgkQJNaLcl1U
h9CJuAf40t7iOsCtCUCgOGIXB+YibWRckLCGnZaxx9lO8FpS02JKK8a1kZ7BzmBu
KUB9QEeaKj5mR76HSW9ptzpbLt2Dhgy92E9In/53UHZK8w7xCRzpngrLvLy/ngg9
BKxBDoUN5rANRRMIhK18StZ4TKHqviLnTyfFlFkchbmu9KH3bQpwV1v+t0Mv4TqS
rbeE860BfkVkR6iCMCt/vTlIi+XwRxoTVgjLUWPIphox2CzAYX0ChmRuuX+lXfz3
t1LJLptjNXavM3z03a/6EeLrgjIvTlc0EmXJNb2YpjSl4w2Lfhtiy8saxwuwXa1s
UIApc9MXI4DnImX3tQ8K1ZWo2qJq
=9QgI
-----END PGP SIGNATURE-----

--sBvc846/5FzkyDmz--


--===============1795843313686695934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============1795843313686695934==--
