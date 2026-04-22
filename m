Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B23346791;
	Wed, 22 Apr 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871017; cv=none; b=rSGzOrcRYZx2j5hjYAIg9rfGmI08lv1VkL84+F0wHUzhc/6pIu5t8QihIKi525H74VeV9fFFdRgMgG2dC+jw4RymNPz88JQRI+z+hJBL2/8V+tTIoOHKdgAgKBEhYl3pERL7zNEPDnivURXGjpEYW4YriCD0pZ7rUSbfUZ2xbBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871017; c=relaxed/simple;
	bh=7O7XwKYDSIZRgMFfhLYwFoKq7qcfU4DTABqxZTA2LvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3eWzJp96JP7ZJdn+5U0EovT36PzA9CvXGqTMTNm1WD75N8QIjfNm2GVdcbYS5LcgV9+YhZfAPRcuZoGJaJzgzUIVNR4MQEHgJi8Ks8In2L+2uGqEo0OimMO8vWuqlxgNYRvLFIxaHrA2u6ohfnuFapidiUSkpuPtjOZpeW9Xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjPOdUdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjPOdUdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8416BC2BCB2;
	Wed, 22 Apr 2026 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871017;
	bh=7O7XwKYDSIZRgMFfhLYwFoKq7qcfU4DTABqxZTA2LvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjPOdUdwvCnIwij52v9gpXXY/g1jbWUp/bFS3g/eWT6+BqKG69ot8AIHul472r3g1
	 uXnaot9MGfx+6jFELAUjW/ijgQ8LwLOQEdIHlrLzGQH8nlf8QIVPOy3iJ0+Xgq8abT
	 Aiik7a6VTbVSdKFKEqhxTwGfb0I/Sn9M5OHZm5KqloiviFr65LVQGH+3AdQAdqoVFR
	 RqXtQ0isKey0IJkTMTbv5fETenkr7bc9zKT9m1StPfYbc6ptRXFokF6xCWlt7JchOs
	 H5LJ/6o2xSVpx2PclQtvXuA+FHwfYHNqzb/VbVzARSnBNWb+qj+EdMYK8R+yMconQP
	 046Oig843ImLA==
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
Subject: [PATCH v1 4/5] spi: microchip-core-qspi: remove an unused define
Date: Wed, 22 Apr 2026 16:15:45 +0100
Message-ID: <20260422-resilient-pantry-833f1d383a15@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422-foe-strength-a5d8ad650ef4@spud>
References: <20260422-foe-strength-a5d8ad650ef4@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ZQeTCH4jxeGgUWZk1PzFturjJZpquzfnJzGD8RIaUkw=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvnjkE/Drd+E5p8tU/l58nRk/mZ1x5Trd98hnlm37vd /ZVfuJd1FHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJ6H9j+O/G7/Z+v89n/sem ovXNvgGZqY3HbDknxDZrX3lrInrGtZOR4fIHU/Nnz07/0vhrn/PI/fssiZzOs0E6z7c+nsBlUzj lPTsA
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
index 629f785bd230b..ae1c7ce09b2ed 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -99,7 +99,6 @@
 #define REG_IEN			(0x0c)
 #define REG_STATUS		(0x10)
 #define REG_DIRECT_ACCESS	(0x14)
-#define REG_UPPER_ACCESS	(0x18)
 #define REG_RX_DATA		(0x40)
 #define REG_TX_DATA		(0x44)
 #define REG_X4_RX_DATA		(0x48)
-- 
2.53.0

