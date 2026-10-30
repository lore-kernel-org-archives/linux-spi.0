Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380279;
	b=zVWCdEM9NKXwDi70J72Mi5MM4qR4BENr688CKxrPST1vLMW7YXP6HUPatfCYxKFLMlJ2
	 Y0KcrdWMgL/fzU9o3W8vBeEkrEKYgJbKJg63l6sDDIguVq4I3+3Dmq81KGqkuCYtxr872
	 R0HDB4TKQ4jvWPNSkkZTGe3H1VG7joJ8kgcqpAHBNBx8wCqlMBwdY7N3SYv60JnrE6+ji
	 4IDHJv8vPvcbrQIaprJl2BBgBCBt63mBO53yZD1J2Dfwj+IqUDXOcqvAAV5oFXad6hYjH
	 s1FrelBvxztWfpBZxECQgWhQp/KA5KTl/Lc0sNKLrDgh45SrClli3UHTvt1hQdycSgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380279;
	h=Received:DKIM-Signature:Message-ID:From:To:Cc:Subject:Date;
	bh=IR331jw7mCWAedop4Aj+lmIIBJ2tTwsVqV6KYgr6nFo=;
	b=PpZ7QDu+CHP91DLsrF/0wemO+5Q2P04GL+FWOI+wunG3S35cY0QzmHULLxXRZrFzricB
	 wjROxyHza8tphC+zN/pPKtE2ZSQF792rSfQIBC5UTNlgvFfAtU83uwnz6OLPeW+Zp0Pcd
	 9tj4ahhz82Cd73XauZHyQIDc8OsLGrW4/x3WiJ9/4WLN0NfhjnHijR4siC0xx31Eu+8oH
	 hSwx5iRyxNCcDf+vdCYb8K/UzNYP6aqr+KmJhPYBSdxmaurqHWZAvNrREaTLleOjlnh67
	 1wpdFRT0RGXHUdwjLuks1+v2vWMLYy0Qni8Ia3+R4cidlafcwPC0Th8oH/u5K+pPfhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUvsxMrq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 13130606A31D;
	Fri, 30 Oct 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUvsxMrq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 317991F000C1;
	Fri, 30 Oct 2026 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380278;
	bh=IR331jw7mCWAedop4Aj+lmIIBJ2tTwsVqV6KYgr6nFo=;
	h=From:To:Cc:Subject:Date;
	b=FUvsxMrqjiokR0N8sbzn9eirFng8knI6IJI/ViCnyMwPp3y1zePugkv3HNkNVoDJo
	 mFwY+Di3enGZBE1CveTWfWBcsWfNGvKt0HfOdxLAbkDhO2KtaC4GPqbQjduWPIQjY2
	 naTcgMJRT+cSwzU8tCMIM7UT96KOj/R9N+woxPQut/YvureJ5b+7i4BRewckxFR84X
	 sN2NUtVY/BPwtRI9eUCfJ0zJ77DFB19PhFdm6ZYbGy2lFxCei4vlBwoTO4utv2i8pO
	 FzO6pYk/D24dkghA4N98vYzC4xW2i8BnX8kO7FyNrDOeTQOwWBwHD4+NtiWDg5tj42
	 VVcis1s5b7sJQ==
Message-ID: <5e5b62bd58db33070504988e42e31d6c@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.4-merge-window
Date: Fri, 30 Oct 2026 17:10:40 +0000
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The following changes since commit d5acef12e819c1627c8bf6a0325845ab39d8c99d:

  spi: Merge up fixes (2026-10-19 18:00:23 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-merge-window

for you to fetch changes up to 7da2aca123754c0e06092bbe179d58078b58d8d4:

  spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54 (2026-10-26 18:26:59 +0000)

----------------------------------------------------------------
spi: Fixes for v7.4

Two patches here, one a straightforward device quirk and the other a fix
for a potentially nasty data corruption bug in the zynq-qspi driver.

----------------------------------------------------------------
Jérémie Rodon (1):
      spi: cs42l43: Add speaker ID quirk for Dell XPS 13 DX13260 SKU 0E54

Pufan Jin (1):
      spi: zynq-qspi: fix address buffer corruption and support 4-byte address

 drivers/spi/spi-cs42l43.c   |  8 ++++++++
 drivers/spi/spi-zynq-qspi.c | 13 +++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)
