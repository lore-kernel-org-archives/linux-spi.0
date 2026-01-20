Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466147B425
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937450; cv=none; b=OOeF8Fe6fVINtdOfJP3RB1wSCVtbTeaCTr7NuzchforzWtwds7b0ryKfeAhqzpHM6SRJFgy4jmWYcL4H6F3q54gdY06twJmU9Nf0ieG5XppWxKYUIWLWmmB5el9qTlzQo2hp24Q7cIqJkH5NR0XvXoHKz92f8b1D086iDaY23lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937450; c=relaxed/simple;
	bh=SGhyWsQ8Te5q5ZFN5AXZxCVAaz400EScv/7+l0PW6+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I+vlWpF5G7oueBhfgHzZN8OrYMuWcoNxK9HQJ02cNAnOwNvjQozA0G675/tiOtdEkh/e3n4G90W0Eua5tgC8fC0h08XKH3W4uKGM1fvvLorbr4rwc1/PJ7+zNUAW0Qkxc5hMBrQ/EoZzV+fZNCMfij9nZI4GjjXougMXrpDn5Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrWxJLda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrWxJLda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A46C16AAE;
	Tue, 20 Jan 2026 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768937450;
	bh=SGhyWsQ8Te5q5ZFN5AXZxCVAaz400EScv/7+l0PW6+o=;
	h=Subject:From:Date:To:From;
	b=ZrWxJLdal0fUcTRPHIK0asD8ElFfam+oeMM38pdaVZVtVuPPtRO2udOzd81/8P1HK
	 /LEKhSRHA+z0lcGwDS6E7Eb/gyY+aGwdFlXcfNSXbH4gqHwbEKXO1mV26FczpxfqLz
	 pEyzayoZO2U6nrSWIB6EF/HWHo93UinHe6WVlRa908oTiW7DeND9bXNz7ri775O9+A
	 mu/zbcRscv+tZhrVAzMI1BoRuWX15PNVL6ylKZ8qNPhwrRFZy0JBKYoL7b9BFQYwsO
	 lAunCfvqFbHsDbjPbnhbo/UtgQERtmkYpqdIqDNsr9Q44khuy55bVWuGceHk08mrr6
	 WVtN+pgAIgZdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2556380820D;
	Tue, 20 Jan 2026 19:30:48 +0000 (UTC)
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
 <176893744778.579155.17816125611344129033.git-patchwork-summary@kernel.org>
Date: Tue, 20 Jan 2026 19:30:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Make SPI core to take care of fwnode assignment
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1041419
  Lore link: https://lore.kernel.org/r/20260112203534.4186261-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/4] spi: Propagate default fwnode to the SPI controller device
             [v2,2/4] spi: Drop duplicate of_node assignment
             [v2,3/4] spi: Drop duplicate fwnode assignment
             [v2,4/4] spi: Drop duplicate device_set_node() call

Series: [1/3] spi: xilinx: use device property accessors.
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043555
  Lore link: https://lore.kernel.org/r/20260116233535.260114-1-abdurrahman@nexthop.ai
    Patches: [1/3] spi: xilinx: use device property accessors.
             [2/3] spi: xilinx: make irq optional

Series: spi: xilinx: make it work on non-OF platforms
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043574
  Lore link: https://lore.kernel.org/r/20260117012136.265220-1-abdurrahman@nexthop.ai
    Patches: [v2,1/3] spi: xilinx: use device property accessors.
             [v2,2/3] spi: xilinx: make irq optional
             [v2,3/3] spi: dt-bindings: xilinx: make interrupts optional

Series: spi: xilinx: switch to device properties and make IRQs optional
  Submitter: Abdurrahman Hussain <abdurrahman@nexthop.ai>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1043946
  Lore link: https://lore.kernel.org/r/20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai
    Patches: [v3,1/3] spi: dt-bindings: xilinx: make interrupts optional
             [v3,2/3] spi: xilinx: make irq optional


Total patches: 11

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


