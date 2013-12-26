From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: dw: fixes, and manages resources migration
Date: Thu, 26 Dec 2013 22:34:23 +0200
Message-ID: <20131226203423.GC3873@tarshish>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <20131226115507.GI8064@book.gsilab.sittig.org>
 <20131226121224.GA11794@sapphire.tkos.co.il>
 <20131226154250.GO8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131226154250.GO8064-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Thu, Dec 26, 2013 at 04:42:50PM +0100, Gerhard Sittig wrote:
> On Thu, Dec 26, 2013 at 14:12 +0200, Baruch Siach wrote:
> > 
> > [ ... GPIO controlled CS lines for SPI ... ]
> > 
> > Thanks for the head up. I was considering adding a spi-dw specific "dummy-cs" 
> > property, to be used for cs-gpio numbers that are higher than num-cs.
> 
> Look at it the other way for a moment.  These GPIO backed CS
> lines aren't "dummies", having control over them and having more
> than four of them is not at all exceptional or strange, it's the
> actual motivation for cs-gpios in the first place.  And all of
> these GPIO lines are "real" and useful.
> 
> Try to see the internal CS lines in the hardware of the SPI
> controller as the exception instead. :) These are the ones that
> are rather limited, both in their number and in their behaviour,
> and are of questionable use.  These internal lines of
> uncontrollable behaviour only get used in the absence of a GPIO
> spec for the CS line.

That's what I meant. The "dummy-cs" should be an internal chip-select that 
does not control any slave signal. It is meant to be used only to trigger the 
start of transfer. This is necessary in particular when the number of GPIO 
chip-select lines is higher than the number of internal chip-selects. 
Otherwise, the high bits in the Slave Enable Register are ignored.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
