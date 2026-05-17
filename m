Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6DD2C027B
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999169; cv=none; b=Nd15xoAVbZh3SvKYt0WbzQNX0qY9sg+Sf6HuSMVhIK8jTnAl1c5Ysf4MtsjtSaoYDe7kp85CqwJ5oOztoMddBM18nwmJ2sKMFvnHKR++sFEA1G2/SLfshqsH9fcazaP5rtayR1xHceKrNjxJtX/PNOHbkNqEvo/KlXE8mN/jyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999169; c=relaxed/simple;
	bh=vUqB4yVX3zAJzQFdOE7mli6Bb/XeWPhigapaBpgt0nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oy5tr87X+zoxmkJpP7PxK2kBFUIQLSAtFCwswnEHz0rFWup2NeKqfhjNNq1q54z6tiDobWlGW32Zx/7V41yj70BQWize15chWnX+GOHn83kU8azoD3PMjgAH/mVHlr5SPDWCi0FvOCbXVGEBLpXq0jVV+r+9VVkYBdL2Zo1h0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk; spf=pass smtp.mailfrom=pcc.me.uk; dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b=lcYOpY1y; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pcc.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pcc-me-uk.20251104.gappssmtp.com header.i=@pcc-me-uk.20251104.gappssmtp.com header.b="lcYOpY1y"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ee990e8597so3872792eec.1
        for <linux-spi@vger.kernel.org>; Sat, 16 May 2026 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pcc-me-uk.20251104.gappssmtp.com; s=20251104; t=1778999167; x=1779603967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fD48aiciFvO/6QSCRaKgqQTSwUDqCgYJGqwbqc21HlU=;
        b=lcYOpY1ytCx5gKdtAmBbMHJT3XOa5lBr5+HwR/5KFLIySKgnpSa8SjpjACnaBlEslt
         MaQ1xDPGcICVv8JR+grIGoEbrWnv+t2y9OAY0XOtEK5LQ1hthWBTsC+i+IV7Xo0HjAEm
         gR4HHzCjNoj9yYtTg8vB3DwWsy8Yahl1Aw8hznZ5CB3EuD9QvzD1AdiKMK5PrQPaSMWw
         5upfYKado1kE2OxVMr+rpdT48fLX2cqWr176DJdKNuh4mHIbI6pAG5ED4FQDL+vwkxBx
         qmOHy47QPCJq0hwmmeMVFpc8BiStR4Fv9v0zwl72zG652zVZZh3zy/JY1JfBmP7cNdBB
         4fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999167; x=1779603967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD48aiciFvO/6QSCRaKgqQTSwUDqCgYJGqwbqc21HlU=;
        b=kIjdvwZ10Jgu03sFNEj/kxpt+qgMYHf2wx8oEMDCC/dy5amFCR2g9KXPNyZuwWWMez
         5QM7rThnkVAbLKJsLuIMA/hLjADkqj20CLPXIBY1APpLVxGiJk3UM5EPvlCHonqWUdAu
         RPrI4wXQLUQjP5ohPE9aueqHQsfIbxBn3ZsqDZJEL0rha/cMwez2qNl+ZvginOw69lfq
         G6qyMBzO/fGEh09udznaWyAOPd61rMV/tWSmHAn6UWygkY553+ETqUMcB8WgDMe9rCa7
         JimHwYOXIdbkUyPgVjIRYjti3EXbbkjKWX503ijHoB4tHlDDNtbuwskFWB4Xe4aGVs41
         vFig==
X-Forwarded-Encrypted: i=1; AFNElJ/ARv94CGFcrndzDrRyunscQ06vBh0VDjA1qBKfJm9fVwM32DozcFg3oltGSwjYcRA54/Xv2ADp1b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC+GwGPDyUrlma1QgDSE/CoQjLH/pTuCq7jyDrrO8IQ8LdqVLy
	MgVwsbcVvW2Uqiz7CxrTIfjEjci4I6mAEVI5gtC224KYnei90lenPUmGkncz9kELrNaGDG+XwbX
	tdWsX
X-Gm-Gg: Acq92OGotIBieulAZu1dTjkrdJdgif/hfUyzYKEgoUW9zC/66EZMfwPhI3QKTKVqfAr
	TKnmpp6NB9RNAjLGPyIMn/01IYBb9BIoGIK4ZSEcwwDrmOeHL26bKp8dejFji2+ZNiyyjfPaNLU
	uV7+4OiZ/QnLSnrrXhSD9PQaGZd+r1QMYhXUiIdUdH7h2GbHeScIzFBwrO7CQfNB4h1YmIhKX/Q
	rPxUV3vKI/QvXsOXU8pyE9QqAhx1iJ6wezbb8HOKPLg6De7gwBA8hTkhAFuKw1OOhfqUCPvTJD6
	aZuVYDRhDBCPl9rbM8KfIz/QDH2ik3d+hKgTgzPj3l59apsA6zi6NwshZo8AQr4z/u2jrc9isvS
	uXrkCwUledjSDlcgOo8LO0wzpMiI6Q4nnnyBJ1Ui3KZKt8ouFaaykD5x+522oKxYPdBJp7UJ9DW
	bxkQbcVeCDecjwTyGff5yQ/aUkTfABIFIJmojXTFdFRjK52R7xF7ZbrFo=
X-Received: by 2002:a05:7301:2f85:b0:2ea:ed7c:912f with SMTP id 5a478bee46e88-303986a1430mr4952782eec.27.1778999166750;
        Sat, 16 May 2026 23:26:06 -0700 (PDT)
Received: from localhost (c-67-180-161-137.hsd1.ca.comcast.net. [67.180.161.137])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-302944ffb85sm11402308eec.7.2026.05.16.23.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 23:26:06 -0700 (PDT)
From: Peter Collingbourne <peter@pcc.me.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH] spi: use udelay() for short polling delays
Date: Sat, 16 May 2026 23:25:54 -0700
Message-ID: <20260517062554.117448-1-peter@pcc.me.uk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A short polling delay, such as the delay of 5us
(SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
can become a 1/HZ (order of ms) delay caused by the usleep_range()
call in read_poll_timeout(), significantly reducing SPI NAND access
performance. Fix it by implementing the polling delay with udelay()
(via read_poll_timeout_atomic()) if it is short enough, matching how
the initial delay is handled.

Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions")
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 drivers/spi/spi-mem.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a09371a075d2..914e35e51cea 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -1005,10 +1005,19 @@ int spi_mem_poll_status(struct spi_mem *mem,
 			usleep_range((initial_delay_us >> 2) + 1,
 				     initial_delay_us);
 
-		ret = read_poll_timeout(spi_mem_read_status, read_status_ret,
-					(read_status_ret || ((status) & mask) == match),
-					polling_delay_us, timeout_ms * 1000, false, mem,
-					op, &status);
+		if (polling_delay_us < 10)
+			ret = read_poll_timeout_atomic(
+				spi_mem_read_status, read_status_ret,
+				(read_status_ret || ((status)&mask) == match),
+				polling_delay_us, timeout_ms * 1000, false, mem,
+				op, &status);
+		else
+			ret = read_poll_timeout(
+				spi_mem_read_status, read_status_ret,
+				(read_status_ret || ((status)&mask) == match),
+				polling_delay_us, timeout_ms * 1000, false, mem,
+				op, &status);
+
 		if (read_status_ret)
 			return read_status_ret;
 	}
-- 
2.54.0

