Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945A933B6E3;
	Thu,  9 Apr 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746605; cv=none; b=HLWdmAQrkL23VIyINjhZLLuPjZPhMsNZKFRfVQRkUUQy9Pha7o+UZHyqzJaEnctAtCUmGMYHThBL8ehj9WjoNSoEiRziFL7agdjZLL7JzbhXOyAO+OPs7/5hFint3CY3GfYjXIC/pQGoaEfbWxrP94PM0blZ5GdE73N5BrqM2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746605; c=relaxed/simple;
	bh=HIwZqnfpJMZ4NaOPFRxIJn0HfdFu+HsW4kt2nF1Vblg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SET/R5MNymlCVqX6nGHePdF8HlOqSy8BnByNXzOr4vLXIrLKwAxtQQT+RGv0vP1KOCGTCMp2dGD9H7XKlJYCXwAw/+0KkaDfQkSH4djE59lzTQPREm0GUQcoHaBlhjrhsZ71QOOcncajuGtRk06LMyq89OkCXVKMGIHjzSaSt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpmxH+fp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpmxH+fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40162C116C6;
	Thu,  9 Apr 2026 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775746605;
	bh=HIwZqnfpJMZ4NaOPFRxIJn0HfdFu+HsW4kt2nF1Vblg=;
	h=From:To:Cc:Subject:Date:From;
	b=VpmxH+fpMsMW4TCvcHKp70z6VkIx75STo2eMI7cLeAaZROWkpO0xSlPxmwFLdni5f
	 l2LuS+KVucZer+rZd9u0EZuzAXdwbSE8hl8TungVYnCIJqOna2afWNaIxy2+RTN76J
	 Z/N68yjJUfov0HY6LmSi0Bf05Oxz/5HRZl7G53ww/NZPCdl+L01HMJL0C4Wf/mXLPh
	 TbQmwDptj1ul8xSl46SMRW8slm9yLdKxH9p2lU9uFPmu69n5HM/tXJs/izTOxdhrsR
	 vpqI2DEKDmtyiHo3Z4cyGfK9ZDz+wvHiiRoNWoe+GhC5cDoefwezsjJzH6Y6IUzj6z
	 UcmdCxlbaPsHQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAqoF-00000001xPw-0MZn;
	Thu, 09 Apr 2026 16:56:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: atcspi200: enable compile testing
Date: Thu,  9 Apr 2026 16:56:18 +0200
Message-ID: <20260409145618.466701-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There seems to be nothing preventing this driver from being compile
tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddd53cb48567..b563f49e2197 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -138,7 +138,7 @@ config SPI_AR934X
 
 config SPI_ATCSPI200
 	tristate "Andes ATCSPI200 SPI controller"
-	depends on ARCH_ANDES
+	depends on ARCH_ANDES || COMPILE_TEST
 	help
 	  SPI driver for Andes ATCSPI200 SPI controller.
 	  ATCSPI200 controller supports DMA and PIO modes. When DMA
-- 
2.52.0

