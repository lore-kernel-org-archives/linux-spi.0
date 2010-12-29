From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/9] spi/pxa2xx: register driver properly
Date: Wed, 29 Dec 2010 14:36:43 -0700
Message-ID: <20101229213642.GA15198@angua.secretlab.ca>
References: <20101229081120.GN8172@angua.secretlab.ca>
	<349566.41372.qm@web180301.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <349566.41372.qm-g47maUHHHF+ORdMXk8NaZPu2YVrzzGjVVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 29, 2010 at 09:00:36AM -0800, David Brownell wrote:
> 
> 
> > Date: Wednesday, December 29, 2010, 12:11 AM
> > On Thu, Dec 02, 2010 at 06:47:29PM
> > +0100, Sebastian Andrzej Siewior wrote:
> > > use platform_driver_register instead of
> > platform_driver_probe. The
> > > latter only checks available devices at the time of
> > calling. So if a
> > > device gets inserter at a later point in time then the
> > driver will never
> > > play with it.
> 
> 
> I detect an effort to change the classic model for board initialization in Linux:  first set up
> and register all system/platform devices on each
> board then do the same for their drivers.  ("hardware first" ... "software second".
> 
> (Without such a change, there's no need for
>  patches like this (of which I've recently
> seen a few).
> 
> I've not seen discussion about the desirability
> of such a change.

That has never been the Linux device model.  It may be a reasonable
assumption on a large number of boards, but it is definitely not the
model.  In this case, this specific driver now needs to be bound to a
device that is registered in a pci device driver's probe routine.  The
change is completely justified.

Regarding the platform_driver_probe() pattern, I've never liked it
because it short circuits the normal device model behaviour and makes
all drivers that use it a special case.  It does recover a couple of
KB at runtime per driver, which is why I tolerate the existing users,
but doing so is effectively pinching pennies to solve a deficit in the
thousands.  I don't think it is worth it and I will not hesitate to
remove platform_device_probe() from a driver if it is possible that a
device will get registered late.

Instead of doing this per-driver special case thing, I would be far
more interested in a mechanism that allows userspace to trigger
discarding of  __devinit sections for any module at runtime, along
with the associated dropping of .probe() hooks, so that a system could
take advantage of the runtime memory savings on all drivers.

g.


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
