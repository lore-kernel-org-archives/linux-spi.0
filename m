Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFE33AD85
	for <linux-spi@vger.kernel.org>; Mon,  2 Feb 2026 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072611; cv=none; b=FYJRfEzsOCQJoUYIpWO0DGPhs/Z/oMWn00kDEjEUHb6EN/nlFkuSLXaKLNC1R7QQv33ugeB2wzibAYye42DPzPZvLvz5r15OfTQGzI2fYp44LS/y8NTCY1vpcMUaNBgTaJYXhKme2rm5qLIrVY910y64nS2iYbd15nWOrB/nBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072611; c=relaxed/simple;
	bh=4pcyW1tRerDuzXusYAx5oYAiiE6M/YfuwBQKi+QDrqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=R/7fJQRc7/MBNlnL1iJnvRlOsEaSk8TgjvmWYZTn/R1NOq33aCn9zqN5y3oc11rRG0uYPmF05rby87KDcBb+EfTjq9X+JNWB0IbQLebn0GuCvcXIKqnweV8pFf1DQpdH1l5sVS5UZP94O/xvpBVzLxD8E9uemmHNQQris/y58BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3GPiF35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3GPiF35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2885DC116C6;
	Mon,  2 Feb 2026 22:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770072611;
	bh=4pcyW1tRerDuzXusYAx5oYAiiE6M/YfuwBQKi+QDrqE=;
	h=Subject:From:Date:To:From;
	b=L3GPiF3500nIAyI+rSAheN/OQHWM6bwrYezVtNtoJ49YcUo6m1/TTZ/0mGDOsktZJ
	 9/3OtMHmc6CK6lRRm8+TcJBBXGY8L622RFKwHxQNi+fspQdrVJWuA6EEWQkVRTe4Jo
	 raMOHkn/gTIYnV5akB7OWKwETtvIGykmoxeWnOPa29ZL3VTnaTkcmS1yoIlEDgD7ua
	 dogj5j2TxlOxaSgKhBcctgW8SsqE25QUMM02cDawDo5vF8950dr7r6Z7hQddoM8tjC
	 qSyivE3dtm+gL7pljVmIcOG9awJXTKDrcWuD7DRwSpWUNRnMryAWU9z5hwU+17nt2R
	 hwNmfyXJZMlng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198403808200;
	Mon,  2 Feb 2026 22:50:09 +0000 (UTC)
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
 <177007260768.1222501.9131025749518651941.git-patchwork-summary@kernel.org>
Date: Mon, 02 Feb 2026 22:50:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add multi-lane support
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1046465
  Lore link: https://lore.kernel.org/r/20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com
    Patches: [v6,1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
             [v6,2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map properties
             [v6,3/9] spi: support controllers with multiple data lanes
             [v6,4/9] spi: add multi_lane_mode field to struct spi_transfer
             [v6,5/9] spi: Documentation: add page on multi-lane support
             [v6,6/9] spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
             [v6,7/9] spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


