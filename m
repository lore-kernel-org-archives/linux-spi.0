From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [sodaville] SPI support for CE4100, v2
Date: Wed, 29 Dec 2010 01:10:51 -0700
Message-ID: <20101229081051.GL8172@angua.secretlab.ca>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
	<4D01074A.2020106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D01074A.2020106-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 09, 2010 at 05:43:54PM +0100, Sebastian Andrzej Siewior wrote:
> Sebastian Andrzej Siewior wrote:
> >The SPI core inside CE4100 is very much the same as in PXA25x.
> >I Cc the ARM folks because patch 4 reorganizes some files so that they
> >can be access from x86. Yes, CE4100 is a x86 SoC :)
> >The SPI device is behind a PCI bus. The PCI probe code simply creates a
> >platform device so we don't have much changes to the platform driver.
> >There is no clock framework on x86 and the peripherals don't support
> >changing their clocks or to enable/disable them. So I provided dummy
> >function which keep the driver happy.
> >
> >History:
> >v1: initial post
> >v2: - the patch touching subys_inticall() got removed.
> >    - platform_driver_probe() is replaced with platform_driver_register()
> >    - there are no files created in include/asm.
> >
> >The patch series has been created with the -M option so file moves can
> >be easily noticed. The whole series is also available at
> >  git://git.linutronix.de/users/bigeasy/soda.git spi
> 
> It's been week since I posted this and nobody commented on it. Is this
> patchset missing something or is it good to go?

I've just picked it up into my test branch, and I'll push it out to
git.secretlab.ca in the morning if everything checks out with the
sanity build.

g.


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
