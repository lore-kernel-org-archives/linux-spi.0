Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563398;
	b=NWU6cQN0FqMYezKwACrnRG+Ddfg3kylIUg5+Xbbz5p6WjfbjZl99tB4wmTjZg2ZdEu4T
	 IwJzDvlvyFAh+4w8PyT9kKUfzvWoEoz0ANnVH1p45pDGlfPxn1OvrojqLhqueSi06wYV7
	 xqOEg6qYqhDcAR6LNAynoBeQbjlWcJ2H4Sn3Ek4hv749aUNhIFWd8PqRt+tuZfqBHszYG
	 HsgpA0rGxOtdvgOBxEqnFeeNBpmI9zP5o9apbg6LkT5yrsI7+a5HF2amug+XWIPMPnKP+
	 0s42ZEY2UkBIuDhtsY2wiRF/uiicrUh3dfsxTJ3HMFnDKb2BLsUG5YDsUYCFsG5aynw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ACe0xGAoqmUry5IzCbHuAC/BxWutmA5j1wpS/cDhhFQ=;
	b=zk5TIAGkvGK5919Tvt79z5VV5TICNqgcRIb7Vqer+BHSljcBcCzI3MPJ1hWLo1LGxp8X
	 3T/bgPhpH1UOocAP+6KNy5xyluAMTmLzZ8FlTFakwLqAX22y+7ftjXYpRjhLTxnHVBzDK
	 qMlmk62N9jVU5kf2aeXHM1H0Viw9+2nhhEX1jaIkGwhmzYRokmWoVqcGLtBtUA8c9IWKk
	 GpWwh6xYIpci0ugd/9GZZs5FyGjs4gZ1X+6Uwchg3Uo3hdiqVrpWGDPgK6jnXv3goGv8l
	 KrhjhG6Jem1A/2nXSnqmCLUhBMYB84ybYTrfpQfr8XjuSZGGjm4By3tjnXHCcVGd+rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNHQlq2B;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D4606A325
	for <linux-spi@vger.kernel.org>; Sun,  1 Nov 2026 20:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 681D4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wNHQlq2B
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a18fc7a38so3608423eec.1
        for <linux-spi@vger.kernel.org>; Sun, 01 Nov 2026 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793563396; x=1794168196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACe0xGAoqmUry5IzCbHuAC/BxWutmA5j1wpS/cDhhFQ=;
        b=wNHQlq2BYYC5qwhf1AQwGywFzLEAyyFQx/xW7ITVUaDfdpYpxwuY8CI5vHxwvRSI4T
         PpFBWUDnlXIR56YCLQcGDaqUYROxPlxm4VKlFD1QD457HbEuuyc4GS3/uqGpPLZYspb0
         R/+qO+jZhQaSRHsGeMUwvt5N9S1TMVEoflfzTudgmlmyAl5cCREtKxM5+ODvJIOluEpH
         sej2O9Ws4GiwSB+mlcYicY7UKw0Yo0FLsJbteMPLN/sOsOOl1yPDnyX3VVhflf0lTPjz
         vsJ/ZRALr9t3zKFVxBwWGL7EHZw8erTt2mvLLfnw25+iUldSh8u92aDt4Yn6LZkEZwhe
         po6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793563396; x=1794168196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ACe0xGAoqmUry5IzCbHuAC/BxWutmA5j1wpS/cDhhFQ=;
        b=YBttDL9zqCVkYa9nrLkusdOZdzOb2i/HqS79DFC8j4VX25KB+ah7Fe09y10Q9+5PYo
         vKxKS2v9c7mHkIGLT0v90q53ibDy9AvNDUQZqZaB3S7mNK0mC0A7FcWylSg1jodNu3sS
         a9b2V0QVsUXbjnEEjzuvj5JftJQflVJcvz4fvzHAc20N3DMHAquEjkGVltuLZCC/mOuK
         bmC+Dblio1aCSojLce2pcJgtcN3B10hpM8rAbpLgiqNSQeLcpx5WdGBrpl1BjMYps1Wd
         uok7wer+x4ULG1jMoh8Y6YBtBfGHUmNMt4i5mbaUdCXaUin/O0yTFBHrIUBb7ffjgbDR
         0XTQ==
