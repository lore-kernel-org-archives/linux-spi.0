Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD440242B;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550599; cv=none; b=e2u47n69eZejbX7zcmUop2IQW9qCxLlszxVNZ7m/OkT6Fn2F45DEDvp7ssZ5U8Jss0TvqkirCKEkAaFFd8MOFFvmJ1vwSPRib6rQY0fzItODCPykmRVrz2R3yt4GAvOHdT02lgapdS6VG/NssQwivEUMUGy5MiHOMhaBwRPBxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550599; c=relaxed/simple;
	bh=fm+pzn+AlX7t+BsZwPVcVopQSTIjM9i1hIELQ4MxFN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsY8ldzm3sBwOcPSR8nmY/whh6ph5I4LL7xMhHd5PqV2T006G+0CKuwmHYOwDbP3TLH/RGGME81MQgYn7XtMAgCNnsNJJ3Sv3BC/3vWavy0G9QhEu5JGv0UCbipkdgkJFgX0vDfp0FTQqwKPEzijUrYlhejeGeCNloO422kLI7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeMrEKk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeMrEKk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BDEC2BCC7;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550599;
	bh=fm+pzn+AlX7t+BsZwPVcVopQSTIjM9i1hIELQ4MxFN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeMrEKk+YiGiopes+khnlgqzxu9nXvMwr7iXqmAqNFqJVU+NAdAbqukvL8VDWDCwx
	 UYE6nKbmYLQwbXw3HuioUYg16FC1O3/8cus+9ekNuwD2mMl/xtAeiLrTlSCm3e6sM0
	 3lV7mMCyByxznFdlw6L/ZVHdFb9frlakje111CsSvZS/y4HB7VDxHzx6sjug20boyK
	 m8HNSwDA6GWjxNFJV+SeD1N7PnN8MEVmcjl7NfAofe7xQYs/UmlKl3uJcwovtuALl6
	 7uAYRggPTPJw79MvTdjtAMDnGAnCQLO2uhnEwVNhCd9R/x0F3N9xzs1S7g23N0o6BF
	 RIa7uxiim7OZg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIQ6v-000000012sz-0ont;
	Thu, 30 Apr 2026 14:03:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] spi: omap2-mcspi: clean up probe return value
Date: Thu, 30 Apr 2026 14:02:00 +0200
Message-ID: <20260430120200.249323-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430120200.249323-1-johan@kernel.org>
References: <20260430120200.249323-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return explicit zero on successful probe to clearly separate the success
and error paths and make the code more readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 59ebdf7edbd2..d53f98aa0aac 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1594,7 +1594,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto err_disable_rpm;
 
-	return status;
+	return 0;
 
 err_disable_rpm:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.53.0

