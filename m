Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014C3655C0
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989878; cv=none; b=IOBYMPUZtFvYOIN2KBJzEmZKAXBFU70eszGImPKGvwJQg1CTaE8zBlrIPsLlIiOcgB9U3r8AV7Yb5bJiugdNIFphdpoVJL8OAI7VKw/mDXj5KsKis3Ddj1ielBpIWZgUwXMjpi4Yyh0uBZNU8zCWBIp9Ey/e55UuXYlkuBxx1+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989878; c=relaxed/simple;
	bh=uWiKethqvRladU3xLwu1u9TYm8p9jlbVh3Yb+pJA6z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=R0Qv2noLQ1tNrO4bC5ex7N2Ylop1T8clHAX29Es7UUbARIpexOfdzMCug+EyrN2VIZnHgru7r88wKxTyF+yd191mlAI4KynBcks1Enph4SnBL6De6SKRV6mSpFDiECfYQTk2y5fvP7XbxxP5AfMWxiOLSAAwcZWCmBPPfyC4AT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BadIo45Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BadIo45Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4716D1F000C6;
	Wed, 14 Oct 2026 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989877;
	bh=wAs6h7Mpcbm6DcLxhTNlMnp3UtBbCOSW2ll7bhshkdY=;
	h=Subject:From:Date:To;
	b=BadIo45YrmusKv76Y8qIHv6YKhKUEKkH4Jo636SsutaFo3qK7WvETYBK/uypbMFeS
	 PNLGtrscppwoP8Fl/DWqaJ4PyJ9vMFKvN+dpwAvxxFfYMwpz8Iy/XAdoHij47PLY+X
	 9tu6bXHGl8fT6stBCiM4/yASsAdYKH4ulu9NVBrpHa5ycpPIawv/vNqUAYWkkaI1vo
	 EWqx06MVnWunYY9OpfS+TN/i8t9CBcOkevttIVAM9ELg2rPCazIn8Mlw1m4kporD91
	 p95DWljyd6wjJzv7Bb0Ii77hTJwWalmq/Yq9A16w0dPrWK0T53qXOQC4gNDO/uVOiF
	 MpWUGGbKD30Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A28439EB079;
	Wed, 14 Oct 2026 14:57:57 +0000 (UTC)
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
 <179198987571.1889947.2911420799720978201.git-patchwork-housekeeping@kernel.org>
Date: Wed, 14 Oct 2026 14:57:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] dmaengine: Support bus widths of 32 bytes and above (2026-10-14T14:19:11)
  Superseding: [v5] dmaengine: Support bus widths of 32 bytes and above (2026-10-09T15:52:52):
    [v5,1/9] dmaengine: Support bus widths of 32 bytes and above
    [v5,2/9] dmaengine: dma-axi-dmac: Use bus width capability helpers
    [v5,3/9] dmaengine: dw-axi-dmac: Use bus width capability helpers
    [v5,4/9] dmaengine: qcom: gpi: Use bus width capability helpers
    [v5,5/9] dmaengine: stm32-dma3: Use bus width capability helpers
    [v5,6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
    [v5,7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
    [v5,8/9] spi: dw: Use dma_slave_caps bus width helpers
    [v5,9/9] dmaengine: Drop legacy bus width fields from dma_slave_caps

Checked 203 series in 4.31 seconds.
This project currently has 16766 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

