From: Julien Boibessot <julien.boibessot-GANU6spQydw@public.gmane.org>
Subject: Re: SPI: Add SPI driver for most known i.MX SoCs
Date: Tue, 02 Jun 2009 10:13:22 +0200
Message-ID: <4A24DF22.4040601@free.fr>
References: <20090504214307.GN15603@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090504214307.GN15603-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Sascha,

I finally had some time to test your new unified SPI driver on my i.MX27 =

platform...
It's a good idea to have a common SPI driver for all MXs but I have two =

remarks:

Sascha Hauer a =E9crit :
> While there already is a SPI driver for i.MX1 in the tree there are
> good reasons to replace it:
>
> - The inkernel driver implements a full blown SPI driver, but
>   the hardware can be fully supported using a bitbang driver.
>   This greatly reduces the size and complexity of the driver.
>   =

I don't know yet if it's related to bitbang but I would say that your =

driver is 2x slowier that current inkernel one. We (armadeus) have i.MXL =

and i.MX27 boards with ADC, Touchscreen and CAN bus on SPI and saw a =

lost of performance with your driver (when fast successive SPI transfers =

are needed). You probably won't notice it if you only have a Freescale's =

power chip or an EEPROM connected to your SPI bus.

Sorry but I didn't had time yet to investigate more :-(.

I know that I can't have the official Linux kernel suited for my =

particular needs (;-) ), so what would be the things to do to improve =

your driver performances ?
> - The DMA API of the durrent driver is broken for arch-mx1 (as opposed
>   to arch-imx) and nobody cared to fix it yet.
>   =

Will your driver use DMA in a near future ?

Regards,
Julien

---------------------------------------------------------------------------=
---
OpenSolaris 2009.06 is a cutting edge operating system for enterprises =

looking to deploy the next generation of Solaris that includes the latest =

innovations from Sun and the OpenSource community. Download a copy and =

enjoy capabilities such as Networking, Storage and Virtualization. =

Go to: http://p.sf.net/sfu/opensolaris-get
