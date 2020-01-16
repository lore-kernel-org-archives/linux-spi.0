From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 4.19 370/671] spi: spi-fsl-spi: call spi_finalize_current_message() at the end
Date: Thu, 16 Jan 2020 12:00:08 -0500
Message-ID: <20200116170509.12787-107-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116170509.12787-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

[ Upstream commit 44a042182cb1e9f7916e015c836967bf638b33c4 ]

spi_finalize_current_message() shall be called once all
actions are finished, otherwise the last actions might
step over a newly started transfer.

Fixes: c592becbe704 ("spi: fsl-(e)spi: migrate to generic master queueing")
Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 8b79e36fab21..cd784552de7f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -407,7 +407,6 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	m->status = status;
-	spi_finalize_current_message(master);
 
 	if (status || !cs_change) {
 		ndelay(nsecs);
@@ -415,6 +414,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	}
 
 	fsl_spi_setup_transfer(spi, NULL);
+	spi_finalize_current_message(master);
 	return 0;
 }
 
-- 
2.20.1
