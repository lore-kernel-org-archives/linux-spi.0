From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH resubmit 2/2] spi: fsl-espi: make use of max_msg_size in
 spi_master to handle HW restrictions
Date: Mon, 30 Nov 2015 21:25:36 +0100
Message-ID: <565CB0C0.9060104@gmail.com>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk> <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk> <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Propagate the 64K message size limitation allowing client drivers
to deal properly with this limitation.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c27124a..773bbab 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -670,6 +670,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	master->cleanup = fsl_espi_cleanup;
 	master->transfer_one_message = fsl_espi_do_one_msg;
 	master->auto_runtime_pm = true;
+	master->max_msg_size = SPCOM_TRANLEN_MAX;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
 
-- 
2.6.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
