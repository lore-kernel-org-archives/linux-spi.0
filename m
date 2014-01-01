From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: dw: fixes, and manages resources migration
Date: Wed, 1 Jan 2014 07:01:30 +0200
Message-ID: <20140101050130.GG4263@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <20131226115507.GI8064@book.gsilab.sittig.org>
 <20131226121224.GA11794@sapphire.tkos.co.il>
 <20131226154250.GO8064@book.gsilab.sittig.org>
 <20131226203423.GC3873@tarshish>
 <20131231123425.GP8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131231123425.GP8064-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Tue, Dec 31, 2013 at 01:34:25PM +0100, Gerhard Sittig wrote:
> On Thu, Dec 26, 2013 at 22:34 +0200, Baruch Siach wrote:
> > That's what I meant. The "dummy-cs" should be an internal
> > chip-select that does not control any slave signal. [ ... ]
> 
> Ah, nevermind then, I simply misunderstood. :)

Thinking about it again I think that "dummy-cs" is not a good name. Maybe 
"disconnected-cs" would be better. This is the actual hardware level 
description of the chip-select, rather than software level use as dummy value.

[...]

> So the introduction of another dummy-cs property might be
> appropriate given the observed behaviour of the hardware.
> Alternatively one might just pick an arbitrary internal CS number
> at runtime (probably the highest internal number, i.e. the last
> one), which should not be a problem as long as this behaviour is
> documented -- GPIOs then can get used for this CS number and all
> numbers above, so no functionality is missing.  Mind that this
> workaround then is a feature of the Linux driver, and not the DT
> binding.

Choosing an arbitrary chip-select number is dangerous. You might damage the 
hardware by choosing wrong. I don't think that relying on documentation 
(where?) is reasonable in this case.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
