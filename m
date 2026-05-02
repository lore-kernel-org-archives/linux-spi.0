Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF81322522
	for <linux-spi@vger.kernel.org>; Sat,  2 May 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777730314; cv=none; b=o2UlrVsa1g8Nw2wDx2Hoe4wXIBUbnSwjvgnkHoIvDUzM0n0Pca4fX7yS5e0aq9djwtnhj8qZnzObMgiAFfwsUP62LaDmuT4uNlIvOQVIQk4g4UbPuZrlw2ZbypgJsQaHwjws1SLnV4loI5LMWTddKB2BGaRQCZzX481rQJUr39k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777730314; c=relaxed/simple;
	bh=KMYop4/dvNfcAYhByeGk4jymjzWzXhbwFAZr/MIzG5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JIL5Rod+byzaCutj+61DlhKVCIz8XRXC4bNU5A7oZZZ0ZQZQIGTImjkUpJe/1L+gE9mA2v4OivyRDVqgLIG8fkrb3naa2UnSxTEsCvB+umTUnXQeYBCOo27yNAjGbouAumEJqA3N+aeBx+CqKU8lroHyxHz9/eGsiPCM/rHBVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJCRywE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJCRywE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B9AC19425;
	Sat,  2 May 2026 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777730313;
	bh=KMYop4/dvNfcAYhByeGk4jymjzWzXhbwFAZr/MIzG5E=;
	h=Subject:From:Date:To:From;
	b=XJCRywE347h+SUjolL5UWHcAhVWEiCSXFgNWJDMdfbzudlngpfW8czTi+ZgECrLDW
	 Qg2V60rsV19m/ZDT7MKPcDszYjWJhmXxSdGzAfVViy6EJjxLbnP+3gK88da1p8qlz1
	 N184gFRsCys1Q5JexDD4OuiO/od7Z+P2E2f6WQoQuoYI5lEs9hZz0aZcdAq6fBCw5O
	 LhzeAjiSQ3egyjafOeQ2irXmDy6VDGcEKVD5PLdQb079JvrL9ExPZCP7xIkUJElxKk
	 daLQk1cZMYwYhDw0XNl8SqvaurZN04IK64fLO5yZwwbN4Zw0eU+dF4qv20XsTADGC9
	 L3ow05JY1Hklw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFF4380CEFC;
	Sat,  2 May 2026 13:57:47 +0000 (UTC)
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
 <177773026584.3844179.13526339128489674552.git-patchwork-housekeeping@kernel.org>
Date: Sat, 02 May 2026 13:57:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] spi: support the SpacemiT K1 SPI controller (2026-05-03T01:30:50)
  Superseding: [v9] spi: support the SpacemiT K1 SPI controller (2026-04-28T02:01:26):
    [v9,1/3] spi: dt-bindings: add SpacemiT K1 SPI support
    [v9,2/3] spi: spacemit: introduce SpacemiT K1 SPI controller driver
    [v9,3/3] riscv: dts: spacemit: define a SPI controller node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

