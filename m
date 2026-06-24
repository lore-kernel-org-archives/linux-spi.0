Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2E308F26
	for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782330020; cv=none; b=ktsO0FUkwte1o6oQeX4EtSr/KjMF+l0rw5I49QNyBYyeaI/3+MGaB0YwjtkkM9F9rm/APMjfUowx2C8uHhqXZSkrzLjdHucKbWJIJIIEYTdCirojalFbRgE55xuBxlTju/N+FSdsx/0wxTC8wgKoADq1o0M2bqc+q/IN7uPF6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782330020; c=relaxed/simple;
	bh=pvN6o2AOX30X2jsvxXYJfTOAfR1ohaqQz4rsJxfvI4s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Q9IEGrY5PuUGJPfNsrAY/vZqQd1xYTrmsuJGdSVrFAYKLdj5hUclEj93IMrQIhDR9NVSE6SLhyuV4WZdUpw7Z9NN0KYhI0yjVkq+G0evy1UcsdkgIO5nm/VmZ7BB95HAY1geBOnFk18KqKIJuyrFa1+8NDc5x7CHEUqFYWxhzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMeAZ1hX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMeAZ1hX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFCE1F000E9;
	Wed, 24 Jun 2026 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782330018;
	bh=DYq7Cg6fnOf4/2zTBAm4HkHdS9yzTv9fTQsV8UPi1Ns=;
	h=Subject:From:Date:To;
	b=EMeAZ1hXeHTl5whi7B193zSjeJAhIoZ8dQ/rhz3Wnn9jEmA2vLEBnxvx0YPA4XuI7
	 ZhEldZLjwhPrO0QM+jWIz/UKtmwDApvrcCCJGFCTG7zM/qDlLDat2pi8aG1ZRI6n18
	 2PJLBE8AiKDUa8sfM6CRTyqmhLd1sx0dLh7EEaqlwPlGRbCM/K38OhBAwbU3lNaIti
	 fGBsZOeM6KwXmXeuoJetWFoG1S2Cy6fg6y+bKIwo/EKZ6LqWFQE7gOSc4pjXRZX/p4
	 QBIMtI8G5voO9+oG03Nnfxn2dMtltn/MXMzGlRYjIZXP4CU0od2MUCicULvifcy5rK
	 9fRk3zNkmiy9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 967DC3AA6A69;
	Wed, 24 Jun 2026 19:40:08 +0000 (UTC)
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
 <178233000728.2967934.3799683017080564734.git-patchwork-summary@kernel.org>
Date: Wed, 24 Jun 2026 19:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: imx: reconfigure for PIO when DMA cannot be started
  Submitter: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1116023
  Lore link: https://lore.kernel.org/r/20260624151958.18626-1-javier.pastrana@linutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


