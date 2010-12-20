From: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: problem accessing ADS1256 spi Analog/Digital converter from spidev
	driver
Date: Mon, 20 Dec 2010 10:24:38 -0200
Message-ID: <AANLkTikL0Q8KYDainBMHp6dDkQ4yKV8uUNyUwvBQN_Qo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kleiton Blane <kblane_sp-/E1597aS9LRfJ/NunPodnw@public.gmane.org>
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

    Hello all, I'm need access the ADS1256 spi analog/digital converter (
http://focus.ti.com/docs/prod/folders/print/ads1256.html )
from a Linux 2.6.32-2 kernel running on a friendlyARM board (
http://www.friendlyarm.net/products/micro2440?lang=en
) that uses a Samsung S3C2440 ARM processor and I'm using the spidev module
to do the access in user space.

    I'm using the SPI1 processor SPI channel because the SPI0 processor
pinout was not delivered from core board, but I believe this is not a
problem, the system configuration is the same from SPI0 ?
    When I try to read anything from A/D I can only read random data, for
example if I do a command to read the 11 registers values I have only random
data, some values on A/D answer it seems with the correct values but in the
wrong registers position. The procedure is write() in user space with the
command and after read() the A/D response.

    Searching the web I noticed that several people has the same problem and
it is related with the rigid timing between the last bit from MOSI (the
command from CPU) and the first bit from MISO (answer from A/D), this time
is always 50*clock_period (8us when using 6MHz clock), and I believe that
has some problem with the S3C2440 spi driver because when occurs the spi
interrupt the irq handler cannot read the correct value from spi controller
(I don't know why), maybe this is because this interrupt handler was called
too late, if this is the problem there any way to speed up this irq handler
?

    Someone can identify from datasheet information the SPI mode that this
ads1255/56 works ?
    Someone experienced some similar problem and there's some way to read
data correctly for this chip ?
    Use spidev is the best choose to do access to this chip ?

Thanks in advance

Flavio Alberto Lopes Soares
------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
