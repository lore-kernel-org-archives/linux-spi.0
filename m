From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] spi: s3c64xx: add device tree support
Date: Wed, 9 May 2012 15:32:00 +0100
Message-ID: <20120509143159.GU3955@opensource.wolfsonmicro.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
 <20120509090716.GC28702@sirena.org.uk>
 <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com,
	rob.herring@calxeda.com, grant.likely@secretlab.ca,
	jaswinder.singh@linaro.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 10:13:28PM +0800, Thomas Abraham wrote:
> On 9 May 2012 17:07, Mark Brown <broonie@opensource.wolfsonmicro.com> wro=
te:
> > On Wed, May 09, 2012 at 03:34:54AM +0530, Thomas Abraham wrote:

> >> +- gpios: The gpio specifier for clock, mosi and miso interface lines =
(in no
> >> + =A0particular order). The format of the gpio specifier depends on th=
e gpio
> >> + =A0controller.

> > This seems odd... =A0This isn't a bitbanging controller, and surely the
> > driver will need to know which signal is which? =A0I suspect this is
> > actually for pinmux rather than to identify the signals but that should
> > at least be made clear and really should be being done using the pinmux
> > API.

> The driver retrieves the list of gpio's that it is allowed to use. The
> gpio numbers for miso, mosi and clk are mandatory but the order in
> which they are specified is not important since the driver never needs
> to which gpio is which interface line. I agree the pinmux api should
> be used here, but the call to pinmux api would be a incremental change
> here, not changing the code this patch is adding.

I'd suggest just specifying the order - someone might want to use it
later for some reason and it's not really a hardship for someone to use
it.  Avoids any "how does that work?" questions like I had.

> >> + =A0- samsung,spi-cs-gpio: A gpio specifier that specifies the gpio l=
ine used as
> >> + =A0 =A0the slave select line by the spi controller. The format of th=
e gpio
> >> + =A0 =A0specifier depends on the gpio controller.

> > We should really have a binding for this at the SPI level (and ideally
> > some code to manage setting the GPIO too) - it's pretty common to use a
> > GPIO as /CS.

> The existing implementations vary in the way the nCS gpio lines are
> specified. For some controllers, the nCS gpio's are included in the
> spi device node whereas in this implementation, the nCS gpio is listed
> in the spi slave device node.

Yeah, I know.  I'm saying we should try to come up with a binding for
this that can be used by new SPI contollers going forward so things are
consistent.

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqn/VAAoJEBus8iNuMP3dIwgP/3KPY/u7tdmncacubX4YNq26
fkT53lEMXPD5GNuFpeifkemEmgW/yU7q4o8qYUvcxnYaoQ3kBY4UJ6Sphfj02GUY
+oEH4tTtKhrbxBXsZD7KNtlLNO2vZpv4zNxz7Zjp0iKbX0XGIpkSwerP0R7OFoLi
dCvkCXNt9YbZNmPaV5SvbXqhE5UbkmjJBzFjoF/I4/g2bUBkOz3cuAzax/iQqipZ
15j+7Ikt/1u19mN/qNm1rbdGgTKyv9u8cD0aAc2RbHkmHiB8QkQZEP8g9rmFDZYf
OcG9xY7Nn2+9yzKoV/xYR6yVHYSjGoNSvJR841zxOvI8qFgR8tc6kLA76JwNBild
A22jztub5Sc4p64UykJE0k61xTa876pA7XJjG4zrpvUoJN2KDXfPDIx8XsXomHua
Ab53pDVoZrhig1ZbeEjh6/hVbvw8hWWRiocuZX6dyPOaPh1vsUeDolrkN4uhFv4q
dfDwo2qIJVpUplYjjjiYY5JFoVUrA5EUwLrEz19S9OIRpm2gHAqki0C1UdmyanuW
pQLO65zd9YHnEYjzkZSqnXMcMgJ3mpCd0gi+9zPSjvP/AAK9TOm/3KK6Tt+t4oJy
JRmzfIG54US56HLAJbqLNak0CPVaCcTxhBTAI8Bycd1o/oRnebofhXwXU5fY60RR
ZghtrfNI4v8TpIaEE9bo
=4jZk
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--
