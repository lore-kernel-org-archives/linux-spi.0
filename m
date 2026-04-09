Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5783876A9
	for <linux-spi@vger.kernel.org>; Thu,  9 Apr 2026 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772634; cv=none; b=Ge7UwDcCmwjVhssNyF7FFAiVJOOo5a+cAiktu89opPL699aQRz98gz9QSZhyGqiQnXoP5+H0XMYp32JVw5Dcjr00HX4crzShV0rAGXxdbRcnsBZzV5XYTZO0uRG4nZ/uQ12KiwVs4QkieEtUm6q0XT3ojDGr5knVkjUFhrjImGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772634; c=relaxed/simple;
	bh=r7LXTyNt6RSLKYDIysSFG75cBhcWnsJydacARt2pb2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XiseV7aP9MkxfZVUKW2cfjPl1lI1YY+Ry9NFVkPEJRPIC0PSaLu6e1QtFVU48w9sQ+Ojn+LGdN9j8L/dh8eODjXRTFGU9wkJrU009nY2EGkEU2xCkUM9oXJiuknNG4sY6B/TZfMsowEc0OpnmuK/xxYGPj/z4GOilw7c1irPrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxjlASF6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxjlASF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F89C4CEF7;
	Thu,  9 Apr 2026 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775772634;
	bh=r7LXTyNt6RSLKYDIysSFG75cBhcWnsJydacARt2pb2o=;
	h=Subject:From:Date:To:From;
	b=VxjlASF6hhcbtdJY1b058PocLx75MRZuH4VR0IXGuSPqX/CNohpveq9DZVvRG4Ydb
	 NmdsvDyzPpDen7HB+P77aVJaPwB7WI7lfb4hzw9yF+ICf2tT8VeU5cfwvDRu9LzgsV
	 cpxwEyjFv0vO9TGr7e9Gj6TIf6VCaawgExiaZJG6ejyywW0qCGjLvR/4tEdKCY9v3H
	 BXUFLOpHK/IVfr3Ho+AZItMNwd7iRDHJfrJ57X7vnrBNMihCX+Jme8Vsj4JHrOjts8
	 oKoK2K5Idk6fccJDa04eE+H3xEYadyHXZVGwXkw+KtYY8voqGqfLgbk+2e+1wFQlcY
	 HjB1Y7OQ32J8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F76039308C6;
	Thu,  9 Apr 2026 22:10:10 +0000 (UTC)
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
 <177577260903.1762716.2467300224514291786.git-patchwork-summary@kernel.org>
Date: Thu, 09 Apr 2026 22:10:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fix controller deregistration (part 1/2)
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079313
  Lore link: https://lore.kernel.org/r/20260409120419.388546-1-johan@kernel.org
    Patches: [01/20] spi: amlogic-spisg: fix controller deregistration
             [02/20] spi: aspeed-smc: fix controller deregistration
             [03/20] spi: at91-usart: fix controller deregistration
             [04/20] spi: atmel: fix controller deregistration
             [05/20] spi: bcm63xx: fix controller deregistration
             [06/20] spi: bcm63xx-hsspi: fix controller deregistration
             [07/20] spi: bcmbca-hsspi: fix controller deregistration
             [08/20] spi: octeon: fix controller deregistration
             [09/20] spi: cavium-thunderx: fix controller deregistration
             [10/20] spi: coldfire-qspi: fix controller deregistration
             [11/20] spi: dln2: fix controller deregistration
             [12/20] spi: ep93xx: fix controller deregistration
             [13/20] spi: fsl-espi: fix controller deregistration
             [15/20] spi: img-spfi: fix controller deregistration
             [16/20] spi: lantiq-ssc: fix controller deregistration
             [17/20] spi: meson-spicc: fix controller deregistration
             [18/20] spi: microchip-core-qspi: fix controller deregistration
             [19/20] spi: microchip-core-spi: fix controller deregistration
             [20/20] spi: mpfs: fix controller deregistration

Patch: spi: npcm-fiu: drop unused remove callback
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079314
  Lore link: https://lore.kernel.org/r/20260409120810.388909-1-johan@kernel.org

Patch: spi: atcspi200: enable compile testing
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079315
  Lore link: https://lore.kernel.org/r/20260409145618.466701-1-johan@kernel.org


Total patches: 21

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


