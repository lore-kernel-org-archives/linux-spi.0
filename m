From: Hans <herr.eklund-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: mmc_spi lowlevel onetime retry?
Date: Fri, 28 Mar 2008 13:04:36 +0100
Message-ID: <47ECDED4.90404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

In short:

1) im about to make the mmc_spi driver work on Blackfin uClinux 
platforms via the Blackfin SPI master driver.

2) will then apply and evaluate some new ideas to fix concurrent access 
on the SPI bus.


Longer:

I made another mmc/sd driver a few years ago so i have had this battle 
before vs the odd mmc/sd spi protocol implementation and shaky spi 
master drivers. Progress and modifications so far, all to mmc_spi.c host 
driver:

1) Disabled spi DMA(could be dma_map_page not working correctly vs 
bfin-uclinux, will look into this deeper soon)

2) Disabled spi crc checks, CRC is one off(0xabcd vs 0xabce ie.) on many 
read blocks. Data seem correct anyways, checked by md5 on files etc.

3) Ignored transmission data-response byte (allways 0xff for me) but 
data get to the card anyways. md5 verified.

4) Implement one-time low-level retry. It increase stability immensley. 
I can format, copy files and do any heavy action vs the card. Without 
it, no go. I implemented it like this:

in mmc_data_do()

         retried_once = 0;
         retry:
         if (direction == DMA_TO_DEVICE)
             status = mmc_spi_writeblock(host, t);
         else
             status = mmc_spi_readblock(host, t);

         /* one low-level retry */
         if (status < 0 && !retried_once) {
             retried_once = 1;
             goto retry;
         }

I know i did the same to my old spi_mmc driver to improve stability. 
However, i always got the feeling this was not the right way to do it. 
Books and others told med to end_request with a status != 0 and let 
block layer resubmit the request(eventually) for me to retry. Whats the 
correct policy for this?  Whitout my retry-fix i cant write more than a 
couple of 100 sectors until i get a sector error like:

end_request: I/O error, dev mmcblk0, sector 160

Why is this sector not resumited to lower levels to try again? Since the 
sector number that failed was different allways a retry would probably 
work, its a communication error not an actual bad sector.

Without fix, the sector fail ratio is somewhere around 1:100 to 1:1000, 
wich is not very good, my fix is hiding a common low level SPI error. 
But even with a perfect SPI driver i would really like to have a retry 
policy somewhere when doing data transfers, in this case it actually 
squares the fail ratio to make it 1:10000 to 1:Mil. Where should that 
policy be implemented? I never got a good answer to this the last time i 
asked around.

Thanks.

/Hans





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
