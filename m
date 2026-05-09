Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF51A6836
	for <linux-spi@vger.kernel.org>; Sat,  9 May 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778349343; cv=none; b=nSYXawabKI1WsLqr+IT9eH6Xea3pFju4w7+GjvwFkDvIju3gX4o4zfzbZyoIazyBT4VeLOGuccqm7FzUrY1ZQnUIbyMbItYWC8+XCuYK8cJrYPjdSoyzHHNjNsmUEzuqP1ystE3zzK5abt50SUsckKx2BnYNPg0+PLq/SEng8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778349343; c=relaxed/simple;
	bh=lzDchxhHtPBQa1sKrWzU7ln4zgtB68T8z64OOY1Zf9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hbQe3XkVUHbW4KzceTqdi2Qtq+o6H0scqx5bti6Wg2HyhxR1ekTTcfg7lzyhT0K2hXjWcAKrTN18urD/oFH+iDhlQU5ZjOGstYg8cSPLDjRr6evf1uFe1QKGV0+lWcTp/3CheqwWuqdXGDrUxpVWSkLm4HiDbDTrMZcM7hABAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moZir0mM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moZir0mM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36622412e97so1787080a91.2
        for <linux-spi@vger.kernel.org>; Sat, 09 May 2026 10:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778349342; x=1778954142; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CllBL8xoJh4IglhZocsMiJYl6zMjGoSZL3uJ5PhEPoU=;
        b=moZir0mMRo7rpR1j6Dv7VscV2NR9VuP9s1cjdZD2fFFuyDsmv5IiH7bP/OheoZMIcT
         tC7BAZKe+nROVpkE1MX5xtib8mG7TZfMqKb5IOiAce/iWhzFuYoa2XSLfttI07QdqV2R
         C4xBXJpdNb29Evj/H7VyrsukIGPDO9BW6ww30tUld9fWlxhWpvAxJTG1lVYUSLdVkpdj
         oXqmb7nIJp1DeAd5vgCvAF0z8Rv8JrdUvs7qJkMwhYRpGt5z8fn44w0/zz5sOeXjptUQ
         jB0BZX1tP7wIoZIrOciRip71uiwaIl8O112xvQLlxF1OxevGdaoNIMuQGOw63XmxsEot
         FkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778349342; x=1778954142;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CllBL8xoJh4IglhZocsMiJYl6zMjGoSZL3uJ5PhEPoU=;
        b=r8Yn1qQTa5YPF6K7nBT0SEt64aklsdsm94mkU+te4YhODASFI+OVvtBFNAn+wBHe2E
         VzJKGtEgMfK/ZPDi2/MK+90pzDyna6htDyTV+x6ZvTv2q/+nGVxiI8RCNXXH+VvYk9m9
         MS5NjHqTP6t+AuWw91l/v7u5c8pZdxrTQ+FR2Vx71SS5jX7gMsAZa+m5To0drSN1WQio
         gHDSxGj4PU+4azqyaVd1LrZLNVpsa20DFDGb8/TLwNgMWoFJT+qMgPBF59FzvZ0uFLdO
         xmrWIs6biPbaB25r4w11U1uVUvfUhchnBWU5+al9LMQOOBR0xNpkCAvW3VchfA35eF3E
         UzDQ==
X-Gm-Message-State: AOJu0Yw4D3FN/FdTyQqKw5dChuvDJcIo+R56QeaWJJ93CArk2iPeTUoa
	hcKsHjUGzWlnYhrDKhB6kuNYQMmkZm+Aihzp3YxfE+lUeMSpyCidYYcw
X-Gm-Gg: Acq92OHdSBYfQ/WJgY1a2r6XPcFyli30OLYwErdOzA0XW4DwUAp5bABKux0a0Qddmgd
	JtNkfONaxiIekWleBpGyOhNYLMfrwebEXKbKIV8Q0ml8BOGLfzwKbmnV4w7Mbjqech/Od8vlyUd
	FtdEpJMICSdSdcY65BylHz2SwHAN+TRSC9+SjedLfrnkaWhVjPsvwtJlujsux8HC4zP0v89gY8L
	eQT3VV29FzcxdXg69pMBne8Yn5LR0ZyQInGJP+Um1zHlH2Cks7HJtIJVDfGm2gQ8fcb5JX025iB
	+rijzHPruQCtbYXnnNeqCxthSCg7ggftkyPSmLTc3g4qosXqmStwMnDe1yQq9ABqNeGUQwLgy8+
	UmTsIOVYKouqlY3b6CtV82ILBf6k+QL8/CVr0xDUL4kGMgrYDVL7j4ZQEwSoPDfnsZFhz8mkYAI
	aXSxfTXXlOXRJ6oMJ+VCqOtLsszVLCLPrt8JGuoao6B3+UxYIGo9m9WBi8ie/1N95c6gLn0HAd/
	FP5sfrXg8xaSSWqHDpOKqScATK+Sw==
X-Received: by 2002:a17:90b:54cb:b0:366:5c38:fd61 with SMTP id 98e67ed59e1d1-367d46cf57bmr3438337a91.12.1778349341817;
        Sat, 09 May 2026 10:55:41 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d627bc2bsm2657564a91.7.2026.05.09.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:55:41 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 10 May 2026 01:55:37 +0800
Subject: [PATCH] spi: mtk-snfi: Fix resource leak in
 mtk_snand_read_page_cache()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-snfi-v1-1-bc375cf1af8e@gmail.com>
X-B4-Tracking: v=1; b=H4sIABh1/2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNL3eK8tEzdZIsUQ3MDU0NjSwtzJaDSgqLUtMwKsDHRsbW1AHZnNMF
 WAAAA
X-Change-ID: 20260509-snfi-c8d170513987
To: Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chuanhong Guo <gch981213@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778349338; l=1056;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=lzDchxhHtPBQa1sKrWzU7ln4zgtB68T8z64OOY1Zf9A=;
 b=HbtX3JjNE9/jOKrWHby/HPxknGm2rdz0M2k5cyqeMlF6IqYdlnAEwyswtC2+TX2xR1+vNf7Yo
 wpuwsjCInqSCHzzwBS1Zt/2GOyefeCnYKyuDCkLjSjM0FwxSIRKaC6r
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When DMA read times out in mtk_snand_read_page_cache(), the original code
erroneously jumped to cleanup label which skips DMA unmapping and ECC
disable, causing a resource leak.

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index e616e6800e92..6e96e50fedad 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -961,7 +961,7 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
 		    &snf->op_done, usecs_to_jiffies(SNFI_POLL_INTERVAL))) {
 		dev_err(snf->dev, "DMA timed out for reading from cache.\n");
 		ret = -ETIMEDOUT;
-		goto cleanup;
+		goto cleanup2;
 	}
 
 	// Wait for BUS_SEC_CNTR returning expected value

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260509-snfi-c8d170513987

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

