From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] spi: dw: Add compatible string for Renesas RZ/N1 SPI
 Controller
Date: Sun, 15 Sep 2019 12:22:42 +0100
Message-ID: <20190915112242.GA43855@sirena.co.uk>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568376720-7402-4-git-send-email-gareth.williams.jx@renesas.com>
 <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeJY44oqYPhb-E8U1Uz5tKEJ1wZfmsGYEDttLzypHEAHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 15, 2019 at 02:00:33PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2019 at 3:14 PM Gareth Williams

> > The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI, but has
> > additional registers for software CS control and DMA. This patch does not
> > address the changes required for DMA support, it simply adds the compatible
> > string. The CS registers are not needed as Linux can use gpios for the CS
> > signals.

> > +       { .compatible = "renesas,rzn1-spi", },

> Can't you simple use in DT something like
>   compatible = "renesas,rzn1-spi", "snps,dw-apb-ssi"
> ?

Yes, you can and should do that but it's still nice to list the
compatibles explicitly in the driver in case someone leaves out the
fallback compatible for whatever reason - if both the driver and the DT
list things then there's a bit more robustness.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+HwIACgkQJNaLcl1U
h9AfuQf5AVfP2aLgb/wagBnPhqQNepUFArGUV9VrZqyKZbaEveqGp42TXTaWp4Z4
F5vjPMGkBHfhHJoKWyJZiFnNaimOHVvH2MxsVxdxckvF5MDWShZO7xtKHGAqkwmv
JGXJRWaSkVPW1WQ7rYXLLTqXYyhIYASbl1YNjymHxgw/aEr9Zn2XoxihmgeiLANg
K990BsukJHIcY7n15boVvb15IqTiB2W51exwDyTHw5SMQ4zEt8IXexDn8meqZKzs
x4qQeZKni+Y0Lykk9c6+Y7Sixf+P8XUjVaVW1jCjBWkmB9ebBnb6o4oSzhlHP4SC
F8eS11Hqa8IvR+5S+AZLRgDTXVBYCQ==
=BDOI
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
