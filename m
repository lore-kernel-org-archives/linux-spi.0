From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 47/49] spi: davinci: remove unnecessary private data member
	'region_size'
Date: Wed, 17 Nov 2010 16:14:19 +0530
Message-ID: <1289990661-30126-48-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
	<1289990661-30126-42-git-send-email-nsekhar@ti.com>
	<1289990661-30126-43-git-send-email-nsekhar@ti.com>
	<1289990661-30126-44-git-send-email-nsekhar@ti.com>
	<1289990661-30126-45-git-send-email-nsekhar@ti.com>
	<1289990661-30126-46-git-send-email-nsekhar@ti.com>
	<1289990661-30126-47-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-47-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Remove unnecesary private data member 'region_size'
being used to store the size of SPI memory region.

Instead, get the memory resource size directly from
the platform data.

Tested-By: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 42314a32..f6f63d0 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -129,7 +129,6 @@ struct davinci_spi {
 	u8			version;
 	resource_size_t		pbase;
 	void __iomem		*base;
-	size_t			region_size;
 	u32			irq;
 	struct completion	done;
 
@@ -835,17 +834,15 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	}
 
 	davinci_spi->pbase = r->start;
-	davinci_spi->region_size = resource_size(r);
 	davinci_spi->pdata = pdata;
 
-	mem = request_mem_region(r->start, davinci_spi->region_size,
-					pdev->name);
+	mem = request_mem_region(r->start, resource_size(r), pdev->name);
 	if (mem == NULL) {
 		ret = -EBUSY;
 		goto free_master;
 	}
 
-	davinci_spi->base = ioremap(r->start, davinci_spi->region_size);
+	davinci_spi->base = ioremap(r->start, resource_size(r));
 	if (davinci_spi->base == NULL) {
 		ret = -ENOMEM;
 		goto release_region;
@@ -972,7 +969,7 @@ irq_free:
 unmap_io:
 	iounmap(davinci_spi->base);
 release_region:
-	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
+	release_mem_region(davinci_spi->pbase, resource_size(r));
 free_master:
 	kfree(master);
 err:
@@ -992,6 +989,7 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
 {
 	struct davinci_spi *davinci_spi;
 	struct spi_master *master;
+	struct resource *r;
 
 	master = dev_get_drvdata(&pdev->dev);
 	davinci_spi = spi_master_get_devdata(master);
@@ -1003,7 +1001,8 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
 	spi_master_put(master);
 	free_irq(davinci_spi->irq, davinci_spi);
 	iounmap(davinci_spi->base);
-	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(davinci_spi->pbase, resource_size(r));
 
 	return 0;
 }
-- 
1.7.3.2
