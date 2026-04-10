Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AA3D903B;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836162; cv=none; b=RlkI99Sc/CQYApDvdXthQKu4nNE/RSrMUAU+ZC+OJmoupQlFXG/8TTZnWGAV7qOxtoKmBPzFBnVumfRZrAO65pKSZ5iOCMRg7E4BBz4zTHgCFwMAI682P+iI3g9YzTD077YXXv2fs9vuZJg2FkOrHigzvYqT8A3BhJ5222zCnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836162; c=relaxed/simple;
	bh=hhcWLZ7i+S1Fd0VS4l3oTnHgeKqBUhsVX+nrjCmWJ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYCfAhrXU/RE9VJuQbFkSzsRGQsYv+hdsTOu7BUcF1LAGFIGfyCeSJzwrlmL/7+zxvOiuRknDOuGcrpyhhrhlNaJKSqjtScx0UCp9EbL3O7SNsZak72Zjwyc7Db+lnzcjUtiNPnKEsBBFt5FluOX3LAhXAhajXGS1IB9TI7ul/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5zJEm3d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5zJEm3d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D39AC2BCAF;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836162;
	bh=hhcWLZ7i+S1Fd0VS4l3oTnHgeKqBUhsVX+nrjCmWJ1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5zJEm3dgEywQYrkdVLCow24rrXvAyvAOGOxOzUIiIn/pb9mv+6ZcSbSjZGkTepkU
	 dKEigPIB4S1yKSUY9fIbahRbkck9Dnt3Bg0pEp3zsNXdKg+/PaDpZK31kPhBrpPaSC
	 c292B/BFMB7KnDLmWDVOPCajRnUd+09D6GbC84o4pG6GZhnO+W4WEHbokzgfUMvxVg
	 yyXZJm8K2/9ZEBgHtweKJxCrYv0Q7n8JhTDXj6JFwOVXfHLI947uIRbwoGSVJmav4x
	 fM8j3PHEyk6TtblgVKRMIt3vm3pd7ZxNEA/lE2ky+LPSAgV8SfgSCX6iQTuUQwh2l9
	 D8vQ+NBCb9gZw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wBE6i-00000000Xd6-0BNX;
	Fri, 10 Apr 2026 17:49:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] spi: fix controller cleanup() documentation
Date: Fri, 10 Apr 2026 17:49:07 +0200
Message-ID: <20260410154907.129248-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410154907.129248-1-johan@kernel.org>
References: <20260410154907.129248-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller cleanup() callback is no longer called when releasing a
device, but rather when deregistering it (and on registration failures).

Fixes: c7299fea6769 ("spi: Fix spi device unregister flow")
Cc: Saravana Kannan <saravanak@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0dc671c07d3a..0de636484f3d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -700,7 +700,7 @@ struct spi_controller {
 	int			(*transfer)(struct spi_device *spi,
 						struct spi_message *mesg);
 
-	/* Called on release() to free memory provided by spi_controller */
+	/* Called on deregistration to free memory provided by spi_controller */
 	void			(*cleanup)(struct spi_device *spi);
 
 	/*
-- 
2.52.0

