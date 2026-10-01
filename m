Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010024D17AD
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848819; cv=none; b=Pq3DvkFkqeap9eYq1FglY0aa1w/HvKAfeswtHbG/oNlv/CD4bQwDxgttB9+f1k5731ou/vSTmuStrN741gpW6BW0/EqJ0vBVRbdY7Ux86CNZt/E8vqRViw6unFMPzO4Ddd/1KEfXm4n1619sO80kkY6c/CYZUWejHHVf0XnvIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848819; c=relaxed/simple;
	bh=dYkt419SuIA6IdlKH7QBi5wrV8p753A19kPoLGhVXeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=COLNADrjcMESkWOhAoDITmaW3TQtVJohjI//iDR6DGYmqYGY20wG0es7HkLKeExFeitwKpKXLu9LS6h2/EU4aGAyp7D423xaT0CPBpNlm3CuJnC6GrsfVVUDjFBJ8z+QfyOJp9O01+z+zUvIoz0xgPqdTHMuWMB+LAe14R2cCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZmh+Irv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZmh+Irv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FAD1F000FF;
	Thu,  1 Oct 2026 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790848816;
	bh=1+yGoeJQo3gGe8sKEbjgR8dhgKdipQwsNtVoUbyxV9I=;
	h=Subject:From:Date:To;
	b=QZmh+Irv8aWn9wnpScSbrO0hjmRaxfOSi8iPo1HrAfICdQJDpShrAN8W46hyh2DF+
	 SUgnFPdIX67uArvMCNhVBuf4xO7Xqdxhf94FpGiOWbOWhCIVqFxUPMifJ0ENavLQHw
	 TaomnXaF1cJj830a8PPmOTKpzKpUbR3ndv/vo6Pd29cn3adoSS0XBcVkLa3XcFbktx
	 NKoW2KxrmHjEIeoubAewVaOyZSBkvTQboO7c2XkGFQeMlglfTDD+pMQsQ3boPZfB63
	 67nARtbiah5lEhPWjfdUPT2OmCBLmy4pWdFTwuk6w/Bna3n3tBaga4JpvQ0X04G9hZ
	 eYsGnCshZjREw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77573380DBDA;
	Thu,  1 Oct 2026 10:00:16 +0000 (UTC)
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
 <179084881503.2368407.16562520139045647615.git-patchwork-housekeeping@kernel.org>
Date: Thu, 01 Oct 2026 10:00:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260 (2026-10-01T08:58:30)
  Superseding: [v1] spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260 (2026-09-19T13:47:30):
    spi: cs42l43: Workaround for wrong speaker ID on Dell XPS 13 DX13260

Checked 185 series in 4.04 seconds.
This project currently has 16673 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

