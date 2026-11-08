Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170251;
	b=CGcxDY210kVOaccFzGWRxPsIl/J5ESu6O4zxFEUnQcRgm0XnkcS7xwPltilvtniMl98u
	 mBw2+LfKHuLYkR9Z9nXuZtYLLR7DRg+GveGH1EtXaKEpdYVnXKckCcKKDeZU2Lp7Nrk4E
	 3BCWFkM3HU5IZaA/dBnckcbjSXO2nJDtu6bx6eVaNgBJ9w06BtOQxLIKSDptL1pIshDHF
	 lJaMMzPUGnALZnnOoKxAszwzdcH3+qZE6H3OCn/71bXw749j7BNeR0HO+NgBF5lOcWSQD
	 fbFuXnqyYQR8kvC7Bni2Hkdjw6uXLOvYL8B2fgo28ZU+i231AEizKS/CX3zlm+hSIqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PKtqM0lKSDw1R6nZxeofGNfXJYXQE3Or9TXWomGfKyI=;
	b=0TgokRaFOApjNpyisOEyIY/U4vfNTd+Ox+TSgrZwAM98ESIEpZEIZC7sI/Sq0KCg8R0d
	 M0PmF/7jOx1mKXGf748hC12Fj+20I5i0ZiwJsSo44z2xypVu/50Dliz68FQVVU8i2dfdx
	 qGYl5YaIRu/H7kLaPyyybRF9IrSAAWjfnYZqe4z0NAaGGe1xA+U8sGysG7Rj7lA/NQvAj
	 rVMIfJf+6D5Pkzo4zAB/NRomYbQrycX54RMw8dZGWEgloA8lKX+rCAYNrzLe1nsZrMUJU
	 GwdVva/UuRWtISTCpfuSUwmIrPAReFEGHewv0KkYKXnsUIRihJcVLvLR0tHuZz0hRDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWivARwK;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F0606A9C2
	for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2026 20:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031F0606A9C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MWivARwK
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso94655a91.2
        for <linux-spi@vger.kernel.org>; Sun, 08 Nov 2026 12:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794170250; x=1794775050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKtqM0lKSDw1R6nZxeofGNfXJYXQE3Or9TXWomGfKyI=;
        b=MWivARwKsNq+6QEsTWJ1HacIfAB9KHWf+dMnYRSHzE/YABHD2UzbcFhNnB1WPJW0sa
         i+FIY7vKbCeBZzfTySGJHHfB0yWEbqpvGpnkGR2vacETy3l0NFlRKl0mhr1GIa/aVaqP
         zt9OUip3pe3KrBNZR5uFkkVqHZnGioszvVgAQrkZVGCasNsgMRFNSoynUq5CgkdAXRVp
         4q615C9b2PYeO+zLh1KWVrAtg+zDtUSHw+r7e4CPa7E+tQBoVdiNO5jzf1f38mpRXBVB
         Va3vrPv6ScYyBPHnpdoE5pn8zsheYHmPghYhkAWwrb4AMDflVaGwmgBiOh1jszIPN816
         tk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794170250; x=1794775050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKtqM0lKSDw1R6nZxeofGNfXJYXQE3Or9TXWomGfKyI=;
        b=ixQnF/hhcPvZQatZZ+L+TXmYZD1jq3gAnxC+8Fqb4pKMwm/fr+uAmVPpGgXKosZWQ5
         MrIbJxkQlxW8ka3nhFL13QP+yJOXsQG9AZVyLc7Fu/Ubz27InvBAb2b5iBbr8tXsjnKz
         ElYloZX6XUTWDFoKuTzPnjDI+88eYUL5BpWstyM39ljen6I9Wzifthi8fl+mKcV4ZQb3
         w/wC4MXWFDnIalP2ZnGF0sdBu5ioUhZT5GiY3plPBKVFp+DHIFoJcyg9cOgvlCo7F4wp
         YdbsRqnZzSC9Xztr7l5LxB5A/nmtmX31S+fpubtM8qIhW5j7J1vqWCgqz6J4zyqBqBSh
         wzBQ==
X-Gm-Message-State: APuU4Z/QMg1hmjeyR7EqCu8pf+F6/DmbAan3yTn8OOBMN0XQ0KRH2Wdm
	On2ZEUDWElGTpso64SgfhZvddseH+Y9Aa9ckJzQLXljwnoyy55wenGyiVcePsg==
