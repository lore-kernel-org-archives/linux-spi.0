Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CF4418A43
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873424; cv=none; b=C7PxXxr5dfgl3hbYou/xnLbp08Kz0yOrAQkCQTjrlwZGChNoKkVcC1dWnhQPvTNGlv4j5PA3A2h2ozcLuWFEuzFBrnNWjCcDUmJRMBm/MdCl5AO8PiZArHC0xjJ7q1X0jmu7dPh/5QZVT9VktT7plXB6sSSnwu9NV0fhIeuE2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873424; c=relaxed/simple;
	bh=ELkKlb2uGwlptdGWhJapy+2399oST6LUdG6e11zSle4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uwmbcEO953aXvuvw1uUcLkqBOF8dVwM6STqyy/Dnn34hFNc4xVRcBFQcZMlT6exD1XIT/B/25liYMwrwm56TCaBzmXWgIaWwZpKxLRikN5H9DBCuVLEJ3XHkThJMlxu0cpXUejo+nWZIbdQ6beMVx5c3K9X3Miwi6k/T+n7kNqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlwvgY1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlwvgY1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED51F000FF;
	Thu,  1 Oct 2026 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873422;
	bh=uQPb9m/8nJ5miWFF2MUebGE+o/PNIb532Do2UDj5ZD0=;
	h=Subject:From:Date:To;
	b=UlwvgY1D1AsDE8g+YUwm3PBciD6UWCoCyRHDsQMBOMYU94rX8pux9vQc32ijYPv3u
	 V03SLZXZVlivACHEB/FNru7H3rglzz4l0jXa+e4jJ3NIOJmPZmok7e+F8jA67gDkIX
	 Jm7P1FjPThFhu6VPf/HQ3G8fRY/74ccuCvKs+QzBbQLzc1Q4bGrceEuJUURvCoyi3U
	 rv/eSo+1gUqsHEwfOj5K1R9nIVwy40zzrIAw6bcyB+g3zHHCRKrzeMmBuzyeKzKwJx
	 NRF02EtamRt2yGG0gsQ9WQxfZvAZUnkeT5lpvR3rZVBQJ0ph+u+tcbCp+BigpuidSH
	 ltj/dQjTHLfxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AAD0A3811960;
	Thu,  1 Oct 2026 16:50:22 +0000 (UTC)
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
 <179087342154.3011010.12657064442093655525.git-patchwork-summary@kernel.org>
Date: Thu, 01 Oct 2026 16:50:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: sophgo: Fix SPI NOR errors and clock limits
  Submitter: Han Gao <gaohan@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1177158/
  Lore link: https://lore.kernel.org/r/20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn
    Patches: [v2,1/4] spi: sg2044-nor: Return transfer errors
             [v2,2/4] spi: sg2044-nor: Honor SPI clock limits


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


