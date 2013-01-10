From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: bitbang: convert to using core message queue
Date: Thu, 10 Jan 2013 13:04:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301101304210.24058@axis700.grange>
References: <Pine.LNX.4.64.1301091502020.13376@axis700.grange>
	<Pine.LNX.4.64.1301091507120.13376@axis700.grange>
	<Pine.LNX.4.64.1301091535490.13376@axis700.grange>
	<CACRpkdbsbXTM47TYTjF9sJQaMRetTbHm0Xri-=2kWsdK14AYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdbsbXTM47TYTjF9sJQaMRetTbHm0Xri-=2kWsdK14AYPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 10 Jan 2013, Linus Walleij wrote:

> On Wed, Jan 9, 2013 at 3:44 PM, Guennadi Liakhovetski
> <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> 
> > [   79.968000] mmc0: new SD card on SPI
> > [   79.976000] mmcblk0: mmc0:0000 SU02G 1.84 GiB
> > [   80.024000]  mmcblk0: p1
> > [   80.132000] mmcblk0: error -38 sending status command, retrying
> > [   80.136000] mmcblk0: error -38 sending status command, retrying
> > [   80.140000] mmcblk0: error -38 sending status command, aborting
> > [   81.028000] mmc0: SPI card removed
> > [   81.572000] mmc0: error -110 whilst initialising SD card
> 
> The queue mechanism has not changed.
> 
> This *could* be the card itself. So it doesn't appear before the patch?

No.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