X-Gm-Gg: AYBFou19qW/eo0ik8ZLaE1w0ymAlLftkLKsre+GVzLetqRb6KtgtDX7mY4VWI03zlqX
	rI/AUdiCReujinQQK3C+jONqidNnv1gO42gpFZc6bTAJG7+ykI+YTCcL5SNhRjmlwUc0sIKLBhV
	aKacYz8fJ6BuRWqrKvrKuihSJL+GY5zFaf7Y5sMn50n/9X92gei5IHyW9b6OD4RuLLORnBP5wBm
	CPqWvtLxIO5LTqYVPLxiZIPYqo8xtkbEpD66Y6hVIp4J5qIOUFyWeVOQumbhOP5vD+cpwoUWYAo
	6ys62jl9gJ0tVmHF54UO9zexGgYqgZQFtyFF62qoL0rLMlk94mTa9iA1m1Gqjv8RX8xywmwvg3D
	alYue5ZdxQAZRPo4LnIN/53ju02hvxLwUBJaMHhVcOIv6d6f9C48/t6XXzVUH3HKl3XhfGjYZDT
	iNqIJx9GYyKxLFXqVvmFLhi/8gFbcOs1JjSVxAed06pwM701Tz+BoK4mPyXCBWdb0K4wQeofXI+
	3vjdv5PPg5T1IZdTxnGBlPJoO97d1BkJx58pkgq8gC/zA21U/Vzh9aKnWrfTYKT4Cai5U3ftfkF
	7Armoe1zkb08YsWwLZYuZRlvDp6EoSyyxSIKKcDEmunEFZXR3zywm4WghPIVVTAM90NTo7eWXdh
	gZ7rauZF/qa1C8W7Q7BuTiGY2f7pBva9J7CFdZoNEDte3UPaNnvVjt4GCZrv/clbWJ+CNKixHvF
	RWsaolzQ8ZjD8y+5bBIWoHUw4=
X-Received: by 2002:a17:90b:3890:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b12d5b4cbbmr1975130a91.52.1794170250281;
        Sun, 08 Nov 2026 12:37:30 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278cb8d5sm4762368a91.10.2026.11.08.12.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:37:29 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Mauro Lima <mauro.lima@eclypsium.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Pratyush Yadav <p.yadav@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] spi: intel: only check locked opmenu for SW sequencer operations
Date: Sun,  8 Nov 2026 12:37:28 -0800
Message-ID: <20261108203728.25735-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

On controllers that use the software sequencer for register access (LPT
and BYT), intel_spi_supports_mem_op() rejects any operation whose opcode
is not in the BIOS-locked OPMENU. However the check is applied to every
operation, including normal data reads and writes which are always
executed by the hardware sequencer and never consult the OPMENU.

On a Dell Precision M4800 (Lynx Point) the BIOS locks OPMENU to
{02, 3b, 20, 05, 9f, 9f, 00, 00}, which lacks both READ (0x03) and
FAST_READ (0x0b). As a result every read op is rejected and spi-nor
fails to probe both flash components:

  intel-spi intel-spi: 0x3 not supported
  intel-spi intel-spi: 0xb not supported
  spi-nor spi0.0: can't select read settings supported by both the SPI controller and memory.
  spi-nor spi0.0: probe with driver spi-nor failed with error -22

Only enforce the OPMENU check for operations that actually go through
the software sequencer: register reads/writes when swseq_reg is set and
erase when swseq_erase is set.

Write Enable (0x06) and Write Disable (0x04) are excluded as well, even
though they are register writes. WREN is never issued from the OPMENU:
intel_spi_write_reg() verifies it is in PREOP_OPTYPE and uses it as the
atomic preopcode of the next cycle. WRDI is not sent to the flash at
all. Rejecting them whenever they are missing from the OPMENU, as on the
M4800 where 0x06 is only in PREOP_OPTYPE, makes every program and erase
fail with -EOPNOTSUPP.

With this both flash chips (W25Q64 and W25Q32) probe and read back
correctly.

Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: exclude SPINOR_OP_WREN and SPINOR_OP_WRDI
 drivers/spi/spi-intel.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 7494b921a743..391e79fa4678 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -754,6 +754,28 @@ intel_spi_match_mem_op(struct intel_spi *ispi, const struct spi_mem_op *op)
 	return NULL;
 }
 
+static bool intel_spi_op_uses_opmenu(const struct intel_spi *ispi,
+				     const struct intel_spi_mem_op *iop,
+				     const struct spi_mem_op *op)
+{
+	if (iop->exec_op == intel_spi_read_reg)
+		return ispi->swseq_reg;
+	if (iop->exec_op == intel_spi_write_reg) {
+		/*
+		 * WREN is issued through PREOP_OPTYPE as an atomic
+		 * preopcode and WRDI is a no-op, so neither uses the opmenu.
+		 */
+		if (op->cmd.opcode == SPINOR_OP_WREN ||
+		    op->cmd.opcode == SPINOR_OP_WRDI)
+			return false;
+		return ispi->swseq_reg;
+	}
+	if (iop->exec_op == intel_spi_erase)
+		return ispi->swseq_erase;
+	/* Data reads and writes always use the HW sequencer */
+	return false;
+}
+
 static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 				      const struct spi_mem_op *op)
 {
@@ -768,9 +790,11 @@ static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 
 	/*
 	 * For software sequencer check that the opcode is actually
-	 * present in the opmenu if it is locked.
+	 * present in the opmenu if it is locked. Operations executed by
+	 * the hardware sequencer, as well as WREN and WRDI, do not use the
+	 * opmenu so skip the check for them.
 	 */
-	if (ispi->swseq_reg && ispi->locked) {
+	if (ispi->locked && intel_spi_op_uses_opmenu(ispi, iop, op)) {
 		int i;
 
 		/* Check if it is in the locked opcodes list */
-- 
2.56.0

