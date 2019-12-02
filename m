From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Mon, 2 Dec 2019 13:43:44 +0000
Message-ID: <20191202134344.GE1998@sirena.org.uk>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2670281508208146092=="
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <db6a1e17-49a3-e3ed-7713-56b7763713d6-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
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


--===============2670281508208146092==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 12:10:11PM +0000, Phil Elwell wrote:

> A relatively recent patch [1] to the spi-bcm2835 driver modified it to use
> GPIO descriptors for chip select handling. A side effect of this change is
> to set the SPI_MODE_CS_HIGH flag for devices connected to the controller,
> which seems strange since it happens for devices that require the usual
> active-low chip select.

I take it you mean SPI_CS_HIGH rather than SPI_MODE_CS_HIGH?  I
can't see anything in that change which sets the flag, can you be
more specific?  The change no longer acts on SPI_CS_HIGH when
requesting the GPIO but I can't see anything which *sets* the
flag.  It does not visbily modify mode at all, nor did the
original code.

> This change came to light when a user reported that the SPI-Py library
> (a client of the spidev driver) wasn't working on 5.4, which was traced to
> it overwriting the SPI mode flags when it was only trying to set the
> CPHA and CPOL flags. This had the affect of inverting the chip select
> line, with the obvious consequences. That corruption of the flags is clearly
> an error, but what if the application and library were genuinely trying to
> specify that the attached device required an active-high chip select? Would
> it now require that they _clear_ the CS_HIGH flag?

I can't follow what you're saying here at all, sorry.  Can you
please be more specific?  You appear to be saying that the issue
is that the application modified the mode in some way and this
was acted on apparently not in the expected way.

In general it's a bad idea to modify mode at runtime, and it's a
bad idea to mix multiple means of configuring the polarity of the
chip select (eg, mixing DT configuration with other means).

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3lFRAACgkQJNaLcl1U
h9CrIQf9HCV/qWHL5/pcqPbHvmYpq/QkLXAmASYand7ZtsEI0XEYuxucc50dZx8i
imfB3jXgeXcp7u4Thj5YhmeTbO5EcFvWodHnx2o8Iu/bd/1n2U6TJez8kaL2e+To
YNjaCe5KiMX/xzcfnupzihe2g46+eSRZpaY3NW2Xcg+8/AVlhCJQPbnj2+mLAVl5
xnL12QOJt566I0rBkKQCOjIWyTVDc90hPdC9HAoj197Abc29dKNTiYhQ9sQ4Vfj1
o5rf4YX4dJv6rGJZNAoCyxFya1QWIdZud0W1SRR8qi4m5uVgsdy4pRZHB2MuR9GG
gQs2hewoUsvDdSr4UYUee5NwattvYA==
=JZaa
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--


--===============2670281508208146092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============2670281508208146092==--
