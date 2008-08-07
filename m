From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pxa2xx_spi with SFRM
Date: Thu, 07 Aug 2008 14:03:22 -0400
Message-ID: <489B38EA.8030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Hi,

I am using a custom PXA270 board and tried to use the SSP port to 
communication with a SPI Flash. After reading docs on how to configure 
the spi_master and spi devices, I have the device driver's probe being 
called. But I cannot get the pxa2xx_spi driver to work correctly. I can 
connect either a SD card or a M26P16 Flash chip to the SPI port on my 
board. Neither device driver can completely operate their device.

It looks like it is impossible for the device drivers to control the 
chip select (CS) line. If I use the manual cs_control callback, the 
timing is invalid because the SSP clock keeps running. That means that 
several bits are clocked out before the SSP controller starts to drive 
the TX line correctly. If the SFRM signal is used, it does not allow the 
driver to keep CS active for multiple transactions as they expect and 
assume. The spi_sync call takes an spi_message which contains a list of 
transactions to send. Normally, the device will need the CS active 
during the complete message. But the SSP controller deactivates SFRM 
when it is done with each buffer. For instance, the M25P16 datasheet 
indicates that CS has to stay active from the READ command through the 
complete data transfer. When it goes high, it resets the command interface.

It looks like the SSP port needs to have a register bit to turn off the 
clock when there is nothing to transmit. Or a bit to tell the SSP 
controller to leave CS active. Or I can change the HW so CS gates the 
clock and a manual CS chip operates the device CS pin. I might also try 
the bitbanging SPI driver next to see if that can operate with the Flash 
chip.

Is there some other setting I am missing here? Is anyone else using the 
M25P16 chip with PXA270 SPI driver?

Vernon Sauder

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
