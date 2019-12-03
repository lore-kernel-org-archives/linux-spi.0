From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Tue, 3 Dec 2019 16:35:21 +0000
Message-ID: <20191203163521.GM1998@sirena.org.uk>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7081898801320142191=="
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
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


--===============7081898801320142191==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zHDeOHGDnzKksZSU"
Content-Disposition: inline


--zHDeOHGDnzKksZSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2019 at 02:11:51PM +0000, Phil Elwell wrote:
> On 02/12/2019 13:43, Mark Brown wrote:
> > On Mon, Dec 02, 2019 at 12:10:11PM +0000, Phil Elwell wrote:

> > I
> > can't see anything in that change which sets the flag, can you be
> > more specific?

> bcm2835_spi_probe in spi-bcm2835.c sets ctrl->use_gpio_descriptors to true,
> and of_spi_parse_dt in spi.c includes the following:

> /*
>  * For descriptors associated with the device, polarity inversion is
>  * handled in the gpiolib, so all gpio chip selects are "active high"
>  * in the logical sense, the gpiolib will invert the line if need be.
>  */
> if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods &&
>     ctlr->cs_gpiods[spi->chip_select])
> 	spi->mode |= SPI_CS_HIGH;

Right, I see what you're saying now.

> > In general it's a bad idea to modify mode at runtime, and it's a
> > bad idea to mix multiple means of configuring the polarity of the
> > chip select (eg, mixing DT configuration with other means).

> Applications using spidev to implement user-space drivers need to be able to
> set SPI mode, CS polarity etc. at run time. I agree that there

I'm nervous of spidev user doing stuff like that with the chip
selects, with DT even spidev devices should be registered
normally, you will get a complaint if you register a raw spidev.
There's no free pass for "oh, spidev can do anything we don't
care" here - the DT should describe the hardware, if some of the
hardware happens to be implemented by spidev then fine.

That said we do have other in kernel users that do change modes
at runtime, though I'm not convinced many of them have GPIO chip
selects.  Linus?

> are many ways to set the polarity of a chip select, and it may be that
> too many are being used with GPIO CSs declared by DT, but I don't think that
> completely explains the connection between use_gpio_descriptors
> and the automatic setting of SPI_CS_HIGH.

That's the result of there being too many places where the
polarity of the chip select is set so the code is pushing to at
least only implement this in one place so things are clearer and
more consistent.

--zHDeOHGDnzKksZSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mjscACgkQJNaLcl1U
h9A5nAf+KL/EMG9AeIeRv8/4LbT1CbXUDlGeuE6JyVP6WkAZaVRqab2gbl4rUOAI
vuIKIOJ76vkvjOG9deGsO2N+rIRmXfKt+U0Nz1z92Qg4OjkAybQbiv0ObJU2C5QJ
HUoMtPJ4HlGgOoct0EXfz/MlwLC3CtXaAM9j6rwE+kZCfLAgJ2I4N6yK4H6/030Q
dw/Q+opbvHM2AFKfLPOCInDryDmQrwcstyPHmWKfsrkoJdyZ8QS1G9EydnQQIBYR
31IsXVzDWE8ziAuc5gF5+FN4/cBbdQxtcIHCx3mDVYcB3F6xEKDRPd0aDglAMP1J
51pDSdVPkHYzoUB7PiuvqGH9KtFr1w==
=h29l
-----END PGP SIGNATURE-----

--zHDeOHGDnzKksZSU--


--===============7081898801320142191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============7081898801320142191==--
