From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4 2.6.23-rc2 + mm2-git-mmc]
	mmc_spi host driver
Date: Wed, 29 Aug 2007 09:59:32 -0700
Message-ID: <200708290959.33584.david-b@pacbell.net>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080912.54918.david-b@pacbell.net>
	<20070829100708.GB15021@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070829100708.GB15021-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Wednesday 29 August 2007, Sascha Hauer wrote:
> Hi,
> 
> On Wed, Aug 08, 2007 at 09:12:54AM -0700, David Brownell wrote:
> > +
> > +		dev_dbg(&spi->dev, "    mmc_spi: STOP_TRAN\n");
> > +
> > +		/* Tweak the per-block message we set up earlier by morphing
> > +		 * it to hold single buffer with the token followed by some
> > +		 * all-ones bytes ... skip N(BR) (0..1), scan the rest for
> > +		 * "not busy any longer" status, and leave chip selected.
> > +		 */
> > +		INIT_LIST_HEAD(&host->m.transfers);
> > +		list_add(&host->early_status.transfer_list,
> > +				&host->m.transfers);
> > +
> > +		scratch->status[0] = SPI_TOKEN_STOP_TRAN;
> > +		memset(scratch->status + 1, 0xff, statlen - 1);
> > +		host->early_status.tx_buf = host->early_status.rx_buf;
> > +		host->early_status.tx_dma = host->early_status.rx_dma;
> > +		host->early_status.len = 1 + statlen;
> > +
> 
> The length to transfer here is statlen, not statlen + 1.

Right -- ACK.  Although the code could be shrunk a smidgeon
(and IMO made clearer) by doing the memset of the full buffer,
then just overwriting the first byte with that token.


> With the following 
> patch applied the driver works more reliably for me, though not perfect.
> I still get occasional errors like this from some SD cards:
> 
> mmcblk0: error 2 sending stop command

That would be an error on the READ path, yes?  Because the
SPI protocols only use a STOP command on multiblock reads.


> This is a crc error.

You're sure?  On my systems, error 2 == ENOENT, which is
only reported when an MMC or SD card fails CID fetch...


> There may be still problems in my (Hilscher netx)spi driver. 
> The mmc over spi stuff is the first testbed for this fresh driver. 

Feeling brave, aren't you?  :)


> For a 
> real crc error I would expect that they are somewhat dependent on the
> clock rate, but this does not seem to be the case. Before going deeper
> here, has any of you seen this or got an idea where to look for it?

Haven't noticed such a beast myself.  You can disable CRCs,
that could help rule out CRCs as the cause (or finger them
a bit more clearly).

- Dave

> 
> Sascha
> 
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ---
>  drivers/mmc/host/mmc_spi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6-arm/drivers/mmc/host/mmc_spi.c
> ===================================================================
> --- linux-2.6-arm.orig/drivers/mmc/host/mmc_spi.c
> +++ linux-2.6-arm/drivers/mmc/host/mmc_spi.c
> @@ -886,7 +886,7 @@ mmc_spi_data_do(struct mmc_spi_host *hos
>  		memset(scratch->status + 1, 0xff, statlen - 1);
>  		host->early_status.tx_buf = host->early_status.rx_buf;
>  		host->early_status.tx_dma = host->early_status.rx_dma;
> -		host->early_status.len = 1 + statlen;
> +		host->early_status.len = statlen;
>  
>  		if (host->dma_dev)
>  			dma_sync_single_for_device(host->dma_dev,
> 
> 
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
