Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2E3FB042
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182993; cv=none; b=og0BWyICSui0Ei5eOXeKMDNkr0KnowWjyC7t2xg3YnKhKJNK0Xci8YwCLk6VxPl6R2sEvs563Wh5VM+/fs+K/M3rgUuVRo1HPuelzx6ceBFuEQtAiqM6gnL9r1TDDRdA4AI7zCLtIPU7TuUZWUsToQRlTuWYDEpA9Bwd+VKaiik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182993; c=relaxed/simple;
	bh=MDk0jtCHv2PsMnkJ9RvAreYUbo7k2Lz0SDCPDjWXjJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Jpp1u7KxQMfrK7awRxxDSeZ5jk7F0uoxR/AKvwljIh6Wlj7t53vG3zeuPVN3fCqkjxQeYk8CreG8XXpJcikrTuZ4c2waYEqpvQSAX4u4xktmWjZNtlbOcnrnwzdQd8PawHVBC1CQajC7rOB0FnfFlORrEWrJwThNpJCqYL1JSjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRCkSW3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRCkSW3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1950EC2BCF5;
	Tue, 19 May 2026 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182993;
	bh=MDk0jtCHv2PsMnkJ9RvAreYUbo7k2Lz0SDCPDjWXjJk=;
	h=Subject:From:Date:To:From;
	b=pRCkSW3rcIfMIY4q4dOkQ81nsaB6qNvmGWYo41BFr/WE3oEnzZhF6Kf9AIsCsvvAd
	 amuueU6+rhRXdNhBIlGaRcyQtmAyo3XxZrzqmMXeriwdoGN84QSEzhjRmVHYgkFnNg
	 VpEJ32Uuh8G7UDAtlLjFGGHPmaDzyK/QMnvT3yOzQxeT4NIBLIimbxKoIQHejx4guy
	 U5X70WNhDornXzGqkdk/c1Gfx3KNCNnuZU//gH4GutFAqgRx7s4UR4FwU/pGeJIFTJ
	 lurZJOjJ/gCl0RzPwiJvyIkVUT2iT3GwFAc5K9JCKaFrhjlIhMsSrpV1t9+X2kDVq4
	 jlW7wV59VRVhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 593443930DEB;
	Tue, 19 May 2026 09:30:05 +0000 (UTC)
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
 <177918300395.2200471.8847311241966795099.git-patchwork-summary@kernel.org>
Date: Tue, 19 May 2026 09:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ti-qspi: fix use-after-free after DMA setup failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1093351
  Lore link: https://lore.kernel.org/r/20260512074809.915084-1-johan@kernel.org

Patch: spi: sprd: fix error pointer deref after DMA setup failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1093350
  Lore link: https://lore.kernel.org/r/20260512074733.915029-1-johan@kernel.org

Patch: spi: qup: fix error pointer deref after DMA setup failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1093344
  Lore link: https://lore.kernel.org/r/20260512074334.914735-1-johan@kernel.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


