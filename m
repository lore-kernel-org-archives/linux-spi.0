Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231412BE639
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207012; cv=none; b=gtzWVDLZoctoQSPqZXve56nFLng8E6nNo8sp4oXnNmjTRDld4Bkm1Yp3dY/UDyyxBN/tE3RSOtFKDQh55ndD9Pd6YiFyq3PDAD4XZHVjAWh3TkUhYRTDlTlHHNVkY53QZz46wH+LejbZu8zRL/gK2moBbubSgSLXzFFLn+Zo52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207012; c=relaxed/simple;
	bh=cS/NI687MmaSvGKGqvY7cvEPM/RXH3nr46FT+A3L+Co=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pQxWtbIA6k/RQdNebcP0ET0Xw0J3/07+wVw/Ib3XyzzKHnUVep5oQ6sLXkTzG7bcyHTOw3/44Da+hp7ao+1a4GZctMcBldPTCMszv+HkWLRU3l0CA4KAR7q4kgbU2y+nsiT5a3oeVYEaI6R1vB4ec+pN2nOMZawgW2iU+v3s7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxgtCH53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxgtCH53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB61C4CEF7;
	Wed,  4 Feb 2026 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770207011;
	bh=cS/NI687MmaSvGKGqvY7cvEPM/RXH3nr46FT+A3L+Co=;
	h=Subject:From:Date:To:From;
	b=pxgtCH53jlUgjyiP7xgyKP20K4mVPab0GUXCiXLxTWbF8rpHg4UZzkW9PEFKpZjAq
	 KiaglIMXe28Z0Mwp7/vW2BP9uIqdzIoo5iw8GoQOjfg3gbTSGS46LdoAz9XFGkb9KX
	 WaVx1eUP15/A4PkLO023rLprqh1bbG3JDVucJ9MMye8RqNapEpzPkW5ovMdpUpAO5D
	 06ZhYWY9hypYbguFzjobXLTfcssHx7ed7CMnfj05aYWat/bHCe4aa1hXhow8YKj1pj
	 XIPZX4Zb8REBAPkMUzXazwY1btGuFF8d8Alcf+J2SBY/2xIN/sNJg7o6OU5klSQ+Sc
	 +DQK48AeOrCDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B1D3808200;
	Wed,  4 Feb 2026 12:10:08 +0000 (UTC)
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
 <177020700733.2316570.8280060949120470599.git-patchwork-summary@kernel.org>
Date: Wed, 04 Feb 2026 12:10:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: xilinx: make it work on non-OF platforms
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043574
  Lore link: https://lore.kernel.org/r/20260117012136.265220-1-abdurrahman@nexthop.ai
    Patches: [v2,1/3] spi: xilinx: use device property accessors.

Series: spi: xilinx: switch to device properties and make IRQs optional
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043946
  Lore link: https://lore.kernel.org/r/20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai
    Patches: [v3,1/3] spi: dt-bindings: xilinx: make interrupts optional
             [v3,3/3] spi: xilinx: use device property accessors.

Patch: [v4] spi: xilinx: use device property accessors.
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1050017
  Lore link: https://lore.kernel.org/r/20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


