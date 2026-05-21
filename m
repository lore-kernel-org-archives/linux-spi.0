Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE94228CB0
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779404395; cv=none; b=dTBRpKowahfzJ+dIz3cv4/x2ZDHXKR41IJJTTpKjLpK0y2UDy0+TLs3EQ+1HkLWsycJVIFiV8QeY+Xidc2kIfacaMPXsiKWQiNKvSnSRN7xVMCm8q5iGgNCp3itGox9206A7AZPM7jru6Rr8KEuoaaQ+lH8OzqTV3HdqPR3gNyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779404395; c=relaxed/simple;
	bh=Et7uCk1KUdiXR+wDCCmdlgRrhsFB/HxYu4u/lcgNpjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lKTefJiySMqSxmugpl92Iu5ZPTkla155RoV5Bc6ybwZKFmxuTTum6amdF7TwIN9pIwm2hxeAymwB9j6AodasuW/LJGWpaffFaXbR7rY3Pq6IMJxZHThkYUE8LfnT0JPRiFUMSBLFM5+xnKQ96KRSaIcfEklXa/aj/mYQLNzGhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8jP0x3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8jP0x3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8098E1F000E9;
	Thu, 21 May 2026 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779404394;
	bh=sRzc1qtTO373G7T9hQzzyc74favwc2PVQ1tIlBJPbso=;
	h=Subject:From:Date:To;
	b=P8jP0x3YjwKipNDDkb6ZeLJQ6R9UW9LF1L77Snc1oQvOU324jatDBbNDeuBT+sna7
	 6bOqBQAk74lYUdphprp0TvaLTJ1k26NfBPWsJkW3vd5ALKc/OxkPfpQKJzfFdWQk6f
	 mIgRW0z92opsxsvvKxqj51hFQ8WDcFfOLAS/4p9/L/RhQUuvLc7BZ+Fk0IjOi1ke5A
	 hMRKi70WJ9nXlCQLts9PkjCgsf8yez7+P3mhtCuMPQGIGo2Lzm1lTP8rOOt7i4rBC4
	 9X+pG+Dy1pneF4ZiE+JFkZiDILw/yuowwtZ4YGKBE0M5kXvEboGo7yGlUxB3Qd5mmz
	 NRSmOYcaCSGaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5926C3930E3C;
	Thu, 21 May 2026 23:00:05 +0000 (UTC)
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
 <177940440387.545382.5797217001592390866.git-patchwork-summary@kernel.org>
Date: Thu, 21 May 2026 23:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: enable the SpacemiT K3 SoC QSPI
  Submitter: Zhengyu He <hezhy472013@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1098863
  Lore link: https://lore.kernel.org/r/20260521-k3-pico-itx-qspi-v2-for-next-20260521-v2-0-52bce26e5fd8@gmail.com
    Patches: [v2,1/2] spi: dt-bindings: fsl-qspi: support SpacemiT K3


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


