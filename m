From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: dw: drop unused struct dw_spi field
Date: Thu, 2 Jan 2014 00:21:33 +0800
Message-ID: <20140102002133.46eef5d3@feng-snb>
References: <cover.1388040447.git.baruch@tkos.co.il>
	<134cfa84519ca84268fc0ef502fba12773224133.1388040447.git.baruch@tkos.co.il>
	<20131226114258.GH8064@book.gsilab.sittig.org>
	<20131226115826.GY11794@sapphire.tkos.co.il>
	<20131226153346.GN8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131226153346.GN8064-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Thu, 26 Dec 2013 16:33:46 +0100
Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org> wrote:

> On Thu, Dec 26, 2013 at 13:58 +0200, Baruch Siach wrote:
> 
> Please re-check, or tell me if your code base is different from
> mainline and I'm missing something.
> 
> Inspection of local code (v3.13-rc5-4-gf399199c01c7) suggests
> that the local cs_change gets preset to 0 and enforced to 1 if
> the "chip" (the SPI slave?) changes.  I can't see any other
> condition that gets evaluated.  So the current driver does ignore
> the caller's request.

For gpio-CS spi slave devices, I don't have much experience.

This dw-spi driver has worked with both low-speed uart and high-speed
 modem device with the internal CS register setting (no extern cs line)
on our platforms (Medfield/Cloverview platforms)

IIRC (I haven't touch this code for long time), some other developer 
contributed the "cs_control" callback to dw spi driver, and I guess it
was for the external CS line.

As myself have no HW to debug the external CS-line, any improvement in
this area for the driver will be highly appreciated.

> 
> > > While you are checking whether the SPI master obeys the caller's
> > > CS change spec, can you check the optional delay between partial
> > > transfers as well (I assume that both get handled in the same
> > > spots of the code path)?  ISTR that these two aspects (and the
> > > lack of GPIO backed chip selects given how the hardware CS line
> > > acts) were real obstacles when trying to use this DW SPI master.
> > 
> > The code in pump_transfers() seems to honor delay_usecs. What was the problem 
> > you encountered?
> 
> Since you made me look at the code:  The delay_usecs spec appears
> to only get obeyed _between_ transfers.  It gets ignored for the
> last or only transfer of a message.  Which may be unexpected, and
> differs from what other SPI controllers implement.  Can't tell
> whether this breaks existing SPI slaves, but the delay probably
> was introduced for some reason.  I guess deasserting CS while the
> slave still wants it does have implications...

Actually quiet several spi controller drivers handle the delay_usecs
this way, like the Blackfin, pl022, you can simply grep delay_usecs
 in drivers/spi/

I wrote this driver several years ago, and IIRC, the intention of
skipping the udelay for last xfer is trying to save some udelay time,
as switching to another spi_msg will surely take a while. I didn't
see problem with it used by low-speed uart spi device or
high speed modem on our platforms.

But if you do see problem with this behavior, we can change it and
also notify the other spi controllers who use the same method. 

Thanks,
Feng


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
