From: Balaji Rao <balajirrao-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi_bitbang: Add support for
	non-blocking	synchronous transfers
Date: Sat, 28 Feb 2009 15:28:48 +0530
Message-ID: <20090228095846.GA32044@fedora.yogi>
References: <20090228081036.31964.80618.stgit@fedora.yogi>
	<20090228081117.31964.51155.stgit@fedora.yogi>
	<20090228100914.2ec2ff7f@lska2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Green <andy-4Bgg8jF3iZdWk0Htik3J/w@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Kagstrom <simon.kagstrom-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090228100914.2ec2ff7f@lska2>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Feb 28, 2009 at 10:09:14AM +0100, Simon Kagstrom wrote:

Hi Simon,

> Thanks for taking this up Balaji!


You are welcome.
 
> In the comment below I'm assuming the Openmoko accelerometer use of
> this functionality, which would include doing SPI transfers in the
> interrupt handler.
> 

> 
> > +/* Synchronous non blocking transfer */
> > +int
> > +spi_bitbang_transfer_sync(struct spi_device *spi, struct spi_message
> > *m) +{
> > [...]
> > +		if (setup_transfer) {
> > +			status = setup_transfer(spi, t);
> > [...]
> > +			if (!m->is_dma_mapped)
> > +				t->rx_dma = t->tx_dma = 0;
> > +			status = bitbang->txrx_bufs(spi, t);
> 
> Another thing that we'd need to take care of is that the stuff being
> called from the synhronous transfer is actually callable from interrupt
> context. Looking at txrx_bufs for s3c24xx (s3c24xx_spi_txrx), it's
> using a wait_for_completion which is in turn completed by the s3c24xx
> SPI interrupt handler.
> 
> Without trying, I'm guessing that that won't be possible from interrupt
> context.
> 

The master is not spi_s3c24xx but spi_s3x24xx_gpio, whose txrx are very
simple code.

Additionally all of this has been tested and found to work. The code,
along with the modified new spi based lis302dl driver is all in
andy-tracking [1].

[1] - git://git.openmoko.org/git/kernel.git andy-tracking

Thanks,
Balaji

------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
