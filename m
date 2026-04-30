Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAF2402429;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550599; cv=none; b=Z8w0+K3FJkB8hrYqw2r5bYQ3M4i/HvgLDlhKYQzENWz/k8OtE7G4ZNpgBo4SUrJ8pIxVCB3zg/C+4B/BFUnmR2OYTZDe/olc3kQMCvxqo86CRoly+vTEWB06tff4llWKya79QEmjzZGpqfgDzAY0jP5Grc6KnhxUsqbAVQpoheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550599; c=relaxed/simple;
	bh=NnJmvJx9L4ymruhVWTOL4pqSqymoTrSWMz2vyh7Uepg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwDgocFu+xumFmG6h5adqJjFTsV2Bovm8oQyvhde+5V71G3zXcCOsuXq4LJVxfBYTKAfGp2+jqArDt9DtSR1gpdC8lQU6x48XTSVOSg7gcWuKEaYQtfcuDtKWsXm0EsVPvmmNYfWwDGk3EYjmBMUCC9EkgsmfjCmg/UBLefZnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6oCAuL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6oCAuL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C7BC2BCB4;
	Thu, 30 Apr 2026 12:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777550599;
	bh=NnJmvJx9L4ymruhVWTOL4pqSqymoTrSWMz2vyh7Uepg=;
	h=From:To:Cc:Subject:Date:From;
	b=Q6oCAuL7JHUq6iH7YLBhdZIou7M81AlmeMBjY+knzvq8FLLH2b4sOR5vBkdH7KItt
	 GDSE3aem2zN2G0c+f/aKOu1VNLTQvR7YmMH7CdjO5wlxab0h4APmQCjHzFJrWYHXW6
	 Ad5fM/mD9fIbnuAf7i76IdbDHb8+rTA4XhC7yQH4XXZI/hwEg3YZwSyxBH1hR4a2zw
	 q1aaStgCby7l65+m4BJ8ilm8eVvf0QNBn/7/xvr8Al39dPDNn+1qaatRc/WHUgOLOb
	 0lgLr4nd6WkhMuvhAcZGsJuavAyREJ0+QXaUBz3FyBWMRVAbEiOA3liO6sRu1vGgwc
	 fCBampLZL1kyw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIQ6v-000000012st-0dc3;
	Thu, 30 Apr 2026 14:03:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] spi: omap2-mcspi: switch to managed controller allocation
Date: Thu, 30 Apr 2026 14:01:57 +0200
Message-ID: <20260430120200.249323-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series supersedes the omap2-mcspi patch in the managed controller
allocation series. [1]

Included are also two related cleanups.

Johan


[1] https://lore.kernel.org/lkml/20260429091333.165363-1-johan@kernel.org/


Changes in v2:
 - release DMA resources also if DMA setup fails
 - clean up error labels
 - clean up return value


Johan Hovold (3):
  spi: omap2-mcspi: switch to managed controller allocation
  spi: omap2-mcspi: clean up error labels
  spi: omap2-mcspi: clean up probe return value

 drivers/spi/spi-omap2-mcspi.c | 42 +++++++++++++++--------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

-- 
2.53.0

