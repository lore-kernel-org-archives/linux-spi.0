Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12746AEDF;
	Tue, 28 Apr 2026 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399891; cv=none; b=Q2IUvNQUHLyP8A6MOFcaBx5oGxDaktDIvcgmkUpN09Pt4GJ+v0mj+DIt9a5jfOnoE4z3lkvRQfylxl+IoPzqKBGUK/juW5fdkhMriqhQFznMsd3qp1PoQXoe+g9NluPrGXpJ2dlFLIWy++eFn0AojdQPjT52VNN99rxL8OiolLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399891; c=relaxed/simple;
	bh=/uECH2zjlibLlsJAdmhC/CXvxN/bm+bCDRaoAlCIo+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRuYjHSiKzlTl/+hGnJIfRRPc+FKEDXQJgtyXdWVSny/Sc1aF6by8G9kFjqt6h76Xx/zQyR2sjzu0N2Zq3mJcgi8myibB/ihPtEH5vm3el+c8AjMUoYC7OCQMkAzjPAE7xQpxibn0pjGgK8p6AvsZ2WytKxgfOLelwmKbaJ+hfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LybcyWZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LybcyWZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC8AC2BCAF;
	Tue, 28 Apr 2026 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399890;
	bh=/uECH2zjlibLlsJAdmhC/CXvxN/bm+bCDRaoAlCIo+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LybcyWZHUJacpuoAWHtQb3Rq73SbC5ypZRjIvaUhUsoO1h1sByVWHfBWIqOF64Zx1
	 GmPLZLenmk66aDGEbAC/e+0X0l+sXg/a4XvdB7JJtljCMTWaZfQRQ6eZGJp4qPZ/Ji
	 7iBejm8HyS8ZjiTpZ6p5m0k5sE7oBFFL7EPWikC5RPpBMij3RzFiSAjKwYp4vvkCft
	 UXZBJoPm9omqrXjx2/PKqTuMIOi64VzBFb+UGGvxkhqkorI8gwqjVwSL/acIhoWTrC
	 p4KngxN7UJzKNcwHrgILei+4mfw07lfsuCY0rc17nIfW7rBLLEgCbFSUZVfX+NIHhn
	 XcL0mGJgSqpTQ==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] spi: microchip-core-qspi: remove an unused define
Date: Tue, 28 Apr 2026 19:11:12 +0100
Message-ID: <20260428-viability-crepe-4e4c85e7c506@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428-surfboard-unhearing-96776be0495d@spud>
References: <20260428-surfboard-unhearing-96776be0495d@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=VNXeihsw7ojkS6VjtBbTddZL37lqa6SOjRRE8S3DHDM=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkffthLqt5rUbAS6dgx/8nF/pQqJ07fLcHxCyXEFsziu pJ0uOp3RykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaSs5Hhn3pi7teivw5pP/xz uI5Wsv6zmfOJQdhk0qdTu+wreF/vP8rwT3WSXoOijtiCM8kfzGRXd9a9Lnt7OyfC1eBt0AVbnZt VvAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

I noticed this define was incorrect, it should be UpperAddress, but in
renaming it it became clear there were actually no users. Just get rid
of it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index c8b053c7c857b..477a1bb390bb9 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -92,7 +92,6 @@
 #define REG_IEN			(0x0c)
 #define REG_STATUS		(0x10)
 #define REG_DIRECT_ACCESS	(0x14)
-#define REG_UPPER_ACCESS	(0x18)
 #define REG_RX_DATA		(0x40)
 #define REG_TX_DATA		(0x44)
 #define REG_X4_RX_DATA		(0x48)
-- 
2.53.0

