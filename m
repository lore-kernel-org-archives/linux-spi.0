Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D161A3164
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194273; cv=none; b=a489VIjItzIaVIoNzF/sSMyT8+VZtzzzsAWiO+J6+4+q35ErP+OnBmTznbzYHydShoKdoBLeOuTFYUuzSjXODswdzkzVF7O6yioleNOprE6p29KUHE+4ZTMN29UB8yxPP1Q8msD3jtVPAtH/4u/hJDGfFEfiImqUgnhD/q3s2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194273; c=relaxed/simple;
	bh=8WyFUqwojyGofYanrszDKm+HxBhyIKE8BejCzM7tN3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IMwK6WpzWg2VW20oIsDW6XgjtFbgFS3W6GWmyhB0441noU6MRzkC2ABZAcCQwRvEo9nyJtOr7OwUBsdIbndzbEcjqeSKMfvZMtSctYcinBQlk2JUXBWIF57BSQkKF12kPVizyqVhqPpg53TcoOxguAym60bKG6fRFbFGV9bxpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKG96ZWJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKG96ZWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A95C19423;
	Wed, 11 Mar 2026 01:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194272;
	bh=8WyFUqwojyGofYanrszDKm+HxBhyIKE8BejCzM7tN3E=;
	h=Subject:From:Date:To:From;
	b=qKG96ZWJNoiNdp5mM7IZyLRLskajRfVfRMMHdgMMLxJi5ynivTvKND7zGREmGO5dN
	 Fz562J+5ckgpOOZbD/mgoIk4GcQZJkNj2NUJg70BH9f2q4g/hdSlBmBVGAtuR+24cx
	 pRm7Qv6dsH2pEPY1NGxTH++mUo3i/avbNj9rLdxY3UT1l6o+Bd3AoJfBsScYbygwjQ
	 b9OVkC7ZRluZvudgtAT2+lXbgf7XjHAsYA+FZXw1H4hgEgHcgs+iF6cn5fL2WXp9Kl
	 fwK24bs/GSoh3M9fxBiHW3WtFIywCywOH9lCNrCRUNfm57jZzPNUn2bhNAK2lmBUYJ
	 M5qrrUcPGbQig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D05E3808200;
	Wed, 11 Mar 2026 01:57:50 +0000 (UTC)
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
 <177319426903.2999129.14352483843270856815.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Mar 2026 01:57:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-11T01:51:27)
  Superseding: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-05T07:15:42):
    spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

