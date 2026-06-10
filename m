Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2813F426699
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104807; cv=none; b=ZeW5YRzK8G4FLVOMnfRPhZwn7E0NPS6Nb9f3gDhiHRz5W+b71RSgsaE+tpcUjM2GtjAZeXfuBOnVsbiA2h24an2FWLtEESlBHLfkIUfOV9cxOf8i+z4/UJhiGhTtzdphSYCZe0zFa9vS91ISc7DzYpjF6J+6cU8u9vGI6o09jyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104807; c=relaxed/simple;
	bh=N/N95GJnKexRD/qNzkNRIqCz8HLZMcY5X8pHUCySfwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W9twQq6ZFUin1pqafzlsi7iamqW3+C2Nla5HHkDdHJY1x0Hiu9lHLJPtrl63ib7IwO3XSPRyET4YZqaOXccac5g8dUBdsoaqFxYZRuScSclpkUsKXzb3S4A3imp/ebE9ht5IFCCDYIIBPAw0rLFiDDj+NR0RHNVEAgyq8qsgpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBwQPNev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBwQPNev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8A51F00893;
	Wed, 10 Jun 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104805;
	bh=1gZTqNYr21xBDLzhO33kTVjQiE1SWKvlAm2lfguM9mY=;
	h=Subject:From:Date:To;
	b=hBwQPNev1eEy6dTg1SZS7jZ1TiUN4GZvX5hPvVJG2Pr4VdniVOqz5m7cYz5zGfyBV
	 pDRanVbJohk9BGy48/ulRqKB5dD2vskCbbJH7EN1LJyI0EmQJlxCBrlKF1bTp9Imaa
	 9igJC8rBOwKyBif11q8+/2p8VBD8Trld8JMxPD1GVWQwQbvZBLog1NFNxbK2wdJVd2
	 TKNErM8gb8epNLt/e7uwjhIx7zw/gLmL5vzFCTtLzSZUyqk/fBMX0u1yTOvXxOzR4y
	 dH8wJOZBU4jauDwix3zC4FCAL+qqlNKzGT8xyh5OQsyil75sI7bzZ+O+5ozmNWV9kC
	 YyNunmO/HA++A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D33563930D5F;
	Wed, 10 Jun 2026 15:20:04 +0000 (UTC)
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
 <178110480374.3089075.6928506451855104419.git-patchwork-summary@kernel.org>
Date: Wed, 10 Jun 2026 15:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Nuvoton NPCM FIU DTS fixes and binding conversion
  Submitter: Tomer Maimon <tmaimon77@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1109255
  Lore link: https://lore.kernel.org/r/20260610121822.2524634-1-tmaimon77@gmail.com
    Patches: [v5,1/3] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory reg-names
             [v5,3/3] spi: dt-bindings: nuvoton,npcm750-fiu: Convert to DT schema


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


