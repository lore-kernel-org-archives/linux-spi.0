From: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: mmc_spi.c driver
Date: Thu, 3 Apr 2008 18:35:33 -0400
Message-ID: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
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

Hello all,

I'm trying to use the mmc_spi.c driver on an EP93xx platform and ran
into the "can't share SPI bus" issue.

My platform currently has an EEPROM (SST25LF040A using the at25.c
driver) and a MMC socket connected to the SPI bus. Just to see what
would happen I commented out the return when multiple devices are found
and just let the driver load. The driver then  appears to load ok and I
can mount the MMC card and still access the EEPROM.

Is there a patch to correctly handle the shared bus issue? If not has
anyone thought about what might need to be done?

Also, I have hooked up the card detect irq thru the
host->pdata->init(&spi->dev, mmc_spi_detect_irq, mmc) call and added a
comment in mmc_spi_detect_irq() to make sure it is called. Nothing
happens after that. I haven't looked into what mmc_detect_change() does
yet but shouldn't I see a new message from the mmc stuff about a "new
MMC card on SPI"?

Maybe I'm just missing something... still pretty new at this whole Linux
thing... ;-)

Thanks for the help,
Hartley Sweeten


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
