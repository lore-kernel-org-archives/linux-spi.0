From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch -resend] spi/spidev: handle integer wrap in spidev_message()
Date: Wed, 27 Jun 2012 12:02:15 +0300
Message-ID: <20120627090215.GG31212@elgon.mountain>
References: <20120627085800.GA3007@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120627085800.GA3007@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

"k_tmp->len" and "total" are unsigned integers.  The first message
could be close to "bufsiz" (4096) and then the next message could be
4GB which would cause an integer overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have a way to test this.  I originally sent this message on Tue,
18 Oct 2011.  I'm not totally sure what the implications are but it
seemed like there might be security implications.  I honestly don't
know.  I never received any feedback on the patch.

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 830adbe..aab05e1 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -241,7 +241,7 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->len = u_tmp->len;
 
 		total += k_tmp->len;
-		if (total > bufsiz) {
+		if (total > bufsiz || total < k_tmp->len) {
 			status = -EMSGSIZE;
 			goto done;
 		}
