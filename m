Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D42D7380
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488055; cv=none; b=o3NOtr1AnLn4sSrqvAgL1AvBAneAFiE+en3RsEHsIwZaTaFV57E93wIlXMKiir+o2S3NQwTQTgccjyEb7WIHRWm+gcMjwrYRYMU4RAgrB5AU2Djp0rj/HyxQRYcF4nShpBrQ57lFncO1UVcjI9F1Ynjz7pQefco8hOwb4JHMiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488055; c=relaxed/simple;
	bh=lN4ggqEP7B2HnxNFiPGg4Iyh55RHixoEoTlT0XFki5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OaGtv7tD/VNHrCLRGisD1b/s894oVY9/U1NCcB4CHEvGcxlQLd3KFDdrBWiYGFiCayQL50lcKaIon/X68iaDy+kyecg7S5qaQHgCr4w/LdAAsnIOT068Hq6brFkY3E5G1iqqJ35S0QL/NXL4bFCfT3jF68ztzN83BUvrxcLRO5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzqHk8No; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzqHk8No"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E61F000E9;
	Tue, 11 Aug 2026 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786488053;
	bh=zh/FPdC7aK9sP8C7BvfEd3VOJMM1FPd2Jhh48HPkmog=;
	h=Subject:From:Date:To;
	b=UzqHk8NoFi3eXZdAB3XuMokqjm1NcNuUyjN65B012lV3JFtkSGSVPFZ0BmSf/YMkE
	 WNWc4xszsXOiDLGKtuKA7S8TOYiVjpXGSiGZts4u1THXsMmg6rde3eSQiFZCaxTcRo
	 xM/XpkI7G0pP9Vuprbi/fOmTH78eOQ5rN1igkqBF0iuesRXfsrI6oZlRXEVaxPhBw7
	 CZUsZor5I+nFDnKvthL241YklNopzyxmg85fh62ckyrzLmyaP+RkcKyL4mNfRI+w6N
	 DscTQMQfWuoQz9Y39WPeMzPeeI13mbIxRS4bqa5dKP6TBnOM2ePJhD+hbuIT3I4WTm
	 OYCgcTgnd9trw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D32EA3809A33;
	Tue, 11 Aug 2026 22:40:10 +0000 (UTC)
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
 <178648800948.1181637.13544477789227617464.git-patchwork-summary@kernel.org>
Date: Tue, 11 Aug 2026 22:40:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add quad mode support for QPIC SNAND
  Submitter: Md Sadre Alam <md.alam@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1142329
  Lore link: https://lore.kernel.org/r/20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com
    Patches: [v2,1/3] spi: spi-qpic-snand: move command mapping helper
             [v2,2/3] spi: spi-qpic-snand: add quad mode support
             [v2,3/3] spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


