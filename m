Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE03E2755
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138237; cv=none; b=Ic5WBbrBORWfjMRZCVl9GzSRu83Y3aSDqLZU6lqZlyQXbgE6YZOsCIXXtvaMp9AGR1dhD853MIGBNe1lGpX98bwUN2e4WLO8W0e6r7X6Sk2Sn8JLQEHzZz8KtUPFxHixJ8KEhlzJmCooX1hiF3kjteZLc8a9zcAEokMShI9j5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138237; c=relaxed/simple;
	bh=KQx5I39iXI6c0JgK+XoVOetqd+WviFv0KQIn3GVYFe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AusHogq2jhGH/jAFhVjTkEXh2cuJeQA1gvPcgLXwhWFqBZfyjt0UFsNrn0Oq0p3dkPpLZCVgVWIBV2tGD9rNP/sLBdw2HsGp7w7v22B97uLOQcqaAa6ovI0Tnzp7KXcOmvsZyN0tgQzWu9XqAVlfqzoR/lS9Ge06FruLiirUINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyUiYDYq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyUiYDYq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64551C116C6;
	Thu,  2 Apr 2026 13:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775138237;
	bh=KQx5I39iXI6c0JgK+XoVOetqd+WviFv0KQIn3GVYFe0=;
	h=Subject:From:Date:To:From;
	b=nyUiYDYqsiLFPacW2bifop4Z+zq5NYkvIkRcoiAvKN6Mi3CnJsXJ+QLK8NpDTEiU9
	 IwidJbEpDAXbaP8gxq1acgNyA0Gw3xg9sGCOJ5s8qDCqSiJNmsFRVy655CgXkX9R/i
	 EjafP7LD0t3JP9kdfw/3wyULdnsiAdKZtRuxoUmOSrvu2spCVNYh4fdO9uZ3yEcSok
	 4NdrBc5LCRwj5NT76DhOsqPAjVFKv7AN5KB/1iMx8ObfXegMeSscGEuZG/ACyOwXRc
	 OAIUUmYjhcvnBmeCyUK3/m8dcKN1D76QCfwwJpy6q6zFeAy3kYoTKgyit8RPTZ1fvO
	 LMg8w0wkguFTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D583809A05;
	Thu,  2 Apr 2026 13:57:01 +0000 (UTC)
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
 <177513821967.42449.4572339662087758656.git-patchwork-housekeeping@kernel.org>
Date: Thu, 02 Apr 2026 13:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add Renesas RZ/G3L RSPI support (2026-04-02T13:10:15)
  Superseding: [v1] Add Renesas RZ/G3L RSPI support (2026-03-04T07:49:00):
    [1/2] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
    [2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

