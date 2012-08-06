From: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
Subject: [PATCH] spi: Use PTR_RET rather than if(IS_ERR(.. [1]
Date: Mon, 06 Aug 2012 19:51:17 +0200
Message-ID: <1344275477.14513.113.camel__20750.8161468015$1344277936$gmane$org@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: [grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org]
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

The semantic patch that makes this change is available
in scripts/coccinelle/api/ptr_ret.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Thomas Meyer <thomas-VsYtu1Qij5c@public.gmane.org>
---

diff -u -p a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -1134,9 +1134,7 @@ static int __devinit plat_mpc8xxx_spi_pr
 		return -EINVAL;
 
 	master = fsl_spi_probe(&pdev->dev, mem, irq);
-	if (IS_ERR(master))
-		return PTR_ERR(master);
-	return 0;
+	return PTR_RET(master);
 }
 
 static int __devexit plat_mpc8xxx_spi_remove(struct platform_device *pdev)

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
