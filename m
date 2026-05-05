Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C0648A2D1;
	Tue,  5 May 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003870; cv=none; b=jSx+bpq43P3K/7oN9GUIDbMurxxK1kUhhUUt4eeZuqh5jGY0kWmQwb9BRnKPBDPTnu/ksXnSC99gcLHqg5PJHMxBTDKhawNv8P9nZUCj7z5GSqLmjKxr62wpT2eGigimqIlfUjaC0x63lSktNl4R3Sgv0mDdGXGVYkIFtWXhsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003870; c=relaxed/simple;
	bh=CVoF/aMvFZiiQJ2jem9yrxKDBn80nFnyrlVLhIRdosA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+6y7FfmnR9SlYTchcCVeS8KmQhDJk0TFXRbOWPDvoO8CKB/nvDdMu6FzHhzOVl93gFyQJUaaYUNRfgEjCxEFOghcMU+ozYhfTc3v9PClygMpE+o8Zaag5txV9w1ozNlh6ChbI49NdMeBFfGEb7xjWsicp7g8Ni+VhF99/dYsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArMc8fDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArMc8fDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA09C2BCB4;
	Tue,  5 May 2026 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778003870;
	bh=CVoF/aMvFZiiQJ2jem9yrxKDBn80nFnyrlVLhIRdosA=;
	h=From:To:Cc:Subject:Date:From;
	b=ArMc8fDVcsmjBKD7s6parLZQ298K1YD0Ki7w0CyVdtMHumfu7gz27pCqVsF0ZS7O2
	 R8n1fRC+/Ij/9jD3dFX69yCyWTSRBycqIvayLuJMwzC3TUlRLJMtE87UuYQCrWaOF3
	 vz9ql8d3QegfzBGObI6x/2mNgPw52miXVkiw462IEBlbpjC1nJ8dcmGrJ4GJaTnGIw
	 1GCKDz7KI/Yl7XuDVFRWtmKBbrKqhonj0wQJeQC7/UYr0mj8YH1AO5V4XjDBnTTfaf
	 IFaNDIbRuNhyXPL/7TDC/V03o/y/G2CnFZngNTuMMvO8XWhryB04I2Z7BNqtVeaNDW
	 pCJlsW5ZEE5Jg==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Alex Elder <elder@riscstar.com>,
	Guodong Xu <guodong@riscstar.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spacemit: avoid 32-bit integer overflow warning
Date: Tue,  5 May 2026 19:57:33 +0200
Message-Id: <20260505175744.900750-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Calculating the bit rate in nanoseconds does not fit into a 32-bit 'int'
type, as gcc-16 points out:

drivers/spi/spi-spacemit-k1.c: In function 'k1_spi_set_speed':
drivers/spi/spi-spacemit-k1.c:393:38: error: integer overflow in expression of type 'long int' results in '-589934592' [-Werror=overflow]
  393 |         nsec_per_word = NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;

Cast the value to a 64-bit constant to force the longer type for the
calculation.

Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
There is probably a way to rework the algorithm to avoid both the 64-bit
multiplication and the following division, but I kept this as a minimal
change.
---
 drivers/spi/spi-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index 99db429db0b2..215fe66d27b4 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -390,7 +390,7 @@ static int k1_spi_set_speed(struct k1_spi_driver_data *drv_data,
 	 *   ticks_per_word = BITS_PER_BYTE * drv_data->bytes;
 	 * We do the divide last for better accuracy.
 	 */
-	nsec_per_word = NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
+	nsec_per_word = (u64)NSEC_PER_SEC * BITS_PER_BYTE * drv_data->bytes;
 	nsec_per_word = DIV_ROUND_UP_ULL(nsec_per_word, drv_data->rate);
 
 	/*
-- 
2.39.5

