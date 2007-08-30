From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 +
	mm2-git-mmc]	mmc_spi host driver
Date: Thu, 30 Aug 2007 10:59:00 +0200
Message-ID: <20070830085900.GA18374@pengutronix.de>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080912.54918.david-b@pacbell.net>
	<20070829100708.GB15021@pengutronix.de>
	<200708290959.33584.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200708290959.33584.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, Aug 29, 2007 at 09:59:32AM -0700, David Brownell wrote:
> On Wednesday 29 August 2007, Sascha Hauer wrote:
> > Hi,
> > 
> > On Wed, Aug 08, 2007 at 09:12:54AM -0700, David Brownell wrote:
> > > +
> > > +		dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
> > > +
> > > +		/* Tweak the per-block message we set up earlier by morphing
> > > +		 * it to hold single buffer with the token followed by some
> > > +		 * all-ones bytes ... skip N(BR) (0..1), scan the rest for
> > > +		 * "not busy any longer" status, and leave chip selected.
> > > +		 */
> > > +		INIT_LIST_HEAD(&host->m.transfers);
> > > +		list_add(&host->early_status.transfer_list,
> > > +				&host->m.transfers);
> > > +
> > > +		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
> > > +		memset(scratch->status + 1, 0xff, statlen - 1);
> > > +		host->early_status.tx_buf = host->early_status.rx_buf;
> > > +		host->early_status.tx_dma = host->early_status.rx_dma;
> > > +		host->early_status.len = 1 + statlen;
> > > +
> > 
> > The length to transfer here is statlen, not statlen + 1.
> 
> Right -- ACK.  Although the code could be shrunk a smidgeon
> (and IMO made clearer) by doing the memset of the full buffer,
> then just overwriting the first byte with that token.
> 
> 
> > With the following 
> > patch applied the driver works more reliably for me, though not perfect.
> > I still get occasional errors like this from some SD cards:
> > 
> > mmcblk0: error 2 sending stop command
> 
> That would be an error on the READ path, yes?  Because the
> SPI protocols only use a STOP command on multiblock reads.
> 
> 
> > This is a crc error.
> 
> You're sure?  On my systems, error 2 == ENOENT, which is
> only reported when an MMC or SD card fails CID fetch...

No, it's MMC_ERR_BADCRC. I don't use the patches from -mm at the moment,
I noticed that they report errno instead of MMC_ERR_*.

The problem with the crc is reproducible. I watched this on the logic
analyzer, it's the response from the card to a SPI_TOKEN_STOP_TRAN
transfer. It occurs on the very last block on an SD card:

mmc0: new SD card at address 0000
mmcblk0: mmc0:0000 S016B 14560KiB
 mmcblk0: p1

 root@netx:~> cat /dev/mmcblk0p1 > /dev/null
 mmcblk0: error 2 sending stop command
 end_request: I/O error, dev mmcblk0, sector 29112
 Buffer I/O error on device mmcblk0p1, logical block 3637
 mmcblk0: error 5 sending read/write command
 end_request: I/O error, dev mmcblk0, sector 29112
 Buffer I/O error on device mmcblk0p1, logical block 3637
 mmcblk0: error 5 sending read/write command
 end_request: I/O error, dev mmcblk0, sector 29112
 Buffer I/O error on device mmcblk0p1, logical block 3637
 cat: read error: Input/output error
 root@netx:~>                                                                

14560 * 1024 - 29112 * 512 = 4096

I tested this with six SD cards. They all behave like this except one
512MB Kingston card which works. A MMC card I tested works too.
Maybe we have to use a single block transfer on the last sector?

> 
> 
> > There may be still problems in my (Hilscher netx)spi driver. 
> > The mmc over spi stuff is the first testbed for this fresh driver. 
> 
> Feeling brave, aren't you?  :)

Sure, we do quality software here ;)

Sascha

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
