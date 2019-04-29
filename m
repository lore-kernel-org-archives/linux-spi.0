From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date: Mon, 29 Apr 2019 22:02:46 +0000
Message-ID: <BYAPR12MB3398D133D1C71355BC530754C2390@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
 <20190419151823.GS2803@sirena.org.uk>
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
In-Reply-To: <20190419151823.GS2803@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> > This patch exports spi_set_cs of the spi core to allow SPI masters to=20
> > use when gpio based chip select is needed.
>
> This isn't really what I meant when I said it'd be good to use the core G=
PIO code - this function doesn't do a huge amount really and the usage of i=
t in your subsequent patch for the > driver isn't exactly joined up with th=
e little it does (which is mainly swapping in the GPIO chip select instead =
of the hardware chip select) isn't used in your driver usage of this as far=
 as I can see.  The bulk of the chip select handling code in the core is ac=
tually in transfer_one_message() which your driver doesn't use as it's got =
it's own implementation of that; I've not looked in enough detail to figure=
 out if it could use it.
>
>
>
In SPI Tegra driver, we wanted to have GPIO based CS control when cs-gpios =
is specified in parallel to HW/SW CS. Having parallel GPIO based CS is to m=
imic some of the timing stuff that's needed for some spi devices by not act=
ually using HW CS on platform but only for SPI HW design logic inside the c=
hip.

Tegra spi driver don't use set_cs callback so looking into spi_set_cs from =
spi core implementation when cs-gpios property is used it exactly the same =
that is needed for GPIO control CS. So used this in V3.=20

Can you please provide more details on what you are suggesting?
Do you prefer not to use SPI core spi_set_cs and gpio_set_values APIs and i=
nstead implement in tegra SPI driver using GPIO descriptors ?

Thanks
Sowjanya
