Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2193D902B;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775836162; cv=none; b=ZsanzR+jaZQqEyPcAPpPlOJOpnC9k5/Sz55GfBlFyu42CaiDya3F8Mom2GI2QTsW+DbN9SKWzGLMSG61oqy2JPHQ84ereIwmneR3ixghJdbki8QPMIdFzrjDbGZ0+jNIzT8kI9VTHbG6LmEdbz0Kk8xIc/SoW0D+DNFsZiVLd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775836162; c=relaxed/simple;
	bh=Wk590oEqKQwVPmHW7O2rsLBXolxeD49oG8d7nTw/D/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1ij/w1v2kKDGHiAlojnuKH4ZtAWmrWpTEhR7o0CChKGJy6l70mHD9burAXQmlBYIp0zsh1xFztVVk1k6fqnEQqv8n41WztQt/xuh+CfyWW7Vh9/ItOexEcQZJnG5R0ukNHw5v0FeowyhVtrqVgWIECAey9c8tg8qBPFIWmTB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI5tduuf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI5tduuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD4C2BC87;
	Fri, 10 Apr 2026 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775836162;
	bh=Wk590oEqKQwVPmHW7O2rsLBXolxeD49oG8d7nTw/D/g=;
	h=From:To:Cc:Subject:Date:From;
	b=fI5tduufpzQXU4oTzfQEyeCBxF/DuU4cpxHlnNNBXyQ6ADaDvfuuv8do5dbA/KyUT
	 RXZC+ZK9NDqkrqDzWRdifKAa6UYpe5fOaGWy3AFR2FzJtFLPgVbKOJUUDaNEdkX8Zo
	 HvWJppq9Euf6TVsX9BOaY3Tp3F3GoYywHII/7Pyyt9CLLCLAniDJaCtjALxxY5GTlY
	 tFMW5Sdj+AXZ+4TCtdVym9i5iiFkeGGhY6xF8EvquIcg8DkcSol04k8tUYuNzgO372
	 f+YvBKny88WLQetPTwBfSNZFQ/3B0NAY+MM7NLVteqHiGrtWZ9T+Ihiurw3l7tMf1v
	 mGwyOI3sB7QvA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wBE6i-00000000Xd2-03XE;
	Fri, 10 Apr 2026 17:49:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Saravana Kannan <saravanak@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] spi: fix resource leaks on device setup failure
Date: Fri, 10 Apr 2026 17:49:05 +0200
Message-ID: <20260410154907.129248-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to call controller cleanup() if spi_setup() fails while
registering a device to avoid leaking any resources allocated by
setup().

Johan


Changes in v2:
 - only call cleanup() if spi_setup() fails during registration
 - use spi_cleanup() helper
 - fix controller cleanup() documentation (new patch)


Johan Hovold (2):
  spi: fix resource leaks on device setup failure
  spi: fix controller cleanup() documentation

 drivers/spi/spi.c       | 61 +++++++++++++++++++++++++----------------
 include/linux/spi/spi.h |  2 +-
 2 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.52.0

