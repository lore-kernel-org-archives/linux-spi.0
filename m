Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2A3BFE5B;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736326; cv=none; b=a7BxdSWWSCcliZ0xQZ9nKshrfJ6bZNWQvdiM0wOlzGZYJDuHvQ0yq/bx2N4odCRecbSnEnTa5w6PZlUPtzXUKAMjBw18BDJ9Y5uDdFAcMOcOKufYoAzo5imlN90+CB4JWUP4qyg4WEJ+EQYwsw138OiJb9hZ3xh/sbu0nNOC3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736326; c=relaxed/simple;
	bh=m013MwNmUgWVC7z7zyIG+6nePlWTBqWNW5DTkKX3MXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwVNjH0R1V868fxKOjF0tgE5Rxli11KAjgtN9+HeNMMPkIQ17N1U56Bayni24n5JuQu/TRLuPmecwBbiPkdX5EiE3g0sMFKF/mQJK8fHu2dx/EJbSmAvPJzrtG8DK0ATUJHZNKPBbpVndmfQvlllCJW4LfOSRa5awsSd0SzMtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrgRt9C2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrgRt9C2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665E0C2BCC7;
	Thu,  9 Apr 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736326;
	bh=m013MwNmUgWVC7z7zyIG+6nePlWTBqWNW5DTkKX3MXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrgRt9C25icP/TDVNoEqJ9F006zS/lQG9lQPW1RfSQNz/PDVUyzSNVH/FuUjytE8z
	 MwGASqsIEJxz+Ak2oQ1lh4KfUMU33FscIIZppjRsGGB3sfOugJI9k8wS/080vZtJ3b
	 EwsTGOcvC+drmh3f8TsmM0ctgKPXVutEOsoAMNmjPArtQBTyuSNGfJCUEbH9lcuduR
	 yLXK6X6hGaIz2Fw/EqJQ3ppT4IGQByNzIj/XoSafOifKqjhmCix36XWzbx6zBNmRgP
	 fv2vctDGbkmXGCI187NLe0VnJ5GV3LtLbkQMHLFCcY8kWUkc8JIz0nEu88Rjl7gFTW
	 7i1zjfgUazBJQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wAo8S-00000001d77-0McG;
	Thu, 09 Apr 2026 14:05:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 14/20] spi: fsl: fix controller deregistration
Date: Thu,  9 Apr 2026 14:04:13 +0200
Message-ID: <20260409120419.388546-15-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409120419.388546-1-johan@kernel.org>
References: <20260409120419.388546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to deregister the controller before releasing underlying
resources like DMA during driver unbind.

Fixes: 4178b6b1b595 ("spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup")
Cc: stable@vger.kernel.org	# 4.3
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bf3fc3ce0cc2..2681ed8daf2b 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_probe;
 
@@ -751,7 +751,13 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
-- 
2.52.0

