Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397F3B8931
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748813; cv=none; b=ZcnNuDbxvrM8bJX5JQ1ITcQGY/329vWQEYImw7a1IuOGZ0tP3L+7eHphnDhfabkRRj2s4RxjevJNWRBVDqnAriqmzjv3HUbF/HjiskZPTJmCKSOSgh1zvinL7VjJ1FAs4ley8LZWT8B4X3rc/WMQTv9w4TBoQOAJIDgXaXalILA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748813; c=relaxed/simple;
	bh=/uebWTmv05z7/AUNnAxAlik4trrM92VqAC9pi3LjuD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M0BJjEuh7ai0II+jsfVcjGDSuqGbonK0Kq/0SMBBGMuRPaZ/+8X/w4s0tyoVX9jEtfZANE58VVvHdpxwpbkvQavJSI0u5ayMJM0hrplPK83OxPrdNTKWPbeYDctLRqhc7rHL7qFOO4dSqN+TKG3uLL4v30qQLVLfxVrFJqhIoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTE2dNkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTE2dNkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B2EC4CEF7;
	Tue, 17 Mar 2026 12:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773748812;
	bh=/uebWTmv05z7/AUNnAxAlik4trrM92VqAC9pi3LjuD4=;
	h=Subject:From:Date:To:From;
	b=BTE2dNkx83tVRzS0If/8tpww1mmCZvgqn4Z2ZWCZIYGKJsNvWHmO1+iYd5gFwrhtA
	 SEJutBlf4TeykGysdyt2IohJBdstGMT/KxJFA1UIDU4znvPOjWJouaAFC4XbeAEny0
	 AZqNbF2LDoudPnNY7iBVh6onl4M2mVRdODHfV+EhKGE0rfOwOxUNbr4mkBzdnnfQwL
	 e8n50UBE7mwndQBUSdaQEO714uWIwmBksnnlm/EhgMkBUKfGUS1uyVSU9rNzCcyo+C
	 pmplLxsR7whOwXzSra25iFUGsEzI4rnWYBEt5jmiMkbzyYQpNgpdeU/zgx26eFK4Cb
	 UQGR9OJw9QWog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F9B33808200;
	Tue, 17 Mar 2026 12:00:06 +0000 (UTC)
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
 <177374880521.3585799.4330331579393285057.git-patchwork-summary@kernel.org>
Date: Tue, 17 Mar 2026 12:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: controller registration fixes
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1065746
  Lore link: https://lore.kernel.org/r/20260312151817.32100-1-johan@kernel.org
    Patches: [1/5] spi: fix use-after-free on controller registration failure
             [2/5] spi: fix statistics allocation
             [3/5] spi: drop unused devres statistics allocation
             [4/5] spi: fix misleading controller registration kernel-doc
             [5/5] spi: fix misleading controller deregistration kernel-doc


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


