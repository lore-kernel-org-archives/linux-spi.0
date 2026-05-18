Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729D330B32
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127024; cv=none; b=Q5Ay6vnLR+s8Geux9VvMHIa1TOMnYGDyRMbCfJxkIiSOb0foBGRJgTShe5oMQdp+n5OGwoWGACKGh+RxJufI76bR3jl0kOUMgOse5lYAJprLMSsrR0nUhAsWTchXuPTaRIHQgheMvW4eYJ1A88OdQJGYfIeZLOXeTP3Sg9PSK6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127024; c=relaxed/simple;
	bh=+6lTVc295yTrjXNwtpulisl4Iw46b5Q53Q4q9PcV4Gw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FfHrchZu5DWQwPTADlmrsrI8BDbktoUb352lL6Zsi6jy/nK4t2z85HKpbHPsQa50xZnQdOLJucQ9qHK/CZpBLG3RZVY8HdhOv6VTJSRUmWRF6Bb0gmy+p+IBGlnj9FZnZPxbvCAfLI7aXQ5wfDOO9TH6qTTkHuanbtFF6QJM4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK7itsw7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK7itsw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C4CC2BCF5;
	Mon, 18 May 2026 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779127024;
	bh=+6lTVc295yTrjXNwtpulisl4Iw46b5Q53Q4q9PcV4Gw=;
	h=Subject:From:Date:To:From;
	b=BK7itsw7a+L4+gYN0rTVdxJCoHNaMy0irCdHvF2nB2p/bFAxgByUVMyMk9dRrHtvM
	 sVVHF5cGgn2/mI/mWkWFk0LjXQgcbHeVtU4wjpM15RTfuZOGOfthVJtpzE5oqHdsTu
	 6w/tMm3NertfwjW2NUlaUZasn6nloZFpaVSCWzk4utUkjDxRcLGNOLgbej5SwqmNCM
	 V7S93fAuHkT049MbT+zt/o0jDxb+9HGm/6bDAHXouDVnN2q+xO7dmxysQzC4jCqtVe
	 6MDCsz22dkeIn8Doq+Q/7cAYWkdoUbBkhQ+f+WBdCA5oApjL6eq4qKJLv0etBkFnhS
	 oi028+Y3/OS0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A83930CA0;
	Mon, 18 May 2026 17:57:17 +0000 (UTC)
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
 <177912703571.1913639.14021884108157207386.git-patchwork-housekeeping@kernel.org>
Date: Mon, 18 May 2026 17:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add trace events for Qualcomm GENI SPI drivers (2026-05-18T17:00:51)
  Superseding: [v2] Add trace events for Qualcomm GENI SPI drivers (2026-05-12T06:12:51):
    [v2,1/2] spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
    [v2,2/2] spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

