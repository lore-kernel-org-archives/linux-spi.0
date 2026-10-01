Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BF3A48E9
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790867407; cv=none; b=UD9Sr6+qmS1zLaMGSphrpPDf9ItQ/yzN/SCqdOPUGgBYtKaDOSbMjKqxe4a9DgDlxTFemOp3Pg2kgUUGra2JCqmfXC92add/PqBqOmPijkNqSS86D3rW8610OrhskaPh9YAZ0XG9HH5tnlBaIi/1ofTC4KPv0gvBQbcyG9YStbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790867407; c=relaxed/simple;
	bh=J2OEBnHX6giotc7Y1reTcdt86GbbfZQ2Y5DMERieCIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M8gtp6psm9Uru2FjYqK6uyMP2r98tZ57JJjVSlbrcIOgd13G/qOPtMDwEQqLY+iS/lOFIlZPU/YLp+3tPf8uhmQE3Rioo9QtaK9wkE25GLnkONFhcNBzwxbOZHHg+4uRAxeYTIdwalANWgpSG/Z05V4OveHvZ6MtfaR05Tn3w10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckoEEzrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckoEEzrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9751F000FF;
	Thu,  1 Oct 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790867405;
	bh=FK0ComEbWA80VG3MlgFx6SmDDcH+YddAxDVHwtlqgDM=;
	h=Subject:From:Date:To;
	b=ckoEEzrDJluxo55soG8eO+sndD1qSUYmHAXDKjuTO2GEpr181XadHeBn9QOncKDa3
	 zBq0r0pQKUvllvhYhoiHGhZBjQ3uRzbqow5aa2+TKBfNWePUMD8EyL8Qb0meEmV2my
	 F8Ox0z8g4LAX9Q2Ap+gIwUHeg5jZFyzz6kGf4x6XOgZhOnwTDnX6tS3uuFml99Co7K
	 /aTkXn0kPYKLu1EnDiKjRPmdRmbJh3t8w7ns6WZ+z1ZJVL6zyTSwwRycCmxeVPclQw
	 dRzVlJu3yQnJcRO/NXg+f66giOFaybuzGyBrC25ivukQz2T7kNtARMrNxTxydAvJqr
	 F4fSePiLS43jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6D7138111DF;
	Thu,  1 Oct 2026 15:10:05 +0000 (UTC)
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
 <179086740433.2512207.12998356943410403707.git-patchwork-summary@kernel.org>
Date: Thu, 01 Oct 2026 15:10:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v2,1/2] spi: use dmaengine public API instead of raw ops
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1176978/
  Lore link: https://lore.kernel.org/r/20260930140257.490019-1-Frank.Li@oss.nxp.com
    Patches: [v2,1/2] spi: use dmaengine public API instead of raw ops
             [v2,2/2] spi: use dmaengine_get_dma_device() instead of chan->device->dev


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


