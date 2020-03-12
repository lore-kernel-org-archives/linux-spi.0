From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
Date: Thu, 12 Mar 2020 14:31:54 +0300
Message-ID: <20200312113154.GC20562@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Adam Ford <aford173@gmail.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The platform_get_resource_byname() function returns NULL on error, it
doesn't return error pointers.

Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The commit message for commit d166a73503ef ("spi: fspi: dynamically
alloc AHB memory") is not very good.  Why is it necessary to allocate
the AHB memory dynamically instead of during probe?  Also I suspect that
Adam should have recieved authorship credit for that patch.

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 019f40e2917c..1ccda82da206 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1019,8 +1019,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
-	if (IS_ERR(res)) {
-		ret = PTR_ERR(res);
+	if (!res) {
+		ret = -ENODEV;
 		goto err_put_ctrl;
 	}
 
-- 
2.20.1
