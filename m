Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061B18E02A;
	Tue, 24 Mar 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348263; cv=none; b=cbybia+xHzaYd6HGly2WLIvV9mwwu+vPxiOxswQrQy2LbM3BxWYr7WOI0swvr7KI6tAzXmg+hAbMa5erCK10a1M4zHOJ94gM36IKk350PqDTAg0ABBoxujM8XrzntP7upBZ0j0O2+XChmXPNQoszO4PrTpfE7FfCLzQcEGeLpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348263; c=relaxed/simple;
	bh=O5oLilp5PYvGLIHjlXW3o/oo9dXA5vlBEiYCNSbf/i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ulvb8uEZFKs5nqxI9uBdHny4/1ttGiZnjuDBYpGDVuvCCErb+DWoY1BRnisso85v9xt+7J8IVk1Tsh1M3uXLY3vZi682VjW0hbFQglN0wUxfQ5eU1UYUrZMvZB61P2AbHX5eKE1ZpMpESaIyxiY2DKjzZx9V3tPm+fVLrwFCWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmiIw88N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmiIw88N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE756C19424;
	Tue, 24 Mar 2026 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348262;
	bh=O5oLilp5PYvGLIHjlXW3o/oo9dXA5vlBEiYCNSbf/i8=;
	h=From:To:Cc:Subject:Date:From;
	b=rmiIw88NVq03EST+qWMT8JG7lJ9qCfrb30OwRpxP7VyQHtjpIptEEe1ymboC+5QIE
	 wtL77SnPDsJs6tQhOmtnPgD7ZvlgMxHgom023F+08BFF6pvGlqy0ELoXFHnWYmccjy
	 oJtEs5q4PABIZiMadOhve50H8QhWCjxmBsSM9yUEOLyKZIy/mASXvVv5aIYe7I+bc8
	 4mldpYn0L+pZj24Eu4VWYzxJ4CsRx91l6z91xEvGQ1m2rk9VldVDVtFdJp5R+MkJcF
	 i9frbaNM4IB9v592LtpiF5r9GeQOVg4XZr/0UCYQzlND3646mUZPqjDiW3ynGMEfxw
	 Mbplv5dDwm/wA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4z2K-0000000478n-1Y5z;
	Tue, 24 Mar 2026 11:31:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Saravana Kannan <saravanak@kernel.org>
Subject: [PATCH] spi: fix resource leaks on device setup failure
Date: Tue, 24 Mar 2026 11:30:42 +0100
Message-ID: <20260324103042.980740-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to call controller cleanup() on late device setup failures to
avoid leaking resources allocated by setup().

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: stable@vger.kernel.org	# 5.13
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9fe9f99183bf..cb00619864cf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4091,7 +4091,7 @@ int spi_setup(struct spi_device *spi)
 	status = spi_set_cs_timing(spi);
 	if (status) {
 		mutex_unlock(&spi->controller->io_mutex);
-		return status;
+		goto err_cleanup;
 	}
 
 	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
@@ -4100,7 +4100,7 @@ int spi_setup(struct spi_device *spi)
 			mutex_unlock(&spi->controller->io_mutex);
 			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
 				status);
-			return status;
+			goto err_cleanup;
 		}
 
 		/*
@@ -4136,6 +4136,12 @@ int spi_setup(struct spi_device *spi)
 			status);
 
 	return status;
+
+err_cleanup:
+	if (spi->controller->cleanup)
+		spi->controller->cleanup(spi);
+
+	return status;
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
-- 
2.52.0

