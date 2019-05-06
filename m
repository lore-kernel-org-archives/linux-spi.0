From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Mon, 6 May 2019 13:44:25 +0900
Message-ID: <20190506044425.GN14916@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UIkw8Cc2/Xz5YwHB"
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UIkw8Cc2/Xz5YwHB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > > This patch exports spi_set_cs of the spi core to allow SPI masters to=
=20
> > > use when gpio based chip select is needed.

> > This isn't really what I meant when I said it'd be good to use the
> > core GPIO code - this function doesn't do a huge amount really and
> > the usage of it in your subsequent patch for the > driver isn't
> > exactly joined up with the little it does (which is mainly swapping
> > in the GPIO chip select instead of the hardware chip select) isn't
> > used in your driver usage of this as far as I can see.  The bulk of
> > the chip select handling code in the core is actually in
> > transfer_one_message() which your driver doesn't use as it's got
> > it's own implementation of that; I've not looked in enough detail to
> > figure out if it could use it.

> In SPI Tegra driver, we wanted to have GPIO based CS control when
> cs-gpios is specified in parallel to HW/SW CS. Having parallel GPIO
> based CS is to mimic some of the timing stuff that's needed for some
> spi devices by not actually using HW CS on platform but only for SPI
> HW design logic inside the chip.

> Tegra spi driver don't use set_cs callback so looking into spi_set_cs
> from spi core implementation when cs-gpios property is used it exactly
> the same that is needed for GPIO control CS. So used this in V3.=20

> Can you please provide more details on what you are suggesting?
> Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs
> and instead implement in tegra SPI driver using GPIO descriptors ?

You're probably best open coding in the driver if there's value in using
the hardware chip select.

--UIkw8Cc2/Xz5YwHB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPu6YACgkQJNaLcl1U
h9DM0Qf7Bykvbj1t4ndVRPemN1ZjRrYC94F5FOwPPHuLYIIFawPR0xupsoIwdZPi
b9rbj7/L3dNBHHO+gjkDEQLYC++gMNJnL5bSo2AA8cz/qJhVqzMS0nu+F6Fgofup
jwo4IWbjxYPAJWqrjWFj6Y79h+cXTmu+lcOiEnHoEjuqjxNH5fWJXqLrDYe7irOJ
ST8QQXWtz2T1A9BfvWzZ56NFlieoOR+vKQFZZjwYzS7irq+F9LqT5Q/VKNQOvExL
SLu4ZnMlPuZQBkOxFqtr8yve31kkxhyFfUrvhKCBwAHKzg+dt3Aop+gkbwJCeEEJ
tuLSjnUOUENVdEKWAwHEj4DdEcXH7Q==
=C76I
-----END PGP SIGNATURE-----

--UIkw8Cc2/Xz5YwHB--
