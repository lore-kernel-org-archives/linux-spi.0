From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Fri, 10 May 2019 18:53:25 +0000
Message-ID: <BYAPR12MB3398D946FDD0E5406B23EB50C20C0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
 <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190506044425.GN14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506044425.GN14916@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Mon, Apr 29, 2019 at 10:02:46PM +0000, Sowjanya Komatineni wrote:
>=20
> Please fix your mail client to word wrap within paragraphs at something s=
ubstantially less than 80 columns.  Doing this makes your messages much eas=
ier to read and reply to.
>=20
> > > On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > > > This patch exports spi_set_cs of the spi core to allow SPI masters=
=20
> > > > to use when gpio based chip select is needed.
>
> > > This isn't really what I meant when I said it'd be good to use the=20
> > > core GPIO code - this function doesn't do a huge amount really and=20
> > > the usage of it in your subsequent patch for the > driver isn't=20
> > > exactly joined up with the little it does (which is mainly swapping=20
> > > in the GPIO chip select instead of the hardware chip select) isn't=20
> > > used in your driver usage of this as far as I can see.  The bulk of=20
> > > the chip select handling code in the core is actually in
> > > transfer_one_message() which your driver doesn't use as it's got=20
> > > it's own implementation of that; I've not looked in enough detail to=
=20
> > > figure out if it could use it.
>
> > In SPI Tegra driver, we wanted to have GPIO based CS control when=20
> > cs-gpios is specified in parallel to HW/SW CS. Having parallel GPIO=20
> > based CS is to mimic some of the timing stuff that's needed for some=20
> > spi devices by not actually using HW CS on platform but only for SPI=20
> > HW design logic inside the chip.
>
> > Tegra spi driver don't use set_cs callback so looking into spi_set_cs=20
> > from spi core implementation when cs-gpios property is used it exactly=
=20
> > the same that is needed for GPIO control CS. So used this in V3.
>
> > Can you please provide more details on what you are suggesting?
> > Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs=20
> > and instead implement in tegra SPI driver using GPIO descriptors ?
>
> You're probably best open coding in the driver if there's value in using =
the hardware chip select.

Sorry, Just to be clear on my understanding of your suggestion,

3 ways of CS control implementation is needed for Tegra SPI
- SW CS thru SPI Controller
- HW CS thru SPI Controller
- Direct GPIO based CS control=20

Patch Series includes both HW CS and also direct GPIO based CS.

Regarding direct GPIO based CS, I understood you prefer to use GPIO descrip=
tors.
I see SPI core set_cs API also uses GPIO descriptor for direct GPIO control=
 of CS.=20

Tegra SPI driver need parallel implementation of direct gpio based cs to hw=
/sw based
CS control thru SPI controller.
Since SPI core set_cs already has implementation using gpio descriptors, in=
 V3 I am using
the same API.

Any concerns for using set_cs API from SPI core as it already does direct g=
pio based cs using
Descriptors?

Thanks
Sowjanya


=20
