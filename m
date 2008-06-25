From: "Zik Saleeba" <zik-fsgeVU6Z5FysTnJN9+BGXg@public.gmane.org>
Subject: Problems with latency
Date: Wed, 25 Jun 2008 16:02:10 +1000
Message-ID: <33e9dd1c0806242302y4e39b869n4a64f4955cc71dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0805620175=="
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

--===============0805620175==
Content-Type: multipart/alternative;
	boundary="----=_Part_30404_31158448.1214373730478"

------=_Part_30404_31158448.1214373730478
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm writing a driver for the NXP sc16is752 serial chip. This chip is
accessed via SPI. I've actually had a working driver for quite some time now
but I've been having problems with it since I changed from 2.6.16 to
2.6.24.Occasionally the driver fails due to its 64 byte receive buffer
overflowing
before I can get the data.

I've set the serial chip's receive buffer interrupt level to 16 bytes - so
after I've received 16 bytes I have to get the data before the buffer
overflows its 64 byte limit. This isn't too demanding - I need to have it
done within 8ms of getting the interrupt at 57600bps. The tricky part is
that I need to do three separate register reads to get status before I can
do the final buffer read so it's actually four SPI transactions. And what's
more the chip has two serial ports so I need to check both - which makes it
up to eight SPI transactions.

Normally this is absolutely no problem - the bottom half work queue fires up
and the SPI subsystem on my pxa2xx romps it in. Once in a while however the
latency between the interrupt and removing the data is much, much longer and
the chip's receive buffer overflows. This happens enough that it makes the
driver unusable at higher bit rates.

Does anyone have any suggestions what might be causing these random latency
jumps, and also whether it might be related to work queue latency or to
pxa2xx spi delays?

Thanks,
Zik

------=_Part_30404_31158448.1214373730478
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m writing a driver for the NXP sc16is752 serial chip. This chip is accessed via SPI. I&#39;ve actually had a working driver for quite some time now but I&#39;ve been having problems with it since I changed from 2.6.16 to <a href="http://2.6.24.">2.6.24.</a> Occasionally the driver fails due to its 64 byte receive buffer overflowing before I can get the data.<br>
<br>I&#39;ve set the serial chip&#39;s receive buffer interrupt level to 16 bytes - so after I&#39;ve received 16 bytes I have to get the data before the buffer overflows its 64 byte limit. This isn&#39;t too demanding - I need to have it done within 8ms of getting the interrupt at 57600bps. The tricky part is that I need to do three separate register reads to get status before I can do the final buffer read so it&#39;s actually four SPI transactions. And what&#39;s more the chip has two serial ports so I need to check both - which makes it up to eight SPI transactions.<br>
<br>Normally this is absolutely no problem - the bottom half work queue fires up and the SPI subsystem on my pxa2xx romps it in. Once in a while however the latency between the interrupt and removing the data is much, much longer and the chip&#39;s receive buffer overflows. This happens enough that it makes the driver unusable at higher bit rates.<br>
<br>Does anyone have any suggestions what might be causing these random latency jumps, and also whether it might be related to work queue latency or to pxa2xx spi delays?<br><br>Thanks,<br>Zik<br>

------=_Part_30404_31158448.1214373730478--


--===============0805620175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============0805620175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0805620175==--
