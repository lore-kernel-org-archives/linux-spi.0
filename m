From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 14:03:01 -0700
Message-ID: <CA+7tXijF8VTsA3Mk3j8Qe7r0nqr+Xri6=GDfEZGH74Doup5=eA@mail.gmail.com>
References: <52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
	<525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
	<525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
	<525D41E2.30206@ti.com>
	<20131015180142.GS23337@ld-irv-0074.broadcom.com>
	<CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA23640@DBDE04.ent.ti.com>
	<20131015205254.GX2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131015205254.GX2443-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 15, 2013 at 1:52 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Oct 15, 2013 at 06:33:23PM +0000, Gupta, Pekon wrote:
>
>> Therefore early suggestions were to make 'MM_MODE' as default
>> (if device enables it via DT). This means:
>> (1) switch to 'SPI_MODE' _only_ when required for commands like
>>  mtd_erase, etc. and switch back to 'MM_MODE' when done.
>> (2) And keep your controller clocks on.
>
> This sounds like a policy decision, I don't see any reason for it to be
> in DT.  What works well with one application stack may not be the best
> choice for another and future developments may change what's most
> sensible for a given system, it shouldn't be fixed in the DT.

I could see the driver using the transfer size to decide, memory
mapped or SPI with DMA.  Small transfers via memory mapped access and
larger would use DMA.  The spi-mxs driver does this to decide PIO or
DMA.  The threshold size is hard coded in the driver.  If you wanted
to be able to change it, I would think a sysfs attribute would be the
way to do that.

It does get tricky when you're dealing with flash roms, as people
often want to boot from those really fast, so you want the kernel to
know how to use them in the fastest way before it boots as opposed to
after booting when it's obviously too late to configure the kernel to
boot faster.

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
