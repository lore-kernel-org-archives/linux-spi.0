From: <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH trivial] spi: spi-mem: Fix typo, s/fallback/falls back
Date: Sun, 16 Feb 2020 21:40:17 +0000
Message-ID: <20200216214012.1106658-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

"Fallback" in one word is a noun. "Fall back" is two separate words,
a verb and an adverb. Use the latter.

Signed-off-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e5a46f0eb93b..3c46747bacb1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -487,7 +487,7 @@ static ssize_t spi_mem_no_dirmap_write(struct spi_mem_d=
irmap_desc *desc,
  * This function is creating a direct mapping descriptor which can then be=
 used
  * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_writ=
e().
  * If the SPI controller driver does not support direct mapping, this func=
tion
- * fallback to an implementation using spi_mem_exec_op(), so that the call=
er
+ * falls back to an implementation using spi_mem_exec_op(), so that the ca=
ller
  * doesn't have to bother implementing a fallback on his own.
  *
  * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
--=20
2.23.0
