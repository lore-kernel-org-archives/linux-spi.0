From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 7/7] spi: topcliff-pch: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:23:10 +0900
Message-ID: <002b01cf6384$4191f0b0$c4b5d210$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Alexander Stein' <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index f406b30..f05abf8 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1578,14 +1578,11 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct pch_pd_dev_save *pd_dev_save;
 
 	pd_dev_save = kzalloc(sizeof(struct pch_pd_dev_save), GFP_KERNEL);
-	if (!pd_dev_save) {
-		dev_err(&pdev->dev, "%s Can't allocate pd_dev_sav\n", __func__);
+	if (!pd_dev_save)
 		return -ENOMEM;
-	}
 
 	board_dat = kzalloc(sizeof(struct pch_spi_board_data), GFP_KERNEL);
 	if (!board_dat) {
-		dev_err(&pdev->dev, "%s Can't allocate board_dat\n", __func__);
 		retval = -ENOMEM;
 		goto err_no_mem;
 	}
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
