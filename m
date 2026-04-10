Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04353C4559
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836696; cv=none; b=NTT+ldt+jQ0/DF64eD1T/cpoijka7S7G43IGxW6APcMyvWchkDLxnxRPzdwX/mYLpnJPSaAFpTi/2yBdkKK8l47a1EZKwor3kN90PiPod5DMv6B5MQYUIKPTvI2gAjsmi8vDRs9iQFaPOS7vh8rvrsYzvcA0GKZDzVd8IhYhjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836696; c=relaxed/simple;
	bh=DfdxmBD7LdpBOJRAbjmT3LPHVFczR/eSmc9hc9rN30M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fMtjAcs+k+mpWzqV/rMdEq8Tb8rlT/bPOwuE9rOQt5knIUK1bFaZ+DF8gK+m1PS0zulaD3EEk34q9JCKlkear1fDg/MR/8k03GorvP4ZQTWzTAEE1MYMZdgnrjPM1mDnrTZaxDVUy/cFWlzmfyUen+tNNBlvvqNIkHkfT26u9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpQn07pE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpQn07pE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A174C19421;
	Fri, 10 Apr 2026 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836696;
	bh=DfdxmBD7LdpBOJRAbjmT3LPHVFczR/eSmc9hc9rN30M=;
	h=Subject:From:Date:To:From;
	b=rpQn07pEF0cAbmrSZidcNK/yQ3Qw1MIUM6+/o4s1qlaz1lWAAdcfhqW6VDxvzBu1B
	 ZjCMYYEXkZg1xJDcLYbzV/ssbwD00InUwMw59wNZ4uMqkvShE+X58yM17y7bZjMEKm
	 qrwoKSrCdKu8F56BGt18KUwAd+UwFV4SPiF11Ledhz79opAk04oSfaJga1v+8xM2So
	 z42uuG0U4e1zHFSiHlvY7iI1rjr2BFpNkzzVAcuzHZOzSyyQrhkXeNhmCg/Yi9rZEh
	 w2Gak/ozAmgcGfSL+U6vwhw8ADrXrdgJNnppvaKHTMViB6rkrbX0VNs6QbKi7PffTi
	 SU8ncbeJkM2WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 057973809A87;
	Fri, 10 Apr 2026 15:57:52 +0000 (UTC)
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
 <177583667054.2532773.17846206143825889621.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Apr 2026 15:57:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: fix resource leaks on device setup failure (2026-04-10T15:49:05)
  Superseding: [v1] spi: fix resource leaks on device setup failure (2026-03-24T10:30:42):
    spi: fix resource leaks on device setup failure


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

