From: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: [PATCH 2/2 v2] xilinx_spi: test below 0 on
	unsigned irq in xilinx_spi_probe()
Date: Thu, 24 Apr 2008 09:35:09 +0200
Message-ID: <4810382D.8040405@tiscali.nl>
References: <480F99D5.7070300@tiscali.nl> <480FA248.7080900@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <480FA248.7080900-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
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

Joe Perches wrote:
> On Wed, 2008-04-23 at 22:55 +0200, Roel Kluin wrote:

>> -	xspi->irq = platform_get_irq(dev, 0);
>> -	if (xspi->irq < 0) {
>> -		ret = -ENXIO;
>> +	ret = platform_get_irq(dev, 0);
>> +	if (ret < 0)
>>  		goto unmap_io;
>> -	}
>> +
>> +	xspi->irq = ret;
>> +	ret = 0;
> 
> Is the only negative return from platform_get_irq ENXIO?
> I think you still need the ret = -ENXIO before the goto.
> 
> Also, you don't need the ret = 0 line, it's set again
> a few lines below.
> 
> I think you should end up with:
> 
> 	ret = platform_get_irq(dev, 0);
> 	if (ret < 0) {
> 		ret = -ENXIO;
> 		goto unmap_io;
> 	}
> 
> 	xspi->irq = ret;
> 
> cheers, Joe

In that case, this should suffice,

thanks again,

Roel
---
xilinx_spi->irq is unsigned, so the test fails

Signed-off-by: Roel Kluin <12o3l-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
---
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index cf6aef3..2a471b3 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -353,11 +353,12 @@ static int __init xilinx_spi_probe(struct platform_device *dev)
 		goto put_master;
 	}
 
-	xspi->irq = platform_get_irq(dev, 0);
-	if (xspi->irq < 0) {
+	ret = platform_get_irq(dev, 0);
+	if (ret < 0) {
 		ret = -ENXIO;
 		goto unmap_io;
 	}
+	xspi->irq = ret;
 
 	master->bus_num = pdata->bus_num;
 	master->num_chipselect = pdata->num_chipselect;

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
