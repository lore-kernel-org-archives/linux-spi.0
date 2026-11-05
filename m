Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911102;
	b=jl0lJN5Cg0G7pLSEg+u2hhycwhF3YoOdQNGw97Q3352RJW3xBP9IrQEtxPMeYjgILy6k
	 ODL3LPHnPTiHWNpERGtWyclbrSQHF+NZ5nrMcmKcA25Ce/aiCZt2UVFzbXtzm1AyZoJpO
	 bT6e2/oLn/uDwPAxjKVDkivMtoR8CxRtxICPTuFWMmc/+4R6u6TEwOSa1B0BG+jetqvEd
	 GWhcAU5gm9JZHpCsafvtHdf+N5ALhCtEhrccR28EPtZVY6AkQS7LaJdXhvYETFbeJvsNL
	 DyaQ94haWxEbfBH2NVMiNmlp44ADlRM2pPIGXY1CbAYhjHSHkK9NBvv0U+PFcP6dl1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=frICwY2Jg1jswprX/TCp9Cf0c4VXARn/d3XOOLE2RH4=;
	b=E47egmXXW7COA2eiAKthjRDZEvYPs2jDMzP3zYS2a+PfrT8y6KwRrbh5Bp+yFUkJfE0K
	 wHAARM9RZ11KoHiUxPUs8WnXIrokmy1m1qpXo1LR4SFEJtWSVHPovKPm9kTCMA0a65t8y
	 ZJrMVj4uiWk112TPCJvgnpE5WqLdhC2KJnEesVkiKZur8swowMpvzZEz0HCZTkRSHwIUD
	 TGjcq4XVw74t/wiQhtLJs7FYQD0kIxMCUrPz3uS/ZoakL5yZ/1cUwoNF0XboZr9D+7/NR
	 VIdVJawsLA1SOWBpM87wcJ34l0nCqFW+ONmcWt+dJM3fj/gZXI17zFnjo6W3Gb6ULoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yKsM61YW;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069D606EE91
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 20:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F069D606EE91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yKsM61YW
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so986486a12.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Nov 2026 12:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911100; x=1794515900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=frICwY2Jg1jswprX/TCp9Cf0c4VXARn/d3XOOLE2RH4=;
        b=yKsM61YWN3IcVZvn+a3rwEw4BouIC0Rs/wIfZR9q5lRGxz80AYBSWq4QrQ/1eOlgBW
         GLnWiQm80mJEsWtEEmDfpHuWcvbyyNBg5HwL4akb7of2Efc1L5jbNbFa9pId4NWfb2kz
         rb4uqynFzEhG5Z7iWFe/EEtWkSYqMENGUAS5JTmBsNuKeHdfOpTux6/9w0AXG4jviGw1
         MrMG7MKy8VWYKb86wwUmUVVD1QRToP2XONFFVAePEjzuZRuTdlYiCLTOwZnA05+zC+Px
         uU8a3GrHVhcCqwFQwVLh14elqpGg+hyBq1wIMDg8itg3tSHBE7sldUR8zyVI6v4gUO1A
         o94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911100; x=1794515900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=frICwY2Jg1jswprX/TCp9Cf0c4VXARn/d3XOOLE2RH4=;
        b=pED6A5L4uvhC1nc7lsXbahtoS5yi208YstuuUICltdKFz2CbEb6KwD6HFrojafwz1w
         xGdz7E/JcyuEj+9IMCc3eb6ywtmy5V88d0+vLBnESVT4SOna386ad+dRxqZDmkPTC9mM
         DODIZkcNT9/FbJBp+nexi7HC7RMpJMdcvG7a+ZfrmRqVXO8f1KWikEZIZZFcLBD0GXod
         xab/+W4kD5UHoLVUERoSVxqRovDoIpQS8e02vnf6N4/je7eRXtz9h5nf48KIPjnFz1k8
         anULp8ucVjHF2lWJoFEB5CQYdOugYR4hK9jjoAQGR8S6+1xR1JwrpMXLH7bhZa5GGP53
         8HAw==
X-Gm-Message-State: APuU4Z+0vVeumIu3TXwgSH5xQmZIQN098SVB5YG3p8Lz44E443HHLG9A
	46QnfetygQrRQ7sDpUcM6BvB2YkTbwnbiGpMr44D3O8ZXvXLXASuWmKZ
