From: Hu Mingkai-B21284 <B21284-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Fri, 8 Oct 2010 10:13:08 +0800
Message-ID: <73839B4A0818E747864426270AC332C3057F6134@zmy16exm20.fsl.freescale.net>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Gala Kumar-B11780 <B11780-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Zang Roy-R61911 <R61911-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <841976.76219.qm-g47maUHHHF8HBU+L9ui1Svu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
> Sent: Thursday, September 30, 2010 6:46 PM
> To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org; spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; lin=
ux-
> mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Hu Mingkai-B21284
> Cc: Gala Kumar-B11780; Zang Roy-R61911; Hu Mingkai-B21284
> Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page=
 by
> page
> =

> =

> --- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> =

> > From: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read page
> > by page
> =

> NAK.
> =

> We went over this before.
> =

> =A0 The bug is in your SPI master controller driver, and the fix there in=
volves
> mapping large reads  into multiple smaller reads.=A0 (Example, 128K read =
as two
> 64K reads instead of one of 128K.
> =

> It's *NEVER* appropriate to commit to patching all upper level drivers in=
 order
> to work around bugs in lower level ones.=A0 The set of such upper level d=
rivers
> that may need bugfixing is quite large, most will never be used with your=
 buggy
> controller driver, and all such patches will need testing (but the test
> resources are probably not available).
> =

> Whatever SPI controller driver you're working with is clearly buggy ... b=
ut not
> unfixably so.
> =

> DO NOT head down the path of requiring every SPI device driver to include
> workarounds for this odd little SPI master driver bug.
> =

> - Dave
> =


Thanks for your comments, the controller driver is the proper place to hand=
le this, I'll fix it.

Thanks,
Mingkai


---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
