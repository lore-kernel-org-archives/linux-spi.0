From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V2 11/20] spi: expand mode support and add LSBYTE_FIRST
 mode
Date: Thu, 11 Apr 2019 19:58:33 +0000
Message-ID: <BYAPR12MB3398CC43DC1F78A10BC51DE8C22F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-11-git-send-email-skomatineni@nvidia.com>
 <20190408062819.GJ2803@sirena.org.uk>
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
In-Reply-To: <20190408062819.GJ2803@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Thu, Apr 04, 2019 at 05:14:10PM -0700, Sowjanya Komatineni wrote:
> > Some SPI Master controllers support configuring Least significant byte=
=20
> > first or Most significant byte first order for transfers. Also some=20
> > SPI slave devices expect bytes to be in Least significant first order=20
> > and some devices expect Most significant first order.
> >=20
> > SPI driver declares mode and mode_bits as u16 and all bits are used.
> >=20
> > This patch changes mode and mode_bits to be u32 to allow for more mode=
=20
> > configurations.
> >=20
> > This patch also creates SPI_LSBYTE_FIRST mode to allow SPI clients to=20
> > choose LSByte order or MSByte order through the device tree property=20
> > spi-lsbyte-first.
>
> Please submit one patch per change, each with a clear changelog, as cover=
ed in SubmittingPatches.  This makes it much easier to review things since =
it's easier to tell if the patch does what it was intended to do and means =
that if one part of the patch casues problems it won't hold up the other pa=
rts.

Hi Mark,
I split changes on SPI code side and SPI Tegra side as separate patches.
Do you meant to have both changes on SPI core and SPI Tegra together in a s=
ingle patch?

Thanks
Sowjanya
