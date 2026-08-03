Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2B41A93A;
	Mon,  3 Aug 2026 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767228; cv=none; b=ZcrqWjbYZTUZkQtGy5CB0GssCpwMRsLyYGnUtrSQWuSZfWOgwIWyw+imVsYfBkqKPayxI8+pjhry3lyJwW8CqwlBrQDiHDHgsdQ/aS86zX5yWH9fqrT8HlpHor1t7NxrYn5nOFCEnObHPdvh70QbxGslUubaY8rTp8jrqjdnq4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767228; c=relaxed/simple;
	bh=YtUjK2t6V1+fOLlxYatYTj2nwVl8W5O/qyi5DneuEto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTV6okz01w6mq0B+chq6+gCTkC/08UL+o73njFFQ07KjJlX6zNXM+XjOMLQm5Dv3AcVuH2kugyVYm4JavlDLSAQQIFPwGpZ3UKcddkv7hoZX0JO7kzXsgG7p7zZlyvD/0PW1tVYP7djnHtoMUnF9NO8UFK3Czhl8SopyZCTLJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myQ8NEcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myQ8NEcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B51A1F00A3D;
	Mon,  3 Aug 2026 14:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767227;
	bh=lA2uaonlGGEnsffT43uMEYcrS5+hPlWlCaa1MynRySg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=myQ8NEcrYInS1nRLoIZ+zjbog11Og1HYlztU4l71COV9PIA7falKI5+5Z8cmP7gQP
	 aYXoaTiVrAmlT406kfioPCAwl6XyJzwYSD7Cou3n+cnHD9s21F7KviyuN5lk1HI2JI
	 yRBd2BTUwEKR1Vin74LJtIAYBO7QSjpjYqDPHn2b5U42ozmHmgiqf3+u7q4rtNyZ7s
	 N73jUe24d/1T47iDt0uZTMlaFi2X1Z0V6KDOJ2eQU9QlFDwkMUn9zMDIo9onV2IbS0
	 tycIaSkFudX57e6Pkx/jBtY2OC56CiAddrHIdHqVGcCLAHsAuzU/govFhJLXh9w+xO
	 gojaVuQQ3QC2Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] spi: cadence-xspi: remove 64BIT Kconfig dependency
Date: Mon,  3 Aug 2026 22:07:28 +0800
Message-ID: <20260803140728.12747-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140728.12747-1-jszhang@kernel.org>
References: <20260803140728.12747-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now everything is ready, we can remove 64BIT Kconfig dependency now.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8782514bb89b..601bfa321adb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -321,7 +321,7 @@ config SPI_CADENCE_QUADSPI
 
 config SPI_CADENCE_XSPI
 	tristate "Cadence XSPI controller"
-	depends on OF && HAS_IOMEM && 64BIT
+	depends on OF && HAS_IOMEM
 	depends on SPI_MEM
 	help
 	  Enable support for the Cadence XSPI Flash controller.
-- 
2.53.0

