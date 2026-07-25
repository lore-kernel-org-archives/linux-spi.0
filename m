Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E331E820
	for <linux-spi@vger.kernel.org>; Sat, 25 Jul 2026 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784953813; cv=none; b=e/tlfcY0xMaZdrr7Fwab0umwyQzcwvwjVRsyGpHHgtydfNa1jTfWmNCTVTBXpqOmh2BSNBSoyfUCbm2ovH6SIyrd9Vih+4RkM08ZxaqrAzrweuPx9M4Ha0mf2KAyBA9tQ5IckAmNx9g3BhSDiJobSnnYPjl7+0NYF3nU3WyI0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784953813; c=relaxed/simple;
	bh=musYvu4kG+XXqxnTHrbOaZuAwdan+yHB+92wfOCg1PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIB/eU7QK+LyfYmoMA4zI5/XwJuHmt2M5Vz6OrJya2rREVW9GqmTBWiEdASEJ3xptmWJ9cyS5APiXsblUyFevNMwQ2U681U2ljYIBdt1q67ec3eRxeUHwGyMfpDnAvFPVKk5DWj4QyJcXOvp1L5OV2DYhRu2hJY3DsTaTa5JmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=T01Dbcwk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="T01Dbcwk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso677006a12.0
        for <linux-spi@vger.kernel.org>; Fri, 24 Jul 2026 21:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1784953812; x=1785558612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EjohzwxsJRfPbC2U2sWKg8g16sF/knZCZszVfz0+Kq4=;
        b=T01DbcwkuNOiALqPv+mOpI21gYOVK1xpEz1S+bRM6rv0uEvmgoYx4yKyuQxJNL8zCB
         Az+Fhd85wyBHkrgzCTw7eR+hKKtycilsh9nJAr+yTodGY9O/+MDnKSczCaqLPa61bCTk
         /n59kYtHnBcfUidvDj3qFQ2iAcZ+w0hWl2iVLd+NxJM5al9kgqyf5+5HO/Do2ZzDUzbf
         NVqi86z+jUKacxv+PWs+uWWSOBS3xsxdd9J0MLu0yaHGixOfminPKQ1oIbIdImcVgobo
         BtzEIhUfb2yFT698Dd4wobsOtsAKvMofkMj8UJZF4pf87R8nHffrOzWYV9Yfm97cF+wq
         CrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784953812; x=1785558612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjohzwxsJRfPbC2U2sWKg8g16sF/knZCZszVfz0+Kq4=;
        b=SBiTu1L5dXkzMCCUF+bu7qEHWlt/qJ+1w/TB7H2CN3SVF5v/lmMX3X9oGLyDnjlPxI
         Y2k7FPfZ7lmYZKwzET4epUHdV4k68xRoTk4ft1rKmozgkBQ7uy9EvZCWKAni0dXMvdNb
         YI1UdtEHydxFF6XwB72XPrlnWqCQdqxjZ+CC43TxUVtKmVno80/iim2yv09V69ZJkt1r
         r7/ukJvpS6c0FmGhAJaFXE8E7v+z7kSknRZuCOjYmjTXOMwJtG+9okuFgZ4w41r11Jdj
         WAHRdYu00ogSdRNlaLB8JQq8mltygHeBus1rXVGrvpewcoEXkc+/M6yji9RsD3rOX6OD
         9fbg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3NrPLKXlwP14SmBdFF6mKaeI/G6pJayrcZlLrgRACPjJYUrDr+V0HlQd4Lf6NFZnYIrUV4jQCrbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrC8QFX3NkFT7Vcm0KtwqOBaO0CYZl4Gqv5EIT+UJ/ghA3+3WP
	83DvyRepuDw67lAdGItuf9KgcjwJqgwx9IVadjk8cncVrgLXG8KNVllKQBPVH/BWEcc=
