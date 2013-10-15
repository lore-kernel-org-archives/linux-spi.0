From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 11:13:38 -0700
Message-ID: <CA+7tXigv1Q3BPE3uhzdJpx3DsqUpxzrBUaPfWR-i15PsVtMWsQ@mail.gmail.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
	<52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
	<525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
	<525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
	<525D41E2.30206@ti.com>
	<20131015180142.GS23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131015180142.GS23337-bU/DPfM3abD4WzifrMjOTkcViWtcw2C0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 15, 2013 at 11:01 AM, Brian Norris
<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> So, the flow can be something like this:
>>
>> drivers/mtd/devices/m25p80.c
>> get_flash_buf()
>> {
>>     lock();
>>
>>      t[0] = GET_BUFFER;
>>      t[1] = buf;
>>      ......
>>
>>      spi_sync();
>>
>>     unlock();
>> }
>>
>> mtd_read
>> {
>>     get_flash_buf();
>>
>>     if (flash->buf) {
>>         memcpy();
>>        return 0;
>>   }
>> }
>>
>> Not sure, if free buf is needed as devm_* variant is used to allocate that
>> memory.
>
> I believe you are misplacing the discussion of devm_* variants. devm_*
> is only useful for resources allocated/mapped released/unmapped at probe
> and release time. They do not magically remove the burden of resource
> management for I/O and other dynamic operations.

Are there any numbers to show if memory mapped read support is a
benefit in Linux?  There is some question as to whether it's useful at
all or not.

If it is, I think low latency for small reads is probably one of the
only advantages.  To do that, you aren't going to want to deal with
device PM for every single read.  It would make more sense to turn the
hardware on when the MTD device is opened and leave it on until
closed.

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
