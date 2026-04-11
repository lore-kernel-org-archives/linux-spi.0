Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33E29ACF6
	for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775908185; cv=none; b=ok+skpV5siioCzwLyTwX58kdkkLmMQD4AhmZBq2rr6kFQq85b2IWnyU5BlqAP7K3rsvrB0sdjpf4KBVk6DARpjP3b6KgwNTzAUEHKP89rXPhu3Se/yvu3NLy7AoExgxMIQbOBsZCDljBNB7M9DN6GgtazJHEc5UrzP7N1XBfexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775908185; c=relaxed/simple;
	bh=YlDBfTNKDC61NbJ/MWxSYVaEY5En/uqTnBWbyaQ/IXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LJqp97m7azXYsNCuDxX+pnlRm20f4tfhRngmFmZoVQj7UHqhLmM4/7I1RZzWoAdhWjc01TCOMuNIFkIL18/DDSDn5NO6u7xIV4AR33dY3J7kN7g/848DETlvifEG9pWbgh07Iqxebiyv9lQtxB8+9SE/6mQZhekoNDqQfW1NYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCv13mjB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCv13mjB"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1144964a12.1
        for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775908184; x=1776512984; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05Bl1VMHrlqvAGCe4SZJGpUzfEdAgQQ/S9qmsGrkSYM=;
        b=KCv13mjBivZ3/LUDSHAxFCHrmXDW+lxp3lTI/uslX5FLw/WORDSE3TK6XbPAWlNwBa
         6SOwTQppomE5WclJENnuF+7TtPgxjYmjwpaqiLS6ytvgb7PYUjo/vsxfeLn6O26upcBc
         eeCby+e5SbDYANnC3T0fvcNR6otzf01L1vRf07l7VldynTqzM++COmkkWhu1fc9gf2DF
         CdzDupSsn3lgOGHXTmzH5AkHFUQ+XfEBWIvbzr3Hh8w45egtCNGzDWviRzIONC7NhPJV
         5e7GYu/6FdG5Z+togoxZOoIS8V40y8KRJ70SDVoPBOFBNOTgs1F4pWmvVAXFFtT/7tVk
         loIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775908184; x=1776512984;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05Bl1VMHrlqvAGCe4SZJGpUzfEdAgQQ/S9qmsGrkSYM=;
        b=K76Daqt84nCp4xaOrbyZCmTY9pqq9srnDMBqD0v/wLpV8PsI9PrtPhXKxJnizT6Wl6
         Hy5KSF258JUWAm3Y/rjT+iPTujC8vmn1LodrhR4Qv6mNorTj6RHQC6Lzho3NqCZed6vq
         8W7ntLkdnKHwuvR4e3k/8Zs5dYdcP1h8ARl2mYf9sqGG55l0Yfq3Slf+2cIkwD5i9iDJ
         I+ZBVE+EVMfjfMxYHdUIgAAzNwxpZxNN4zK4e6zOM5qoVOkjOYPWz+0TDYyu01Y/T6ei
         sDSDwbjMee4Bh2NOslfr7o9ZOVPbLPX7mkhFV7nUPHosAB3JaiN2XhlkusqRWe25OHuP
         M0ww==
X-Gm-Message-State: AOJu0YwuWUBFpayGnSykmOTry14XtHJloUWFv+zak/ZEv0WrqA8y6lWs
	2XIJT9A3Sflq3CZ5eE+D2sQqSRwCgaWUT5k69bsZgpAlEKzqM3AvKaUzD1Q2iYPrjUM=
X-Gm-Gg: AeBDiesXU44NAi7LsPFKVLcISCK4KeW1XUpK+nMS5qZ1kO13OTzJD7FDDu1Cl13UatC
	oqBXeh0eu6y46IP9ek8YxiHvaQNWQ+H/tvUYR1WsGp1NdVQ9QvQVqisMnipthNpqVrDILxG3bVU
	FaTLdzwZmv9N9/2TCqNCzX+ZUH6n+InAjKdiJCGxBNvVxWsQRfDS4x/uAXUWyMkmJVVCMCsv7Pi
	LFarkhuiPbnMLxufmsWHJXwi+I1qqzpUXRFmtzcP4aHD2h0Ei89mGrWADZgstRJsCjI/UkvCrVE
	8qifikTaRpyey8g4/rFyk7LfghDpCrXdZevnJzT86Cszjlbcn2dkzh8U4wxcCZpEa09r1FGQ65M
	J/lUGqOCcnty2dPqCnIy8W2XI+EF8zErC1mwhUJaryQ9U+3omtCXZt69+PUhiI1AlRed7mKFA5B
	/h2jQXXlWZrTCid6OZ1HsGaCoOEyZNEDNq5bO55x6kqsKTOihsoHv6meedRfQPTHBqSUKKaRK1F
	TOgRyFXzSh85CjLE5qn
X-Received: by 2002:a05:6a00:17a7:b0:82c:dd31:b84a with SMTP id d2e1a72fcca58-82f0c2b03a3mr6917094b3a.43.1775908183861;
        Sat, 11 Apr 2026 04:49:43 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c371825sm5421377b3a.25.2026.04.11.04.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:49:43 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 11 Apr 2026 19:49:38 +0800
Subject: [PATCH] spi: sn-f-ospi: fix incorrect return code for invalid
 num-cs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-ispi-v1-1-af384e81c4c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFE12mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0ND3czigkxdi1QTU0tTQ5PklLQkJaDSgqLUtMwKsDHRsbW1APW194J
 WAAAA
X-Change-ID: 20260411-ispi-8e459514cdfb
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775908181; l=865;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=YlDBfTNKDC61NbJ/MWxSYVaEY5En/uqTnBWbyaQ/IXQ=;
 b=RtthSPOeP4fGWtwjriNR1eGEkX1u7LJMJYtl7vs3iNJjEopGY2kihveEU9AJcFeeKUWt3Gujo
 6YCxLzoKu88A5Szvua7bpbzRmYEpGm1yHMViFWgi7+imP3fFw3+Xov2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Returning -ENOMEM for an invalid num-cs value is semantically wrong. Use
-EINVAL instead.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-sn-f-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 3c61c799723b..b459d51cb3a8 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -625,7 +625,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > OSPI_NUM_CS) {
 		dev_err(dev, "num-cs too large: %d\n", num_cs);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 	ctlr->num_chipselect = num_cs;
 

---
base-commit: 66672af7a095d89f082c5327f3b15bc2f93d558e
change-id: 20260411-ispi-8e459514cdfb

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