X-Gm-Gg: AR+sD13yDUUq/1zjGqZtxPcQzviy68vMi6V+VgYPhFg4Hj3V5Le6TkbwUCIXze0EaJm
	kDr3yx2hImv0s+YrbxcU4BqESgOfJHcJj/IPpKuVlSIiQYeWokZvMarPxGxCU2uymdJ6l81rJl9
	lgdNo4/g7pIvOD43JeLCJjOSmWUCytTbm7NC7Nq1D4Y82lwVsfpSaEOQAbtivg1lkflZkgVC85z
	4brdCeG903krVlW3JYUF6JHDfJjdlRi4DPmhFSaMJwPfcpRbwT6F1Siftx3XOfcLHnZlThE2f+k
	ahzn08j1/jLoT+gScP7A3zc0PDdxeezgoikYtJvVgRsVNsNqKJSUWXsbqHQBF5S/9zjKlK/QZhU
	PHO8wCjvENNm9Ylhoh+xJsaOYU+40DNZltfPvcyUG+J0jQ+j+wbNv4KeKVNOtqc9+UTkkDffPUS
	XuIQ4SCOligSogXONXhUBaIsL7kWA4gKoX4Srz0TAgmDUeacw6Anc=
X-Received: by 2002:a05:6a20:9f46:b0:3c4:46ca:3350 with SMTP id adf61e73a8af0-3c67dae9748mr1209444637.6.1784953811727;
        Fri, 24 Jul 2026 21:30:11 -0700 (PDT)
Received: from abeMaticDesktop.1020marsh.offices.matician.com ([2600:1700:471:807f:da8a:3174:41e9:b949])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a04b2sm5158361eec.28.2026.07.24.21.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 21:30:11 -0700 (PDT)
From: Abraham Zukor <abe@maticrobots.com>
To: Mark Brown <broonie@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abraham Zukor <abe@maticrobots.com>
Subject: [PATCH] spi: tegra114: initialize native chip selects inactive
Date: Fri, 24 Jul 2026 21:29:44 -0700
Message-ID: <20260725042944.1204409-1-abe@maticrobots.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tegra_spi_probe() initializes SPI_COMMAND1 with only SPI_M_S, leaving
CS_POL_INACTIVE clear for every chip select. This drives every native
active-low chip select low until tegra_spi_setup() runs for that device.

SPI children are registered and probed one at a time. A synchronous
probe of an earlier child can therefore transfer while a later child's
chip select is still asserted. On a Tegra234 system with active-low devices
on CS0 and CS1, this caused both devices to be selected when the CS1
device probed first. Its initialization then intermittently failed. A
logic analyzer showed CS0 remained low throughout the CS1 transfer and
went high only after the CS1 probe failed.

The Tegra234 TRM also documents all CS_POL_INACTIVE bits as one after
reset, so the existing probe code replaces the hardware's safe reset
polarity with zeros on that SoC.

Set CS_POL_INACTIVE for all native chip selects during controller probe.
This matches SPI's default active-low polarity and the documented
Tegra234 reset polarity. tegra_spi_setup() continues to configure the
inactive polarity of SPI_CS_HIGH devices before their drivers probe.

Fixes: f333a331adfa ("spi/tegra114: add spi driver")
Assisted-by: Codex:GPT-5
Signed-off-by: Abraham Zukor <abe@maticrobots.com>
---
 drivers/spi/spi-tegra114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aa44ffd09e61..c28aae093d57 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1394,7 +1394,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	reset_control_assert(tspi->rst);
 	udelay(2);
 	reset_control_deassert(tspi->rst);
-	tspi->def_command1_reg  = SPI_M_S;
+	tspi->def_command1_reg  = SPI_M_S | SPI_CS_POL_INACTIVE_MASK;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	tspi->spi_cs_timing1 = tegra_spi_readl(tspi, SPI_CS_TIMING1);
 	tspi->spi_cs_timing2 = tegra_spi_readl(tspi, SPI_CS_TIMING2);
-- 
2.54.0

