Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725E5221D5
	for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686797; cv=none; b=dcLMTcMpscAOc1N17oNEuEKGNOZVA4Py3vR1XiXp9+uk3t0z0lx5t/gAHeeP7lKdjfaTZl1IfFJTF17zloy5hiFHXh9DfepEQHf6pmcxm1Shov74fegRUUppq6ofuQYy2pPKEVKk3RS+UBtJv8IwfiI+Uy4oVNa/haC6g1juUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686797; c=relaxed/simple;
	bh=cVyllB4YCCPQueXXKXQNqgocUkvzx8aJNS0hMLzChOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=q7R/fCFg7eqhOYV2Urds1582dIdg85mUNzbIB4Bjc4QE6tfQihGt9vBPOY7SUCRI+gZeh0JlW5vRExo7T+gDq5kMOCNOZWeaBRfKo4cb0QUt7o5I47T1b8ncivA7TZpVKdimY609Dz5xinbaRwadgFx8gtDR5QcRgi21my7LR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMIjmxEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMIjmxEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4B21F000FF;
	Tue, 29 Sep 2026 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790686796;
	bh=wpAkTe8glwC/yaEBTb0sEA/7TtKxJEWcVNIEmom8jlY=;
	h=Subject:From:Date:To;
	b=AMIjmxEmm/w6McQe90vMR8II5Zq3SvdQt5kMp1nCos5hglaXxmeOKgqLNYhHXXHOT
	 rZk4eFDjocLKh2w+fH1T8wLhR/r7fVCWuTWr8glstZtAnavSO66VNt7jbg6dQSeu1r
	 BKt98mAJHzIv6EX1fgl7FKDMwvMRmdZWvjtRV0jxL9hyWfgsKn1JKMWAOYGwQoTxFh
	 l/4pMK4ucEPOQYJEP0HooXB/aiQfa5CQH0x6vpGhzDB9JVmiMGIdOOkL2Zt+77s3dY
	 8MDr9el+W71f/EV0HTNT/z6UJurBEPxiUjtVcB0nZ1uY/4SyOCA6kzYokPrbnXgZXC
	 hmV3wd1P+ibGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79EB139263BE;
	Tue, 29 Sep 2026 12:59:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179068679500.477415.7295308366200596622.git-patchwork-housekeeping@kernel.org>
Date: Tue, 29 Sep 2026 12:59:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: dw: use threaded interrupt (2026-09-29T12:18:12)
  Superseding: [v3] spi: dw: use threaded interrupt (2026-09-09T14:36:47):
    [v3,1/5] spi: dw: use DW_SPI_ISR directly
    [v3,2/5] spi: dw: remove useless dws->transfer_handler check
    [v3,3/5] spi: dw: remove duplicated "!rx_len && !tx_len" handling from dw_spi_irq
    [v3,4/5] spi: dw: restore previous irq handling behavior when !ctlr->cur_msg
    [v3,5/5] spi: dw: use threaded interrupt and optimize the threaded ISR

Checked 183 series in 12.52 seconds.
This project currently has 16653 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

