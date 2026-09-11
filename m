Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721354A5C23
	for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149508; cv=none; b=pkWTuu5ALOlVlZYVbNwAc7cMcqzPCEAKepqno+fD86Xjx8HcmT5asLpLE0ZsDGH8Bhe8tH8Lsn2D9ZfzQc621zf0EXsa1tpxYR1YVE5TfDElyukYCTDercCnIOnIvPXSB4YcYqp6/QruWtXUFTo9n7DloHlrnCHOCstB9B+54WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149508; c=relaxed/simple;
	bh=2uaq8iAxJ6DFvLTad4DgrUzUZ3TGYtdgFR2yA1bK4N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MwVGoLQpIsfrDV9nE4zT5R28AUfQjTAN9pEEN1g1QtURUvdeXGuyQEoxUre4U7TL1Lobj2HUhjMzpP7+qV6QrKwqBdszeS0bNCPEKGKnMSvx+1fIif3Oh0tapf/uSfTxwr6dfMWpZuq8fcSB2mLqIWSef+k3/uciAOPs4aYCX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdYF89IA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdYF89IA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DED1F000FF;
	Fri, 11 Sep 2026 17:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149507;
	bh=1SogTv7BTy9RoAGq9b2feA+iy5oxJ37zdGKNHg0Hn8I=;
	h=Subject:From:Date:To;
	b=JdYF89IApNkFGhDQw5F/sH/UHE00Y6iSEzFou3JiJVetW0qDKMFD4jYpE6LL0ZyEj
	 CXB3PcRv3SGwG6iHms1WjdchmgNTW1JqQLuYi0FIGvCVxhUYmNCqwh3T66SMZSWYqC
	 h08DbvqjkZ9qzJ2tXHCmjDM9CxoXWJmRAxEQwUZMtWEQH+1OwUB0cnQEt6eyzspmhh
	 UsI57KX4DvYsH4ZBXJrzoONQDYlW3S/gsfDVrT/+TjXpTqSihRMaWPVh7PO9KZ5Wdz
	 QYEsUzoSi/Hk9ECGHAtlzxOg3sw9j6eTmPFB+RDoPKOYXpIYEdlHC+VUXTyvXlYAU7
	 IM8ahr6lRyXnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5695A3924450;
	Fri, 11 Sep 2026 17:57:25 +0000 (UTC)
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
 <178914944396.3032373.4092973311519371697.git-patchwork-housekeeping@kernel.org>
Date: Fri, 11 Sep 2026 17:57:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] dmaengine: Support bus widths of 32 bytes and above (2026-09-11T17:25:36)
  Superseding: [v3] dmaengine: Support bus widths of 32 bytes and above (2026-08-31T11:46:37):
    [v3,1/9] dmaengine: Support bus widths of 32 bytes and above
    [v3,2/9] dmaengine: dma-axi-dmac: Use bus width capability helpers
    [v3,3/9] dmaengine: dw-axi-dmac: Use bus width capability helpers
    [v3,4/9] dmaengine: qcom: gpi: Use bus width capability helpers
    [v3,5/9] dmaengine: stm32-dma3: Use bus width capability helpers
    [v3,6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width accessors
    [v3,7/9] ALSA: pcm_dmaengine: Use dma_slave_caps bus width helpers
    [v3,8/9] spi: dw: Use dma_slave_caps bus width helpers
    [v3,9/9] dmaengine: Drop legacy bus width fields from dma_slave_caps

Checked 161 series in 2.83 seconds.
This project currently has 16467 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

