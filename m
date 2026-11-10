Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326382;
	b=llBeB4egHtRslCL6f1WGofvldzsCn3sbz1z0LP8Ft+1horuSQWNLTbfvsQmCuNrfxGqJ
	 kLNOpsF3jI6HvtyViCi1bMvfDi2i5VREjRzdD2QLSEl2lKOgB5cV+V7b8yTVPxzJoh3VU
	 Ojd96rF0IEuqv1HWHuf8H5eg3D2YEuh33pKTRo1lqzqBTgWT+sUDEHfjgiZU/m0ENfsWA
	 q5jwIKqHLDUeY14Xu8WeiUUKpDzJvWKO9/ReHU1ffu3xdS3OzzZdOyQsTLva3vdbVn3n7
	 ww05kBhow4FlT96LDDieHCSY4A9w3ucGA0CZdrYCbegHlPwi7p1nMRvwfbHrAFnUwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326382;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=UrALiXX2dmln3hXPe/mVeF9tc9D40BtgSnzu5p5cisg=;
	b=2FWlXLOs2I4RifFVmnRh9wHNTPZTXVot+n9Ns6oQ9NrpKHbx4MYhPfs68OA+Gx1Q4eGe
	 9mgKUsfI6s0lnuNNnEZ0kc72vy4+i1pWt3JkaMqESy4vbxvV8A2nRTR1oqgf8lrXccS1L
	 xNqTv2mn38Nd6u8enBA3ZkKbvgiQzqDdMLPy7F5lSnwBWqMxWKsxsL4/3/6o+2jlttYyz
	 8zc7Vvvil3m4YUwcijMjGlkbfqgiTmW9+yfn21z/wW5M7NfQeuL5XKFvQtpJWw3UpfMTW
	 v0SJPA/ABKQZmR/A9wkL12kczIFGrq9gxaCW58SRZ+9vuJbIYNAu/6xvr6BAivF3AQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZo7z39j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5160A260D
	for <linux-spi@vger.kernel.org>; Tue, 10 Nov 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZo7z39j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D611F008A6;
	Tue, 10 Nov 2026 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326381;
	bh=UrALiXX2dmln3hXPe/mVeF9tc9D40BtgSnzu5p5cisg=;
	h=Subject:From:Date:To;
	b=OZo7z39jGMIsAxDG9GBLgEX/+wKc+HE8jBZXMjUjizL4+uYuCVeoq7j3U2If+wNLq
	 MzdTM6iVdcrWRsFhrDLwD6QLTjjIyZA8nLWcsEIOXH62aIG4P0dVoEMLAnAzCe6m+D
	 DWV5EMxrFEi1ycgZ63+X3QMs0o+Kk2u4+jEPA/oEXU+0Pd77zuWymlip3r5KXFQVqF
	 NUIN/sXn5Ynf+U8+f6RRvZbbH0QDwZhRlsq+e496paJqu8C/Mt2uuHahu8eXLl3Ych
	 CIi/XTUC905Xx9PhKHhp+iw8LI6MEINoymxw3fgdWLEC/DPo+SI3x/NbzhtETLL6Ow
	 Ua+1WieVyVb0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B4B539D267B;
	Tue, 10 Nov 2026 15:59:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179432638009.4056072.1792629899345161674.git-patchwork-housekeeping@kernel.org>
Date: Tue, 10 Nov 2026 15:59:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: fix division by zero with a zero transfer speed (2026-11-10T15:34:50)
  Superseding: [v1] spi: fix division by zero with a zero transfer speed (2026-11-06T15:47:51):
    [1/5] spi: sifive: fix division by zero in clock divisor calculation
    [2/5] spi: bcm63xx-hsspi: fix division by zero for devices without a max speed
    [3/5] spi: bcmbca-hsspi: fix division by zero for devices without a max speed
    [4/5] spi: apple: fix division by zero in clock divisor calculation
    [5/5] spi: atmel: fix division by zero when transfer speed is zero

Checked 215 series in 4.76 seconds.
This project currently has 17005 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

