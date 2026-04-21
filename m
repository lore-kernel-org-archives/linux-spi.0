Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19A3A4F58;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782380; cv=none; b=KqWYPW2jQESHebv2YWphnURvGVzSIQh6XdkZg+fwsn5qwP7y3lnHv1jwXJAnjMhARDRQiPDSFI+oJsMVqWHuZOTLqhCV2NI5v1mikmAc6Uejkjdn7QVsP9mUKv30ymz75hsSIKPBiyJDBTGRnUgm4hGyU1RV0iTZBW/G/Pj7xCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782380; c=relaxed/simple;
	bh=a/92PbNgAa9NhdPLCqXs6cqKx0gXdh1h2JC/Z7rvKqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh2tMxBLmapm8Wxm7MaZI8EnF3SkGV2D1pkPYqAPZppUAHYQCoSWlpQuFMCy4jEGcPGrrwFZBI0C95GQygYII7SCfIA0AnOkqtFCF249+bwdQV5hNgOS3stBq33Lg+b7a4mHA7LQIbnzl1nvQhszxVBLfySDzkHrNk/JJVdFyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WizirZwB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WizirZwB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CB9C2BCB0;
	Tue, 21 Apr 2026 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782380;
	bh=a/92PbNgAa9NhdPLCqXs6cqKx0gXdh1h2JC/Z7rvKqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WizirZwBADjxFphe0smYTkYpEssxvI5LGE4nqZbMeQZJeo+kXvJF+KDu8IylvhJxa
	 H9HRQVuW74FqgKacobLzw7dRxh6VSFkGLYy7BZVrgVDTCP1S8rdAjEPO2uVF1oCpJL
	 fCbs39GnnTMDDT+hzLMe2bDpr2anqTL0/0CI7oIaeoj/NCCqMG9BjncM/nl431O1Ay
	 TynjmKFiB/u5QYAucUwrkwdb1ptr8k0yo2t/cD9zkqsz8DFUGRCJjYnxmIc8/W7Bgz
	 Gth6khUdHk87OSTdY+n30ZRi+dxZIawAHxNRb9zEpkwekl3N4Yt5falm5pZ8hmWf6T
	 q5e36W9k5PQYQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFCGI-00000006VhI-1DFi;
	Tue, 21 Apr 2026 16:39:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Harshit Shah <hshah@axiado.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] spi: axiado: rename probe error labels
Date: Tue, 21 Apr 2026 16:39:24 +0200
Message-ID: <20260421143925.1551781-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421143925.1551781-1-johan@kernel.org>
References: <20260421143925.1551781-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the probe error labels after what they do.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-axiado.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-axiado.c b/drivers/spi/spi-axiado.c
index 6449b376a3a8..a347774ae824 100644
--- a/drivers/spi/spi-axiado.c
+++ b/drivers/spi/spi-axiado.c
@@ -785,7 +785,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(xspi->ref_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable device clock.\n");
-		goto clk_dis_apb;
+		goto err_disable_apb;
 	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -815,7 +815,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		ret = -ENXIO;
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, ax_spi_irq,
@@ -823,7 +823,7 @@ static int ax_spi_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	ctlr->use_gpio_descriptors = true;
@@ -847,21 +847,21 @@ static int ax_spi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto clk_dis_all;
+		goto err_disable_rpm;
 	}
 
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return ret;
 
-clk_dis_all:
+err_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 
 	clk_disable_unprepare(xspi->ref_clk);
-clk_dis_apb:
+err_disable_apb:
 	clk_disable_unprepare(xspi->pclk);
 
 	return ret;
-- 
2.52.0

