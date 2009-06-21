From: Julien Boibessot <julien.boibessot-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: Add SPI driver for most
	known i.MX SoCs
Date: Sun, 21 Jun 2009 14:59:32 +0200
Message-ID: <4A3E2EB4.90806@free.fr>
References: <1245235220-23816-1-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-2-git-send-email-s.hauer@pengutronix.de>
	<1245235220-23816-3-git-send-email-s.hauer@pengutronix.de>
	<Pine.LNX.4.64.0906172010400.4218@axis700.grange>
	<4A39F255.2090301@free.fr>
	<Pine.LNX.4.64.0906181028120.5779@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0906181028120.5779-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Guennadi Liakhovetski a =E9crit :
> On Thu, 18 Jun 2009, Julien Boibessot wrote:
>
>   =

>>> Tested-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
>>>
>>> on a i.MX31 with a DAC124S085.
>>>   =

>>>       =

>> Which maximum sampling speed can you achieve with this new SPI driver ?
>>     =

>
> Is "sampling speed" at all applicable to a DAC? =

Oups... sorry I thought it was an ADC.
> If you mean at which rate =

> I could output values, then I did not and could not measure it due to a =

> hardware bug on my system.
>   =

ok. Let me know when it's working again.

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
