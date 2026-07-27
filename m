Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2904E3F6C4B
	for <linux-spi@vger.kernel.org>; Mon, 27 Jul 2026 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785193264; cv=none; b=oNN4Nrke1K45cDoWSm3c7nSbep9Jn6mnAbuKWWbXMVfPYe/u/wzR9In0Cbet2ZWkGtQgrUaqSfcZfiDbtNxDarP6L1bmGAuyrJlorA0X7w4zn6fmGgUZjyY/ZfUnblUiv/aAGhLKEAGPbHKWYfgqFLgk4CTJrGsQkYyMaqFKZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785193264; c=relaxed/simple;
	bh=KG/mlx4j/LyK4nAstggveOi36xhROzk4c47qJ8aNCQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pAUvWcLwHVE5JZH9Iww/hTQTQIF119e5aytW1wfzKVzs+3lImsxAVvPp6H9AMdpQ8s1Gl/7rIzQnboP/i14LrBy85Ss4clxGKm1itdn9vhO34N5O11ppyM5XCGxCaJZpbUO+5qMpdbuv9BfM5ABGdVaF+wO6CbrS3FPqt9DvGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJXDGYwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJXDGYwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD81F000E9;
	Mon, 27 Jul 2026 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785193261;
	bh=QCpA4k6n0xqNUmLmKmkuUUdloGO3YHFJln5NXZ6rIYk=;
	h=Subject:From:Date:To;
	b=NJXDGYwD/vNY0SIoWDs8D0xy6roBW06iQgUOkV+3oykqtiRwY1bXD5QMASOh7jaRu
	 a7Cq27rr02SkMAYJ8rReOONx2aYX2AUfPEmcybDa1kvuGDP8JZ1es187dlrIHHkRGs
	 O+crynBp2fbQOdZgRrp/8lV4UQuYmp09hAN0Er+BaRAmr6sccmaIO3wHDdmPJnO/eA
	 zXZH4QmO9Urx3dNCuNSqqLn4RKPchkHeBdx1IRfNPhi5tCtIE7mT4WPSZpY6OirG5d
	 JJUBmRXphCEaYKsXvNCw76wLWbb8nWN9TyJ/PoWNjIi7urg0TFFWzqOrvnmjOihyOW
	 Ubphef0cLhs9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1A05F380CED1;
	Mon, 27 Jul 2026 23:00:28 +0000 (UTC)
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
 <178519322672.1451487.15842702102479783035.git-patchwork-summary@kernel.org>
Date: Mon, 27 Jul 2026 23:00:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: oc-tiny: switch to managed controller allocation
  Submitter: Fan Wu <fanwu01@zju.edu.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1130195
  Lore link: https://lore.kernel.org/r/20260719010014.3163356-1-fanwu01@zju.edu.cn

Patch: spi: spi-qpic-snand: Increase ECC strength for large OOB SPI-NAND devices
  Submitter: Md Sadre Alam <md.alam@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1128544
  Lore link: https://lore.kernel.org/r/20260716-8bitecc-v1-1-6eef4bcc3a14@oss.qualcomm.com

Patch: spi: dt-bindings: qcom,sa8255p-geni-spi: Add compatible for Nord SA8797P
  Submitter: Shawn Guo <shengchao.guo@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1127388
  Lore link: https://lore.kernel.org/r/20260714120226.1788391-1-shengchao.guo@oss.qualcomm.com

Patch: spi: spi-cadence: Move TX FIFO full busy-wait into FIFO
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1130881
  Lore link: https://lore.kernel.org/r/20260720125510.60166-1-srikanth.boyapally@amd.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