X-Gm-Gg: AYBFou1Xlrkh8lNdyTav3Zhi/mf99V+6zYwCW5inxn/rrkBouyd1rn9ATOhp2AdfLQV
	FTINyxAraHWNRF+uxZyMaG/LiSI7yTSkM4m8OhriNjxO/lTTK5yRkC943iiEJ+0qupHou3PEFw+
	+tB1yIHc2dPmEzl4LEKClM5QBtSnRfKqgs19bLWtKfLos2gy8PNxh71MaP3K2MuEsIS4Dj8sUGN
	m3KAC3xb1s2wtl8RozIREZdK+oP/K3GF1/Ky+TO7iCEOf7nRiY1O683vmY36JNstdrDZNqy8iLW
	GYFdqhvdWk3nv4LQu2C3J/QghsUbNHP/QaIZN2OvxjF3WAWVfPYs4nBAHYhyLLtqmsBAAzqUuFN
	ULybKSJPxlhS40YiOllksNsMte+0NeNdy1dJYW3Th+EyfP7Gnw0ZGVt8o47KKf/34iN0LA7mKrf
	UEgLByDXRJ29X7PAw3RQRT5fr9MMW+4JLWGCTGJGTfnc8VW0rij8BZ+OTmEmshZ8lExVbc+it9g
	Isv18N+lDZD/IB5VNyvU3mgfcjCLX1IBQskLh3yRH7S3TGKR7UlUwAQuC5TIAryJGxYjYh38MR3
	eArA9M/N0eueyU3vMEHfUTJ1M5xCsBlQtMVA5DHEvU+XrpbdHN1a/IKGAAhq1LPwwuJM9LyGr52
	GRQwYI17fVSUBPdayS1h43XgyE0RLOGf0lI7YVaI7Up7s3XO6wLjUXp6WJY7OKE92pQAyN/ZJQD
	vJVm4QdhqxPGuEeEiF3++oeQfdKdRtLrETS1wJ8ZKfVkSmLt40DoFnwO1BSApsqcGFm3l74Icug
	63UuDjzcl2cQjH9
X-Received: by 2002:a17:907:d22:b0:c3f:7e8:235d with SMTP id a640c23a62f3a-c4d351f3023mr50453966b.5.1793911100187;
        Thu, 05 Nov 2026 12:38:20 -0800 (PST)
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
Subject: [PATCH v1 2/2] spi: zynq-qspi: program and erase flash above 16 MiB via the EAR
Date: Thu,  5 Nov 2026 21:37:34 +0100
Message-ID: <20261105203734.979168-3-mario.behn@gmail.com>
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


The read-only stage turned every operation with a 4-byte address into
WREN, WREAR(addr >> 24), the 3-byte form of the operation and WREAR(0),
and refused programs and erases. Carry them the same way, with the
things they need:

 - the write enable the spi-nor core sent before the operation is used
   up by the WREAR command, so it is sent again after it (the ADI 6.12
   spi-nor code does the same);
 - a program or an erase with the wrong bank selected lands 16 MiB away
   from where it was meant, so the bank register is read back (RDEAR)
   before the operation and the write is refused with -EIO if it does
   not hold the expected value;
 - after a program or an erase the flash is busy and ignores everything
   but Read Status, so the bank register is restored only once the WIP
   bit is clear (bounded at 3 s, a 64 KiB block erase takes up to 2 s on
   the W25Q256), then WREN, WREAR(0), WRDI so the write enable latch is
   not left set.

The bank register is 0 between operations, so operations in bank 0 keep
going out unchanged and a warm reboot leaves the BootROM and U-Boot in
bank 0. Address-less commands (write enable and disable, status register
reads and writes, chip erase) go out as they are.

Signed-off-by: Mario Behn <mario.behn@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 113 +++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index e20019a03964..c72c00a82a99 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -230,10 +230,14 @@ static void zynq_qspi_init_hw(struct zynq_qspi *xqspi, unsigned int num_cs)
  * WREN + WREAR(addr >> 24) + the 3-byte form of the operation, and the EAR is
  * set back to 0 afterwards, so that U-Boot and the BootROM find the flash in
  * bank 0 after a reset (the same scheme as the ADI 6.12 spi-nor code, but in
- * the controller driver instead of the spi-nor core).
+ * the controller driver instead of the spi-nor core). A program or an erase
+ * above 16 MiB needs a second write enable after the WREAR, and the flash is
+ * busy afterwards, so the bank register is restored once it is ready again.
  */
 #define ZYNQ_QSPI_BANK_SIZE		0x1000000U
 #define ZYNQ_QSPI_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define ZYNQ_QSPI_OP_RDEAR		0xc8	/* Read Extended Address Register */
+#define ZYNQ_QSPI_READY_TIMEOUT_MS	3000
 
 static bool zynq_qspi_supports_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
@@ -661,12 +665,44 @@ static int zynq_qspi_exec_plain_op(struct spi_mem *mem,
 	return err;
 }
 
