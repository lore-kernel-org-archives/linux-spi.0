From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 +
 mm2-git-mmc]	mmc_spi host driver
Date: Fri, 31 Aug 2007 16:00:51 -0700
Message-ID: <20070831230050.4F31F2371AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080912.54918.david-b@pacbell.net>
	<20070829100708.GB15021@pengutronix.de>
	<200708290959.33584.david-b@pacbell.net>
	<20070830085900.GA18374@pengutronix.de>
	<20070830185623.9C6CD231986@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20070831170054.GA11112@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org,
	drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070831170054.GA11112-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> > > The problem with the crc is reproducible. I watched this on the logic
> > > analyzer, it's the response from the card to a SPI_TOKEN_STOP_TRAN
> > > transfer. It occurs on the very last block on an SD card:
> > 
> > ISTR seeing some comment in a document pointing out that there can
> > be some odd faults reported when reading that block.  Maybe you've
> > found a case where the mmc_spi code needs updating.

Did you verify that even with CRCs disabled, a problem appears?


> > > I tested this with six SD cards. They all behave like this except one
> > > 512MB Kingston card which works. A MMC card I tested works too.
> > > Maybe we have to use a single block transfer on the last sector?
> > 
> > Could be.  See what the current "Simplified SD" spec says ... I do
> > recall language about reading that sector, but it didn't seem to
> > matter for any of the cards I have for testing.  So I probably didn't
> > pay enough attention to those words.
>
> Unfortunately I did not find anything about that in the spec.

I'm sure I saw that, but have no idea what document it was in.  If
not the "Simplified" spec, then a vendor's card spec ... either
Sandisk (MMC, SD), Samsung, Hitachi, whatever.


>		If no
> other idea comes up I will try what happens when I read the last block
> using a single block read next week. The easiest way would be to fix it
> in the mmc block driver. That should not be too much overhead for 'real'
> SD cards, or is it?

I'd not think so.  That's more Pierre's call though.



> btw what is the reason why mmc_spi requires an unshared bus? Even the SD
> spec talks about connecting multiple cards to one spi bus. Is it because
> of the CS high phase during initialization?

There are a bunch of chipselect games MMC plays.  Notice how most of the
commands require the card to drive MISO for at least eight clocks after
they're deselected, too ... that means having the SPI host drive the
clock during that period too, also shifting out ones on MOSI.

I'm remembering that one of the issues was the handling of BUSY status,
which is a bit awkward but still remains one of the few places where
it would make sense to drop the chipselect and access another device.
But it still has those silly rules about "working" after chip deselect...

The canonical trouble spot is probably just reading a block.  That's
built out of any number of transactions, and it's not possible to know
in advance how many it will be.  So the host has to issue one, see if
the card's got data ready; if not, repeat until it is; then finally
process the actual data.  All *without* dropping chipselect.  And the
same issue comes up with both single and multiblock reads.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
