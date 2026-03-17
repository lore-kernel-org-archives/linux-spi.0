Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05AF363C4F
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771611; cv=none; b=VkTb/wyKxVPMH2oWJz2iuFrGjTvnqokV59yipUWvp3vN5lH2SJcBoix2lnI2V6gzqkr9R+4vRtTIO4AF1tcyqonWJYlwa95zG8beGrHuBvW3qjyv3EGuaiitUak2x2oeFKsBSeK9pkrRUP9sx21o5vOklUrLRyY4/9fXYKOxcik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771611; c=relaxed/simple;
	bh=xNGZBdBiWu189//1Udy/dtBPpqmAT+MBUSFMnQCG5Vk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=cWwvCnlIO1W37BWQpj+OWC7AcxHaYWp20B/oT07Bcte3SInZLJ552zmUyYsuulv3KoflAGHiDUtVb+/AeGp38agoyA4JrHs+1ngb5SI52I5d6MYGwUxZbvlZCF1SlY2zStYKEkLLGiB0/+3UPOhAXW+G5tKYJ9BpYMnDMz6fmwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOQXYDUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOQXYDUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA74C4CEF7;
	Tue, 17 Mar 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773771611;
	bh=xNGZBdBiWu189//1Udy/dtBPpqmAT+MBUSFMnQCG5Vk=;
	h=Subject:From:Date:To:From;
	b=aOQXYDUqEDzqEg+JURqQba9hbv9luqUfZ6uS2z29NZmTZMb7yOmiG4Li8nlmnKdBT
	 s3rJKdtGkXj+3LURMASNTBz//wBKbN6FCoYaahTCdgc2naYfFIDvoX+G9p8i1Sxco8
	 yoI72+TMH1J7gckBy+fBUSGwollBkzWe7Li7zxQ7naeXGNTqf+KUSq3nC4emhva3iX
	 Wux9XoDzpOx5HMVBiPaMrK/dzKbLdwbx8apDjRtZ+I3/HlYrSOypMJjWRCD6DGTr4F
	 jhWNoSIV1rU4x+oB+MEOJmlyNU7XBH71nv+M1rquJAbk/KLJkENnGuiedov7yqQcC0
	 YlQ6HtLE/GVmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F8CF3808200;
	Tue, 17 Mar 2026 18:20:04 +0000 (UTC)
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
 <177377160310.4150137.9340211735427374477.git-patchwork-summary@kernel.org>
Date: Tue, 17 Mar 2026 18:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: geni-qcom: Check DMA interrupts early in ISR
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1066462
  Lore link: https://lore.kernel.org/r/20260313-spi-geni-qcom-fix-dma-irq-handling-v1-1-0bd122589e02@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


