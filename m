From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 08:37:00 -0600
Message-ID: <BANLkTin93sqhJ1hmefv0AqgEZvSEQYFiMg@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder> <20110605081331.GA3499@acer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110605081331.GA3499@acer>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 5, 2011 at 2:13 AM, Mika Westerberg <mika.westerberg@iki.fi=
> wrote:
> On Sun, Jun 05, 2011 at 01:18:14AM -0600, Grant Likely wrote:
>> [repost: I had a typo on the spi-devel-general mailing list address]
>>
>> Sort the SPI makefile and enforce the naming convention spi_*.c for
>> spi drivers.
>>
>> This change also rolls the contents of atmel_spi.h into the .c file
>> since there is only one user of that particular include file.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 80 ++++++++----=
-------
>> =A0drivers/spi/atmel_spi.h =A0 =A0 =A0 =A0 | =A0167 ----------------=
-----------------------
>> =A0drivers/spi/spi_ath79.c =A0 =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_atmel.c =A0 =A0 =A0 =A0 | =A0155 ++++++++++++++++=
++++++++++++++++++++
>> =A0drivers/spi/spi_au1550.c =A0 =A0 =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_coldfire_qspi.c | =A0 =A00
>> =A0drivers/spi/spi_davinci.c =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_dw.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02
>> =A0drivers/spi/spi_dw.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_dw_mid.c =A0 =A0 =A0 =A0| =A0 =A02
>> =A0drivers/spi/spi_dw_mmio.c =A0 =A0 =A0 | =A0 =A02
>> =A0drivers/spi/spi_dw_pci.c =A0 =A0 =A0 =A0| =A0 =A02
>> =A0drivers/spi/spi_ep93xx.c =A0 =A0 =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_mpc512x_psc.c =A0 | =A0 =A00
>> =A0drivers/spi/spi_mpc52xx.c =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_mpc52xx_psc.c =A0 | =A0 =A00
>> =A0drivers/spi/spi_omap2_mcspi.c =A0 | =A0 =A00
>> =A0drivers/spi/spi_omap_100k.c =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_omap_uwire.c =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_orion.c =A0 =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_pl022.c =A0 =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_pxa2xx.c =A0 =A0 =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_pxa2xx_pci.c =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_ti_ssp.c =A0 =A0 =A0 =A0| =A0 =A00
>> =A0drivers/spi/spi_tle62x0.c =A0 =A0 =A0 | =A0 =A00
>> =A0drivers/spi/spi_xilinx.c =A0 =A0 =A0 =A0| =A0 =A00
>> =A026 files changed, 192 insertions(+), 218 deletions(-)
>> =A0delete mode 100644 drivers/spi/atmel_spi.h
>> =A0rename drivers/spi/{ath79_spi.c =3D> spi_ath79.c} (100%)
>> =A0rename drivers/spi/{atmel_spi.c =3D> spi_atmel.c} (85%)
>> =A0rename drivers/spi/{au1550_spi.c =3D> spi_au1550.c} (100%)
>> =A0rename drivers/spi/{coldfire_qspi.c =3D> spi_coldfire_qspi.c} (10=
0%)
>> =A0rename drivers/spi/{davinci_spi.c =3D> spi_davinci.c} (100%)
>> =A0rename drivers/spi/{dw_spi.c =3D> spi_dw.c} (99%)
>> =A0rename drivers/spi/{dw_spi.h =3D> spi_dw.h} (100%)
>> =A0rename drivers/spi/{dw_spi_mid.c =3D> spi_dw_mid.c} (99%)
>> =A0rename drivers/spi/{dw_spi_mmio.c =3D> spi_dw_mmio.c} (99%)
>> =A0rename drivers/spi/{dw_spi_pci.c =3D> spi_dw_pci.c} (99%)
>> =A0rename drivers/spi/{ep93xx_spi.c =3D> spi_ep93xx.c} (100%)
>> =A0rename drivers/spi/{mpc512x_psc_spi.c =3D> spi_mpc512x_psc.c} (10=
0%)
>> =A0rename drivers/spi/{mpc52xx_spi.c =3D> spi_mpc52xx.c} (100%)
>> =A0rename drivers/spi/{mpc52xx_psc_spi.c =3D> spi_mpc52xx_psc.c} (10=
0%)
>> =A0rename drivers/spi/{omap2_mcspi.c =3D> spi_omap2_mcspi.c} (100%)
>> =A0rename drivers/spi/{omap_spi_100k.c =3D> spi_omap_100k.c} (100%)
>> =A0rename drivers/spi/{omap_uwire.c =3D> spi_omap_uwire.c} (100%)
>> =A0rename drivers/spi/{orion_spi.c =3D> spi_orion.c} (100%)
>> =A0rename drivers/spi/{amba-pl022.c =3D> spi_pl022.c} (100%)
>> =A0rename drivers/spi/{pxa2xx_spi.c =3D> spi_pxa2xx.c} (100%)
>> =A0rename drivers/spi/{pxa2xx_spi_pci.c =3D> spi_pxa2xx_pci.c} (100%=
)
>> =A0rename drivers/spi/{ti-ssp-spi.c =3D> spi_ti_ssp.c} (100%)
>> =A0rename drivers/spi/{tle62x0.c =3D> spi_tle62x0.c} (100%)
>> =A0rename drivers/spi/{xilinx_spi.c =3D> spi_xilinx.c} (100%)
>
> We also have things like this in drivers/spi/Kconfig:
>
> config SPI_DAVINCI
> =A0 =A0 =A0 =A0...
>
> =A0 =A0 =A0 =A0This driver can also be built as a module. The module =
will
> =A0 =A0 =A0 =A0be called davinci_spi <--- This is now wrong
>
> should these be converted as well?

yes.

g.
