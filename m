From: Gilles Casse <list-34SiRylZz+CsTnJN9+BGXg@public.gmane.org>
Subject: atmel_spi: truncated read data
Date: Mon, 8 Jun 2009 14:49:59 +0200
Message-ID: <31936.1244465399@gcasse.net>
Reply-To: Gilles Casse <list-34SiRylZz+CsTnJN9+BGXg@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello,

I observe in atmel_spi that the read data are sometimes unexpectedly truncated (board similar to at91rm9200ek, Linux 2.6.28-9, SPI transfers at 8 bits, 6Mhz) .

Everything seems ok though: no SPI overrun, the DMA RCR, RNCR counters correctly reach 0.
More details below.

What could cause this? dma issue, cached memory?
Any pointer would be greatly appreciated.

Thank you,

Gilles


* read buffer truncated

For the debug, the read buffer (rx_buf) is initialized at 0x5a (Z).
After an incorrect read, the last bytes of the read buffer are still at 'Z':

00000000  85 19 02 e0 ff 08 00 00 3e 63 97 5c 6c 03 00 00  ........>c.\l...
00000010  de 03 00 00 ed 81 00 00 00 00 00 00 00 10 04 00  ................
00000020  01 17 43 38 01 17 43 38 01 17 43 38 00 00 04 00  ..C8..C8..C8....
00000030  bb 08 00 00 00 10 00 00 06 00 00 00 ff 5a 5a 5a  .............ZZZ
00000040  5a 5a 5a 5a                                      ZZZZ


* atmel_spi sequence

For the debug, the access to the SPI/PDC registers have been traced (stored in an internal array).
The spi message has two transfers: command (8 bytes written), read data (0x44 bytes expected).

atmel_spi_transfer:
PTCR = 0x202 (RXTDIS/TXTDIS)
 RCR = 8
RNCR = 0x44
PTCR = 0x101 (RXTEN/TXTEN)

atmel_spi_interrupt:
 SR = 0x00010032
IDR = 0x00000010
RCR currently equals to 0x24
RNCR = 0
PTCR = 0x101 (RXTEN/TXTEN)

atmel_spi_interrupt:
 SR = 0x000100f2
IDR = 0x00000050
RCR and RNCR equal to 0
PTCR = 0x202 (RXTDIS/TXTDIS)




------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
