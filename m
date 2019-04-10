From: Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: RE: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 12:30:37 +0000
Message-ID: <MWHPR02MB262352F3C89EB163AB1EC2B5AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
 <20190410122457.GP6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>
To: Mark Brown <broonie@kernel.org>, YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410122457.GP6106@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

> -----Original Message-----
> From: linux-spi-owner@vger.kernel.org <linux-spi-owner@vger.kernel.org> O=
n Behalf Of
> Mark Brown
> Sent: Wednesday, April 10, 2019 5:55 PM
> To: YueHaibing <yuehaibing@huawei.com>
> Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>; vigneshr@ti.com; linux-
> kernel@vger.kernel.org; linux-spi@vger.kernel.org; Michal Simek <michals@=
xilinx.com>;
> nagasuresh12@gmail.com
> Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without CONFI=
G_SPI_MEM
>=20
> On Wed, Apr 10, 2019 at 08:22:29PM +0800, YueHaibing wrote:
> > On 2019/4/10 19:57, Naga Sureshkumar Relli wrote:
>=20
> > > +static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
> > > +				 const struct spi_mem_op *op);
>=20
> > Here miss a Function body, right?
>=20
> Yeah, I'm surprised that builds...
Sorry, I tested with CONFIG_SPI_MEM enabled. It's my bad.

Regards,
Naga Sureshkumar Relli
