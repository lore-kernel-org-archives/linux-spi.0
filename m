Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D52D9EF0
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772423821; cv=none; b=B39VZsj4lfO9b8i1UQu/MODcnEDp8TtRdNFESiXFK8bNyenR5a/XULEQLCgmwF1lQibsDsDiiN6k8OIuPWq/exvo8NtY86gKYuOM3Sp8TLtnKWcCgeJf7vurfY1g6/YdbDXLsDgNEq5ARvV0mONlZBcKkt/YuVwwEtmVxlhkuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772423821; c=relaxed/simple;
	bh=SsDB2egv2HljMCl4NiQaWlG+noRPbVTvrnFINw0hAFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=biG7I5baFBReteAkCbiAqYl2ha8SS+8QbP2zDG+Kt2o/VpZp3R7WmK7ZZIIOEXL9MLBaczKtjXSqucOtOpCv/vTEZ3GFfQQUSiRRXUdmsaAr5wLtpyVj5nKnhTqGe57x7kZL/TuoEk+NtWUoKQ6VZkYbnjf2YlMRQysMD06oyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSvrW3/W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSvrW3/W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AD1C19423;
	Mon,  2 Mar 2026 03:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772423821;
	bh=SsDB2egv2HljMCl4NiQaWlG+noRPbVTvrnFINw0hAFw=;
	h=Subject:From:Date:To:From;
	b=nSvrW3/W2XGDZ+Lifan5fH/MO+uLhqHHt84RY14Mby3v4zl4v+ZCpedIF+90yI3Me
	 UXa3HqgQW25RhehmVlIsjXRosxKjFPm34OJoqSCWlGcYSxPBM6SRKgRC6uqh4Pzs8x
	 sjf7s008UzfpT11XAN+CM5wOA9J0LfLr5hKnlg0k6Zy7iczddTYCPld9JK8x+2wImG
	 s/M/AkQZBItoywSaBUHmvcUQzdGVB6qNVlIaAi49Rge/1/R99jkHfzA47L4lARN0+6
	 MrIz7XWDao3ygkSkMWHD98Krcd6iZdFcT6JUc65q/oGUvp2sXaMLm7GszezlLnpoYB
	 NORVeGy24l9OQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFE439308D0;
	Mon,  2 Mar 2026 03:57:04 +0000 (UTC)
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
 <177242382306.3901302.3228541394126240582.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Mar 2026 03:57:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-03-02T03:10:15)
  Superseding: [v1] spi: cadence-quadspi: Implement refcount to handle unbind during busy (2026-02-25T08:02:39):
    [6.12.y] spi: cadence-quadspi: Implement refcount to handle unbind during busy


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

