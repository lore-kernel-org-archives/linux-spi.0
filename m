Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B133630B0
	for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189733; cv=none; b=VmybG47FDbW25sSrM4V4KYRMmkE0B+NPlAtqQMFPglRCYXdDkvOwiDg7zAL3or6z+NMcGcPErOK07ctcfr9vdjdTHd+Frf1eb37yA42+rKkP8TrVYejgNPNaImEiUx3XG68IaCRWAkEe3xQPJLtKmimHtzgCQ7nolMe0Nvp/iTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189733; c=relaxed/simple;
	bh=nlDpkeLXmC3IbASLOK+T58E+TXrmqad8q7Jcp4v8ME4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qppkK9S0sALfy7rzQkUyDtN02ZHpRUwTu9bZTY76IDtTZ8HSBmlfebq7ZKPnzEB+wN2+7S3jue4dtsCRnq4nwm8E0W+EWlxnKLY6rCwGaqmWXWLeDqtGRlanRdHw1EB6/vnnl/8O6Mck1T/BmQigSJCfVGMPLeHm4qcj3AeH4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik8xcxZs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik8xcxZs"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so1001598a12.0
        for <linux-spi@vger.kernel.org>; Sun, 22 Mar 2026 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189731; x=1774794531; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kva3CCELe9ArRSfLv8LT8G/ktzyF3jm4fohVcwRoSAI=;
        b=Ik8xcxZs/MGEwijQQiaohsqv9tq/8tYtAjXPhOMYjn12XMiroXyK12KPIIvZKMODRv
         98Ogdpy7AFKjzYVOK5IRFulc/o+SrmfsW6jBDGN4CIU8vxDpFZ5q3JYFKjym3krIJLj3
         NJBRR3dCAmXUuApnTQCNVf1LyiTnEYsu8NZaJVNtAHDeMVBQqepjbOdjvan6eSra+Gn+
         CSXQlIDr5K82rrrlTgWXSlwvqGGcalL0VHwMUUPE1vyYh58JKDy5sAkVHkAqSeR2QOCO
         FLxPmtJLzyfJEdD42E2GbQkJ8tbAaUALXt21pqi3TS6SdpeTChVzy2dcS5CBRThaLTQ5
         WP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189731; x=1774794531;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kva3CCELe9ArRSfLv8LT8G/ktzyF3jm4fohVcwRoSAI=;
        b=I6yybbPDUSpbpFN6Dmm6JkbN+2Ndx6Ylqr7+l2XMe6Gt9ZXua90Lkc4ZcDXbtVio18
         fbE8Ic4RIATG1Fc/+ZFMGRcR3y/+VUjKPvH/oITDBaAPvgMhuPoA9B/YSkMEa0LrBSSv
         h1Q5MkZtYHXcS30iVXufhjBcDvX1wzm/zspm/NfFs9fS5YBc0ff81+3yGFMsYIAcXp+d
         4TaR6iJKksSXTcL8huTQuORhE+YvqKfwVbA0GDIIbSNl8BnWd16yvfeyYeJ5wlessVc8
         MwIzxkwwYzEGYgdY5w9j3IrO9+g1OyBXzanJcEr0/ZYMmzcPWsPASfEe+c6mFkxJdcYO
         VN8w==
X-Forwarded-Encrypted: i=1; AJvYcCU/8NWpWonggiJkEuQDe3Vwf8J2/OrMZYp+PiFDte7SAJoxh5t3/Mv6a7TJIbjTWRr6DMQDokdVVBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0Yt240ZcWxhRuDGx1Txg2YVcj31aU2SzFVrtZSI+7Iu1jkeh
	uvtkS/uen4H4zSIu+RFIul3ppjnj2JlqPOjHPNOlNHo1J1oizbntdbRO
X-Gm-Gg: ATEYQzxti5kaSyK4UwqWUwxK1nXyNIb0fI6TeUxeAsl9wyVIgeiWR/uxist3DwFGYep
	LVH3271/GAd3s1izSWavexWqZn+iRTpda3yZJ5sm7T4CLtP1S6VWxkLTrsdsRH+zArqymZT/QBt
	N/z/JXRcPDDsdk7+/9AnwHj2+9Ba5gmTzdLcs0QWWQjKEt+1an2EUaw4ppJM24bH3oF4J0PzhLH
	l1pV0wEQ5Hiz/Xaj6UbsdTQy4lOnVusv098cgs/NwpoGhe+KtVqsvE+Prv23aEoI4k2jmi7qGmO
	XbulcEnouhvw3HvsbdscyYOeGC1BToDrC85VuaFyNDir+veU0QgW0W1GAgllv0IATXnEStdKMhO
	ZpWIq1012Hf3AT/pmoBvJOYTh/LTllFxoqLiadp2I/XHhhSYYYf681RHsRjufpZJ2mZXJAC63VN
	zhwJmSlGnkI3xoAWZPbh5ooAuT+2chDfZdEdGT
X-Received: by 2002:a17:902:e74b:b0:2ae:4555:479e with SMTP id d9443c01a7336-2b08275dfd2mr79474025ad.18.1774189731357;
        Sun, 22 Mar 2026 07:28:51 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352a17asm78621825ad.24.2026.03.22.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:28:51 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 22 Mar 2026 22:28:45 +0800
Subject: [PATCH] spi: amlogic: spifc-a4: unregister ECC engine on probe
 failure and remove() callback
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260322-spifc-a4-v1-1-2dc5ebcbe0a9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJz8v2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMj3eKCzLRk3UQT3RRD81RLU1PL5CRDUyWg8oKi1LTMCrBR0bG1tQC
 E6zG5WgAAAA==
X-Change-ID: 20260322-spifc-a4-d17e9559cb15
To: Liang Yang <liang.yang@amlogic.com>, Feng Chen <feng.chen@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774189728; l=1775;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=nlDpkeLXmC3IbASLOK+T58E+TXrmqad8q7Jcp4v8ME4=;
 b=6PPv7Gwk4qHZTVUtPhWZUbWk3CG9V6WimJMR6ooi/C5l+BmRfIlDlvzSzM0K3W9eHE6uoqYpq
 bEeMFhxkud6CY8aUF0J6b/hLclw4bxwZ6k9M725k25c+rmAoE6bJzla
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

aml_sfc_probe() registers the on-host NAND ECC engine, but teardown was
missing from both probe unwind and remove-time cleanup. Add a devm cleanup
action after successful registration so
nand_ecc_unregister_on_host_hw_engine() runs automatically on probe
failures and during device removal.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 1aabafa36e48..16346f50c7d9 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -1066,6 +1066,13 @@ static const struct nand_ecc_engine_ops aml_sfc_ecc_engine_ops = {
 	.finish_io_req = aml_sfc_ecc_finish_io_req,
 };
 
+static void aml_sfc_unregister_ecc_engine(void *data)
+{
+	struct nand_ecc_engine *eng = data;
+
+	nand_ecc_unregister_on_host_hw_engine(eng);
+}
+
 static int aml_sfc_clk_init(struct aml_sfc *sfc)
 {
 	sfc->gate_clk = devm_clk_get_enabled(sfc->dev, "gate");
@@ -1149,6 +1156,11 @@ static int aml_sfc_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to register Aml host ecc engine.\n");
 
+	ret = devm_add_action_or_reset(dev, aml_sfc_unregister_ecc_engine,
+				       &sfc->ecc_eng);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add ECC unregister action\n");
+
 	ret = of_property_read_u32(np, "amlogic,rx-adj", &val);
 	if (!ret)
 		sfc->rx_adj = val;

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260322-spifc-a4-d17e9559cb15

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

