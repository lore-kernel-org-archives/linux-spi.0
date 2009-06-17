From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: Add SPI driver for most
	known i.MX SoCs
Date: Wed, 17 Jun 2009 20:12:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906172010400.4218@axis700.grange>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-2-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1245235220-23816-3-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 17 Jun 2009, Sascha Hauer wrote:

> v2: Updated and tested on i.MX35
> 
> While there already is a SPI driver for i.MX1 in the tree there are
> good reasons to replace it:
> 
> - The inkernel driver implements a full blown SPI driver, but
>   the hardware can be fully supported using a bitbang driver.
>   This greatly reduces the size and complexity of the driver.
> - The inkernel driver only works on i.MX1 SoCs. Unfortunately
>   Freescale decided to randomly mix the register bits for each
>   new SoC, This is quite hard to handle with the current driver
>   since it has register accesses in many places.
> - The DMA API of the durrent driver is broken for arch-mx1 (as opposed
>   to arch-imx) and nobody cared to fix it yet.
> 
> This driver has been tested on i.MX1/i.MX27/i.MX35 with an AT25 type
> EEPROM and on i.MX27/i.MX31 with a Freescale MC13783 PMIC.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Tested-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

on a i.MX31 with a DAC124S085.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
