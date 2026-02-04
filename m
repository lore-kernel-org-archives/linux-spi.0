Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95B31A568
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224240; cv=none; b=O3YwSa2+LxOPJNpe/pytVxMuC8v46vjtg9PVXbig+Av9OHzIV4SeqxxM//d4k6gxepSvIwANlikwmuCS7JYi/J6xRlNAf2o2C2oUulLX32u2KmwdfE4FpWGGKKaI4g8dwahiHds0o/JRf+XJumFaxges+oM3gm5o/tbXIe7GNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224240; c=relaxed/simple;
	bh=KVVwEayM5DHqRoF6Jd2kzIvlScOTLfLRzeejGhwXx1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=k/Pf87kwnpL9Jbqg8mWyoHuB7RzkXg2d9M3uIywSxzog7I5RbaIL825w80/jkWZGmXPxT2OSiogXVMKeEHvRIKD7VPN6y5KDfqaBEOMX8AHRWj8jFyJ+fLD6xeiZI1mG+wqGynVv8JBR8pxA0NJGjivXwkg1t38fZ6WH2oTwLGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWl/4nY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWl/4nY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A7EC4CEF7;
	Wed,  4 Feb 2026 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224239;
	bh=KVVwEayM5DHqRoF6Jd2kzIvlScOTLfLRzeejGhwXx1k=;
	h=Subject:From:Date:To:From;
	b=mWl/4nY+ASNFPgb/VBB7EiNwm24Xnf2Kn2FAJ/yFQtEAY0GxsB+/Ogh89F1pyu9nC
	 7DGxIXm4hOhR0ALTzXjHqMWBUuy2eBQGWuk2+wGNV65+nInE3qrm4/Rp6Z8cT8l3u2
	 xDzNEI6wZ6PFfWVjSfUCOi04Fnb/lymCWRBvtpdqLGdbiLfVSfkGMuydXshaW4nRsH
	 UGjq8dDYDWq+mjXZ54/9A5lJC0pIUz5YAW/rtYGMDHdAshWCdUsOeL1GBuvBKCSh1b
	 P5IQQkDqBSHVtRYqgALpAUOXq5uOCxbjkPlhRHYRnU5GC0ixGBX9aMMnKYbGQeEXlm
	 jcq94dk/W6KOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE10C3808200;
	Wed,  4 Feb 2026 16:57:16 +0000 (UTC)
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
 <177022423544.2821653.2349097073571745087.git-patchwork-housekeeping@kernel.org>
Date: Wed, 04 Feb 2026 16:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Improve SPI target mode support and error handling (2026-02-04T16:28:50)
  Superseding: [v1] Improve SPI target mode support and error handling (2026-01-22T15:10:05):
    [v1,1/3] spi: geni-qcom: Improve target mode allocation by using proper allocation functions
    [v1,2/3] spi: geni-qcom: Fix abort sequence execution for serial engine errors
    [v1,3/3] spi: geni-qcom: Add target abort support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

