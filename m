Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067231;
	b=JRNpmXyJzeCwYwW6rQ9baYhsM0Xx983cbrHp2eoX11aBFcmW+N7i6DISrsDjxUXc+X86
	 ruLDDWYkDIJgAIu1n5vI0FdfrxdnYCtGmXfq7ZiojrGFPPRv5K4yUVJs4K44HeUaAhf2r
	 MBhtCXlfhG0f0MV8rjYRerR0gxecSoEdS8p/MzlQc65vgxp0gFUoRclDIAopDW7e05Eyk
	 YpFCCzUjCCd0ZMrbvQXXaMSGI80Yye94YRSj5moYB62fwtIgMZ9oy5EP3gKDb6i66iXRd
	 34FAFgYmgB9w21RyO7y+WFzg4/3dnHlttlv23yMt0syq1B89bIqtf/B+c8wZjCw0y4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067231;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+QqJ3MP87LH56I8e79plHZFvlGY9nfaKMQuxuVHnt5s=;
	b=L+YV04/4TNfaC1/Io0OvzCRbqa8TSZJXkCac+tNk4MV8UBZTFrOP2mV5oaJQ9R8bKSX7
	 AJWzlJFsJJISCTgxWCseciYzNxi/XgRaHIvckWxfz8aLCBkqWMu6UqONYkCQIymYNYBml
	 wkdFvHNGBq4K/W0pftAXijav479Iq7zFcSROPdfkOARzHs2PC+P5qwItsZaPfHf2n0qgw
	 QfJjoZezyHbAVXra5luV6bhObXpcpLRAzKeStttRJ0c1mrfLldLZZvtEEhLhh6jUg1D0V
	 qsERoRsuVpTqqpBWC23pzgjdfMWxmbwTzpzZIBhGIJ+HUJ5JLw/HGEDFtDJkykxjThA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=iNn7ouVv;
	arc=none smtp.remote-ip=115.124.28.101
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8AF606A330;
	Tue, 27 Oct 2026 02:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8AF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=iNn7ouVv
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793067221; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+QqJ3MP87LH56I8e79plHZFvlGY9nfaKMQuxuVHnt5s=;
	b=iNn7ouVv7Q/LpXQjwurckJmOcakluKelqe05lloZIcZf8aML2Evai14sxJfnj0GnGYogB/jz3l8I5I7hHW59p76Fff9mTULw0FFT2NeiGwh0VXQysx/vc4Iw+YDtduZgX6VR605dleSlAt4Z+/raIXWwr1FedbL/hOawk5oUBFs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436354|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0107003-0.00186829-0.987431;FP=11119641135974073566|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=liuwb@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jqHVwuv_1793067220;
Received: from localhost(mailfrom:liuwb@xiaopeng.com fp:SMTPD_---.jqHVwuv_1793067220 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 10:13:40 +0800
From: Weibin Liu <liuwb@xiaopeng.com>
To: Raju.Rangoju@amd.com,
	krishnamoorthi.m@amd.com,
	broonie@kernel.org,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhugl3@xiaopeng.com
Subject: [PATCH] spi: amd: validate FIFO usage before executing message
Date: Tue, 27 Oct 2026 10:13:40 +0800
Message-ID: <20261027021340.914399-1-liuwb@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX FIFO bound is checked in the drain loop, after
amd_spi_execute_opcode(). A message whose cumulative RX length exceeds
AMD_SPI_FIFO_SIZE can therefore issue an SPI transaction before being
rejected.

Check tx_len + rx_len while walking the message and drop the drain-loop
check. This validates the complete message before executing the command.

Tested with a user-space replica covering TX, RX and mixed messages at
the 70/71-byte boundary. Oversized split-RX messages are now rejected
without executing the command. No AMD SPI hardware was available.

Assisted-by: LLM
Suggested-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Fixes: e2f4edfc061e ("spi: amd: fix len==0 underflow and FIFO overflow")
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
---
 drivers/spi/spi-amd.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index ddf89e5353c5..d3953de255be 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -331,13 +331,6 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 		else
 			amd_set_spi_freq(amd_spi, spi->max_speed_hz);
 
-		/* Reject transfers that would overflow the FIFO window */
-		if (fifo_pos + xfer->len >
-		    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
-			message->status = -EMSGSIZE;
-			goto fin_msg;
-		}
-
 		if (xfer->tx_buf) {
 			buf = (u8 *)xfer->tx_buf;
 			if (!tx_len) {
@@ -346,6 +339,10 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 				xfer->len--;
 			}
 			tx_len += xfer->len;
+			if (tx_len + rx_len > AMD_SPI_FIFO_SIZE) {
+				message->status = -EMSGSIZE;
+				goto fin_msg;
+			}
 
 			/* Write data into the FIFO. */
 			for (i = 0; i < xfer->len; i++)
@@ -355,8 +352,13 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 		}
 
 		/* Store no. of bytes to be received from FIFO */
-		if (xfer->rx_buf)
+		if (xfer->rx_buf) {
 			rx_len += xfer->len;
+			if (tx_len + rx_len > AMD_SPI_FIFO_SIZE) {
+				message->status = -EMSGSIZE;
+				goto fin_msg;
+			}
+		}
 	}
 
 	if (!buf) {
@@ -380,12 +382,6 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 
 		list_for_each_entry(xfer, &message->transfers, transfer_list)
 			if (xfer->rx_buf) {
-				/* Reject transfers that would overflow the FIFO window */
-				if (fifo_pos + xfer->len >
-				    AMD_SPI_FIFO_BASE + AMD_SPI_FIFO_SIZE) {
-					message->status = -EMSGSIZE;
-					goto fin_msg;
-				}
 				buf = (u8 *)xfer->rx_buf;
 				/* Read data from FIFO to receive buffer */
 				for (i = 0; i < xfer->len; i++)

base-commit: dc5ca34f5e8dc10c566ef39aa3b1a201a17ca734
-- 
2.50.1

