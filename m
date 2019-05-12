From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Sun, 12 May 2019 12:12:42 +0900
Message-ID: <20190512031242.GB21483@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190506044425.GN14916@sirena.org.uk>
 <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
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
In-Reply-To: <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2019 at 06:53:25PM +0000, Sowjanya Komatineni wrote:
> > On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:

To reiterate:

> > Please fix your mail client to word wrap within paragraphs at
> > something substantially less than 80 columns.  Doing this makes your
> > messages much easier to read and reply to.

> Any concerns for using set_cs API from SPI core as it already does direct gpio based cs using
> Descriptors?

Yes, that is precisely what I'm telling you not to do.  That function
doesn't do enough to make it worth exporting and the code that uses it
assumes it's managing the chip select entirely, adding a single other
use will make things fragile as it will mean that there's a chance
someone will change what the core is doing without taking into account
the different things that the Tegra code is doing.  Either let the core
handle chip select entirely or open code it.

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzXjykACgkQJNaLcl1U
h9CdDwf/RMwk8JveODVogg3LW+9FdUslYiuSh/72+FYAjmKk28dm3H328PpA/y2c
ZytPr8GyaF0vI4dbOhl7xFeHSJvb3FSmZxYUrD0f5kWkPjMI/SB2Z2hCZFdnONMm
wssyJ+3Q7dS4fOCmSOg11yn8c02PAzP5R+G2Vqdt/tKH+hj2ItKxghQI10qGL78K
AtAYMCzLlUNJ1QgWeg3cAfNZZlGTQoOuRCx6hvklNTgwxk6ED2aKF2FV4Jw2AxI0
n89eG0UOGQeI0KmPSc8GOUduj/0vUITd0qSWVNOtvirNf1rV6gu6mMZIclPiLPjp
kPI1Fp72G4ZAFyfGuleOFW2K6uDZVA==
=qEfj
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
