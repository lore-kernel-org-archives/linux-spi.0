From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Date: Mon, 1 Apr 2019 18:07:45 +0000
Message-ID: <BYAPR12MB33984E9D0FA76FCC77FD72BFC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
 <20190401074940.GL2059@sirena.org.uk>
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
In-Reply-To: <20190401074940.GL2059@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


> On Tue, Mar 26, 2019 at 10:56:45PM -0700, Sowjanya Komatineni wrote:
> > With SW CS, during transfer completion CS is de-asserted by writing=20
> > the default command1 register value to SPI_COMMAND1 register. With=20
> > this both mode and CS state are set at the same time and if current=20
> > transfer mode is different to default SPI mode and if mode change=20
> > happens prior to CS de-assert, clock polarity can change while CS is=20
> > active before transfer finishes.
>
> This is a bug fix so I'd expect it to be much earlier in the series befor=
e any of the new features.

Thanks Mark. Will change order as per your feedback in next version of patc=
h series.

I see you have applied some patches in V1 series so should I re-send again =
those as well along with feedback changes in next version or just only the =
patches that are not applied.
