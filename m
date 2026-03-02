Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986BA3590A4
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467027; cv=none; b=fJokWo2yM66/4LpoOviOQF1c4lyFXTL5qIuVVrPFqQmD8z9iK/oDuQ1A4AGtZTppF5WS1zAgr7GLvAfbf4OieU/flDa8AONnL+UNi0QdCPGd6QnWwz8iSsxOMGpvhp0CABe0KQbs3R9s1K+k+Lku/Xx8LxCwOQ96vQPtZVs8S8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467027; c=relaxed/simple;
	bh=1ooGX4wvP+Gi5TerOwG6zQfX6M8k76+AsYIq5/aDBmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JQZBL3wPalq4cXynBG0Iywc7wQq+Y5xTgK3OBQHnZQojoQ/ZeOgvcPiI+B2QMZ0dC7LFKBfCMiuebHV0Eu2HgN1H9jfb+URIo6zJLGbGksXCaTXsH0uj1PPmo5RnZXYxMpdKSgSgOFLrF93UOoe971dMETKt83edkE+0rfkK57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH/fyru+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH/fyru+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A53DC19423;
	Mon,  2 Mar 2026 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772467027;
	bh=1ooGX4wvP+Gi5TerOwG6zQfX6M8k76+AsYIq5/aDBmM=;
	h=Subject:From:Date:To:From;
	b=lH/fyru+xlOkFXr0dm3cNY4YvBxD/DLp5Y0qCfmL9DxadmG5ysO6fT2Qux3nuZkkR
	 KUJD0KT5cwKeYy2IoOnb/+yggcvHyFWB1yhRxQvcw73nSRQNnreebrJ6zPRj+j/Wky
	 lgCzqXVh5oSq2pKuAQ1OeqYtZrMErBjcucoQdzd6fpH96vriqPPJEg1GBt3shPxPtO
	 22c6sNRiADmVpsab9lxvx7IpsTz2Gjz6xp98DDFDEc3upfwSffwcaVV5UILturo+1/
	 djvMf0tG9Q//FKFnzqRZdJyYJdxXLkxKabMppldPp/3hITF5hEVWJRVIicD9rQWLDG
	 aY5DGWPG7E0yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF05393089A;
	Mon,  2 Mar 2026 15:57:10 +0000 (UTC)
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
 <177246702874.374526.14545970111881994690.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Mar 2026 15:57:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND (2026-03-02T15:35:55)
  Superseding: [v1] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND (2026-02-27T17:51:54):
    [1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
    [2/3] arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ pins
    [3/3] arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

