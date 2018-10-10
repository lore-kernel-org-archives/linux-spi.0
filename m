From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] eeprom: at25: Drop obsolete cast in at25_ee_write()
Date: Wed, 10 Oct 2018 15:40:34 +0200
Message-ID: <20181010134036.8296-2-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010134036.8296-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
dependency") changed the type of "off" from "loff_t" to "unsigned int",
there is no longer a need to cast it to "unsigned".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 840afb398f9e4c88..7707d3fb49b526d9 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -160,7 +160,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	do {
 		unsigned long	timeout, retries;
 		unsigned	segment;
-		unsigned	offset = (unsigned) off;
+		unsigned	offset = off;
 		u8		*cp = bounce;
 		int		sr;
 		u8		instr;
-- 
2.17.1
