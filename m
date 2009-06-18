From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: Add SPI driver for most
	known i.MX SoCs
Date: Thu, 18 Jun 2009 10:30:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906181028120.5779@axis700.grange>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-2-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-3-git-send-email-s.hauer@pengutronix.de>
	<Pine.LNX.4.64.0906172010400.4218@axis700.grange>
	<4A39F255.2090301@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Julien Boibessot <julien.boibessot-GANU6spQydw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4A39F255.2090301-GANU6spQydw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 18 Jun 2009, Julien Boibessot wrote:

> Hi Guennadi,
> =

> Guennadi Liakhovetski a =E9crit :
> > On Wed, 17 Jun 2009, Sascha Hauer wrote:
> >   =

> > > This driver has been tested on i.MX1/i.MX27/i.MX35 with an AT25 type
> > > EEPROM and on i.MX27/i.MX31 with a Freescale MC13783 PMIC.
> > > =

> > > Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > >     =

> > =

> > Tested-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > =

> > on a i.MX31 with a DAC124S085.
> >   =

> Which maximum sampling speed can you achieve with this new SPI driver ?

Is "sampling speed" at all applicable to a DAC? If you mean at which rate =

I could output values, then I did not and could not measure it due to a =

hardware bug on my system.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
