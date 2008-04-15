From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi lowlevel onetime retry?
Date: Tue, 15 Apr 2008 11:20:27 -0700
Message-ID: <200804151120.27683.david-b@pacbell.net>
References: <47ECDED4.90404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47ECDED4.90404-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 28 March 2008, Hans wrote:
> In short:
> 
> 1) im about to make the mmc_spi driver work on Blackfin uClinux 
> platforms via the Blackfin SPI master driver.
> 
> 2) will then apply and evaluate some new ideas to fix concurrent access 
> on the SPI bus.

Good on both of those.  :)


> Longer:
> 
> I made another mmc/sd driver a few years ago so i have had this battle 
> before vs the odd mmc/sd spi protocol implementation and shaky spi 
> master drivers. Progress and modifications so far, all to mmc_spi.c host 
> driver:
> 
> 1) Disabled spi DMA(could be dma_map_page not working correctly vs 
> bfin-uclinux, will look into this deeper soon)

DMA issues sound likely to be platform-specific, yes.

 
> 2) Disabled spi crc checks, CRC is one off(0xabcd vs 0xabce ie.) on many 
> read blocks. Data seem correct anyways, checked by md5 on files etc.

Strange.

 
> 3) Ignored transmission data-response byte (allways 0xff for me) but 
> data get to the card anyways. md5 verified.

Sounds like another platform-specific issue.  Unless maybe
you've verified that issue by looking at the SPI data that
gets transferred?  Not every MMC card seems to conform very
closely to the MMC specs, but that would be a new and very
surprising failure mode...


> 4) Implement one-time low-level retry. It increase stability immensley. 
> I can format, copy files and do any heavy action vs the card. Without 
> it, no go. I implemented it like this:
> 
> in mmc_data_do()
> 
>          retried_once = 0;
>          retry:
>          if (direction == DMA_TO_DEVICE)
>              status = mmc_spi_writeblock(host, t);
>          else
>              status = mmc_spi_readblock(host, t);
> 
>          /* one low-level retry */
>          if (status < 0 && !retried_once) {
>              retried_once = 1;
>              goto retry;
>          }
> 
> I know i did the same to my old spi_mmc driver to improve stability. 
> However, i always got the feeling this was not the right way to do it. 
> Books and others told med to end_request with a status != 0 and let 
> block layer resubmit the request(eventually) for me to retry. Whats the 
> correct policy for this? 

Low level drivers should as a rule never retry unless they're
explicitly told to do so.  The current MMC stack doesn't have
a way to give such instructions, but it *should* have ways to
retry itself.


> Whitout my retry-fix i cant write more than a  
> couple of 100 sectors until i get a sector error like:
> 
> end_request: I/O error, dev mmcblk0, sector 160
> 
> Why is this sector not resumited to lower levels to try again? Since the 
> sector number that failed was different allways a retry would probably 
> work, its a communication error not an actual bad sector.

I don't quite follow what you're saying.  It sounds like you
may be suggesting that there are two problems in the way the
MMC layer handles faults:  (a) it doesn't retry, in at least
some cases where that could recover from transient faults;
(b) sometimes the fault is reported against the wrong sector.
That latter sounds sort of like a buggy diagnostic...


> Without fix, the sector fail ratio is somewhere around 1:100 to 1:1000, 
> wich is not very good, my fix is hiding a common low level SPI error. 
> But even with a perfect SPI driver i would really like to have a retry 
> policy somewhere when doing data transfers, in this case it actually 
> squares the fail ratio to make it 1:10000 to 1:Mil. Where should that 
> policy be implemented? I never got a good answer to this the last time i 
> asked around.

Since as far as I know the MMC drivers are not expected to
retry commands, I'd expect the upper MMC/SD/SDIO code to do
be issuing any retries.

In general, the lowlevel code isn't expected to understand
whether it's even safe to retry like that.  It's supposed to
understand protocol patterns, not command semantics ... and
there's no reason to believe that a block write must always
be idempotent.

- Dave


> 
> Thanks.
> 
> /Hans
> 
> 
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
