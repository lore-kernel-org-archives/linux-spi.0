Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DA62882CD
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547400; cv=none; b=sGUC/Jjvba/VVuCzMoMWgwAUqWWvhQoUa6qrsthYpbrg/h20I+8lAzCphuyrXR7bQkbKj120aNiGVRhgJTZmcer4HJez8UU7OP3nTkp1kEVAsB1bckgmdprj04lT3kn4xVFXJ8kb2+JysekLgCIybrBCCoeMhy1KVUnEiF79mQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547400; c=relaxed/simple;
	bh=2wESmqd+6q8CL3nR4qvEykSLV5ydLA8VHi9Af7tV9DU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M3Xcidcv5ULEfZFGtMtRWBMju7sdvTRH+iPQrF0Mruq5/WYtwnWV3U33oIFDKYTFlXT3yHjICAkZ1cfZ0f6VsS3v3vT9omTKdD2t9R74+ibmMLcDWsXs1qnKnXoDIDSvmT72Cbilr4UfCpdf7rZJ1PNjXuxhZsdvfr3jwAShg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOI2qKyF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOI2qKyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC014C116C6;
	Tue, 27 Jan 2026 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547399;
	bh=2wESmqd+6q8CL3nR4qvEykSLV5ydLA8VHi9Af7tV9DU=;
	h=Subject:From:Date:To:From;
	b=SOI2qKyF1ViOzkZbYWCy9uUrswTJpYRi+W3KdjbfLSywgp2r/27gWNE+vQp2QEykB
	 vGso7tI0Vk7Z3Pwv0MSN58iV/1olv3IckWaQxyL0mB+b/TQUCMALb3enj4jOWB4xJj
	 SCT2+WlC+5Q03sn6qJjKY7/xPAJjiuymCF9r01SDA9OQzVFKwFI0fhCkgPAVIhCKSX
	 THkJ1kpg1e+zII4m5j4t6F5kfRuWflX444zfSnLA1iH9ns4mLTr+ZBIVcGY84lbUYE
	 OP4/wHgMou0181G/eqrp7RZMHN+7YSMoXS4kolVR/NvwGLfO4tYV9Vv9Dh0aOmnye3
	 cs841zPo8oBmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB9CE380AA58;
	Tue, 27 Jan 2026 20:56:34 +0000 (UTC)
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
 <176954739327.1398975.8360022559348177396.git-patchwork-housekeeping@kernel.org>
Date: Tue, 27 Jan 2026 20:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add DMA support for RZ/T2H RSPI (2026-01-27T20:17:03)
  Superseding: [v1] Add DMA support for RZ/T2H RSPI (2025-12-01T13:42:16):
    [01/13] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
    [02/13] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
    [03/13] spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
    [04/13] spi: rzv2h-rspi: use device-managed APIs
    [05/13] spi: rzv2h-rspi: store RX interrupt in state
    [06/13] spi: rzv2h-rspi: set MUST_RX/MUST_TX
    [07/13] spi: rzv2h-rspi: set TX FIFO threshold to 0
    [08/13] spi: rzv2h-rspi: enable TX buffer empty interrupt
    [09/13] spi: rzv2h-rspi: split out PIO transfer
    [10/13] dt-bindings: spi: renesas,rzv2h-rspi: document optional support for DMA
    [11/13] spi: rzv2h-rspi: add support for DMA mode
    [12/13] arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
    [13/13] arm64: dts: renesas: r9a09g087: wire up DMA support for SPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

