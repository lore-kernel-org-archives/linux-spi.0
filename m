Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E7812FB27
	for <linux-spi@vger.kernel.org>; Fri, 29 Mar 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734031; cv=none; b=FbcWVHf9gWzISEltlTpbaAEBHeySAZTrBw7F8aOESQ6Ix6Ul2NnzHVoZmhdfPR/sM1w0IKehwa9uUImLjfPScfGCgxNPq5cUin1w3VBkDBkbwMXr6bu6rmZdZ9N82G+orbdm39h/NDeFcTUEfJq5cScmErglqWXjAnp3LUG547A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734031; c=relaxed/simple;
	bh=8iG2aM7sOQOLsyrX+OIuXDVP5qY/1Y5smHxB2myQKf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IMCE6fDJDkjHPLF18oyq2x4ctQqSm+dp9HciDFQ1G1SRQ3ksQYkf3Lh9JH87BAn/MkedQyV6rMIfrchhh1UrXTIS8R4Y3YcqXJSGqrvHdGbJNS+PROv7W6cq+FkDxL1e26i9G/5GwqbNCkLMSWfMx/LL/FMaJ9zWdDi/kaInovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYuGs/jM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYuGs/jM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AEF4C433F1;
	Fri, 29 Mar 2024 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711734030;
	bh=8iG2aM7sOQOLsyrX+OIuXDVP5qY/1Y5smHxB2myQKf8=;
	h=Subject:From:Date:To:From;
	b=gYuGs/jMbmCVQbrEPJsNZcVzouGJvYh5CY6r61QRxUA1V8IkI+MvAwJyzlDKLw2cN
	 657DIzmq0S3NlXISjLlI8sp+EkU4g+MyOpZygnWsu3QtNT1IrGlkQs6VRGNfHllagT
	 8kGi7yFV8MYLBF2cShdPIzNuowmRzg5xcZLzTKE+iF1BoQvZv7qo7WHtHKpA1TkEX1
	 4dav3p2I0L07zMfuPY1kYLBjx6zC2H1WSJjOwgG73hXcLzJ+OYF5AK4L0IwNQx/Ir8
	 kamrB0ow7QITxsTegC4DkoNaZZFe7sQAarLZTPm/UiI6TFhW24Xk+ylt/S40A7H2od
	 5p3IJPea0NeDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F76BD2D0EE;
	Fri, 29 Mar 2024 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171173403007.18666.15940082795793701346.git-patchwork-summary@kernel.org>
Date: Fri, 29 Mar 2024 17:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spi.h: add missing kernel-doc for @last_cs_index_mask
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839570
  Lore link: https://lore.kernel.org/r/20240328223340.17159-1-rdunlap@infradead.org

Patch: spi: s3c64xx: Use DMA mode from fifo size
  Submitter: Jaewon Kim <jaewon02.kim@samsung.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839709
  Lore link: https://lore.kernel.org/r/20240329085840.65856-1-jaewon02.kim@samsung.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


