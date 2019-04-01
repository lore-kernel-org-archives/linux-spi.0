From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Date: Mon, 1 Apr 2019 17:59:57 +0000
Message-ID: <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
 <20190401073723.GH2059@sirena.org.uk>
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
In-Reply-To: <20190401073723.GH2059@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:40PM -0700, Sowjanya Komatineni wrote:
> > This patch adds below cs timing properties to allow SPI master=20
> > configuring setup, hold and time interval between two SPI transactions=
=20
> > to meet specific SPI client device requirements.
> >  CS setup time
> >  CS hold time
> >  CS inactive delay
> > DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dnvidia.=
com; s=3Dn1;
> > 	t=3D1553666253; bh=3DTbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=3D;
> > 	h=3DX-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> > 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> > 	 Content-Type;
> > 	b=3DTud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
> > 	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO
>
> Something got corrupted?

Possible. Will re-send anyway with your feedback fixes.

> > +spi-client device controller properties:
> > +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> > +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> > +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock=20
> > +between
> > +  transfers.
>
> Why are these being done as nVidia specific properties rather than generi=
c ones and why are these being configured in DT rather than by the client d=
river?  If the devices have particular timing requirements for chip select =
presumably that's going to apply no matter what controller or system they'r=
e used with so it seems best to configure this in the client driver and hav=
e an API that any controller can implement.

These are implemented thru DT as Tegra SPI is master and master controls th=
e timing.
Some SPI slaves have specific requirements of certain CS setup/hold time an=
d inactive cycles which SPI master should meet when driving during transfer=
 and Tegra SPI controller supports tuning these parameters.
