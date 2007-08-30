From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 +
 mm2-git-mmc]	mmc_spi host driver
Date: Thu, 30 Aug 2007 11:56:23 -0700
Message-ID: <20070830185623.9C6CD231986@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080912.54918.david-b@pacbell.net>
	<20070829100708.GB15021@pengutronix.de>
	<200708290959.33584.david-b@pacbell.net>
	<20070830085900.GA18374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org,
	drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070830085900.GA18374-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

> > > This is a crc error.
> > 
> > You're sure?  On my systems, error 2 == ENOENT, which is
> > only reported when an MMC or SD card fails CID fetch...
>
> No, it's MMC_ERR_BADCRC. I don't use the patches from -mm at the moment,
> I noticed that they report errno instead of MMC_ERR_*.

You should use the current patchset.  I think the rc3-mm1 git-mmc.patch
includes the fix for that merge botch I noted, and I *know* it also
includes a few notable fixes that earlier code didn't.  (None that
would seem to relate to this issue though.)


> The problem with the crc is reproducible. I watched this on the logic
> analyzer, it's the response from the card to a SPI_TOKEN_STOP_TRAN
> transfer. It occurs on the very last block on an SD card:

ISTR seeing some comment in a document pointing out that there can
be some odd faults reported when reading that block.  Maybe you've
found a case where the mmc_spi code needs updating.


> I tested this with six SD cards. They all behave like this except one
> 512MB Kingston card which works. A MMC card I tested works too.
> Maybe we have to use a single block transfer on the last sector?

Could be.  See what the current "Simplified SD" spec says ... I do
recall language about reading that sector, but it didn't seem to
matter for any of the cards I have for testing.  So I probably didn't
pay enough attention to those words.


> > > There may be still problems in my (Hilscher netx)spi driver. 
> > > The mmc over spi stuff is the first testbed for this fresh driver. 
> > 
> > Feeling brave, aren't you?  :)
>
> Sure, we do quality software here ;)

I can only applaud!  :)

None of the other protocol level SPI drivers seem to be quite as
demanding of the underlying controller drivers, so in that sense
it's a good testbed.  On the other hand, the mmc-over-SPI code is
a bit young, and various integration and corner-case issues are
still to be expected.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
