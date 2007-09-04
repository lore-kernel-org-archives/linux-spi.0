From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 +
	mm2-git-mmc]	mmc_spi host driver
Date: Tue, 4 Sep 2007 12:54:53 +0200
Message-ID: <20070904105453.GD7579@pengutronix.de>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080912.54918.david-b@pacbell.net>
	<20070829100708.GB15021@pengutronix.de>
	<200708290959.33584.david-b@pacbell.net>
	<20070830085900.GA18374@pengutronix.de>
	<20070830185623.9C6CD231986@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20070831170054.GA11112@pengutronix.de>
	<20070831230050.4F31F2371AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org,
	drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070831230050.4F31F2371AF-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

Hi David,

On Fri, Aug 31, 2007 at 04:00:51PM -0700, David Brownell wrote:
> > > > The problem with the crc is reproducible. I watched this on the logic
> > > > analyzer, it's the response from the card to a SPI_TOKEN_STOP_TRAN
> > > > transfer. It occurs on the very last block on an SD card:
> > > 
> > > ISTR seeing some comment in a document pointing out that there can
> > > be some odd faults reported when reading that block.  Maybe you've
> > > found a case where the mmc_spi code needs updating.
> 
> Did you verify that even with CRCs disabled, a problem appears?

Yes, this does not change anything.

> 
> 
> > > > I tested this with six SD cards. They all behave like this except one
> > > > 512MB Kingston card which works. A MMC card I tested works too.
> > > > Maybe we have to use a single block transfer on the last sector?
> > > 
> > > Could be.  See what the current "Simplified SD" spec says ... I do
> > > recall language about reading that sector, but it didn't seem to
> > > matter for any of the cards I have for testing.  So I probably didn't
> > > pay enough attention to those words.
> >
> > Unfortunately I did not find anything about that in the spec.
> 
> I'm sure I saw that, but have no idea what document it was in.  If
> not the "Simplified" spec, then a vendor's card spec ... either
> Sandisk (MMC, SD), Samsung, Hitachi, whatever.
> 

Still did not find something about it. I looked in the simplified spec
and in vendor specs from Toshiba and Sandisk.

I tried using a single block read for the last sector and this works for
me. I would be glad if a third person confirms that he actually needs
this patch as I'm still not sure whether theres a bug in my driver.

Here's the patch:


Some SD cards in SPI mode return a crc error when trying to read the
last block using a multiple block read. Use a single block read instead.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

---
 drivers/mmc/card/block.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6-arm/drivers/mmc/card/block.c
===================================================================
--- linux-2.6-arm.orig/drivers/mmc/card/block.c
+++ linux-2.6-arm/drivers/mmc/card/block.c
@@ -244,6 +244,16 @@ static int mmc_blk_issue_rq(struct mmc_q
 		    !mmc_card_sd(card))
 			brq.data.blocks = 1;
 
+		/* Some SD cards in SPI mode return a crc error when trying
+		 * to read the last block using a multiread command.
+		 */
+		if (mmc_host_is_spi(card->host)
+				&& brq.data.blocks > 1
+				&& rq_data_dir(req) == READ
+				&& req->sector + req->nr_sectors ==
+					get_capacity(md->disk))
+			brq.data.blocks--;
+
 		if (brq.data.blocks > 1) {
 			brq.data.flags |= MMC_DATA_MULTI;
 			/* SPI multiblock writes terminate using a special



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
