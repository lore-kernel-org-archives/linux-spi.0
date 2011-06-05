From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 13:13:28 +0530
Message-ID: <BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110605071725.26517.11573.stgit@ponder>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 5, 2011 at 12:48 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> [repost: I had a typo on the spi-devel-general mailing list address]
>
> Sort the SPI makefile and enforce the naming convention spi_*.c for
> spi drivers.
>
> This change also rolls the contents of atmel_spi.h into the .c file
> since there is only one user of that particular include file.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> =C2=A0drivers/spi/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 80 ++++++++-----------
> =C2=A0drivers/spi/atmel_spi.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0167=
 ---------------------------------------
> =C2=A0drivers/spi/spi_ath79.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_atmel.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0155=
 ++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/spi/spi_au1550.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_coldfire_qspi.c | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_davinci.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_dw.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A02
> =C2=A0drivers/spi/spi_dw.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_dw_mid.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02
> =C2=A0drivers/spi/spi_dw_mmio.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02
> =C2=A0drivers/spi/spi_dw_pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A02
> =C2=A0drivers/spi/spi_ep93xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_mpc512x_psc.c =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_mpc52xx.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_mpc52xx_psc.c =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_omap2_mcspi.c =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_omap_100k.c =C2=A0 =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_omap_uwire.c =C2=A0 =C2=A0| =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_orion.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_pl022.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_pxa2xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_pxa2xx_pci.c =C2=A0 =C2=A0| =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_ti_ssp.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A00
> =C2=A0drivers/spi/spi_tle62x0.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A00
> =C2=A0drivers/spi/spi_xilinx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A00

Though the spi_ prefix seems redundant considering the files are in
'spi' directory.
Just a thought, no objection.
