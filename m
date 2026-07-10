Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977734B68C
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709930; cv=none; b=UyRUyKdv8Gz2UGnm73+3rXBEfN9Ac7BnmWwM8xa1/JAzlXl8maD8WdzrbNcexafMc3QLCu0l65mJge0gpUmCcpLsX6ZA9sSLhmOjg6wVAWfcAJksZL0rTrXgE2rpydfCY73bq3dHIVWxtX3Escucur6VhW21YryaXQbGcJ5NkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709930; c=relaxed/simple;
	bh=MUC0wNlJEx05bB0ix6vpLtUfoUscw7cW5sZDw2WekDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sdy8ImBqHSK+g6x1FEB17K2QlBlatHLQy7qQRC87Jsf+nbUcp+YXcQmSKueiXGiU4tewYgfCpAs3ESG7LqDlF+vErGwTyTJccD3Ut10Pq0/TJ8h5yUJ/lxwPU1oe2WirDmZfF4blRGoOA0Xqr0rseDvLww2Xg1JmQ7rWboHwbQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRkNN+Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRkNN+Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9209E1F000E9;
	Fri, 10 Jul 2026 18:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783709929;
	bh=7Zrwhf7B0KSZYUlmK4FfbwgYw/naW89KZkXYV4wXuYs=;
	h=Subject:From:Date:To;
	b=TRkNN+Ghva/MyUnlXrlVpnIB+XvjZuHItc2Mv1MREwv8AmGmUhr89MficGCuFdJ4z
	 ES4KP1O/zoXUg6tF0ufLgr5/U8/Udq0JQrMA4EQY5Kkycc18UfzqtJcTQfycfwgod5
	 zy/YoC6eoqfg6t0Aj7u7JHAPd8T1N7eRg0b9VLBaebvtlrvAdQ4oCxIOK5PPSKuHT6
	 FHWT9rlQlIlf4xY6EVzOP6ovxqkKjI4HiA5A1ngfpGNX7tzDvifXnTxlJH+tEeFLJo
	 BiqHgHbBF/+fOanysaKs925qD46XL6fHoq4Fe42pD9VafBZsgCuWnxDVX5mAKH9Znu
	 oXW7/c1Kr/ZCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7759F3924980;
	Fri, 10 Jul 2026 18:58:28 +0000 (UTC)
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
 <178370990706.814832.8954818790006851388.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Jul 2026 18:58:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add trace event support for GENI SE registers dump (2026-07-10T18:48:40)
  Superseding: [v1] Add trace event support for GENI SE registers dump (2026-07-06T11:08:11):
    [1/2] soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
    [2/2] spi: qcom-geni: add GENI SE registers trace event on error paths


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

