Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81C2D3EEB
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785470367; cv=none; b=qUHu4Lwswv3WR7mAcGNNFdjjvqBQAj9e6sHJq7c3TpCTdEoqH+qh/Kfqhb4s/XefDt8Tyv2LeD+VRMeIZ0Q3r1cAv6IWqTaIpj5uFb6RmXqVBW2w3wL4Fc88ZNTQ18IioR2n/Xoty5Gr87jvezjebzBW04t8Voiai1Zv48KSELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785470367; c=relaxed/simple;
	bh=zQyiEsiDYHZrZUifU7PBfVUvR+iUr3PAU3yRzpNFRgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b3lsg04EFNjhXYdA7i1d/ItrMxnHmhvNNmba+OIpWtfQxTIzbzW2YeeZ3xR1JbNxjsXpslpvwTAm7v1WrI2NIss5/VVDF2IgfyCdOUpQwoBTzhG0WCnADPBw3l/dHQsZ0I2NPss4meZp54F1wD5lw4m/zRXhY5hqxFHBwLj+Tzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPj06ewr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPj06ewr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64601F000E9;
	Fri, 31 Jul 2026 03:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785470365;
	bh=OLEvEVRxI9eOwOViPzj6C4jzFdoyQH7UXrYL/G893uc=;
	h=Subject:From:Date:To;
	b=YPj06ewrScE16YedGmbPMhTumYcEx1az2y/6Ic+LlScEpGw+8VO9UaO5tDVLJdZAF
	 EXu2dzHGMEQvV1PF/s+a1pbXyTaxCdpPRDgaMY2orRavp7U9OOAiGJtv3Xn69Z4yQX
	 jJ953feJ+20uqP1c9ptAbfJL25/EEcez+w7gtdRNvBUaGvLuGsEVDelBkDxkcbp/hA
	 AKhV3AVyTjhmXaw2NHM4G9TQaytfiWYUWhStYDBxDSj0lqqNs1+QMcES7c0fZByUKf
	 Q4WZE6S76GpG+MaaXvwLdW1DuUfzTFY8xmk7FxmTpJRrnv4i4OHn8ksBozDl+esGrw
	 nzLpKa3I0terA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A093924A48;
	Fri, 31 Jul 2026 03:58:50 +0000 (UTC)
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
 <178547032884.110505.15682894338951257780.git-patchwork-housekeeping@kernel.org>
Date: Fri, 31 Jul 2026 03:58:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: tegra114: initialize native chip selects inactive (2026-07-31T03:01:28)
  Superseding: [v1] spi: tegra114: initialize native chip selects inactive (2026-07-25T04:29:44):
    spi: tegra114: initialize native chip selects inactive


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

