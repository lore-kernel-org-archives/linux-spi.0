From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 15 Apr 2008 11:37:00 -0700
Message-ID: <200804151137.00997.david-b@pacbell.net>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1CF6EDDF0820924DA43C9A52FE7325950A27D544-3jZfQB9DylyX6QUl2nWcdlaTQe2KTcn/@public.gmane.org>
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

On Thursday 03 April 2008, hartleys wrote:
> Hello all,
> 
> I'm trying to use the mmc_spi.c driver on an EP93xx platform and ran
> into the "can't share SPI bus" issue.
> 
> My platform currently has an EEPROM (SST25LF040A using the at25.c
> driver) and a MMC socket connected to the SPI bus. Just to see what
> would happen I commented out the return when multiple devices are found
> and just let the driver load. The driver then  appears to load ok and I
> can mount the MMC card and still access the EEPROM.

Presumably that means you're doing mutual exclusion "by hand"
and accessing one device at a time. 

If you access both devices concurrently -- say, running a
script that loops over EEPROM access in the background while
runing an FSCK over MMC in the foreground -- I'd expect you
to see problems caused by EEPROM operations appearing in the
midst of multi-phase MMC operations.


> Is there a patch to correctly handle the shared bus issue?

Nothinge mergeable.


> If not has anyone thought about what might need to be done?

Yes; check the list archives.

 
> Also, I have hooked up the card detect irq thru the
> host->pdata->init(&spi->dev, mmc_spi_detect_irq, mmc) call and added a
> comment in mmc_spi_detect_irq() to make sure it is called. Nothing
> happens after that. I haven't looked into what mmc_detect_change() does
> yet but shouldn't I see a new message from the mmc stuff about a "new
> MMC card on SPI"?

Are you actually getting the IRQ?

However, card detection can be a bit troublesome for various reasons,
and there's a known (but un-solved) issue whereby MMC-over-SPI really
wants to start out with a card that's just been through a power cycle
reset.

- Dave

 
> Maybe I'm just missing something... still pretty new at this whole Linux
> thing... ;-)
> 
> Thanks for the help,
> Hartley Sweeten
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
