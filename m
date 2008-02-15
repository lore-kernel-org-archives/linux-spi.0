From: "Meng Hu" <meng.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: A question on Omap McSPI read/write
Date: Fri, 15 Feb 2008 11:02:50 -0600
Message-ID: <94d6903b0802150902m26de2cdfm2d99abeaad1e13d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi

I am working on a SPI device driver on an Omap2 board. The McSPI
driver is the TI one.
I found a strange issue with read and write.
So my SPI word length is set to 8. I have the following code sequence:

omap2_mcspi_raw_writetochannel( &spi_dev, 0xa1)
omap2_mcspi_raw_readfromchannel ( &spi_dev, dataout)

Say the data I expect from my device is 0xb1, now "dataout" value will
be 0xa1b1.
If I write 0xa2 in the first step, the "dataout" value will be  0xa2b1.
I don't understand why the data I wrote to SPI would be read as part
of the read operation. I think they are two different registers.

Here is my McSPI debug info:

MCSPI: entering omap2_mcspi_raw_writetochannel
MCSPI INFO: R[0xd809a000+0x30]=0x6
MCSPI INFO: W[0xd809a000+0x38]=0xa1
MCSPI: exiting omap2_mcspi_raw_writetochannel ret: 0
MCSPI: entering omap2_mcspi_disable_channel
MCSPI INFO: W[0xd809a000+0x34]=0x0
MCSPI: exiting omap2_mcspi_disable_channel ret: 0
MCSPI: entering omap2_mcspi_raw_readfromchannel
MCSPI INFO: R[0xd809a000+0x30]=0x7
MCSPI INFO: R[0xd809a000+0x3c]=0xa1b1
MCSPI: exiting omap2_mcspi_raw_readfromchannel ret: 0

Is this normal? Since the word length is 8, I probably just need to
use 8 least significant bits of "dataout".  But my question is 0xa1
should be in MCSPI_TX1 while
"dataout" should be from MCSPI_TX1. Why I am seeing 0xa1 as part of dataout?

BTW: Do I need to enable channel before every read? It seems to work
without enabling.

Thank you in advance for any input!

- Meng

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
