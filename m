From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 + mm2-git-mmc]
	mmc_spi host driver
Date: Thu, 15 Nov 2007 15:30:05 -0800
Message-ID: <200711151530.06591.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<20070831230050.4F31F2371AF@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20070904105453.GD7579@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070904105453.GD7579-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 04 September 2007, Sascha Hauer wrote:
> Hi David,
> 
> On Fri, Aug 31, 2007 at 04:00:51PM -0700, David Brownell wrote:
> > > > > The problem with the crc is reproducible. I watched this on the logic
> > > > > analyzer, it's the response from the card to a SPI_TOKEN_STOP_TRAN
> > > > > transfer. It occurs on the very last block on an SD card:
> > > > 
> > > > ISTR seeing some comment in a document pointing out that there can
> > > > be some odd faults reported when reading that block.  Maybe you've
> > > > found a case where the mmc_spi code needs updating.
> > 
> > Did you verify that even with CRCs disabled, a problem appears?
> 
> Yes, this does not change anything.

I suspect this is a case where a fault code gets overloaded.
There aren't many codes defined, after all!


> > > > > I tested this with six SD cards. They all behave like this except one
> > > > > 512MB Kingston card which works. A MMC card I tested works too.
> > > > > Maybe we have to use a single block transfer on the last sector?
> > > > 
> > > > Could be.  See what the current "Simplified SD" spec says ... I do
> > > > recall language about reading that sector, but it didn't seem to
> > > > matter for any of the cards I have for testing.  So I probably didn't
> > > > pay enough attention to those words.
> > >
> > > Unfortunately I did not find anything about that in the spec.
> > 
> > I'm sure I saw that, but have no idea what document it was in.  If
> > not the "Simplified" spec, then a vendor's card spec ... either
> > Sandisk (MMC, SD), Samsung, Hitachi, whatever.
> > 
> 
> Still did not find something about it. I looked in the simplified spec
> and in vendor specs from Toshiba and Sandisk.

I'm still sure I saw it.  Maybe I'll try searching for that text
myself, it's surely in one of half a dozen huge documents I have
sitting around in PDF form.  ;)

I think there may be a regression in this area.  When debugging
this updated code, I was able to "dd" an entire SanDisk SD card
without any errors.  But when I tried this a short while ago, I
saw the kind of error you report.  I don't believe the SanDisk
card suddenly broke.

Your patch prevented that problem from appearing ...

Now, taking only a very brief look at this, I wonder if maybe
this isn't partly a symptom of an off-by-one error of some kind,
with the current MMC stack asking for too much data.  It must
be requesting two blocks, since subtracting one turns it into
a single block read ... but for some reason I count a multiblock
read of eight blocks, indicating sg_len is eight not two.

Anyway, here's some debug output.  It's the tail end of two
DD sessions, one with a generic kernel and one with your patch.
Only the latter one worked.

- Dave


====	#1

	This is generic 2.6.24-rc2 (in terms of MMC patches), with
	mmc_spi debugging enabled

	The card is a 128 MB SanDisk SD card.  The command is:

	# dd bs=4k if=/dev/mmcblk0 of=/dev/null

	Gets a CRC error (-84, -EILSEQ) from R1_SPI_COM_CRC status (0x08)
	when issuing CMD12 (MMC_STOP_TRANSMISSION).

mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   ... CMD12 response SPI_R1B: resp 0008 00000000
mmcblk0: error -84 sending stop command
end_request: I/O error, dev mmcblk0, sector 246008
Buffer I/O error on device mmcblk0, logical block 30751
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:   ... CMD18 response SPI_R1: resp 0004 00000000
mmcblk0: error -22 sending read/write command
end_request: I/O error, dev mmcblk0, sector 246008
Buffer I/O error on device mmcblk0, logical block 30751

	... and the DD command failed.


====	#2
	This is generic 2.6.24-rc2 (in terms of MMC patches), with
	mmc_spi debugging enabled, plus the patch from Sascha Hauer.

	The card is a 128 MB SanDisk SD card.  The command is:
 
	# dd bs=4k if=/dev/mmcblk0 of=/dev/null

	No problems ... although note that there was only *ONE* block
	read at the end, where the failing case tried reading eight.

mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes

	... and the DD command succeeded.


> I tried using a single block read for the last sector and this works for
> me. I would be glad if a third person confirms that he actually needs
> this patch as I'm still not sure whether theres a bug in my driver.

Looks to me like an issue higher up in the stack than your driver.

 
> Here's the patch:
> 
> 
> Some SD cards in SPI mode return a crc error when trying to read the
> last block using a multiple block read. Use a single block read instead.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
>  drivers/mmc/card/block.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> Index: linux-2.6-arm/drivers/mmc/card/block.c
> ===================================================================
> --- linux-2.6-arm.orig/drivers/mmc/card/block.c
> +++ linux-2.6-arm/drivers/mmc/card/block.c
> @@ -244,6 +244,16 @@ static int mmc_blk_issue_rq(struct mmc_q
>  		    !mmc_card_sd(card))
>  			brq.data.blocks = 1;
>  
> +		/* Some SD cards in SPI mode return a crc error when trying
> +		 * to read the last block using a multiread command.
> +		 */
> +		if (mmc_host_is_spi(card->host)
> +				&& brq.data.blocks > 1
> +				&& rq_data_dir(req) == READ
> +				&& req->sector + req->nr_sectors ==
> +					get_capacity(md->disk))
> +			brq.data.blocks--;
> +
>  		if (brq.data.blocks > 1) {
>  			brq.data.flags |= MMC_DATA_MULTI;
>  			/* SPI multiblock writes terminate using a special
> 
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
