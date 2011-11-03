From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 1/2 v4] atmel/spi: fix missing probe
Date: Fri,  4 Nov 2011 01:57:40 +0800
Message-ID: <1320343060-18710-1-git-send-email-plagnioj@jcrosoft.com>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
converted this driver to use module_platform_driver, but due to the use
of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
lost. Place the call to this function into the driver structure.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
v4:

	fix typo when editing commit message
 drivers/spi/spi-atmel.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 79665e2..3cd4f49 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
 	},
 	.suspend	= atmel_spi_suspend,
 	.resume		= atmel_spi_resume,
+	.probe		= atmel_spi_probe,
 	.remove		= __exit_p(atmel_spi_remove),
 };
 module_platform_driver(atmel_spi_driver);
-- 
1.7.7
