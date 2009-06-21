From: Julien Boibessot <julien.boibessot-GANU6spQydw@public.gmane.org>
Subject: Re: SPI: Add SPI driver for most known i.MX SoCs
Date: Sun, 21 Jun 2009 15:10:21 +0200
Message-ID: <4A3E313D.8020008@free.fr>
References: <20090504214307.GN15603@pengutronix.de> <4A24DF22.4040601@free.fr>
	<20090602172259.GB32355@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090602172259.GB32355-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Sascha Hauer a =E9crit :
> On Tue, Jun 02, 2009 at 10:13:22AM +0200, Julien Boibessot wrote:
>   =

>> I don't know yet if it's related to bitbang but I would say that your  =

>> driver is 2x slowier that current inkernel one.
>>     =

>
> Have you checked that the driver gets the baudrate correct? If it is
> maybe my driver produces more interrupts than the in kernel driver.
> Maybe you could produce a defined workload with both drivers and compare
> the outputs of /proc/interrupts afterwards.
>   =

Clock seems ok. The problem is the "setup" time between 2 transfers.
We use an ADC (MAX1027) from which we try to get the data as fast as =

possible (successive SPI read transfers of 16 bytes) and the time =

between 2 transfers was quite doubled when switching to your new driver.

I will try to spend more time to check that after the summer holidays ;-).

Regards,
Julien

---------------------------------------------------------------------------=
---
Are you an open source citizen? Join us for the Open Source Bridge conferen=
ce!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $2=
50.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.=
org
