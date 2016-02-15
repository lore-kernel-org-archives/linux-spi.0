From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for
 Designware SPI driver
Date: Mon, 15 Feb 2016 17:44:38 +0000
Message-ID: <20160215174438.GR18988@sirena.org.uk>
References: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
 <20160205110900.GA12311@sirena.org.uk>
 <56C04962.7080206@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Cc: linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com,
	haifeng.wei@huawei.com, charles.chenxin@huawei.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: Jiang Qiu <qiujiang@huawei.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C04962.7080206@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2016 at 05:31:14PM +0800, Jiang Qiu wrote:
> =E5=9C=A8 2016/2/5 19:09, Mark Brown =E5=86=99=E9=81=93:
> >On Fri, Feb 05, 2016 at 03:11:20PM +0800, qiujiang wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.  Your mail has lines wrapped alternately at
normal length and half length which is difficult to read, I've reflowed
this time.

> >>+	char propname[32];

> >That's a magic number, where did it come from and why is it a magic
> >nummber?

> I'm sorry for here without any comments. This number define is come from
> gpiolib.c. It means the max size of gpio property name. The reference code
> located in line 1815 of gpiolib.c.

That really isn't helping here.  The problem is that you've got a random
magic number thrown in here with no documentation.

> >I'm not seeing anywhere where we store the GPIO in this loop.  It is
> >therefore unclear to me how the chip select is going to work?

> In DT binding, of_get_named_gpio and devm_gpio_request were used to
> parse gpio pins defined in DTs and then request these pins. Similarly,
> for ACPI, devm_gpiod_get can do that two operation in a single
> function. It is a unified interface to ACPI and DT binding.

> If the gpiod is valid, the corresponding gpio pins has been requested.
> We do not need to save this gpiod any more.

No, that makes no sense at all.  If we're requesting a GPIO to use as
chip select we can't just then ignore the GPIO, we need to control it at
some point and...

> which gpio pin was used is defined in spi_device, named cs_gpio, the
> configuration to the gpio pins will be done in the setup callback
> routine of each device. What the spi master should do is just request
> these pins to the gpio subsystem.

=2E..this would be a complete failure of abstraction - you appear to be
suggesting that the client devices should also separately request the
GPIOs and set them up.  That's at best going to be redundant and is
likely to introduce bugs.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwg6FAAoJECTWi3JdVIfQClAH/jcwz+KMQc5oMHgGB6kfiTT6
JDlWD7jzbG3FCzOlm8KBc1iuoLkSkL34D0PqO8hVOT1UcQFXkkwz9ahKJy4MN4H4
YV/mcZgoINXfh9VwjAvLJ9Oqywb3KoknF1TA/CSvtVm9a/MkJmkwQiUWxWqAP83p
1JVWwJCNQSe/jE5mic59Nw0tUChcJ1cRBU3blrRRxdE85RrMm+V5rb2tUVcz1dsW
jU0FgB9nz+jkqCFUEO971ApC+y42wIySR3fR/muPK0qOZUZirS52IBhtsS0j7ODd
fprNGs/W/aHM/+DUBslXTFZ++sUv0tWyzFkSBcNp6Nx8MNQ8n9oEBkvzG7Cfcog=
=LkdD
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