X-Gm-Message-State: APuU4Z+3DKel6emtu2pfChDHSBk+/H6zPqZlvpft9Xp6YR28xZZwz4FZ
	ZRVKTPbnIfQFVN/Yp92mU7OkO0GTCfryGXWYjdj7VWUy1S4CmB1EMNvFKFAy5g==
X-Gm-Gg: AYBFou21NCcOIxezg2UtdEG//tID1gG/TRjPxahO44QqbaqqviTnpmaG+c/kxq6H9dF
	FaSz30BCRXaic0SYqgNF6JodtkIBoeMRkJKeRRsY4dZeo5Xp+hFym6mp1hlGckm5/VvcCPCp2BZ
	PXGjl4fd2tAVaBfG9INZeMz++okvbOue5mns8nDH8jjT29W22hHmcbuEENTdZ+1eZ11iGg7Alu/
	uz+uLc5NuwWl8G1Ra1JyNyfdk4NHH7Ti4ThH0ss1lAxwZzdA6l8IptlC4thCUL+utzqcVR2IpDp
	kUpv4uUTb2B3HQvSLALzGQ76LaoOe0eiJd2w7PoqqIL32kWuUkQFGSuYEhLpfnxXSDhPdSwjYhm
	+vFRmK3MrXB1O8v2UhXpQktR67063ZEKz2cZYluZ29Y+Mbv8Pjlblfpes6NQVcexw2Nu5SUW9X4
	8PW2cztr5De9o/S8POPZT4UDbV5ue3nnjCunFyfgVEHcX/fin95AjwIttHbSd6kMJO33GuSpQKE
	shW7d68n7xVc6XtM1u1Ggu8b8AbJ5DMiYKdbAe+E6ZVFyYPPeO4GRqPWo0TJideKCeZ7COI5FPZ
	eSIvRr+exH794KScGfzRym6+rD59hr+Gtf2jk7vYQsqB2G+m8ZpG4BWV9G+Je/XoJLX2Q++0sso
	PDUX2Go4Fm49gDBdTwuCPUkBzuDEkg06KBnhu5y14WifKvny3NIEFeYZxCvojhI60o0UQafgFbr
	Rckw==
X-Received: by 2002:a05:693c:409c:b0:36a:30b:5dce with SMTP id 5a478bee46e88-36a423a3232mr14502972eec.19.1793563396376;
        Sun, 01 Nov 2026 12:03:16 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a5eee0f20sm10561680eec.17.2026.11.01.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:03:15 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Mauro Lima <mauro.lima@eclypsium.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] spi: intel: only check locked opmenu for SW sequencer operations
Date: Sun,  1 Nov 2026 12:03:13 -0800
Message-ID: <20261101200313.16411-1-rosenp@gmail.com>
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
erase when swseq_erase is set. With this both flash chips (W25Q64 and
W25Q32) probe and read back correctly.

Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-intel.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 7494b921a743..6f1414b199e6 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -754,6 +754,18 @@ intel_spi_match_mem_op(struct intel_spi *ispi, const struct spi_mem_op *op)
 	return NULL;
 }
 
+static bool intel_spi_op_uses_swseq(const struct intel_spi *ispi,
+				    const struct intel_spi_mem_op *iop)
+{
+	if (iop->exec_op == intel_spi_read_reg ||
+	    iop->exec_op == intel_spi_write_reg)
+		return ispi->swseq_reg;
+	if (iop->exec_op == intel_spi_erase)
+		return ispi->swseq_erase;
+	/* Data reads and writes always use the HW sequencer */
+	return false;
+}
+
 static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 				      const struct spi_mem_op *op)
 {
@@ -768,9 +780,11 @@ static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 
 	/*
 	 * For software sequencer check that the opcode is actually
-	 * present in the opmenu if it is locked.
+	 * present in the opmenu if it is locked. Operations executed by
+	 * the hardware sequencer do not use the opmenu so skip the check
+	 * for them.
 	 */
-	if (ispi->swseq_reg && ispi->locked) {
+	if (ispi->locked && intel_spi_op_uses_swseq(ispi, iop)) {
 		int i;
 
 		/* Check if it is in the locked opcodes list */
-- 
2.56.0

