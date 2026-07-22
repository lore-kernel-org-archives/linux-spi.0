Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD97D2DEA64
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724366; cv=none; b=NXCskjz4FeZC39I/AI2Btw06po5MMZont5HsUu4BpAGkENvBt4v80RFP9IYMoFvwFPklLl75dW5j3clbSJ9/ommYD8G+wCyFXbiGC2FSsd2dYYptotzSLKE/YB3QlESylBMSKbulgRnPjYWuFZ+u/IjoFxH0SEhvRZYUJYWAVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724366; c=relaxed/simple;
	bh=jEBryfjQ/whyjE5Rlg7Md+BdPIQrDjddZbAhVXtttN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GFaa7o5Hv5afI/sQvqHNNWDAE6h0CLXcxpMhfJiR5J4DvMnl9PuxrIpKpLeqyaNBVNdphOIhdlQJpnvbGkSKpcRlGKCEiDDkv5hPmRh0qdgOJ0whXk+u81nNP2LuDoEp7q1/Hecz9HneZOGajX78Objc7be4aVZ1SBXsENxhI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRDDamRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRDDamRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3221F00A3A;
	Wed, 22 Jul 2026 12:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724363;
	bh=p3WuSbKh1QFLPeToipRzgNAWvp1ubJAKbnS4lfAJ3bo=;
	h=Subject:From:Date:To;
	b=IRDDamRqERQxjE59c0DrkQjcJqE2jhEkEu9tgxzDvudvR7VpZb17l4lijXJ7ZhB7H
	 EKe+pwdqbanw8G2+oJDywQiqJAnG21HGiO+kFqzaLGNItBVMDl9zkWtUsljRuQbO/b
	 A9wHdoxvm7zP0U6fBL0IxRvTCG+8KKgTCMr6qYp7V7TB4411yTm9AD++YDBH8gSGlX
	 IWJXS2YZkzFMLw/6iDVDZBT686QHA77vqwhm5kg9peUduDkARHBpzG08gje+jwXbUh
	 ZC5dKvmptjpNT3L/AwL9GO3HjX/SzS23M7jVtelXPQc0VLr0qZ3JjzL3eBdPiC5Tnu
	 SFSaqOMqSWHWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 96648380A979;
	Wed, 22 Jul 2026 12:45:33 +0000 (UTC)
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
 <178472433209.1380662.8149600083634572485.git-patchwork-summary@kernel.org>
Date: Wed, 22 Jul 2026 12:45:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spacemit: support K3 SPI controllers
  Submitter: Zhengyu He <hezhy472013@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1129671
  Lore link: https://lore.kernel.org/r/20260717-k3-com260-spi-v7-2-rc2-b4-preview-20260716-v1-0-969a1b0f783f@gmail.com
    Patches: [1/4] riscv: dts: spacemit: add K3 PDMA request numbers
             [2/4] spi: dt-bindings: spacemit: add K3 SPI compatible


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


