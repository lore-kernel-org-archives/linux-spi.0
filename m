From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH RFC 4/4] spi: dw: migrate to generic queue infrastructure
Date: Thu, 23 Jan 2014 22:07:10 +0200
Message-ID: <20140123200710.GK12751@tarshish>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cb13f97edb9250d51bc03d27bcc3ddda93821bf9.1390481413.git.baruch@tkos.co.il>
 <20140123195148.GL11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123195148.GL11727-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Jan 23, 2014 at 07:51:48PM +0000, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 03:05:59PM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> This looks good from a scan through, can you go futher and use
> transfer_one()?

I'll look into it. I had to dig in include/linux/spi/spi.h, 'git blame' and 
commit b158935f70b9c to see how it all works together. The 
Documentation/spi/spi-summary doesn't mention the transfer_one callback. The 
kerneldoc in spi.h should make it clear that transfer_one and 
transfer_one_message are mutually exclusive.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
