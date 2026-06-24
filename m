Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7233BD22F
	for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2026 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782317391; cv=none; b=V33Sl/vkpNeCL7nRrkgRv65+4jf0fe/jI7WXZy64P+wha1MNV7OhaAISNQ18qJYj8o0EZFfL9AjilpczQdI5WMDq3EivoH3I/8eiNFAPQQ5fX78aUYtsGlujqZAEE/8JKY75QJf5TGNlYQ1nwBNPu+oLWXE+voK5lfmNZ9KrnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782317391; c=relaxed/simple;
	bh=iVkFsBL9vrOwEqKNae07UGfwUiLnNnbGmDosfb1rdDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LDdpvxhPWV+UECcv8U4BXcKhEbJmri6noGZTqWsYY/ZLrFUkMqbCBSSAijNWMk5YgHQFc2cVdeR1NdGAl56nHWfaC1mq9aPZpwS4kKsU1RNxS/eppRfBxzmq+HrafjMV5/Uag7fhJqXSTIuS2Cwl1f1OKYkZvQBjUnY+rTIqIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdNeyHAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdNeyHAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A715C1F000E9;
	Wed, 24 Jun 2026 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782317390;
	bh=3TMwMcR/rf3jL1YObiReVzl3L3Yw06/Ui/cP7g/4xkY=;
	h=Subject:From:Date:To;
	b=TdNeyHAyS7RxwOQ/9Wwi1UevskGmvEnHrMWQMVzf2/FbvRkA6RQRLt6rpQ8UQu4It
	 qPGf/ZHxlCro8WXVLKVUZMFbu03mCb3Ov0ZhI8TSWTYm0+22n/7Vfllb4F+LdcPcwu
	 dCH7Y27nAHmCRn0X9LB2w5ADv1bIHxXwrYAu2Gna2I7dAqUTuPyAHinoMJR1HUrNY3
	 Rk/91qhRlL3BbFgKr5IKurNPLNcDQkYr5GXdwoLjCXZF7Z3SrLiS5EeXgmvOqzmuab
	 3Kv5BSv5q3IUIrdjuKoslg/+LrUeFTARS4u/K+sgecEW/PHxzuB/Py8WLy6SwbNgmh
	 8tFVDpTw/+I6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A763A78A7D;
	Wed, 24 Jun 2026 16:09:40 +0000 (UTC)
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
 <178231737910.2856583.2152917280947964114.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Jun 2026 16:09:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: imx: reconfigure for PIO when DMA cannot be started (2026-06-24T15:19:58)
  Superseding: [v1] spi: imx: reconfigure for PIO when DMA cannot be started (2026-06-23T15:32:39):
    spi: imx: reconfigure for PIO when DMA cannot be started


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

