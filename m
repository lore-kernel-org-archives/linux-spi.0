Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C893A7839;
	Wed,  8 Apr 2026 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637853; cv=none; b=n6OPfn5hn4c1+g9elIxjFWiUjRcFG1A/K3HbsBVRARKK+TJdM0FhZBQAp+4G5lZIWJSK1tOqfcgK8hF9ErGnw3qiwUl8NSXwJqioeqsxO8Jsgvg5Y0yVzM2Ozhz8BtaV4hDwyVtCmGASsC2cOne5BO0ku4jl9L5NGqj1Nv5c48o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637853; c=relaxed/simple;
	bh=8NwaRKsWl0A/I7Se6VZgyeuGU4EgBMu8Aas5GvfzhDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTD4T1et+DzLMqK0jg27B3cYEKklfDHP54wgKVeBD52AtZNoh+crCUzJgrq3rJNxHIDeALxLD01x79FkZOKEykKHafAHqI88kPqHP7xR7n1mz3o5MyuM6/Ya/8muSljGMOQaN9EfolYqf/tpzYvvB/PY/pZloMd4MOlZR19xx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNlGCCDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNlGCCDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8923C19424;
	Wed,  8 Apr 2026 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775637852;
	bh=8NwaRKsWl0A/I7Se6VZgyeuGU4EgBMu8Aas5GvfzhDk=;
	h=From:To:Cc:Subject:Date:From;
	b=VNlGCCDyfnGVtwWVUDshbA+iCIl9Y45drcZWgrWDhSvD9uk0zB3asYrCDPw0z7UaW
	 cw3cQpflJn2bMigD6HUtVrMuJRfqjf6Byf9LQ0fxPCT9bSp/K1kwdELXAOK1LigCOm
	 Vo3dOiO4Q1lef4QCKnCIiexnncqO02iX/+RwD0kUyWIDUDEsraViI2sRVKoaabgQze
	 eEkcmYblL0mw55wH5bbVYXFb8ioeVm+taI8NvCdUvuyxM0C5HUPFndLYKMCBPVIs+c
	 fw0VEUx4oU1W5qb0DdOkGoKyqbZDxlz5B3CHe2MPjgl5CAoYyW+fnkOeAbt1EjkC1T
	 kajCiYdjZEPhQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAOWA-00000000Rwj-2fBi;
	Wed, 08 Apr 2026 10:44:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: pl022: enable compile testing
Date: Wed,  8 Apr 2026 10:44:07 +0200
Message-ID: <20260408084407.107416-1-johan@kernel.org>
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
index c3b2f02f5912..ddd53cb48567 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -866,7 +866,7 @@ config SPI_PIC32_SQI
 
 config SPI_PL022
 	tristate "ARM AMBA PL022 SSP controller"
-	depends on ARM_AMBA
+	depends on ARM_AMBA || COMPILE_TEST
 	default y if ARCH_REALVIEW
 	default y if INTEGRATOR_IMPD1
 	default y if ARCH_VERSATILE
-- 
2.52.0

