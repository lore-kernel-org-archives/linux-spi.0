Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC725A2BC
	for <linux-spi@vger.kernel.org>; Thu, 24 Jul 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351081; cv=none; b=M/A2LHYD5Fy/c6vCtI6JgvXU/gmO6q/Zuh+3Rn1WyvhOJYm43nEu9CivnslUK7TuP6FofyPSbUjPs7h4Y7MmHq4ZxhAuBC7WgK8A0nIOtxiXTxvBJTfhuGCrW9M+GUJbRXUDaVfACF43jM+ntuuVaV3rZxp5SSg2CTcmQRI30U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351081; c=relaxed/simple;
	bh=CdbNzvMYf3jZDTDlxlXZOb2jSl2jBzvEM/7+j0B1Rl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mtVbRn+XapNni1yQLxA61y/2PUoMq6llzANVxew/6toxU8jTANvN0tWazbjWOCtlIQXAHCaztCfNF3I7I1IWSxNtkTrODLXG1GPJhyrAWSBim9dYzPi8XCVxJv+yagxGKiOpiml8xP2F4qOg4fu4niXsAfoZlteC/23mNy0yfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5uTaf6c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5uTaf6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF7BC4CEED;
	Thu, 24 Jul 2025 09:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351081;
	bh=CdbNzvMYf3jZDTDlxlXZOb2jSl2jBzvEM/7+j0B1Rl4=;
	h=Subject:From:Date:To:From;
	b=H5uTaf6cmTrQwDVhO/+GZvcX1gaOzsCs/ek1iQodHYL57+encAHTVBWHXvaaUoZm0
	 mQqlqOFzA+ETlJ97jSbuW4TIV2dt5RKYMiNEJ3MxyfQKlbBW/kSSVCaTDBdiOz9uPZ
	 5+xqJ8Q5AvaQ2EV7qlnBxmr1dc/IVmf/MWCnGT9m2g3M6oiMRIp0MCBlWll6Eej9ta
	 Wc8IgWBt3buX5EC0ipblItkvbCOppKQzoxZoS20yk6CA4O5kHpoE58q4LbC1EhiqzO
	 04mHyV+Lxz1fVWYw7wSMs/bMxj6Q2Y4LbELszFIwNGOOGKuRp1TNtk52mn1j3yWvoI
	 caW+szwle2QbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35A52383BF4E;
	Thu, 24 Jul 2025 09:58:20 +0000 (UTC)
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
 <175335109868.2328679.4537832399706638282.git-patchwork-housekeeping@kernel.org>
Date: Thu, 24 Jul 2025 09:58:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Virtio SPI Linux driver (2025-07-24T09:27:43)
  Superseding: [v5] Virtio SPI Linux driver (2025-06-20T04:12:27):
    [RFC,v5,1/3] virtio: Add ID for virtio SPI
    [RFC,v5,2/3] virtio-spi: Add virtio-spi.h
    [RFC,v5,3/3] SPI: Add virtio SPI driver.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