-/* Stage 2: the flash is read-only through this driver. */
-static bool zynq_qspi_op_is_read(const struct spi_mem_op *op)
+/* a program or an erase: the flash is busy afterwards */
+static bool zynq_qspi_op_is_write(const struct spi_mem_op *op)
 {
-	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
-		return true;
-	return false;
+	return !(op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN);
+}
+
+/*
+ * Wait until the flash has finished a program or an erase (WIP clear). While
+ * it is busy it ignores every command but Read Status, so the bank register
+ * cannot be restored before this.
+ */
+static int zynq_qspi_wait_ready(struct spi_mem *mem, const struct spi_mem_op *like)
+{
+	u8 *sr = kmalloc(1, GFP_KERNEL);
+	struct spi_mem_op rdsr = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
+					    SPI_MEM_OP_NO_ADDR,
+					    SPI_MEM_OP_NO_DUMMY,
+					    SPI_MEM_OP_DATA_IN(1, sr, 1));
+	unsigned long deadline;
+	int ret;
+
+	if (!sr)
+		return -ENOMEM;
+	rdsr.max_freq = like->max_freq;
+	/* a 64 KiB block erase takes up to 2 s on the W25Q256 */
+	deadline = jiffies + msecs_to_jiffies(ZYNQ_QSPI_READY_TIMEOUT_MS);
+	for (;;) {
+		ret = zynq_qspi_exec_plain_op(mem, &rdsr);
+		if (ret || !(*sr & SR_WIP))
+			break;
+		if (time_after(jiffies, deadline)) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+		usleep_range(200, 500);
+	}
+	kfree(sr);
+	return ret;
 }
 
 static int zynq_qspi_ear_cmds(struct spi_mem *mem, const struct spi_mem_op *like,
@@ -692,16 +728,60 @@ static int zynq_qspi_ear_cmds(struct spi_mem *mem, const struct spi_mem_op *like
 	ret = zynq_qspi_exec_plain_op(mem, &wren);
 	if (!ret)
 		ret = zynq_qspi_exec_plain_op(mem, &wrear);
+	/*
+	 * A program or an erase with the wrong bank selected lands 16 MiB away
+	 * from where it was meant, so read the register back before going on.
+	 */
+	if (!ret && wren_after) {
+		struct spi_mem_op rdear = SPI_MEM_OP(SPI_MEM_OP_CMD(ZYNQ_QSPI_OP_RDEAR, 1),
+						     SPI_MEM_OP_NO_ADDR,
+						     SPI_MEM_OP_NO_DUMMY,
+						     SPI_MEM_OP_DATA_IN(1, buf, 1));
+
+		rdear.max_freq = like->max_freq;
+		*buf = ~ear;
+		ret = zynq_qspi_exec_plain_op(mem, &rdear);
+		if (!ret && *buf != ear) {
+			dev_err(&mem->spi->dev,
+				"bank register %u not taken (reads %u), write refused\n",
+				ear, *buf);
+			ret = -EIO;
+		}
+	}
 	if (!ret && wren_after)
 		ret = zynq_qspi_exec_plain_op(mem, &wren);
 	kfree(buf);
 	return ret;
 }
 
+/*
+ * Back to bank 0: after a program or an erase wait for the flash first, then
+ * WREN + WREAR(0) + WRDI (the write enable latch must not stay set).
+ */
+static int zynq_qspi_ear_restore(struct spi_mem *mem, const struct spi_mem_op *like,
+				 bool after_write)
+{
+	struct spi_mem_op wrdi = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
+					    SPI_MEM_OP_NO_ADDR,
+					    SPI_MEM_OP_NO_DUMMY,
+					    SPI_MEM_OP_NO_DATA);
+	int ret = 0;
+
+	wrdi.max_freq = like->max_freq;
+	if (after_write)
+		ret = zynq_qspi_wait_ready(mem, like);
+	if (!ret)
+		ret = zynq_qspi_ear_cmds(mem, like, 0, false);
+	if (!ret)
+		ret = zynq_qspi_exec_plain_op(mem, &wrdi);
+	return ret;
+}
+
 static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
 	struct spi_mem_op nop = *op;
+	bool write;
 	u8 ear;
 	int ret, ret2;
 
@@ -710,23 +790,26 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	    (op->cmd.opcode == SPINOR_OP_EN4B || op->cmd.opcode == SPINOR_OP_EX4B))
 		return 0;
 
-	/* read-only guard: only operations that read data from the flash */
-	if (!zynq_qspi_op_is_read(op)) {
-		dev_warn_ratelimited(&mem->spi->dev,
-				     "read-only: op %#x refused\n", op->cmd.opcode);
-		return -EROFS;
-	}
-
+	/*
+	 * Operations without a 4-byte address go out as they are: reads and
+	 * writes in bank 0, and the address-less commands (write enable and
+	 * disable, status register reads and writes, chip erase).
+	 */
 	if (op->addr.nbytes != 4)
 		return zynq_qspi_exec_plain_op(mem, op);
 
+	write = zynq_qspi_op_is_write(op);
 	ear = (op->addr.val >> 24) & 0xff;
 	nop.cmd.opcode = zynq_qspi_opcode_3b(op->cmd.opcode);
 	nop.addr.nbytes = 3;
 	nop.addr.val = op->addr.val & (ZYNQ_QSPI_BANK_SIZE - 1);
 
+	/*
+	 * The write enable the caller sent before a program or an erase is
+	 * consumed by the WREAR command, so it is sent again after it.
+	 */
 	if (ear) {
-		ret = zynq_qspi_ear_cmds(mem, op, ear, false);
+		ret = zynq_qspi_ear_cmds(mem, op, ear, write);
 		if (ret)
 			return ret;
 	}
@@ -734,7 +817,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	ret = zynq_qspi_exec_plain_op(mem, &nop);
 
 	if (ear) {
-		ret2 = zynq_qspi_ear_cmds(mem, op, 0, false);
+		ret2 = zynq_qspi_ear_restore(mem, op, write);
 		if (!ret)
 			ret = ret2;
 	}
-- 
2.53.0

