From: Naga Sureshkumar Relli <nagasure@xilinx.com>
Subject: RE: linux-next: Tree for Apr 9 (spi/spi-zynq-qspi.c)
Date: Wed, 10 Apr 2019 05:46:54 +0000
Message-ID: <MWHPR02MB2623DDF884FD2DAA9C4B7C40AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20190409180042.15bb90b6@canb.auug.org.au>
 <4c933ec6-0247-5820-dfc2-326a5bc6b227@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
To: Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c933ec6-0247-5820-dfc2-326a5bc6b227@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Randy,

I have sent the patch on top of the patch sent by yuehaibing@huawei.com.

Thanks,
Naga Sureshkumar Relli

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Tuesday, April 9, 2019 8:52 PM
> To: Stephen Rothwell <sfr@canb.auug.org.au>; Linux Next Mailing List <lin=
ux-
> next@vger.kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Naga Suresh=
kumar Relli
> <nagasure@xilinx.com>; Michal Simek <michals@xilinx.com>; linux-spi <linu=
x-
> spi@vger.kernel.org>
> Subject: Re: linux-next: Tree for Apr 9 (spi/spi-zynq-qspi.c)
>=20
> On 4/9/19 1:00 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190408:
> >
>=20
> on x86_64:
>=20
> ld: drivers/spi/spi-zynq-qspi.o: in function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x185): undefined reference to `spi_mem_default_su=
pports_op'
>=20
>=20
> Full randconfig file is attached.
>=20
> --
> ~Randy
