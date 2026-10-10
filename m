Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34692E03EA
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791665910; cv=none; b=tJo0BjbsmxUE3vflB+MBRtFF7qw83tOsMf+mBm1/WWf1ndmXcqsAQqIkXnkp+0eIcT7XnTG6OpF1Ah3YPverVbvqCoe3ATChfeXNejW0GlYJKITvXZoZ5oX3RyGiEOeZ7bfkUIlFHkPJ8S/11/cor2tPI3vnIRnJ4xKpzZpiuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791665910; c=relaxed/simple;
	bh=pK1TdfajqzUdTzZnS8mO1ymqCFWGMTzeDNPPtXcVYuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=B8DSoyF687kMY+bsUzZGSqZxEGe3tM+mdS0V4I5UX8IsEtyhoILjOpOZCBPWUygm7H652Zqwd5lf/UrNY+A1fUDIHZ9ljeeN2gRBkBme+kwEryCrTiBzGgGSU7krMGTibX0z6cgqaFHKgYYxNWuoyIYPRTggnS1tApqoHwS7VJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFeXc5Qd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFeXc5Qd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EA01F000FF;
	Sat, 10 Oct 2026 20:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791665909;
	bh=8aVHMEKgQ970EVGMH0rvNBJOPBsWCM36aVauolPZ7J8=;
	h=Subject:From:Date:To;
	b=bFeXc5Qdd8bapowzGbWOtcRLw9YMoHuMD/4l0dpaKTpUp4v9fbIgnRzTxVSq8ZOpN
	 CZt3xcOfPPR2uVtyRqSjot9X2nn8O5P0+1Okdhp0QfGp29XhXEjIHdzqBSKS+dOCE7
	 hPIi3i7dVZiMzIncHs4eomBBCl4PdToORyosNB1QTV88dKDNVW9fIfjYbt2hDKHgAW
	 LJhA/837FX0C/kOmJ2kkiDTvPP/vZhfuayzxKqOnUuFLBvtOpHBVx+WQ5k0SfyG3yR
	 bR1BMb6jMOzF6v3iepLhx1jM+zdTmZtNTc99qtW51hcsMj+UKI8z8fh0AmJtT51Mwo
	 y8TjjX4KqoFfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F35833811957;
	Sat, 10 Oct 2026 20:58:28 +0000 (UTC)
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
 <179166590738.1828326.14184951819536624303.git-patchwork-housekeeping@kernel.org>
Date: Sat, 10 Oct 2026 20:58:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: tegra114: initialize native chip selects inactive (2026-10-10T19:54:05)
  Superseding: [v3] spi: tegra114: initialize native chip selects inactive (2026-08-26T00:05:17):
    [v3] spi: tegra114: initialize native chip selects inactive

Checked 202 series in 4.19 seconds.
This project currently has 16741 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

