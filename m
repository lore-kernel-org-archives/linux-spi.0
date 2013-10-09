From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 09 Oct 2013 21:01:59 +0200
Message-ID: <87hacq1d5k.fsf@dell.be.48ers.dk>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
	<1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
	<20131009160759.GQ21581@sirena.org.uk> <52558A49.5090904@ti.com>
	<20131009174027.GS21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131009174027.GS21581-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Wed, 9 Oct 2013 18:40:27 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>>>>> "Mark" == Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

Hi,

 Mark> I'm not convinced that this is the most useful API, it sounds like the
 Mark> hardware can "memory map" the entire flash chip so the whole SPI
 Mark> framework seems like overhead.

 Mark> It also seems seems like it's going to involve the CPU being
 Mark> stalled waiting for reads to complete instead of asking the SPI
 Mark> controller to DMA the data to RAM and allowing the CPU to get on
 Mark> with other things - replacing the explicit transmission of
 Mark> commands with memory to memory DMAs might be advantageous but
 Mark> replacing DMA with memcpy() would need numbers to show that it
 Mark> was a win.

Indeed. I can see how such a feature could be useful in E.G. a lowlevel
bootloader (because of simplicity), but am less convinced about it in
Linux where we could conceivable do something else useful while waiting
on the spi controller.

But if there's number to prove otherwise..

-- 
Bye, Peter Korsgaard

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
