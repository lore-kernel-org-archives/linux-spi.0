From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
	spi-orion
Date: Wed, 21 Nov 2012 13:29:56 -0700
Message-ID: <20121121202956.GA15020@obsidianresearch.com>
References: <20121121192335.GA14868@obsidianresearch.com>
	<20121121193552.GE15800@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121121193552.GE15800-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 21, 2012 at 02:35:52PM -0500, Jason Cooper wrote:

> >  	/* we support only mode 0, and no options */
> > -	master->mode_bits = 0;
> > +	master->mode_bits = SPI_CPHA | SPI_CPOL;
> 
> The comment no longer seems valid.  ;-)  Also, you are unconditionally
> enabling these modes.  Do all users of this driver support this?

Right on the comment.. Not sure about your second query?

 * @mode_bits: flags understood by this controller driver

The mode_bits need to be set so the mid layer will allow consumers to
pass them down through spi->mode when it calls into
orion_spi_setup_transfer. So that looks correct..

Now, it seems a fair question what mode the driver will run in by
default now.. Previously, the driver didn't change the CPOL and CPHA
bits, so whatever the boot firmware left them at will be the mode it
uses.

If SPI consumers are not properly requesting the proper CPOL/CPHA
operation and instead relying on the boot firmware to leave the proper
bit settings then things will break for those users (they will need to
update their board's DT file, or otherwise) - but I don't see any way
to address that and implement proper programmable support?

This could affect at least dove, dreamplug, ts219 and lsxl.

Jason

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
