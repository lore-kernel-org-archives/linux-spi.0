Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AD3A2543
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555888; cv=none; b=kotLcurXr2YvFJBUSWmEKyEZ6j6juoHhl9SNuUKRjOQdDi5ec64rC1AcriuJOF1m8idk/tWP3WPSCljWsmyvd48SQzXQbzeNs5pkT4n0aornKc12P6gmkyterzMVIRNQv0izsnkbntTgkAoNLwCfWMmxchqiuF05imYRrmFDHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555888; c=relaxed/simple;
	bh=2+tu5B6cjkxSnFBA0xbd4tdWFbwDmt2gF62NHOwYLwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RY7Id3Ns/d3e1ZbL3fnBI9IvwKXwANTmyKdJ0LrP8CbBI7uGULYdIa6gt2Lg3LSleNcKA5LRj+9AW1N2G+7JSq1ETQj42vNwrKhSaEtabNWgxgo2Lbg/rdyMVPYaI1tO8+D9QB4jq3erRossMoqOdWZDts4fw7J0mXUFzKr/ZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn8vlCDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn8vlCDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A51C116C6;
	Tue,  7 Apr 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775555888;
	bh=2+tu5B6cjkxSnFBA0xbd4tdWFbwDmt2gF62NHOwYLwQ=;
	h=Subject:From:Date:To:From;
	b=Dn8vlCDDDAoJWZ3YboF8fDqAFCagsu0xumCHbY85dht4qKkiDWJtkdtnrZGLg0oI1
	 3rLiow/pjanR0ZcPU8cIutTYN0W3S+q4pSLqNtNvbDUa/EvsVFpWlJdWXue/VQyP7/
	 YHYNdDgZOG9LiYKJO3CNMecmxco/5MlvEAvxOTrw3YpU3fiU2u3ti8GllGlqkQRXhy
	 fPD0RzLI/mz1hzQZTBfdIPZbSO9kmIexLrtNsBK9jodwEfAkedojZc98RfMzRoq1eU
	 w9UILFWBUMF2r5jdR7Vi9KEtki3/u7q4vx9M4PSdgYWeNireixIIIDqPp63HSI3euD
	 ZADg9bZ62Itvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E2D3809A28;
	Tue,  7 Apr 2026 09:57:47 +0000 (UTC)
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
 <177555586626.3486859.3017881813715449576.git-patchwork-housekeeping@kernel.org>
Date: Tue, 07 Apr 2026 09:57:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled() (2026-04-07T09:55:08)
  Superseding: [v1] spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled() (2026-04-07T07:32:10):
    spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

