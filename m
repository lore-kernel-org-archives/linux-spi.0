Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1454192EE
	for <linux-spi@vger.kernel.org>; Fri,  5 Jun 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672798; cv=none; b=D76URKSSTzdHRe0WXhyoH96Z2w3r6igPLLVYGnjNtbCJGsduq6bWy/l1JuFqRKX63D8lL5F4bERscEQkWcdm8ybQgI/oBhPOH0E/fq8sDsN6fpwHY10qs76gOOLl/wT2dnFKMJRmrI1miRJNa7JCavwMz/fYzaDfBHfxCPHRWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672798; c=relaxed/simple;
	bh=F/91aYGOp0TA4Df0ndhGc9g7+0e11u48hDY7fSepMX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CfQUQSIdax1zh8j/rWCIt8owFyCHnCa3tC1GDjJEylRYINgDpYABU5nELlk/u3t0Pu9DWf2AYVlzvmoIhbWJ7iBzgaVDsvYRqhCWOJYhv/oYdxCL1zAZfenwNUWZHHSfLymX1oKasItcDSbr3OFf4it8pEPg41YPL48/1/v5jkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8CJwce4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8CJwce4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c859a374903so766083a12.3
        for <linux-spi@vger.kernel.org>; Fri, 05 Jun 2026 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672792; x=1781277592; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aGW6DwMXILcfqbxRFQDtqjBCL5eF+tfSt+H3qYqWsKA=;
        b=Z8CJwce4Y6p7prb45arq2c2BcGQyHxs4FIoSeJrofc5Btr0+RireAz4EE3S/6ggfWP
         hb8xS5RbJb+lc45fOBFi+kTjjknAAjRLFLTcdKwiuicAAWDjrIq9PqfGk4MtxMBMazjw
         n316GssjYYhk8aISl/FEW/ZlMn8VWDqSh66NRBK5zqb23tnbVg9nsgZ32AAH0JaEGJQF
         rXLO35nK9ZD+ZzuOnHBO6L/1Fd/n+DRvp2REq6ATSRHxkAdtrLcVzkAcAuwd/HEAHpg5
         zJ1uV7KVJnI5SlZLjxhChhcC4N/7P2YIL+jIJ7nmHXhQcr/jO3iCc4Q7qRDzFpH39nH3
         r87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672792; x=1781277592;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGW6DwMXILcfqbxRFQDtqjBCL5eF+tfSt+H3qYqWsKA=;
        b=Ow8XcsuR02mRXf2UiZwqDKfAxgmFayEWLn7MTpiJ0RVBVYiASKsZD6rr5gEVw2PN9m
         wm++Hqp/hih/i4tWLlMKusqAR5leEAdAKvAdWeuLxzLLfZforGRdtfPfj+DDXllNtDrR
         yItQTZWeCMgeIP3nMlx0CDnMRYWfGuwfgoBZT6dei6639fFWJ+e/kWc1WFxPlhszdTiW
         bbndEkG3ik3VvTu7NOWR/VHcWKAY+PZ5itAzvwswp2hhiuAoWtVMJFhClngLJAcg1HG1
         k/q5+T7YTuhOMuwIc6QGx6tfDjaXjYw/sxjSgXeAuM07eN87gzmtleNX+XTvkhP+Bkql
         fCCQ==
X-Gm-Message-State: AOJu0YxP4Yf2E7D/EYNSHFY0vVUImioitHxK+ScBv1Dd8Nca1H9cTtUS
	AnpbswgX66j9+Yb+57bP291Sxpv8iMvotpQp54UIlev+qiNLvfbYlxgcy1LceRZPb1M=
X-Gm-Gg: Acq92OFNp1kgfd/zh/5vWD3fbwFWN44j3D2khG4BOCANP/VwGvAALPuiFri+eMNJ5EA
	NiwH3It7Wm2A8kDgJ0d1nLOaaIGheIxu+ajfaZinUQ7LbjKFXpDLadYEmDOJrODe9GJUZlAUcSw
	dxv1/idm8FOP6k4tCgCdVTuLxxv0RQeCgSmkICkfMWxhqYa4nev06rU/UknCwrmimeNlZF1/m94
	Y2iNfgWiHOLYINmMiT9ufzdh5Q0WFkL2aXYzsVqvRLol/TeAiZQWfRCSvlAeERkrs/eQxzuntCp
	HPR6mdvDKuQkuzVfxYBktZK7pv4Dlvgt/YNi3Fv8pyB/6Iom43Lw+39YKgDgdAJe6IMoDmvjMgT
	laumQ0RENwLvaeERBGPlHY/9uJHJQxkrlxbEnW2lx1OTAXVMMFWbYjMmvnxrwa/N4/tFUvQD5ko
	U0aEvAzzdNLshfYNCg7rqWMbWN1U6OogHaFkPAF+BwUU5bPjFT2mopPck0T1AL0MVQ58Wf9yvE/
	IghoIM1sfVHVSRNUuF4nwtJTJ58
X-Received: by 2002:a05:6a20:7289:b0:3a2:f7bd:a9a5 with SMTP id adf61e73a8af0-3b4cd040147mr4994963637.38.1780672792015;
        Fri, 05 Jun 2026 08:19:52 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0be0f0sm7954308a12.30.2026.06.05.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:19:51 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 05 Jun 2026 23:19:47 +0800
Subject: [PATCH] spi: rzv2h-rspi: fix incorrect readl() accessor for 8-bit
 RX path
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com>
X-B4-Tracking: v=1; b=H4sIABLpImoC/yXMQQ5AMBBA0avIrDWpihJXEQvawVggM4gQd1cs3
 +L/CwSZUKCMLmDcSWieApI4Ajc0U4+KfDAYbay2OlN87mZQLAup1BXeJ7bo2txACBbGjo5vVtW
 /ZWtHdOt7gPt+ACaDeUhuAAAA
X-Change-ID: 20260605-rzv2h-rspi-3c8dd168fb72
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780672790; l=1014;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=F/91aYGOp0TA4Df0ndhGc9g7+0e11u48hDY7fSepMX0=;
 b=HepSfuexrpj6g8kfJG5KY1eSs6Sp3+IaYBt5zzn/iDBlV1091dTONl7FFS8zbuFSKE1k4oDhJ
 7FcKOIxWMh0C7yLiZT0SnEVc55ARLok0i7Q8jWA1uz4tJpU2aKHT9iF
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The RZV2H_RSPI_RX macro instantiation for u8 data incorrectly uses
readl(). It performs a 32-bit read which can consume excess data and
cause corruption.

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 1655efda7d20..1406885ccede 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -137,7 +137,7 @@ RZV2H_RSPI_TX(writew, u16)
 RZV2H_RSPI_TX(writeb, u8)
 RZV2H_RSPI_RX(readl, u32)
 RZV2H_RSPI_RX(readw, u16)
-RZV2H_RSPI_RX(readl, u8)
+RZV2H_RSPI_RX(readb, u8)
 
 static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,
 				int reg_offs, u32 bit_mask, u32 value)

---
base-commit: a225caacc36546a09586e3ece36c0313146e7da9
change-id: 20260605-rzv2h-rspi-3c8dd168fb72

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

