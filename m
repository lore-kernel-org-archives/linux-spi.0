Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911101;
	b=4fb4XCu1ge8cwGFmekFGi6nEomA+/DcqRqIlPyKbYV/cHgrIM+GigkzxW0e6X4N6Gqcz
	 lfIE6V/ytG1b31Y6qWW82AJGvel+sIxiljQ6UYj/Vz8L66+dJMcgs9NMGuof9L0LSIlgJ
	 f+1KkZ8zdS4mVV3urWAEX5Wsmh/YDMzB7+llrpciSVVE0MfaATWrStGuECSGpvvczSWBb
	 ZLXRUq32cPNRemwPCCzhzWmHK2DzdTVxgF20zPn5+r57LZXW1X4520fym88FQnMi6k7+4
	 XhfQNfcbNWhkCoC2CkD0bDyianT47FhPEZowFESGoXAH059nuDIRfZJmKTw/hIl0QvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EBvELyKu2dMwI8vyGLt+92VXSFlR51MbGColCfpUNIs=;
	b=3IGGevBMI98XFMcPxkBLUAunB8jCxWFuho2GJ5EzX/jfvLDgblx9t1ThUfRo//r5iUA+
	 SOfjx3bFvToDE2ZobE87t402CTqUW9AdMHFq/SSEk4ZJNhtr0m+7jfGlg+O/1KmwJufCg
	 CkkPMTT+vg5Gr234xfULed+9l+tDVYnGs6ajKS9vC36jDkSEMswn7MLRHbiEGqqsDfef2
	 uXSEOHgUEwpIcrEsV1S8oymyCbYB0jXcWLNRBzrFTtRvtXjF4A5hvgV7fxylkBJrDcv+w
	 EAQXM9pfUtKoSIzbIaTfMpz38dSarN/fUhyOep6rXrm6ERzGEAjprVRer3CCb0LPVKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGz7yOXY;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE25606EE8C
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 20:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE25606EE8C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wGz7yOXY
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so2233738a12.1
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911100; x=1794515900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBvELyKu2dMwI8vyGLt+92VXSFlR51MbGColCfpUNIs=;
        b=wGz7yOXYTbTPQTGuouS5JXBEKQqR4OvR4Qa36lMmmpw11gaXXKrVrVGX7BuX0tq8LR
         c0hTSIdQNe/4pgvwd5H0yzZ7QPUKQnltABUbI+BrSoltMYzRm1vpO3lcQ+Hd3stwPykV
         JE27qqJk8pOI3nD0s53Jnyh5Ga0/PIptzEJinAbOThcRAMWJP+pkxrdlgSbK9x0lT/L7
         ikTXEXqAw+H8Mm0GkljIZPpBHP8Pg2w8dlIF6YwHG1Yyc5LHorfz7deyK4paGmlZjr49
         8Gf12yD4UQ9kSXYJuXZVMXCYC7h6bc9JlMLNmW8HVLtCLgToHyMBBAuuVV5uRas/Hnrw
         jFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911100; x=1794515900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBvELyKu2dMwI8vyGLt+92VXSFlR51MbGColCfpUNIs=;
        b=x1IxZ6y37BHmuXawk3nzmy8yQUuPq8MnPQVagUr496sdNH9TpV2PvSbY6BxLwhxciG
         75E3D1XcpPwLvK3NM0jcPAEi+JrBZ/AMnNjX7LZriB0zZo7EISK5x5G3G4uYTTUSvvKi
         ebATqcEms7tUNG3Wo+KMqXVYPmLjiHi5i3QhHrfVuUHXOYv5xyJOhzkwhH1gDRdILWUD
         mcqCOh4ULV+y/VsbENNojM1BJeXQfNbsUU/ACrpriGEKRFSOn1L2w5VtsJNoJVlecxk9
         1dZStg9xPyXC/dIqsQWbrms1DT21HauriELLjRtCb6SzTLIRqBIpsg9QztWsfqeNlbve
         xi0g==
X-Gm-Message-State: APuU4Z8MnI85/aF6h4Q0PKwyvuK6J36ae7Q3cOJIzcjOyFPmveHhT30L
	4fPqXdiwjcwVYynqlpm4ygOOQ3MO1k4ZnprvZ63LnZvrQFEaWV1Fg8dk
