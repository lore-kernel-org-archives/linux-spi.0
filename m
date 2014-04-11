From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
Date: Fri, 11 Apr 2014 08:04:14 +0100
Message-ID: <20140411070414.GA9801@lee--X1>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
 <20140409213749.GH32070@ld-irv-0074>
 <20140410072509.GA24100@localhost>
 <20140410192902.GM32070@ld-irv-0074>
 <20140411003203.GC3837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace@gmail.com>,
	Huang Shijie <b32955@freescale.com>, angus.clark@st.com,
	Russel King <linux@arm.linux.org.uk>, broonie@linaro.org,
	dwmw2@infradead.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org, pekon@ti.com, sourav.poddar@ti.com,
	shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
To: Huang Shijie <shijie8@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140411003203.GC3837@localhost.localdomain>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 11 Apr 2014, Huang Shijie wrote:

> On Thu, Apr 10, 2014 at 12:29:02PM -0700, Brian Norris wrote:
> > > IMHO, we should create a patch or several patches to add the MTD_=
SPI_NOR
> > > to the defconfigs.
> >=20
> > Yeah, I think that's best.
> I will create a patch when i back to office.
> Or you can create it yourself.
>=20
> >=20
> > > > Also, I think m25p80.c is no longer a "self-contained MTD devic=
e driver"
> > > > and should be moved under drivers/mtd/spi-nor/.
> > > If we move the m25p80.c to the drivers/mtd/spi-nor/, we also need=
 to move
> > > other drivers too.
> >=20
> > Which ones? I think it only makes sense to move those that depend o=
n the
> > same core code (i.e., spi-nor.c), or have a close relation to it (s=
o
> > Lee's st_spi_fsm.c is a candidate).
>=20
> yes, i mean the st_spi_fsm.c and other drivers which will use the
> spi-nor core code in the future.

+1 - happy with this.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
