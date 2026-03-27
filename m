Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F73372667;
	Fri, 27 Mar 2026 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774637449; cv=none; b=Q1HBHK0zQ9haozbYweSnZaMvAoN7hYcXfllXZ4uEdZtBB8NPnn2326lAJ47p/CQpTdU1VOF8bSojGGdzhnlIK4p4KFXYjNPXtob+S4oi3KDAsDosE/iDejfXOMpA8ICklSnU+2xmwwLLJHnCvt+/WVlTIwjv4NDYVY5PMH84IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774637449; c=relaxed/simple;
	bh=3p2iQR/30ay3UgolxFGH+ZlcwISHZJGrugT/HAiKyAM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A42eMjcyocafrRdA8POAIShlmn9DpElU8KHndNwMzKG/uqE8dPNlGAo+7VRHbiDHoRyA6GMOUvdnIYlheHE8IlAeG33c38/uLn3KGt6fVKhCrg/KrHjsOWlWsSX4cSDvUJ6RYcaNvX+iN9JNTGv2BmqW0sZUF/DlDic5VOVZseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLjDBfrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLjDBfrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43942C2BCB0;
	Fri, 27 Mar 2026 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774637448;
	bh=3p2iQR/30ay3UgolxFGH+ZlcwISHZJGrugT/HAiKyAM=;
	h=From:To:Cc:Subject:Date:From;
	b=nLjDBfrXXmfbpU1yVD5pb3vLEmdS17GtRCaK1xbLD344uB9CsVnwrXWYRBy/pgHkD
	 xRzGM++qWt62nAFaTntXcTQpgdAsGPX2RPBevKSxH91wb+GqK8oAcuYTA76bc7w71o
	 pEE0Ua2O7Q759YCP89yMExoqLlA5gScUm0JglOgwE4dmrMmhVOI3hU3K1sqWdiqLVF
	 +opxCMfCe3iqktEW0HgDjlslQ3BwZ1U3GPbiWTq7sr+AoB96tOND8HWWzA1YBCHn83
	 eswvanuGhb4b58IsarN6XjLAHLPgcTTGNEP7YRAm6ND9YglOnEFQdZsb2liHVCn4Un
	 2LaD4lhM907cQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 198D01AC5847; Fri, 27 Mar 2026 18:50:46 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc5
Date: Fri, 27 Mar 2026 18:50:37 +0000
Message-Id: <20260327185046.198D01AC5847@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc5

for you to fetch changes up to b341c1176f2e001b3adf0b47154fc31589f7410e:

  spi: spi-fsl-lpspi: fix teardown order issue (UAF) (2026-03-26 12:27:42 +0000)

----------------------------------------------------------------
spi: Fixes for v7.0

There are two core fixes here.  One is from Johan dealing with an issue
introduced by a devm_ API usage update causing things to be freed
earlier than they had earlier when we fail to register a device, another
from Danilo avoids unlocked acccess to data by converting to use a
driver core API.

We also have a few relatively minor driver specific fixes.

----------------------------------------------------------------
Danilo Krummrich (1):
      spi: use generic driver_override infrastructure

Felix Gu (3):
      spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      spi: sn-f-ospi: Use devm_mutex_init() to simplify code
      spi: meson-spicc: Fix double-put in remove path

Johan Hovold (1):
      spi: fix use-after-free on managed registration failure

Marc Kleine-Budde (1):
      spi: spi-fsl-lpspi: fix teardown order issue (UAF)

 drivers/spi/spi-fsl-lpspi.c   |  3 ++-
 drivers/spi/spi-meson-spicc.c |  2 --
 drivers/spi/spi-sn-f-ospi.c   | 42 ++++++++++--------------------------------
 drivers/spi/spi.c             | 32 +++++++++++++++++++-------------
 include/linux/spi/spi.h       |  5 -----
 5 files changed, 31 insertions(+), 53 deletions(-)