X-Gm-Gg: AYBFou3Mk/qy4UEr9xnM8p9AXkkpoU3KSS+cPX5bQ6PXIuf8ZE6OvQ4coB3QJB53qNl
	xdR5zLr5rxTLemHQCuetXIb1wzJG7rz8NjeFUBE6Uuma5r+GxNYfTFYBHXuqBFI6WQ3HLWGrTAP
	3XKrhDTIOKEaiz+7lfN06ZCnVi+SVMa214xiIBaHP00PwBZ7gtj6iGHP+IfVVZFgcg6lPjlxm+q
	C6hmBns6R0GEH0Ii3xGcFs1rQFZcRt5fVgA5nnAiGT1lwzQ8qtZKweqEQoHtMir+LLzJGugo+cJ
	POjS4lfxIOiYgDNQUGmr7NbYSLuQ6Vh8LGmxdksW9SxG5wToJEEKYppUkRbJY5uLLDLvXbf3ZPg
	pFolzY3nTkV1PuG6q+WN4LLFgF1QHU20lE/yqyFt1V3WmyBEygK2APMVFf6b3NO/+6FboPTr3jp
	QqdEYhC9hHjuWeu9zq3anS4zjVvcbhxlPZzbX6DZr8VW/dQAMCNu9os7yP4ijqf62brCjKYYxJ0
	cgxr6jtYFoLcIgjCuwef9f45PagDeT6z5LaQBhPmHVWmdZ70pA0mB5Pfs+l+NJ07X1cZE8PBz2l
	ypLRycqpVbK3v0gVbGp1pWejSTPgcLUEZwz6z83H/7AOveciy0KDDWr0UmHdyDtGXZ+aIN3y5Md
	K/3CQdbEt6bpFyN3C4ihfQSmHt+2CD5QjdpmmXQX2vMewNs8WposX7JzjKFjJCJz4yZWL68qc6o
	G44fAa/+d38R4+uT4zoyWAz/Bg1aDtbdYfhuIAXUwJ5T37MPB8+Iw12gBL+IKaPTuKBd0f
X-Received: by 2002:a05:6402:2111:b0:6b4:95cf:24f with SMTP id 4fb4d7f45d1cf-6b5977ed8f8mr277799a12.19.1793911099648;
        Thu, 05 Nov 2026 12:38:19 -0800 (PST)
Received: from mb-HP-ZBook-Power-16-inch-G11-Mobile-Workstation-PC.dynamic.ziggo.nl (2001-1c00-1106-0900-938c-4ed8-a3bb-093f.cable.dynamic.v6.ziggo.nl. [2001:1c00:1106:900:938c:4ed8:a3bb:93f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b57feb668bsm886834a12.13.2026.11.05.12.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:38:19 -0800 (PST)
From: Mario Behn <mario.behn@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mario Behn <mario.behn@gmail.com>
Subject: [PATCH v1 1/2] spi: zynq-qspi: read flash above 16 MiB via the extended address register
Date: Thu,  5 Nov 2026 21:37:33 +0100
Message-ID: <20261105203734.979168-2-mario.behn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105203734.979168-1-mario.behn@gmail.com>
References: <20261105203734.979168-1-mario.behn@gmail.com>
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


The Zynq QSPI controller sends at most 3 address bytes, and spi-nor needs
4-byte addresses for a flash larger than 16 MiB (W25Q256 on the Pluto+), so
the probe failed with -22 and no /dev/mtd* appeared.

Keep the flash in 3-byte mode and handle a 4-byte-address operation
inside the controller driver: write enable, Write Extended Address
Register with addr >> 24, the operation with the 3-byte opcode and the
low 24 address bits, then the register back to 0, so that U-Boot and the
BootROM find bank 0 after a reset. adjust_op_size keeps one read inside
a 16 MiB bank. EN4B and EX4B are swallowed so that the flash never
leaves 3-byte mode.

Also stop writing the address bytes through xqspi->txbuf into the
spi_mem_op structure; use a local buffer.

This stage is READ ONLY: every operation that does not read data (write
enable, program, erase, status register write) is refused with -EROFS.
Verified on the Pluto+ (W25Q256, ef4019): the md5 of all four partitions
equals the one read on 6.12, including the 30 MiB partition that crosses
the bank boundary.

Signed-off-by: Mario Behn <mario.behn@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 152 +++++++++++++++++++++++++++++++++---
 1 file changed, 142 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index d762aaf452af..e20019a03964 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 
 /* Register offset definitions */
 #define ZYNQ_QSPI_CONFIG_OFFSET		0x00 /* Configuration  Register, RW */
@@ -222,21 +223,69 @@ static void zynq_qspi_init_hw(struct zynq_qspi *xqspi, unsigned int num_cs)
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 }
 
+/*
+ * The controller sends at most 3 address bytes. A flash larger than 16 MiB
+ * is therefore kept in 3-byte mode and reached through the Extended Address
+ * Register (EAR): an operation with a 4-byte address is turned into
+ * WREN + WREAR(addr >> 24) + the 3-byte form of the operation, and the EAR is
+ * set back to 0 afterwards, so that U-Boot and the BootROM find the flash in
+ * bank 0 after a reset (the same scheme as the ADI 6.12 spi-nor code, but in
+ * the controller driver instead of the spi-nor core).
+ */
+#define ZYNQ_QSPI_BANK_SIZE		0x1000000U
+#define ZYNQ_QSPI_OP_WREAR		0xc5	/* Write Extended Address Register */
+
 static bool zynq_qspi_supports_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
-	if (!spi_mem_default_supports_op(mem, op))
+	struct spi_mem_op nop = *op;
+
+	/* check the shape of the operation as if the address had 3 bytes */
+	if (nop.addr.nbytes == 4)
+		nop.addr.nbytes = 3;
+	if (!spi_mem_default_supports_op(mem, &nop))
 		return false;
 
-	/*
-	 * The number of address bytes should be equal to or less than 3 bytes.
-	 */
-	if (op->addr.nbytes > 3)
+	if (op->addr.nbytes > 4)
 		return false;
 
 	return true;
 }
 
