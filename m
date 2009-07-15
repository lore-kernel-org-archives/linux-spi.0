From: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Subject: speed_hz vs max_speed_hz
Date: Wed, 15 Jul 2009 13:22:07 +0200
Message-ID: <4A5DBBDF.2050901@weinigel.se>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi all,

I'm a bit confused about speed_hz and max_speed_hz.  How are they 
supposed to be used?

For example, on one board I have this:

static struct spi_board_info my_spi_board_info[] = {
         {
                 .mode           = 0,
                 .modalias       = "spidev",
                 .bus_num        = 0,
                 .irq            = IRQ_EINT00,
                 .max_speed_hz   = 4000000,
                 .chip_select    = S3C24A0_GP19,
         }
};

I have a chip connected to this bus that I know can run at 25MHz.  So 
what I would expect the above max_speed_hz to mean is that due to 
limitations of the SPI controller and the layout of the SPI wires on the 
board, even though the chip can run much faster, the maximum speed of 
this specific board is only 4MHz.

The driver I have right now sets spi_device->max_speed_hz to 25MHz 
because it "knows" that the chip can run that fast, so it will actually 
drive the chip much faster than the board supports.  Am I right in 
thinking that the driver is misbehaving and ought to set 
spi_transfer->speed_hz instead?

Also, what should the spi_setup do when passed a too high "max_speed"? 
If the SPI controller is only capable of 10MHz, what should spi_setup do 
if spi_device->max_speed_hz is 25MHz?  Should it return -EINVAL, 
silently change max_speed_hz to 10MHz, or set max_speed_hz to 25MHz and 
limit it to 10MHz when the transfer function is called?

I'd vote for changing max_speed_hz to 10MHz, since that would give the 
IMHO sanest ioctl interface, so that SPI_IOC_WR_MAX_SPEED_HZ call with a 
too high speed and a subsequent SPI_IOC_RD_MAX_SPEED_HZ would return the 
actual maximum speed.  In that case the debug printout in the write 
ioctl ought to be changed to:

     dev_dbg(&spi->dev, "%d Hz (max)\n", spi->max_speed_hz);

so that it shows the actual speed that was set.  Returning -EINVAL would 
also be a sane choice but slightly less useful.

No matter what, the ioctl should be documented as dangerous since it can 
set a clock which is faster than specified in the spi_board_info.

Or have I misunderstood everything? :-)

   /Christer


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
