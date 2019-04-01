From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1 18/26] spi: tegra114: add support for hw based cs
Date: Mon, 1 Apr 2019 18:40:36 +0000
Message-ID: <BYAPR12MB339817E7F593A70D3F9D3D7AC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-18-git-send-email-skomatineni@nvidia.com>
 <20190401074857.GK2059@sirena.org.uk>
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
In-Reply-To: <20190401074857.GK2059@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:39PM -0700, Sowjanya Komatineni wrote:
>=20
> > Tegra SPI driver default uses SW CS control for transfers and HW CS=20
> > control can be enabled through SPI client device node DT property=20
> > nvidia,enable-hw-based-cs and is used only for single transfers.
>
> Why have a property - if this feature works and is useful why would a sys=
tem ever not want to use it?

> > +	single_xfer =3D list_is_singular(&msg->transfers);
> >  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> >  		u32 cmd1;
> > =20
> >  		reinit_completion(&tspi->xfer_completion);
> > =20
> > -		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
> > +		cmd1 =3D tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
> > +						    single_xfer);
>
> It's not sufficient to check if there's only one transfer, you also need =
to make sure that the driver isn't using cs_change to use non-standard chip=
 select handling.

Yes we can avoid DT and force to use HW CS incase of all single transfers w=
ithout cs_change. Will update in next version.
