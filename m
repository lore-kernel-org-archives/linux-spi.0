Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB62322A
	for <linux-spi@vger.kernel.org>; Sat, 16 May 2026 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778905203; cv=none; b=ILByAvu7VCuoFRkT0RseMwfbM4nY8beHhE7+ufuc498YvCSB3R69+rBzw5bYXQs0hG3w8wvJ+xKKACZBpLoq2oQzPDevZkh8Oyrnc7Q/L3Uwna666WEC9tCFzlNWj0zqtNrV9jxTzoc3qR78qfziSOrb19OP2v7w8XdooLsF2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778905203; c=relaxed/simple;
	bh=2xQnDdIhG+Rer8le3dBuIKrby4I3NIIdOPy2z8y3zAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b17wMU+tGs31ECP6GEbOeGNjeRW4O0cmzVZ41D0Tyu0nxvGwSjhXl452eMneGRSg0OkJrmhTc/nGrQG5wZCko5NA1XpvT7EnkphKuGrbHpkNJnWFDN8z9xj+nuIxaxmv6OlMBIr0fyLJwulytDpjF93M+aflpapH8aC6RVE0i8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRSOw5Nw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRSOw5Nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7F6C19425;
	Sat, 16 May 2026 04:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778905202;
	bh=2xQnDdIhG+Rer8le3dBuIKrby4I3NIIdOPy2z8y3zAA=;
	h=Subject:From:Date:To:From;
	b=VRSOw5Nw+16A/jGZIvk7Sv9l+GzDXuvTBvO+Z6gD6Qesb7qhgT2OspJaHazlTV9C8
	 HjPlJHsaMLS4s6qsxNMLc0CimxlwFf0sCdWGhcHl4/gNkMDjFrixLaSzXkwIhsTHu0
	 br6qtexZn/J8o8Hia6N3GdrdLmAdkT9R1STXwW4/07JQiTnPTtZaBQ8oBkeZySV3/v
	 7MMyS50PZTIP7ljnFIf3kE0P/TbrgLMvDzoqN3mkt/csezk1liTrykiIRTjSwQGop5
	 +yXbeUSIuv3zHi7593Rz5M9KKoIUSFOZ27t6hXFSlYArzy8JiRt/xnDKz+liwAOPRG
	 ohTerswOeiWwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3E233930A24;
	Sat, 16 May 2026 04:20:16 +0000 (UTC)
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
 <177890521528.256398.13424521276036283670.git-patchwork-summary@kernel.org>
Date: Sat, 16 May 2026 04:20:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1092084
  Lore link: https://lore.kernel.org/r/20260510-snfi-v1-1-bc375cf1af8e@gmail.com

Patch: spi: rspi: Simplify reset control handling
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1091078
  Lore link: https://lore.kernel.org/r/20260507-rspi-v1-1-8cfa47cd56aa@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


