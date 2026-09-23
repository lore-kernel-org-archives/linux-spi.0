Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BD35AC11
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 21:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197293; cv=none; b=t0wbkLUbD7Vu1K39Ag86RrJm6xOupOHt8zvMAcm+YlshIQROgxUNq05er6/16J2aXQGhG6vhag8eJvchzStiUqus5Uq4D5i2XJKv+2Alsq2Fuvf5gVkJpf+FLwl5M3E8T2q3ncEFh9jJJcI8S/aLVTOTDOngSsJ4pTy/Zrx043Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197293; c=relaxed/simple;
	bh=EZFvMMNk3d/ZY3/uvaDLHvR0oC/Sdc3LfxfqXVclvdA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MIAAFDzWvjUFNn+2qQJzrn9ZUmY/dPJSvv41TcufmwOunoSFK5w7yOzt89SdJ2kM6X1UEsccBlkVK9xZwxPq+kn3K12az/xvwrA2zGicOPZRruRyr4r7htEK3JGG2d8SS39nU3um7YwBTPcGK8gTJntPzSZn2Z15WjEYd+mX/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyNPuLjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyNPuLjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E491F000FF;
	Wed, 23 Sep 2026 21:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790197285;
	bh=OJ5CanADDLRBq3YIHsyI2LiiWqEqCY7s2sp28WzJEqo=;
	h=Subject:From:Date:To;
	b=YyNPuLjVQZtjTiJlcCyS0+kSUroOC4TdeaedBb7FGdjuXIfi+ljzuUPLzUmKLymm8
	 8uL7X0XN7zI5iEnoidX8pApQOtBjSVUcHttT4agXMz8u3Bah8RwxDjv228URbqaZbM
	 Z62a8R+MooSznCGWuRs0G7xgnN4En2i/uhIuWzKQSiI0EaaxoM0AIE19437V5Z7rTX
	 TybJv3VCIz9SvQ+5NMC0AtdK3ssS7ywrOGZO5FsMZ3R9WZlfHzVKJwo2st15tOSjT9
	 yRkUg4A5kJ2fvPdx7p1WRSXxE0ltsqjoCHDfVsh81Zhwl8WhF+pXOh8HvMb3lU6DI5
	 yeaArfMnHoHAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9532739E8A76;
	Wed, 23 Sep 2026 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179019721526.702272.7728635294762083695.git-patchwork-housekeeping@kernel.org>
Date: Wed, 23 Sep 2026 21:00:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: spidev_test: new features (2026-09-23T20:10:00)
  Superseding: [v4] spi: spidev_test: new features (2026-09-18T15:22:48):
    [v4,1/9] spi: spidev_test: include tools/include
    [v4,2/9] spi: spidev_test: clarify help text for --size
    [v4,3/9] spi: spidev_test: add compare mode
    [v4,4/9] spi: spidev_test: allow disabling rx or tx buffers
    [v4,5/9] spi: spidev_test: don't send 0x0 or 0xff
    [v4,6/9] spi: spidev_test: send predictable data
    [v4,7/9] spi: spidev_test: add option to split message into multiple transfers
    [v4,8/9] spi: spidev_test: print TX on error
    [v4,9/9] spi: spidev_test: rewrite unescape() to stay in bounds

Checked 172 series in 4.96 seconds.
This project currently has 16560 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

