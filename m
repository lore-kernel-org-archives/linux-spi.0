From: David LAMPARTER <lists-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: [ANNOUNCE] ftdi_spi FT2232 SPI master driver
Date: Wed, 04 Feb 2009 23:45:55 +0100
Message-ID: <1233787555.8074.28.camel@arkology.n2.diac24.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


I just hacked up a SPI master driver for FTDI's FT2232(C/D/L)
USB-to-serial converter chip. It uses this chip's special
"MPSSE" (multiprotocol serial something engine).

Driver is, well, a hack for now. As you can see from the code, I tested
it with an AT45DB161D flash device; it works pretty fine.

The driver can be found at
http://git.spaceboyz.net/?p=equinox/ftdi_spi.git;a=summary

and should work with any recent kernel; you might want to edit the
source though - for now it always puts an AT45DB161D device at CS# pin
4. I figure I need a way to tell the driver what SPI devices to attach;
I got started putting some device attributes but I'm not too sure if
this is a good way to go.

This is my first driver, created with some copy&pasting from ftdi_sio,
few bits from atmel_spi and some lines from libftdi; feedback *very*
welcome. Only SPI mode 0 is tested really, I'm to confused to figure out
the proper engine commands for the other modes. (I might have gotten
Mode 2 right, the others are probably wrong.)

(Actually - is anyone even interested in this? I figure this driver
isn't much use to anybody except maybe embedded systems developers.)


-David



------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
