Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5433BB9E6;
	Sat, 11 Apr 2026 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935530; cv=none; b=biEj69fyy/s68C3KVYVXnp67qWTvzsscipJHdr/TcEXY/02Pk80vM3C4WfvPDs3SGLN2b8jfUh74DmGMmGBIwbjy9jXZxCXVli0PTPNT7SYRwpQ52Mg/hMt64LBvq5j/RqX7uC8g9fJTjSolsw0KjR8M0Kdl+QcZW3ZzLST2NTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935530; c=relaxed/simple;
	bh=18hKmp2ynuaCD3u73/+m5jJ0CkdHCeUgWhr6viDmcyA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WtUqEpBEwRDkIv6tvDR9XzmC7fSdc1Q89ofs+RzfaQNdrGLTOrY6KV3LQkrICGYOjqfIPLK7Rse4oSFN87H0ze9CtnbYys1699muRrARz6w9eGg67BTed7DrVvDyBpA0prjlBrQ629bRCLEfbMe4QkF/mVdKDL4tISJwBCEH7Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCPDmx09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCPDmx09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DF5C2BCAF;
	Sat, 11 Apr 2026 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775935530;
	bh=18hKmp2ynuaCD3u73/+m5jJ0CkdHCeUgWhr6viDmcyA=;
	h=From:To:Cc:Subject:Date:From;
	b=oCPDmx09SsOuY5FnC56X6ZJXKr5a9bYYnqpCrr99/tKALYQiihwAV0u9qcuznnmnr
	 iOyy9cwHIxv7y65ajXdsz/m8b8sK88zDqD/sy3/kRMATrND0+F5rcsfRh7TKdaHD6X
	 whJwabVoYEuhiGCMDNN6ja3jF6uICl90GHziXLlYuX33nuSHmiFLtuCwUHDoUiOZMV
	 pTwxhopydtgyqiIoYhHeQjQ/CpBbASWphcHbfDyUmHL3wAWZpfRWpv4lchnqYnkv8Y
	 YrvYH2qmyIPYScQ1rcJdwvaic56zQmGjjXxXnpksJhY9F+oYFraAZzlQ+fhUzk4AzN
	 F6AnRc+WUDe3w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 7F21E1AC58C1; Sat, 11 Apr 2026 20:25:27 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc7
Date: Sat, 11 Apr 2026 20:25:10 +0100
Message-Id: <20260411192527.7F21E1AC58C1@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 591cd656a1bf5ea94a222af5ef2ee76df029c1d2:

  Linux 7.0-rc7 (2026-04-05 15:26:23 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc7

for you to fetch changes up to 705355a82b8ea86e0afe44560e970eedc74c05d3:

  MAINTAINERS: Update AMD SPI driver maintainers (2026-04-07 17:45:37 +0100)

----------------------------------------------------------------
spi: Fixes for v7.0

A couple of changes here, one update to MAINTAINERS for the AMD
controller and a chnage from Pei Xiao which in spite of the changelog is
actually a fix - previously the zynq-qspi driver leaked a clock enable
for every flash operation it did which isn't good, these extra enables
were removed when doing the enable cleanup which are probably a good
idea anyway.

----------------------------------------------------------------
Pei Xiao (1):
      spi: zynq-qspi: Simplify clock handling with devm_clk_get_enabled()

Raju Rangoju (1):
      MAINTAINERS: Update AMD SPI driver maintainers

 MAINTAINERS                 |  1 +
 drivers/spi/spi-zynq-qspi.c | 42 ++++++------------------------------------
 2 files changed, 7 insertions(+), 36 deletions(-)
