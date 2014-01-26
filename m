From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH RFC 3/4] spi: dw: add support for gpio controlled chip
 select
Date: Sun, 26 Jan 2014 10:01:31 +0200
Message-ID: <20140126080131.GN5596@tarshish>
References: <cover.1390481412.git.baruch@tkos.co.il>
 <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch@tkos.co.il>
 <20140123132623.GN17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140123132623.GN17314-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Jan 23, 2014 at 01:26:23PM +0000, Mark Brown wrote:
> On Thu, Jan 23, 2014 at 03:05:58PM +0200, Baruch Siach wrote:
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> 
> If you convert to the generic queue then there's generic support for
> managing a GPIO based /CS if you set cs_gpio in the spi_device.  We
> should extend that for GPIO descriptors too.

Generic queue GPIO chip-select management depends on switching from 
transfer_one_message to transfer_one as you suggested in another email. 
Unfortunately there is just too much logic going on in the pump_transfers 
workqueue, and I can't expect it to work correctly without testing on real 
hardware.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
