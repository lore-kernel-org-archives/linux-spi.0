Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD83FB06B
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024287; cv=none; b=bq3MzEaYuHOUtlnX1fMgz/ybUsjjZJzJLTnnJI5I0IoQKAJnnTE4wYCOnwllj0r+D3I2ncOcANVsPP8VK+OqUMguh2oRnvYy0ynstzO3I5nPlf883ujUe5zy69SqCcV5MsPbmYCladcD7nWNHdnmMf89CB18JaYecBkzNwSf8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024287; c=relaxed/simple;
	bh=Q5yiNWsFXK9Q4U1Arig/EKFr80OzaWXTP8y90ZchVmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j4786Lg9/n+xFbC80TezExJ/9WApLdRXvWx/repue8o8A4/G6Q4IEadwedNPqwhXVoOfMk1AUPp3afirZOaYpGYFFSeSb1Keuatpq8koUs1/GDaJjR60MvxArJRN3V2YrUPfVNVoRnWoGH6mYFN7qU9loBdYKizEhkOdgl3QVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2ANjJsr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2ANjJsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D4D1F00893;
	Tue,  9 Jun 2026 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781024286;
	bh=ubZ61ueFDvNhV+44xUVeC/xxLLX6NNTxs9koyVMlh6U=;
	h=Subject:From:Date:To;
	b=C2ANjJsrD69i2RqnuWyQLhhDbORkG+Tv8dLBFhl+vQt996AFBxjVGRU9hIU5KTjHO
	 I4Tr9QmmqlqoR5hDmn7YvKAcU3WqzZx5ymq3C+46lErRWeaoQUFKQmjGXdn6VzKSZx
	 pI4JTw60D/GBep5bF2sHzs8FObwi6F9pqNlU9pBzIgz7lQ0urqRZS0A7lEo4fDlhfU
	 fhPSCXpiZ6pnS/wmXrSyw2oBPU+VGiBfP10Dv0RIaY2XspcNr1SJf+kLc5voQqLKkF
	 HlbH5DEArYCUidOHXPd2WiuRskbg7l5GFuEQzwmdvO9eDfb5/ogAoOsMEW0P0Mtx1N
	 d1xC/BFrp5CkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683A393098D;
	Tue,  9 Jun 2026 16:58:06 +0000 (UTC)
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
 <178102428503.2143538.15719359025558483173.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jun 2026 16:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-09T16:39:16)
  Superseding: [v3] Nuvoton NPCM FIU DTS fixes and binding conversion (2026-06-09T15:54:35):
    [v3,1/2] arm: dts: nuvoton: npcm7xx: Drop bogus FIU reg-names and clock-names
    [v3,2/2] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

