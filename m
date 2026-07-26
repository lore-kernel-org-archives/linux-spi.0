Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EB28751B;
	Sun, 26 Jul 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081954; cv=none; b=UdOx9/Y2RcEwt9AyptE4VI3eZ9Pg4/X6KKRNNCcOFpAEMsgAddEUHYmXXpC8X3wQTwrN43ex2rg2gSXDdf/o8WhFT+WEE867Ml2s5erbDXslH1bBbRKGEhrY+N47AB15thJlypOiAhyr4qR3ru/9Nkv9VXAskb/YuI3Ei+aQ0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081954; c=relaxed/simple;
	bh=XQd8tLRoMhOUs0o/BTr8iIhboAr8ndn1QQLd1JLSoA0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=JTIW/MuVyhSn2n235iG2GhFaS+JS9vOZNdapqHuhwePT+ILSHdYfwMArwQBkkVqOQsmwZ3tYQ7sciflDZw248iA516yelSEALB9ETiU0UqDFr8UkYWq/p3nCMwLM8fPt7LktdqS9vlXh6ODK+qcTpz4+d0FWJl02AcUsXYhIxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpqX63/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpqX63/O"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3AC571F000E9;
	Sun, 26 Jul 2026 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785081952;
	bh=VicJfAw2EbuKMrcGKVSZCYuw79UGDIhTQJmhznlg5ag=;
	h=From:To:Cc:Subject:Date;
	b=VpqX63/ObCiU7Mb971Cd7vnD4sgKAXnRMiWZCKMa3+VxFYyv/6uTJ7GyQ3hkyioM1
	 bsu43y+4mkOgH91xljUu5uc3cVcBUMzlvWWmJKAsR8O2pJsJ832IwEMQHYKZU+HxNT
	 dIewQxeDvW225OFs9UxKiYLn0KnPSGhMuGkCCWq5LlMak29qYL2HGii46Knj8NkOJq
	 u5K15TagT4pENkI+f0cLfyBepOD/siNo//7t/uOY9NvvLOOxxKkmp0oyExg1QVT4py
	 DCHZUeXipgz5IjGy8dCu7++gunfmpWyJyzZVoUlene/ogIUeNRXCLMq08XozElSUjt
	 A05A7DcdgrcPg==
Message-ID: <fb6ebc01f222a49400ca0aa3d9597648@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-rc4
Date: Sun, 26 Jul 2026 17:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc4

for you to fetch changes up to 6389eaf11d6cd3a66d10d0a5ea9cd91f242ccba2:

  spi: dt-bindings: spacemit: add K3 SPI compatible (2026-07-21 22:39:30 +0100)

----------------------------------------------------------------
spi: Fixes for v7.2

Just a couple of small bits for the SpacemiT driver - one small fix, and
a new compatible in the DT binding.

----------------------------------------------------------------
Zhengyu He (2):
      spi: spacemit: Correct TX FIFO slot calculation
      spi: dt-bindings: spacemit: add K3 SPI compatible

 Documentation/devicetree/bindings/spi/spacemit,k1-spi.yaml | 6 +++++-
 drivers/spi/spi-spacemit-k1.c                              | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)
