Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813B63AB496
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171869; cv=none; b=cApr5goASEhv3GMT6Dl6Gspg++H6xvxexnHXT0umUDk3J0xVXxVAIz+yzjwKqjbFad9gY3PPUm1HFRvUEYq6+SoRGYjoqcds9hL+VRPnLbpKQmgMaMDYOnz1jubMJzfbYheFnE4SSTkWxfGoxykyPZsdt8tgYg3Rs227iCdG70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171869; c=relaxed/simple;
	bh=MUQ6WGd85KSTSCcmB44gpxFDubfbkMKH35urFJ1gBdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FE1ECQz0VcJiE4FKqgR+Rrh7YvtdXVhOnkvYlkPZicurnucatM1OdbRMDGObEexRCE5I0sfQrUiL23qBfsych25i34wdP1alTcXrtCS/JYIRlZfeVae/B25lLm7+4mCHpPg63cwxH9ftZk0uDYSgvg1CRoWxYFM4vCRAI8qY1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPcO16v3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPcO16v3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADAA1F00893;
	Thu, 11 Jun 2026 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781171868;
	bh=65jNMMpdguC9bBJuyYMVlwDo2UsLZ3pJTsDG9ymBc4Y=;
	h=Subject:From:Date:To;
	b=NPcO16v3Fqp5eFtbXHroBw1lJyCGG5GAhGvboqPQDIUIdTZxKPeohZ6FXhTIgX9NV
	 F1nQ7hvYyLZUbSvZ5+AW3CWjNRSBFxUQpWHBZWBVHat3+G/YTkVsxH3EvHZ1hvSGvP
	 vB7ElF+KPJJDkSemIY1onTyk15YfIDFfu8vZxsto5uS59DTP5KP2YxvbkiV73YX9fH
	 DJOHcjqoCFOKUAn+/9GIRX39leQKLZb5hzUQwBXIUrVN4zs3HmeJM4/osNSN9R4aL9
	 rvkJeBE5ZtqNvzWksBIQIK2aRHdmg0ZrjjPMtKt9vtEaP00Ti/sH3K2tnrlfeBZMgH
	 AMRQ6eMT5TtRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A413930E3C;
	Thu, 11 Jun 2026 09:57:46 +0000 (UTC)
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
 <178117186556.3868768.1624626406417487784.git-patchwork-housekeeping@kernel.org>
Date: Thu, 11 Jun 2026 09:57:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-06-11T09:12:44)
  Superseding: [v2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller (2026-06-08T02:50:07):
    [v2,1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
    [v2,2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

