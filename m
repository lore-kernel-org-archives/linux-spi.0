From: Stanislaw Gruszka <stf_xl-5tc4TXWwyLM@public.gmane.org>
Subject: Problem with spi_device->max_speed_hz = 0 on
	atmel_spi driver.
Date: Tue, 9 Dec 2008 12:46:55 +0100
Message-ID: <200812091246.55718.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi.

For some reason I have to slowdown clock to touchscreen device.

In atmel_spi_setup() there is comment that max_speed_hz == 0 
means as slow as possible and divider is set to maximum value.
But in atmel_spi_transfer() function is check against not zero 
max_speed_hz with EINVAL returned. 

Probably driver should setup divider for each transfer based 
on transfer->speed_hz value, but I think that would be not
necessary overhead as all used devices have constant clock. 

Below patch works fine for me.

Signed-off-by: Stanislaw Gruszka <stf_xl-5tc4TXWwyLM@public.gmane.org>
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 8abae4a..eec8f11 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -626,8 +626,7 @@ static int atmel_spi_transfer(struct spi_device *spi, struct spi_message *msg)
 	dev_dbg(controller, "new message %p submitted for %s\n",
 			msg, spi->dev.bus_id);
 
-	if (unlikely(list_empty(&msg->transfers)
-			|| !spi->max_speed_hz))
+	if (unlikely(list_empty(&msg->transfers)))
 		return -EINVAL;
 
 	if (as->stopping)


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
