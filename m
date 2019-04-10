From: Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: RE: [LINUX PATCH v2] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 11:34:54 +0000
Message-ID: <MWHPR02MB26238A8F658DED8B3B32A5CAAF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20190410103106.GE6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410103106.GE6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, April 10, 2019 4:01 PM
> To: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Cc: yuehaibing@huawei.com; vigneshr@ti.com; linux-kernel@vger.kernel.org;=
 linux-
> spi@vger.kernel.org; Michal Simek <michals@xilinx.com>; nagasuresh12@gmai=
l.com
> Subject: Re: [LINUX PATCH v2] spi: spi-mem: Fix build error without CONFI=
G_SPI_MEM
>=20
> On Wed, Apr 10, 2019 at 11:14:45AM +0530, Naga Sureshkumar Relli wrote:
> > When building with CONFIG_SPI_MEM is not set gc warns this:
> >
> > drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> > spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_=
supports_op'
> >
> > Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI
> > controller")
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > Signed-off-by: Naga Sureshkumar Relli
> > <naga.sureshkumar.relli@xilinx.com>
>=20
> Why is there a signed off by for YueHaibing here?  Did they write the pat=
ch (in which case the
> authorship is incorrect)?
Yes, YueHaibing has wrote this patch.
I will update the Author name.

>=20
> You've also got an extra blank line between the Fixes and the rest of the=
 tags which is unusual
> and might confuse some tools.
Ok I will remove that extra line.

Thanks,
Naga Sureshkumar Relli
