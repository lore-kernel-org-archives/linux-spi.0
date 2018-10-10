From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to optimize DMA
Date: Wed, 10 Oct 2018 15:43:17 +0200
Message-ID: <20181010134317.8466-4-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
 <20181010134317.8466-1-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134317.8466-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently EEPROM writes are implemented using a single SPI transfer,
which contains all of command, address, and payload data bytes.
As some SPI controllers impose limitations on transfers with respect to
the use of DMA, they may have to fall back to PIO. E.g. DMA may require
the transfer length to be a multiple of 4 bytes.

Optimize writes for DMA by splitting writes in two SPI transfers:
  - The first transfer contains command and address bytes,
  - The second transfer contains the actual payload data, now stored at
    the start of the (kmalloc() aligned) buffer, to improve payload
    alignment.

E.g. for a 25LC040 EEPROM with a page size 16 bytes, a 16-byte write
aligned to the page size was transferred using an 18-byte write.
After this change, the write is split in a 2-byte and an aligned 16-byte
write.

Note that EEPROM reads already use a similar scheme, due to the
different data directions for command and address bytes versus payload
data.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/eeprom/at25.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 5c8dc7ad391435f7..f84d1681835b4ded 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -136,6 +136,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	int			status = 0;
 	unsigned		buf_size;
 	u8			*bounce;
+	struct spi_transfer	t[2];
 
 	if (unlikely(off >= at25->chip.byte_len))
 		return -EFBIG;
@@ -160,7 +161,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		unsigned long	timeout, retries;
 		unsigned	segment;
 		unsigned	offset = off;
-		u8		*cp = bounce;
+		u8		*cp = bounce + buf_size;
 		int		sr;
 		u8		instr;
 
@@ -194,9 +195,17 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		segment = buf_size - (offset % buf_size);
 		if (segment > count)
 			segment = count;
-		memcpy(cp, buf, segment);
-		status = spi_write(at25->spi, bounce,
-				segment + at25->addrlen + 1);
+		memcpy(bounce, buf, segment);
+
+		memset(t, 0, sizeof(t));
+
+		t[0].tx_buf = bounce + buf_size;
+		t[0].len = at25->addrlen + 1;
+
+		t[1].tx_buf = bounce;
+		t[1].len = segment;
+
+		status = spi_sync_transfer(at25->spi, t, ARRAY_SIZE(t));
 		dev_dbg(&at25->spi->dev, "write %u bytes at %u --> %d\n",
 			segment, offset, status);
 		if (status < 0)
-- 
2.17.1
