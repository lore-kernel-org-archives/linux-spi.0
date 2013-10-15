From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Tue, 15 Oct 2013 18:53:46 +0530
Message-ID: <525D41E2.30206@ti.com>
References: <52566ACC.1080100@ti.com> <20131010101410.GG21581@sirena.org.uk>
	<52568AA3.9080203@ti.com> <20131011100839.GA21581@sirena.org.uk>
	<525CDB77.4040201@ti.com> <20131015111647.GX2443@sirena.org.uk>
	<525D2BB3.4020705@ti.com> <20131015124656.GM2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	balbi-l0cyMroinI0@public.gmane.org,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131015124656.GM2443-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 15 October 2013 06:16 PM, Mark Brown wrote:
> On Tue, Oct 15, 2013 at 05:19:07PM +0530, Sourav Poddar wrote:
>> On Tuesday 15 October 2013 04:46 PM, Mark Brown wrote:
>>> Can you fix this by enabling the clock is enabled when you return the
>>> buffer to the MTD layer and then disabling the clock when the buffer is
>>> released?
>> Sorry, I did not get you here. With memory mapped read, there is no
>> buffer exchanged, everything takes place at the mtd layer only, what gets
>> exchanged is just the memory mapped address.
> The buffer is the memory mapped address - part of getting the address
> should be preparing the hardware for it.
>
>>       if (spi->mode&&  SPI_RX_MMAP) {
>>           printk("memory mapped mode set\n");
>> -        flash->mmap_read = true;
>> +        flash->mmap_read = spi->memory_map;
> So this probably needs to be a function call to get the buffer (and a
> corresponding one to free it).
So, the flow can be something like this:

drivers/mtd/devices/m25p80.c
get_flash_buf()
{
     lock();

      t[0] = GET_BUFFER;
      t[1] = buf;
      ......

      spi_sync();

     unlock();
}

mtd_read
{
     get_flash_buf();

     if (flash->buf) {
         memcpy();
        return 0;
   }
}

Not sure, if free buf is needed as devm_* variant is used to allocate that
memory.


}


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
