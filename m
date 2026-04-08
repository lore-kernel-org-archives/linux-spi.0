Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321BB347517
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671832; cv=none; b=ug00UPWDYbwVDKdQjmRt005R2BvsEXYdoeQjvzOUyIqYEBSpllxyZwEXYfo6OQp7gFCec7ISCLF+D4yBOM2u8LeMtF5f/xk2jM1snVk4cW5Aq1f6nc//PRPmxEKeB+3hdv4BvOXVdi0TEAgt0WR7FLIF1isCAgMArv2pHFJPkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671832; c=relaxed/simple;
	bh=5uSsLb1fokpdPi3Ce6UDZ/nf7iT0rPqWp0dcCHXD/fo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=KZCmpVsXrGu+fEhxiNdWscFCVcFDmMNJvoCb4MxDl9qfoY1IF/pcP7Y1jGHB56CpSGJuHmF4nzM4ZBhIKZM8yxOSln0N3IoK550to+MNOzjG02tLEkOO4nIXF9B9lVYUsb8grESrZoYm8luXlTMSFDN5WU5aWV4rXaZ2bJuBTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InVvr1mw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InVvr1mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059D8C19421;
	Wed,  8 Apr 2026 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671832;
	bh=5uSsLb1fokpdPi3Ce6UDZ/nf7iT0rPqWp0dcCHXD/fo=;
	h=Subject:From:Date:To:From;
	b=InVvr1mwqoBrDra9jjSDxfsFylMS6oGVil9ZPM9djBAP3XirtmVwXFGlp5OHBzpe8
	 OZEKPWcPOC20+wK++TlqUbAMgdj2CSI/fUV7PlmgfCwT4w1dD5yo7n6thlqBALEag4
	 mLuXntEDCRn4ZhL3K8cYpF5ooBNhgKs4zd7R3ZMsZykoKqw5enH/n+I+3+An5+Fw/I
	 6EFStfBEeedlTheJb/Bzm4mPFWqbTFN+HEAckRaFceeWlzAxMqXlYlMwTBrWmREHR9
	 crJvxaJdVOw5U85rzGFW2NpE5izpEFPAQ6Bw2BqgOaMcu5ikVN7vnYw38OhJnrUDHe
	 fMV38cqp/lnRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC82539302FF;
	Wed,  8 Apr 2026 18:10:09 +0000 (UTC)
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
 <177567180837.789497.5343317140810314323.git-patchwork-summary@kernel.org>
Date: Wed, 08 Apr 2026 18:10:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add Renesas RZ/G3L RSPI support
  Submitter: Biju <biju.das.au@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1078544
  Lore link: https://lore.kernel.org/r/20260408085418.18770-1-biju.das.jz@bp.renesas.com
    Patches: [v4,1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
             [v4,2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

Patch: spi: pl022: enable compile testing
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1078537
  Lore link: https://lore.kernel.org/r/20260408084407.107416-1-johan@kernel.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


