Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253F3254A5;
	Thu,  9 Apr 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736503; cv=none; b=TgCdbbfhcFkYc69QX6UO2/sZExHQsL25lRC9x+wcJygPvLlhvivXO8CdQef5cHKqqCx7kuWVwlysALiDVUOoUokIjgZkyjSoh1hQoqW7oVqClPK319ViluSdATnOC2uW0mN+WQM4O9ZLT/KXrtZFJJAdEDLUfdTWYIRlaIXUZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736503; c=relaxed/simple;
	bh=+HFbq/McqKsBlEzOXrGqru6axxh8Ao4WdsBJ0a6HujI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BBun9uXK2A/zI0NAsDnrR3x2h8UMXSA16eY17vLe+pn5tqu09i2o1e6vj1c0WKRIcjR+ZLxSVRof0h9FTN/Iejn72YKx333PKCYzmhENVYlEUmhXftG+urJhxAHTqY3bn3S7uJPVpn/h3BCGvTqgyUagIsu8CowCKTycOigqG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcfQRfVF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcfQRfVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8E6C4CEF7;
	Thu,  9 Apr 2026 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736503;
	bh=+HFbq/McqKsBlEzOXrGqru6axxh8Ao4WdsBJ0a6HujI=;
	h=From:To:Cc:Subject:Date:From;
	b=gcfQRfVF0SE8cFHLjbyOU4MhJHMVxiq3wi0gsApJQ1w59DG8Jkp16goMIDTZZqANQ
	 y/GgxVwEMHb55J89UYNqBHNsZA7GJ+l+Ucz6qjD+2bFcrULyRaB7KXlqcnBWvAK4M/
	 k/1WNELbIeH1kML7fX8J9Az5Zzu/5OyL26u96WrQ/BMYSf+/BWVFJEWOQE5AToFoPQ
	 qVDcDtpPlVCok20S5aUfgRsMIU/W5YlJIakPJVs7yQ3cT5WSkTe9XgrEjyh0EQTr6a
	 rE38JbLba4N1jrro/vWrAYG5pyx6tvdfiuBIAM7vPcPQn7GkEYWj0HwEwevewQwdXq
	 JCAqPiRoh2Dcw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAoBI-00000001dB1-3mEs;
	Thu, 09 Apr 2026 14:08:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] spi: npcm-fiu: drop unused remove callback
Date: Thu,  9 Apr 2026 14:08:10 +0200
Message-ID: <20260409120810.388909-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the remove callback which is unused since commit 82c4fadb0b95
("spi: npcm-fiu: Use helper function devm_clk_get_enabled()").

The above mentioned commit also removed the last user of the platform
driver data which no longer needs to be set (twice).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-npcm-fiu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 3961b0ccdb4b..6617751009c3 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -715,7 +715,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 
 	fiu->info = &fiu_data_match->npcm_fiu_data_info[id];
 
-	platform_set_drvdata(pdev, fiu);
 	fiu->dev = dev;
 
 	regbase = devm_platform_ioremap_resource_byname(pdev, "control");
@@ -738,8 +737,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	fiu->spix_mode = of_property_read_bool(dev->of_node,
 					       "nuvoton,spix-mode");
 
-	platform_set_drvdata(pdev, fiu);
-
 	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD
 		| SPI_TX_DUAL | SPI_TX_QUAD;
 	ctrl->setup = npcm_fiu_setup;
@@ -750,10 +747,6 @@ static int npcm_fiu_probe(struct platform_device *pdev)
 	return devm_spi_register_controller(dev, ctrl);
 }
 
-static void npcm_fiu_remove(struct platform_device *pdev)
-{
-}
-
 MODULE_DEVICE_TABLE(of, npcm_fiu_dt_ids);
 
 static struct platform_driver npcm_fiu_driver = {
@@ -763,7 +756,6 @@ static struct platform_driver npcm_fiu_driver = {
 		.of_match_table = npcm_fiu_dt_ids,
 	},
 	.probe = npcm_fiu_probe,
-	.remove = npcm_fiu_remove,
 };
 module_platform_driver(npcm_fiu_driver);
 
-- 
2.52.0

