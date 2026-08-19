Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3572D7393
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 01:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104743; cv=none; b=isstF1BL2f2T5If8T6kuWM2TqCYDA3dFuuv0ufTUGawsLCGvbsn29TZnkq5n/gBQED94EPJ00F9Y8m+SLknW15FGeYEr2Yqs2nqbe4b9tB/kGT3y0lATtJfsta32ExVYVOcOETJVqQR0VY+PnR8uXlGpYJpivjIQm75rFkLkYu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104743; c=relaxed/simple;
	bh=s17LUnqYrMrSx7PvoTpwvucB11DrdNigVjltLQo3070=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mOWXzASeB0x4UgUSKtmuiuvAGMQmvbirRBerRRBwWKv8dOtQgWkib8AQooBXUQwzWIbmqYI2tdz7CqpEIAe2ysb8zJKwf32MoywfuSJTmYjiJ44tY5FqV3AXlC2kUCYjQ6F2VRnex0sjuS2fpGlRjA7A1oQwRtxFyMW8B0sZ/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzGOX0Uj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzGOX0Uj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCAE1F000E9;
	Wed, 19 Aug 2026 01:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787104742;
	bh=TgCg2KNr6fxr3wS4hLNPMzPm02m0XGM9PMVP+i/XdKE=;
	h=Subject:From:Date:To;
	b=RzGOX0Ujd1rykhI+OqRcLedyjF/3p3wzOU5jMzANbLwEi0XNTnoz8z04c04eunnPU
	 33Y4hLJTtW8mdTnt1snf4SR90JBGltYb+E6EhMujp3KI+qLQveNzEMhw0URsByhNZ9
	 mnXHwuZbkvj7EhDJ+DWxdpf4+HRZIV4hXewrOoB/u5e6kiL5loYqLrUz0npqQltA9r
	 zHEzG/QGdo9WfLxSnXRIQdvyEacaOpY0q4E6sZBeCNnGErNURf5wgqgbxYSSqZoLiz
	 38utPYRoMC/Exy7E6ICBxW6hok+92/SgSUbZSM0lkAuFsjsJskYb+G/P+HYnkD0SAD
	 dw2cS57jOXTTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961773927064;
	Wed, 19 Aug 2026 01:58:14 +0000 (UTC)
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
 <178710469331.2785413.566833037571092039.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Aug 2026 01:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: loongson: pm: add .freeze .poweroff .thaw .restore (2026-08-19T01:45:52)
  Superseding: [v1] spi: loongson: pm: add .freeze .poweroff .thaw .restore (2026-08-18T10:42:41):
    spi: loongson: pm: add .freeze .poweroff .thaw .restore

Checked 164 of 5335 series in 3.17 seconds.
This project currently has 24520 patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

