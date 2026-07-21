Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE71643B
	for <linux-spi@vger.kernel.org>; Tue, 21 Jul 2026 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784592637; cv=none; b=K0+HONY9MQuAfj7h44jMb7UoIF+Vu6eR32QYIu3V/56tcw/v5kZGZb2MspsDki5mJEKLxp7ZHQ6hV6zxW71vuMTgzKtqC2OrMENw537IEEt8iHVDr2fKUPR/L7TFrD6/xCVd+cguPKoZjSkVynRYfB3+IXVZThJivSXmIj8qI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784592637; c=relaxed/simple;
	bh=nGsesj8XZi/0GimfoQzcTe5mAP+WF309Nc70BoSBDVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=snq2s2EFZE+4cPtgYLSH7httkzolDr9PIiHnXogFN3OKwW1SQCkW2pymvAdJtHvaGmkShvNNZPo6L3/rxzq0eGSFy07KbJiPWE/vEjAx4o4z3oDpLmQCeIMhl08l5d0PrhhIoSjNH1RCTLoqrM0oTMLFRKyi7ZSosc6U7cPRm9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJtYg0ZQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJtYg0ZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2191F000E9;
	Tue, 21 Jul 2026 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784592635;
	bh=SbfKFexUQ7Z3EG+UYseFi8rOJwyMfONYRd6L21LZcXU=;
	h=Subject:From:Date:To;
	b=DJtYg0ZQSY3hmUtnTBdE7yNWtVqSTx7T0GgN6PF8s9KinsRhycf34eJjdC0qtuFk3
	 /s8yc+NCJ15OpI6PmcNjS3Zy6A4Mn3qobZ7oG/wAId24HlCULTl8325WHgoA6fzS2K
	 +lu8nbOQXKNQSA5zzH/Z7K18bsINKIPt6oTg2yFNBdcQirrB04o2nRTPtmMhbfb7ny
	 AVOYihjhwV+X1G5Xq2c0/3aCTlTLYfX1+oI41zHwDUBzmOOSILK7fKuB7zhioRWJ3f
	 nVvzSemXB3kbSCeWOCrB1x51aW+mG1OfLLN9/NsboHDDcQ6jC/3LOIn5Bf5rcyh+dX
	 xcMO2w8QrSMtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C3E639244E3;
	Tue, 21 Jul 2026 00:10:07 +0000 (UTC)
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
 <178459260564.21673.15831924689317505177.git-patchwork-summary@kernel.org>
Date: Tue, 21 Jul 2026 00:10:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: memory: renesas-rpc-if: Optimize transfer overhead and implement runtime PM autosuspend
  Submitter: Lad, Prabhakar <prabhakar.csengg@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1128425
  Lore link: https://lore.kernel.org/r/20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com
    Patches: [1/7] memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
             [6/7] spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


