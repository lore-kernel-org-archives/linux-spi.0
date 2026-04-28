Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013E41C31D;
	Tue, 28 Apr 2026 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392752; cv=none; b=N/BoHvjmV5988i9cG9qimRVV2IMIXETTsKzH+kbnXjAuUGbnPPEEmlV5wKV88wjZLKcoU7M8oFDXUj0/UqBpBrTYG2f57WUrmrCosdimaolwsGfhVdT8vUUaezFviNgDR45mSVafR+iKwVmJcOFTSEial7nVlbg6BCA9GANaiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392752; c=relaxed/simple;
	bh=KRnGtmY468KGUtHl7CD7HwFCBx4A08AyJSMRArIQA8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hILI5bbAF2rA92otgoy3vbL9Uco8L34hIeAvYOKkjy6G9ofYKJsMSomzoxsrjr9NaWmOoUCHDtaQnf22yHFKtjSBsXnZKZYT02yH4MUczz9FfoYvkEbHeDffS2sWmh1CsD7TOfRl67En8vyoujltVhCzsM8dd5sybm5Y9Y43bWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0LH+T2R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0LH+T2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBDDC2BCB5;
	Tue, 28 Apr 2026 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392751;
	bh=KRnGtmY468KGUtHl7CD7HwFCBx4A08AyJSMRArIQA8o=;
	h=From:To:Cc:Subject:Date:From;
	b=D0LH+T2RZh1bp2bP7EBSkX+UXm2fE34lPTwhSFAzV0dhpA2eenR4OMmE0hOiqwKf6
	 DaZk912kzflpix8NFBmbib6dbHivuDs/zK14MecJ2aPNmOT4siItHevHbam/D9anKW
	 v7pkHx51EaexP/su6XLbUuGe8mLv5Yta9Q6VPRKH+9Y86e/+mUROuLfghLgt/kwu6Q
	 UdWiI+Kr/RLFKsBItxNUS/oldvgQnZA2X7dijl/kcV3l5lnjUO4UI3i8djbDUHtald
	 +u62zJMPSkGGMrIEWulbeaMDuj3R+AGm+mLrfpnRjhJjo61lJW4wjLVmPTxc/hPCJQ
	 H38MDuYu4nRGA==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] microchip core-qspi gpio-cs fixes + cleanup
Date: Tue, 28 Apr 2026 17:12:04 +0100
Message-ID: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=879; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=OjL3jteOlXvTCBInxRMwdQR3kLR+lbu3YZfwpkULSkk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkf7sSuMw79XdVzmrlE9LpMfXbTQnGb7/pT3/y1enBy0 +SD4s7xHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIajojw6L1Uw48SBOYl1M3 nUV+W3+Q1nn31Ozius8FGRdX/PmlmMrIMPs0N2d6z93u3Z+eu7uJJF09IbgjUNNtXsvi7Rrfuhf 1cgAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey Mark,

v2 here drops 2 of the cleanup patches, but keeps one that conflicted
with the changes made in the fixes.
Rebased as you requested.

Cheers,
Conor.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Valentina.FernandezAlanis@microchip.com
CC: linux-riscv@lists.infradead.org
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (3):
  spi: microchip-core-qspi: control built-in cs manually
  spi: microchip-core-qspi: don't attempt to transmit during emulated
    read-only dual/quad operations
  spi: microchip-core-qspi: remove some inline markings

 drivers/spi/spi-microchip-core-qspi.c | 102 +++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 20 deletions(-)

-- 
2.53.0

