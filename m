From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH 0/4] spi: dw: fixes, and manages resources migration
Date: Thu, 26 Dec 2013 14:12:24 +0200
Message-ID: <20131226121224.GA11794@sapphire.tkos.co.il>
References: <cover.1388040447.git.baruch@tkos.co.il>
 <20131226115507.GI8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131226115507.GI8064-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Thu, Dec 26, 2013 at 12:55:07PM +0100, Gerhard Sittig wrote:
> On Thu, Dec 26, 2013 at 09:00 +0200, Baruch Siach wrote:
> > I have a few more patches in the queue for adding device tree
> > support, gpio chip selects, and generic spi queue, but I'm
> > waiting with time until I get a chance to test them properly.
> 
> Just some notes on GPIO backed CS lines.  When I recently worked
> with them (not in mainline, but in a "non-existing" :) tree which
> is why I haven't upstreamed), I learned the following:
> 
> With cs-gpios you can have an arbitrary number of CS lines,
> regardless of how many internal hardwired CS lines the controller
> may have.  Make sure to test setups with high CS numbers as well.
> 
> Make sure to test with low CS numbers, too, because cs-gpios can
> both extend the number of internally provided CS lines, as well
> as "shadow" the internal CS lines.  Internal and external lines
> can get mixed in arbitrary ways.
> 
> The SPI master driver's code appeared to assume that always in
> internal CS is involved, without it the transfer of data was
> stuck.  So I had to pick an internal CS trigger in dirty ways
> despite of using a GPIO line for CS control, just to "unfreeze"
> the data transmission.  You may see a similar issue.
> 
> To summarize you may want to consider the following DT spec
> 
>   ...
>   cs-gpios = <&pio 0>, <0>, <0>, <0>, <&pio 1>;
>   ...
> 
> and run your tests with SPI slaves on CS0, CS1, and CS4.

Thanks for the head up. I was considering adding a spi-dw specific "dummy-cs" 
property, to be used for cs-gpio numbers that are higher than num-cs.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
