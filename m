Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0F8362121;
	Tue, 27 Jan 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540916; cv=none; b=nyWJV8GrrvNt9Ih0yenZki0Sl1nhXIvM3MiXBGdylyCiukkPTBKagTsa5gVHDE65ndfWA9Pt7CLRoO6n6YhtUhnrdt4qzf4syQFk05hDHZpM35iaTQ+HmT3rWzjNjJO7YJgBgH2IgQcY2rHCWWxBuiQYsJfIt9OVt7qS6le3Qq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540916; c=relaxed/simple;
	bh=rB6d4VM4FEa+fd4lXatxgpQ5R3mq7lKLZ9i/SyBeI9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpYnAnBksjyAxaHzfdCpIMOxeCacUQBubwjULwOT35GmcPzn6rulcyYmVIqHhypNpVKRxASbY82ZS7GSFPZ4sBUrurBN/IcGL8LjT2Cd/T8fS+XkWWuyETrlnAS/0jA3eqJg2hxuwx/8FIgEfmGez6jrKt6izDly0hYpVxvm+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FD1C116C6;
	Tue, 27 Jan 2026 19:08:34 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: SPI_AXIADO should depend on ARCH_AXIADO
Date: Tue, 27 Jan 2026 20:08:31 +0100
Message-ID: <386273d50fb3c51cccdba4b3101a0705208abd4d.1769540444.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Axiado DB-H SPI controller is only present on Axiado AX3000 SoCs.
Hence add a dependency on ARCH_AXIADO, to prevent asking the user about
this driver when configuring a kernel without Axiado SoC Family support.

Fixes: e75a6b00ad7962a7 ("spi: axiado: Add driver for Axiado SPI DB controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9e089df33a87868f..8995ea8d2c6b6c8c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -216,6 +216,7 @@ config SPI_AXI_SPI_ENGINE
 config SPI_AXIADO
 	tristate "Axiado DB-H SPI controller"
 	depends on SPI_MEM
+	depends on ARCH_AXIADO || COMPILE_TEST
 	help
 	  Enable support for the SPI controller present on Axiado AX3000 SoCs.
 
-- 
2.43.0

