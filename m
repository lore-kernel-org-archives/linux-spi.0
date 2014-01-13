From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: sh: Use spi_sh_clear_bit() instead of open-coded
Date: Mon, 13 Jan 2014 10:00:44 +0800
Message-ID: <1389578444.18562.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We have a spi_sh_clear_bit() function, there's no reason not to use it.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-sh.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index c120a70..9fea8cc 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -171,7 +171,6 @@ static int spi_sh_send(struct spi_sh_data *ss, struct spi_message *mesg,
 	int remain = t->len;
 	int cur_len;
 	unsigned char *data;
-	unsigned long tmp;
 	long ret;
 
 	if (t->len)
@@ -213,9 +212,7 @@ static int spi_sh_send(struct spi_sh_data *ss, struct spi_message *mesg,
 	}
 
 	if (list_is_last(&t->transfer_list, &mesg->transfers)) {
-		tmp = spi_sh_read(ss, SPI_SH_CR1);
-		tmp = tmp & ~(SPI_SH_SSD | SPI_SH_SSDB);
-		spi_sh_write(ss, tmp, SPI_SH_CR1);
+		spi_sh_clear_bit(ss, SPI_SH_SSD | SPI_SH_SSDB, SPI_SH_CR1);
 		spi_sh_set_bit(ss, SPI_SH_SSA, SPI_SH_CR1);
 
 		ss->cr1 &= ~SPI_SH_TBE;
@@ -239,7 +236,6 @@ static int spi_sh_receive(struct spi_sh_data *ss, struct spi_message *mesg,
 	int remain = t->len;
 	int cur_len;
 	unsigned char *data;
-	unsigned long tmp;
 	long ret;
 
 	if (t->len > SPI_SH_MAX_BYTE)
@@ -247,9 +243,7 @@ static int spi_sh_receive(struct spi_sh_data *ss, struct spi_message *mesg,
 	else
 		spi_sh_write(ss, t->len, SPI_SH_CR3);
 
-	tmp = spi_sh_read(ss, SPI_SH_CR1);
-	tmp = tmp & ~(SPI_SH_SSD | SPI_SH_SSDB);
-	spi_sh_write(ss, tmp, SPI_SH_CR1);
+	spi_sh_clear_bit(ss, SPI_SH_SSD | SPI_SH_SSDB, SPI_SH_CR1);
 	spi_sh_set_bit(ss, SPI_SH_SSA, SPI_SH_CR1);
 
 	spi_sh_wait_write_buffer_empty(ss);
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
