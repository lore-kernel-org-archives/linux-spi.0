From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/10] Speed up SPI simplex transfers on Raspberry Pi
Date: Wed, 11 Sep 2019 12:59:28 +0100
Message-ID: <20190911115928.GE2036@sirena.org.uk>
References: <cover.1568187525.git.lukas@wunner.de>
 <20190911104721.GX2036@sirena.org.uk>
 <20190911114352.w2htkzfi5v6zl7nq@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6031579073418001077=="
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190911114352.w2htkzfi5v6zl7nq-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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


--===============6031579073418001077==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Content-Disposition: inline


--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2019 at 01:43:52PM +0200, Lukas Wunner wrote:

> I use "git format-patch --thread=shallow", then use a Perl script
> to change the Date: header and send out the raw messages with msmtp.

Sounds like your perl script could just be git send-email?

> I suspect the incorrect order may be because all messages use the
> same Date: header and you're using "sort_aux=date-sent" in Mutt.

or that the messages are getting reordered in transit by the
intervening MTAs and it's falling back on delivery order lacking
any other information.

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl144Z0ACgkQJNaLcl1U
h9CiGgf+IZkFNPyHBjwAVwbah4Xor1XYDP/HVn9fnXlcm4hxeMSuYkCdimjnkwFy
NBEgTw0samr7jvJtNwoU8GIOuntj2nbkPyQRTRktAfUX7hwXoPnWXyo6CKmBlGKY
kL1CZhQa62BVgS8p8a/0e9q4oE4hUo/7zTqNrNw11kMcIA1SSs+h6dtWtT65RidS
YZsY4IJclh+qZpnERxE9ceRCOuviz7bIEcGz8H0ZA7/nftR+9va8vjmYgwjnW0ir
5pel+Me4nixf0+fYorS97DvGGq2puMhUfwwajDAaFYa6shsNjea2EbBho5BpqIH5
JBsy+0Z93PeNmUEGgvfprEGmbnpxxw==
=CdYe
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--


--===============6031579073418001077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============6031579073418001077==--
