From: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
Subject: [PATCH] Avoid spidev crash when device is
	removed
Date: Sun, 26 Oct 2008 00:49:11 +0200
Message-ID: <1224974951.4879.39.camel@galileo.recco.de>
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

I saw a kernel oops in spidev_remove() when a spidev device was
registered and I unloaded the SPI master driver:

Unable to handle kernel paging request for data at address 0x00000004           
Faulting instruction address: 0xc01c0c50                                        
Oops: Kernel access of bad area, sig: 11 [#1]                                   
CDSPR                                                                           
Modules linked in: spi_ppc4xx(-)                                                
NIP: c01c0c50 LR: c01bf9e4 CTR: c01c0c34                                        
REGS: cec89c30 TRAP: 0300   Not tainted  (2.6.27.3izt)                          
MSR: 00021000 <ME>  CR: 24000228  XER: 20000007                                 
DEAR: 00000004, ESR: 00800000                                                   
TASK = cf889040[2070] 'rmmod' THREAD: cec88000                                  
GPR00: 00000000 cec89ce0 cf889040 cec8e000 00000004 cec8e000 ffffffff 00000000  
GPR08: 0000001c c0336380 00000000 c01c0c34 00000001 1001a338 100e0000 100df49c  
GPR16: 100b54c0 100df49c 100ddd20 100f05a8 100b5340 100efd68 00000000 00000000  
GPR24: 100ec008 100f0428 c0327788 c0327794 cec8e0ac cec8e000 c0336380 00000000  
NIP [c01c0c50] spidev_remove+0x1c/0xe4                                          
LR [c01bf9e4] spi_drv_remove+0x2c/0x3c                                          
Call Trace:                                                                     
[cec89d00] [c01bf9e4] spi_drv_remove+0x2c/0x3c                                  
[cec89d10] [c01859a0] __device_release_driver+0x78/0xb4                         
[cec89d20] [c0185ab0] device_release_driver+0x28/0x44                           
[cec89d40] [c0184be8] bus_remove_device+0xac/0xd8                               
[cec89d60] [c0183094] device_del+0x100/0x194                                    
[cec89d80] [c0183140] device_unregister+0x18/0x30                               
[cec89da0] [c01bf30c] __unregister+0x20/0x34                                    
[cec89db0] [c0182778] device_for_each_child+0x38/0x74                           
[cec89de0] [c01bf2d0] spi_unregister_master+0x28/0x44                           
[cec89e00] [c01bfeac] spi_bitbang_stop+0x1c/0x58                                
[cec89e20] [d908a5e0] spi_ppc4xx_of_remove+0x24/0x7c [spi_ppc4xx]
[...]

IMHO a call to spi_set_drvdata() is missing in spidev_probe(). The patch
below helped.

Signed-Off-By: Wolfgang Ocker <weo-pMF0Ia4UJXeoYr4blSSd5g@public.gmane.org>
---

--- linux-2.6.27.3/drivers/spi/spidev.c.set_drvdata	2008-10-22 23:38:01.000000000 +0200
+++ linux-2.6.27.3/drivers/spi/spidev.c	2008-10-26 00:40:35.000000000 +0200
@@ -598,7 +598,9 @@ static int spidev_probe(struct spi_devic
 	}
 	mutex_unlock(&device_list_lock);
 
-	if (status != 0)
+	if (status == 0)
+		spi_set_drvdata(spi, spidev);
+	else
 		kfree(spidev);
 
 	return status;




-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
