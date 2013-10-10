From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Thu, 10 Oct 2013 16:53:46 -0700
Message-ID: <CA+7tXigijA6ASOiHkRDz45PTruv2vwYJu0UUWz0hvKr0=zwu5w@mail.gmail.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
	<1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
	<20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
	<20131009174027.GS21581@sirena.org.uk>
	<87hacq1d5k.fsf@dell.be.48ers.dk>
	<CA+7tXii4J_Hie2v-DaSevFHn-YqriiVowhpXCP9H+U51_tbhvQ@mail.gmail.com>
	<20131010101052.GF21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131010101052.GF21581-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 10, 2013 at 3:10 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Oct 09, 2013 at 07:27:11PM -0700, Trent Piepho wrote:
>
>> I've found that the SPI layer adds rather a lot of overhead to SPI
>> transactions. It appears to come mostly from using another thread to
>> run the queue. A fast SPI message of a few dozen bytes ends up having
>> more overhead from the SPI layer than the time it takes the driver to
>> do the actual transfer.
>
> Yeah, though of course at the minute the implementation of that thread
> is pretty much up to the individual drivers which isn't triumph - and
> the quality of implementation does vary rather a lot. I'm currently
> working on trying to factor more of this out, hopefully then it'll be
> easier to push out improvements. It may be nice to be able to kick off
> the first DMA transfer from within the caller for example.

I did testing with the mxs driver, which uses transfer_one
_message and the spi core queue pumping code.  For small messages the
overhead of queuing work to the pump_messages queue and waiting for
completion is rather more than the time the actual transfer takes.  Which
makes using a kthread rather pointless.  Part of the problem could be the
high context switch cost for ARMv5.

>> So memory mapped mode via some kind of SPI hack seems like a bad
>> design. All the SPI layer overhead and you don't get DMA. Memory
>> mapped SPI could be a win, but I think you'd need to do it at the MTD
>> layer with a mapping driver that could read the mmapped SPI flash
>> directly.
>
> Yes, exactly and even then I'm not convinced that it's going to be much
> advantage for anything except small transfers without DMA.

My experience with a device using direct mapped NOR had a similar problem.
While NOR was fast, access to it would necessarily use 100% CPU for
whatever transfer rate is achieved.  The eMMC based flash, while a far more
complex driver, was actually better in terms of %CPU/MB because it could
use DMA.  Writing a custom sDMA script to use the iMX dmaengine for DMA
with direct mapped flash would have been interesting.

Direct mapping flash and losing DMA is probably always going to be a  net
lose for Linux filesystems on flash.  Maybe on small memory systems there
could be an advantage if you supported XIP with the mtd mapping driver.
------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
