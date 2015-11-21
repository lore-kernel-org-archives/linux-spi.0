From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] mtd: m25p80: handle HW message size restrictions
Date: Sun, 22 Nov 2015 00:08:02 +0100
Message-ID: <5650F952.2060409@gmail.com>
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

Extend m25p80_read allowing to read in chunks in case the
SPI HW has a max supported message size.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index c9c3b7f..df4c510 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -115,11 +115,7 @@ static inline unsigned int m25p80_rx_nbits(struct spi_nor *nor)
 	}
 }
 
-/*
- * Read an address range from the nor chip.  The address range
- * may be any size provided it is within the physical boundaries.
- */
-static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
+static int _m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
 	struct m25p *flash = nor->priv;
@@ -153,6 +149,39 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 }
 
 /*
+ * Read an address range from the nor chip.  The address range
+ * may be any size provided it is within the physical boundaries.
+ */
+static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
+                       size_t *retlen, u_char *buf)
+{
+	struct m25p *flash = nor->priv;
+	size_t cmd_len, xfer_len, max_len;
+	int ret = 0;
+
+	/* convert the dummy cycles to the number of bytes */
+	cmd_len = m25p_cmdsz(nor) + nor->read_dummy / 8;
+
+	max_len = flash->spi->master->max_msg_size ?: SIZE_MAX;
+
+	if (unlikely(max_len < cmd_len))
+		return -EINVAL;
+
+	max_len -= cmd_len;
+
+	while (len) {
+		xfer_len = min(len, max_len);
+		ret = _m25p80_read(nor, from, xfer_len, retlen, buf);
+		if (ret < 0)
+			break;
+		from += xfer_len;
+		len -= xfer_len;
+	}
+
+	return ret;
+}
+
+/*
  * board specific setup should have ensured the SPI clock used here
  * matches what the READ command supports, at least until this driver
  * understands FAST_READ (for clocks over 25 MHz).
-- 
2.6.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
