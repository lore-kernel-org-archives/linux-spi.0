Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A74915A0
	for <linux-spi@vger.kernel.org>; Mon, 28 Sep 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634081; cv=none; b=NMaTE/L8qt6aIo+fk9oLYZal0Vi69GfC+igfQVqOHIDgsUxODm1HEczODuWJsFHFHt8FzkYgo5sNvxnID9TBT7Q01CAbSVugdS6OaJ26zXD6GnZ2Y4rotiG4sjEDLmH1meqbnI2v8c1pwOfQW/hvO3uI8PDqxp4pAdGca3AXY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634081; c=relaxed/simple;
	bh=A3Rp1TbvGF7x7cW/7ExWd9zVC8OUjWz5l34BpVMjbrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PDdYpvc2aHs19aMbcn1tHBlqmzm1jrmsTPcskM2Uxmc2+NmQo1Xa5gFxXBMy+Bf3ieWUnPJNfRLYnfPSBd2SH7S+XXjGYS5VpziTft6YYA31PJoHOMFkcUSVQbFP162d8rBE+BmoD55GE5uNFJxm6s3JD/SpE2u9jYWEzJufesA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVc95mNv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVc95mNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CD61F000FF;
	Mon, 28 Sep 2026 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790634080;
	bh=rTF1g2rag1OYqeYVvY+64KzMkJ6ClSGRbIQPvxA65UY=;
	h=Subject:From:Date:To;
	b=QVc95mNvhMrJXMeKzxRceur8nbQxSfo/B7ijlo1023UPGr2V//HUmph5BICTT0K6+
	 JJF1bFjEj4Ffol/rk/j29QMt9/C4/B4FGmpWNyCIik7OyZdoZPbe9HExVsm40cY9dt
	 kB2GtoEJxlk9S+pnaiH/WBUOo0mhH6hv6AVDYBt8B8vpauQVbVAnRoprRdEgQhq1s4
	 4mETzfSh0tWsNaFl2uS/gejk7DKEv9OkwQm+1Gg3i4I36AxagiM5QDHOAwRi8c7Ner
	 96hmWOo5wJUx2aWDqyKWKq23iTbl2P2qAEy7vGCIhpu5kRfEpPVK9nj7/zI8XiWdUy
	 P9ygOjJvI/eEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 967A93924FD4;
	Mon, 28 Sep 2026 22:20:05 +0000 (UTC)
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
 <179063400403.153937.15752537866886403887.git-patchwork-summary@kernel.org>
Date: Mon, 28 Sep 2026 22:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: fix read location register usage in qcom_spi_config_cw_read()
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1171523/
  Lore link: https://lore.kernel.org/r/20260922-qpic-snand-fix-cw_read-readloc-v1-1-67f6819fb3d7@gmail.com

Patch: [v2] spi: bcm2835: fix device_node reference leak in bcm2835_spi_setup()
  Submitter: Lucas Costa <2000.costalucas@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1174020/
  Lore link: https://lore.kernel.org/r/20260925193008.127314-1-2000.costalucas@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


