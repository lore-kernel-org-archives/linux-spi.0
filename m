Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC652E8B98
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605810; cv=none; b=uuVrBDARu1SSoQ+vjfmF4kEBPudLl1p78/HgsoODygm6TXsgFEutfsVGgR8JNlnuztWKpr70txXTSZUeGTI7gYmiYGZQOlPkyW5J0EcKHGBeI6W84EazYHEnCO7l9QWoR/4B9eQBDytG4ZyNu6oH/0+Zq+wbx3IgRTA1uUMlJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605810; c=relaxed/simple;
	bh=4JDqPYSYIn1CHgiRtJUq5K8aM+FouU8dj12w9O9G55U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pVZKN7NdeL9h0PPjj6Zb6txSe/lmcyKq4w5RokJpnvTXjbdDDjV6Mzx4pcJhnHrFcJtrIez4SlW5LI/kTV/kvLpp8qhZhBtyb9cWT291BcsjLYt2HkyHcXnRojlWSuni/Cb2BtDw0rBjCundgasmaSoP4l20SZOxtdn5DPxA3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqeZ5/L8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqeZ5/L8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF55C4CEF1;
	Wed, 28 Jan 2026 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769605809;
	bh=4JDqPYSYIn1CHgiRtJUq5K8aM+FouU8dj12w9O9G55U=;
	h=Subject:From:Date:To:From;
	b=eqeZ5/L8l7mRZLz0r1TfEJl9BLQF2iw15lTgOC1MWOdB1e8la9pBbRIPl7ikDpZHN
	 yyWOI1pfIbL33K62hU9SuLvucGyRWXoqdEuTNhLDT6C1K/OCvlCx+9zXSG0z29EkPJ
	 Qqk3G3d4NAzrPCectlUHyS2fX40NCEFvbGpmG0XN9ryp4GAFhI3qk1UaKjpT4GnOav
	 dkXJymS3ct1/iLDCoi2Ve97cKEcttDg9cNU3Ckn7KJtA14oPHgEo8V6yAhl19ko2f7
	 djk3FZScTVi7EpyWmDZVOiVeQndUj0lBNHV7suNP9suphg9oDzLw261m0JlfHtUGAJ
	 o8DdbwN+GXY8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5141C39D2F41;
	Wed, 28 Jan 2026 13:10:04 +0000 (UTC)
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
 <176960580294.1668219.15910538263114539138.git-patchwork-summary@kernel.org>
Date: Wed, 28 Jan 2026 13:10:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: aspeed: Improve handling of shared SPI controllers
  Submitter: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1044614
  Lore link: https://lore.kernel.org/r/20260120123005.1392071-1-chin-ting_kuo@aspeedtech.com
    Patches: [v3,1/2] spi: spi-mem: Protect dirmap_create() with spi_mem_access_start/end
             [v3,2/2] spi: aspeed: Add support for non-spi-mem devices


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


