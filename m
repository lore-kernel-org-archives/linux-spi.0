From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
Date: Thu, 4 Jun 2015 17:29:35 +0200
Message-ID: <201506041729.35645.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com> <201506040053.29482.marex@denx.de> <CAOMqctRkoQrP7wAgXfWXHb2fbi2-6VayHRx5DgUKn6Djz0qtQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	=?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	"Bean Huo =?utf-8?q?=E9=9C=8D=E6=96=8C=E6=96=8C?= (beanhuo)"
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, "grmoo
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctRkoQrP7wAgXfWXHb2fbi2-6VayHRx5DgUKn6Djz0qtQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thursday, June 04, 2015 at 06:21:32 AM, Michal Suchanek wrote:
> On 4 June 2015 at 00:53, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > On Wednesday, June 03, 2015 at 11:26:39 PM, Michal Suchanek wrote:
> >> Hello,
> > 
> > Hi,
> > 
> >> this patch series makes it possible to access the SPI NOR flash in the
> >> Samsung XE303 'Snow' Chromebook.
> >> 
> >> Unfortunately not all issues are resolved. To work around an issue with
> >> the pl330 dma engine I respun the patch for limiting transfer size in
> >> m25p80 driver.
> > 
> > Looks like fixing a bug at the wrong place to me ...
> > 
> >> As the flash does not contain any sane filesystem and is only likely to
> >> be accessed with mtd_debug or similar tool the limit of the dma engine
> >> is easily reached. Filesystems using shorter data transfers are less
> >> likely to be affected.
> > 
> > Sounds like the DMA engine driver should be fixed.
> 
> I looked at the pl330 datasheet and don't see anything obviusly wrong
> with the pl330 driver in Linux.
> 
> Ideally it would be fixed but I have no idea what's wrong with it.

Ask maybe Catalin from ARM to help you -- he might be able to point you
to the right hardware guy.

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
