From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V3 3/9] spi: add SPI_LSBYTE_FIRST mode
Date: Sat, 27 Apr 2019 00:32:58 +0000
Message-ID: <BYAPR12MB33989D8DCEFCDE5DB76429E7C23F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-4-git-send-email-skomatineni@nvidia.com>
 <20190419152208.GT2803@sirena.org.uk>
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
In-Reply-To: <20190419152208.GT2803@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Mon, Apr 15, 2019 at 02:30:28PM -0700, Sowjanya Komatineni wrote:
> > Some SPI slaves expect bytes to be in least significant first order=20
> > and some expects most significant first oder.
> >=20
> > This patch adds support for requesting SPI master controllers for=20
> > least significant first order using SPI_LSBYTE_FIRST mode.
>
> This is byte ordering as opposed to bit ordering which the core already s=
upports.  Do you have any examples of devices that need this or is it just =
being added for completeness?  If devices are going to rely on this we prob=
ably need emulation > support in the core I guess given that this is a pret=
ty unusual controller feature.

Current upstream platforms have no specific device requirement but added th=
is feature as Tegra support it for specific requirements of some slaves.

[Changed mail client message format word wrap limit to 74 columns]

Thanks
Sowjanya
