From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/stmp: Fix device remove function
Date: Fri, 24 Aug 2012 10:12:20 -0700
Message-ID: <20120824171220.GA4591@roeck-us.net>
References: <1345777729-19342-1-git-send-email-linux@roeck-us.net>
	<20120824084708.GB12630@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120824084708.GB12630-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 24, 2012 at 10:47:08AM +0200, Wolfram Sang wrote:
> On Thu, Aug 23, 2012 at 08:08:47PM -0700, Guenter Roeck wrote:
> > The call sequence spi_alloc_master/spi_register_master/spi_unregister_master
> > is complete; it reduces the device reference count to zero, which results in
> > device memory being freed. The remove function accesses the freed memory after
> > the call to spi_unregister_master(), _and_ it calls spi_master_put on the freed
> > memory.
> > 
> > Acquire a reference to the SPI master device and release it after cleanup is
> > complete (with the existing spi_master_put) to solve the problem.
> > 
> > Also, the device subsystem ensures that the remove function is only called once,
> > and resets device driver data to NULL. Remove the respective check and drop the
> > unnecessaary call to platform_set_drvdata().
> > 
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > ---
> > Note that this driver is impossible to build, since it depends on ARCH_STMP3XXX
> > which is not defined anywhere.
> 
> It can be replaced with the spi driver for mxs once it is mainline.
> 
Maybe the driver should be removed then.

The mxs driver has exactly the same problem as the one fixed with this patch.
I'll submit a patch for it.

Guenter

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