+static int zynq_qspi_adjust_op_size(struct spi_mem *mem,
+				    struct spi_mem_op *op)
+{
+	if (op->addr.nbytes == 4 && op->data.nbytes) {
+		u32 room = ZYNQ_QSPI_BANK_SIZE - (op->addr.val & (ZYNQ_QSPI_BANK_SIZE - 1));
+
+		/* one operation must not cross a 16 MiB bank */
+		if (op->data.nbytes > room)
+			op->data.nbytes = room;
+	}
+
+	return 0;
+}
+
+/* opcode with a 4-byte address -> the same opcode with a 3-byte address */
+static u8 zynq_qspi_opcode_3b(u8 opcode)
+{
+	switch (opcode) {
+	case SPINOR_OP_READ_4B:		return SPINOR_OP_READ;
+	case SPINOR_OP_READ_FAST_4B:	return SPINOR_OP_READ_FAST;
+	case SPINOR_OP_READ_1_1_2_4B:	return SPINOR_OP_READ_1_1_2;
+	case SPINOR_OP_READ_1_2_2_4B:	return SPINOR_OP_READ_1_2_2;
+	case SPINOR_OP_READ_1_1_4_4B:	return SPINOR_OP_READ_1_1_4;
+	case SPINOR_OP_READ_1_4_4_4B:	return SPINOR_OP_READ_1_4_4;
+	case SPINOR_OP_PP_4B:		return SPINOR_OP_PP;
+	case SPINOR_OP_PP_1_1_4_4B:	return SPINOR_OP_PP_1_1_4;
+	case SPINOR_OP_PP_1_4_4_4B:	return SPINOR_OP_PP_1_4_4;
+	case SPINOR_OP_BE_4K_4B:	return SPINOR_OP_BE_4K;
+	case SPINOR_OP_BE_32K_4B:	return SPINOR_OP_BE_32K;
+	case SPINOR_OP_SE_4B:		return SPINOR_OP_SE;
+	default:			return opcode;	/* already a 3-byte opcode */
+	}
+}
+
 /**
  * zynq_qspi_rxfifo_op - Read 1..4 bytes from RxFIFO to RX buffer
  * @xqspi:	Pointer to the zynq_qspi structure
@@ -522,12 +571,13 @@ static irqreturn_t zynq_qspi_irq(int irq, void *dev_id)
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op)
+static int zynq_qspi_exec_plain_op(struct spi_mem *mem,
+				   const struct spi_mem_op *op)
 {
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0, i;
 	u8 *tmpbuf;
+	u8 addrbuf[3];
 
 	zynq_qspi_chipselect(mem->spi, true);
 	zynq_qspi_config_op(xqspi, mem->spi, op);
@@ -547,10 +597,10 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	}
 
 	if (op->addr.nbytes) {
-		for (i = 0; i < op->addr.nbytes; i++) {
-			xqspi->txbuf[i] = op->addr.val >>
+		for (i = 0; i < op->addr.nbytes; i++)
+			addrbuf[i] = op->addr.val >>
 					(8 * (op->addr.nbytes - i - 1));
-		}
+		xqspi->txbuf = addrbuf;
 
 		reinit_completion(&xqspi->data_completion);
 		xqspi->rxbuf = NULL;
@@ -611,9 +661,91 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	return err;
 }
 
+/* Stage 2: the flash is read-only through this driver. */
+static bool zynq_qspi_op_is_read(const struct spi_mem_op *op)
+{
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		return true;
+	return false;
+}
+
+static int zynq_qspi_ear_cmds(struct spi_mem *mem, const struct spi_mem_op *like,
+			      u8 ear, bool wren_after)
+{
+	struct spi_mem_op wren = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
+					    SPI_MEM_OP_NO_ADDR,
+					    SPI_MEM_OP_NO_DUMMY,
+					    SPI_MEM_OP_NO_DATA);
+	u8 *buf = kmalloc(1, GFP_KERNEL);
+	struct spi_mem_op wrear = SPI_MEM_OP(SPI_MEM_OP_CMD(ZYNQ_QSPI_OP_WREAR, 1),
+					     SPI_MEM_OP_NO_ADDR,
+					     SPI_MEM_OP_NO_DUMMY,
+					     SPI_MEM_OP_DATA_OUT(1, buf, 1));
+	int ret;
+
+	if (!buf)
+		return -ENOMEM;
+	*buf = ear;
+	wren.max_freq = like->max_freq;
+	wrear.max_freq = like->max_freq;
+
+	ret = zynq_qspi_exec_plain_op(mem, &wren);
+	if (!ret)
+		ret = zynq_qspi_exec_plain_op(mem, &wrear);
+	if (!ret && wren_after)
+		ret = zynq_qspi_exec_plain_op(mem, &wren);
+	kfree(buf);
+	return ret;
+}
+
+static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct spi_mem_op nop = *op;
+	u8 ear;
+	int ret, ret2;
+
+	/* Leaving 4-byte mode is not needed: the flash is never put in it. */
+	if (!op->addr.nbytes && !op->data.nbytes && !op->dummy.nbytes &&
+	    (op->cmd.opcode == SPINOR_OP_EN4B || op->cmd.opcode == SPINOR_OP_EX4B))
+		return 0;
+
+	/* read-only guard: only operations that read data from the flash */
+	if (!zynq_qspi_op_is_read(op)) {
+		dev_warn_ratelimited(&mem->spi->dev,
+				     "read-only: op %#x refused\n", op->cmd.opcode);
+		return -EROFS;
+	}
+
+	if (op->addr.nbytes != 4)
+		return zynq_qspi_exec_plain_op(mem, op);
+
+	ear = (op->addr.val >> 24) & 0xff;
+	nop.cmd.opcode = zynq_qspi_opcode_3b(op->cmd.opcode);
+	nop.addr.nbytes = 3;
+	nop.addr.val = op->addr.val & (ZYNQ_QSPI_BANK_SIZE - 1);
+
+	if (ear) {
+		ret = zynq_qspi_ear_cmds(mem, op, ear, false);
+		if (ret)
+			return ret;
+	}
+
+	ret = zynq_qspi_exec_plain_op(mem, &nop);
+
+	if (ear) {
+		ret2 = zynq_qspi_ear_cmds(mem, op, 0, false);
+		if (!ret)
+			ret = ret2;
+	}
+
+	return ret;
+}
+
 static const struct spi_controller_mem_ops zynq_qspi_mem_ops = {
 	.supports_op = zynq_qspi_supports_op,
 	.exec_op = zynq_qspi_exec_mem_op,
+	.adjust_op_size = zynq_qspi_adjust_op_size,
 };
 
 static const struct spi_controller_mem_caps zynq_qspi_mem_caps = {
-- 
2.53.0

