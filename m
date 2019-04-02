From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Date: Tue, 2 Apr 2019 11:52:01 +0700
Message-ID: <20190402045200.GS2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
 <20190401073723.GH2059@sirena.org.uk>
 <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xUq7mlTLx96rFlBf"
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
In-Reply-To: <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xUq7mlTLx96rFlBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 05:59:57PM +0000, Sowjanya Komatineni wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > > +spi-client device controller properties:
> > > +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> > > +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> > > +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock=20
> > > +between
> > > +  transfers.

> > Why are these being done as nVidia specific properties rather than
> > generic ones and why are these being configured in DT rather than by
> > the client driver?  If the devices have particular timing
> > requirements for chip select presumably that's going to apply no
> > matter what controller or system they're used with so it seems best
> > to configure this in the client driver and have an API that any
> > controller can implement.

> These are implemented thru DT as Tegra SPI is master and master controls =
the timing.
> Some SPI slaves have specific requirements of certain CS setup/hold time =
and inactive cycles which SPI master should meet when driving during transf=
er and Tegra SPI controller supports tuning these parameters.

This doesn't address the issue at all, obviously the timings for the SPI
bus are going to be impelemented by the controller but that's not the
issue.

--xUq7mlTLx96rFlBf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi6nAACgkQJNaLcl1U
h9DYhwf/cafHrRWzRugYSCrehLshbVA+er54g9/ZcsiAAz4d1eXY5krepBIVxNRW
ekTXpqsXiu7eCEOlOZw4CHzJ/mf5dbJPdE9Y6MadhP8U+wqSHK7s8OD4cXOeq2qq
+s9vk5zpFmq4UMsoxFGM0IPRkU2C8dylcgDZndYLHaYowRGEMCfTJXGljfHDR6OQ
2IQ8Gv8lG88TNPlteORHsICEcukqJ9P0VPfuszoEbIF+vTwp73e0wJZHnVMAVC//
C9s8e9swMavIef92Aq4WSo9xCBHT6RqDlgOASZoGkQhcIzSMDSTOfTF76kxmOOhb
l5c2qXXcuzBH5bEgAv8G+knbRa3hoQ==
=K2T2
-----END PGP SIGNATURE-----

--xUq7mlTLx96rFlBf--
