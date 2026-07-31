Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B73D6CC1
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491957; cv=none; b=XpDdbA07qL+Dew47N8MR5THyYAtqwPwBU7AVye3k+YNTx/93oI3zL+w01RgwNuZ9VgqAAcvDQCoUhh/ibEiDctlBQivmxhe6sb+aBiX0FGJ5Hv8CBvtFc40OXbDnyiND1z9EyN0slKDANn5g2duNtqG0+veCQ82+i9bNcIP6xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491957; c=relaxed/simple;
	bh=SHWxTcUX8px8YY+lGOI+aNpgfUL8ZgX2HCblvSTy/xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nJnJjgWMOHljEFIp8tSORU6YRl2tqCjLD/G88hSLw9+Z3IXKPz3EivxHqogzHK6HK/vEGuTi02WWH2uxj/D9fJDaa4J+lTeNRfld6nPsZC3bjHZLmHdGqGaETOU9AXDKHeh1587Qi8bVmSHVJvYhHQ71eYhD3Dxjrep/DhgzU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnJlIn80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnJlIn80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C11F00A3A;
	Fri, 31 Jul 2026 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785491938;
	bh=+j9gaxwk074Y1ZwASNGnFdbaDkOJ7ExJzEkNewTRvvw=;
	h=Subject:From:Date:To;
	b=EnJlIn80rFXktJ0+scUlhe/uAv24sUWL1POqYi03JNJXHTxePU2jUldWzsMT6BmI/
	 kRHvRgBgmny5PxECGB4xU422whdKi8gtFiAgLATDbefkF9ZV4gegjjyM/U8xKLC+uh
	 LxEkJWb9WWeAo+tQrk80yXOcSOwUhdW7ddlz2C9/xFYeZO9hVRP7SYvO77BCSs8cLA
	 ez04FTA9aqnrhS/XPzRh+Z3+AK+5YDHOFG7h85jawnGHeIA2yprDFVwE0Lk5mXAhiJ
	 dFN/Fbb0eMViUTWCVkSeHgpDFfu4aysW1guw7J1fxETA4Tpcvit9vRKqW80fdEKwPk
	 LZTuCHbI6tw2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A3239253D7;
	Fri, 31 Jul 2026 09:58:22 +0000 (UTC)
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
 <178549190091.224253.2808817521026678571.git-patchwork-housekeeping@kernel.org>
Date: Fri, 31 Jul 2026 09:58:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add support for Amlogic A9 (2026-07-31T09:08:25)
  Superseding: [v2] spi: add support for Amlogic A9 (2026-07-23T06:43:41):
    [v2,1/4] spi: dt-bindings: amlogic: spisg: Document A9-specific properties
    [v2,2/4] spi: amlogic: spisg: Fix transfer size limit and timeout handling
    [v2,3/4] spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor
    [v2,4/4] spi: amlogic: spisg: Add support for A9 controller features


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

