Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB253F23A0;
	Fri,  6 Mar 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816218; cv=none; b=J95mCqP+OMjjG78JCdazPlTc5dmejVG2VD4mK0OKoPpMcRjROduk0FvHYPg8mon2Uo8y9Zt1YEDR3PmPjhNsG/eyxUwAtARBReORnqvfKfDQiIRNESnOIYgzHwcSmeOWpf+Kj891LmCIQZKlSv8kHvEP5YWruVQsAHPUTwHG7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816218; c=relaxed/simple;
	bh=Wl1KP6iJVbGOTBsXT8d/TbiqBMerwcELcxR+OeLsFsc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=DNsIqyKDSq7UBPyluymQQoSGLpWD8HMWdblUXxfgFjvWnwN7gKlsMx2Jons4P9TWzpQ6rqbV1gQ0kyR8FtiLN5sm+/89tcKxyarjgOAFA8RvewUvyis/bDjXCgPRtt9AoHyuU3IIRFZhTpI9UzmdsGWrZdXREU87IGRuvaWcYYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1KaQj8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1KaQj8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021DBC4CEF7;
	Fri,  6 Mar 2026 16:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772816218;
	bh=Wl1KP6iJVbGOTBsXT8d/TbiqBMerwcELcxR+OeLsFsc=;
	h=From:To:Cc:Subject:Date:From;
	b=H1KaQj8K+krfKedd8R+wKquIrJ0Yxwwh6qNMlx3JWpUkSpYPo7jFCRZSdiRgsc4Km
	 4FRgKfKkdRZXcbSEtOECnD2NUrtvBuX8wQ6mWl3HdGjcV1dJUSaXu2UG1ZDajz1ry1
	 Eqj785Y5wJdOS7F/6Km2GaI3v5wjy3U1GzBOyHQ+c69l7IERDMn92jJXE05+SPmhN3
	 ycOti15GyJrOw0Ycn3WdDT20AtDZdW9VFZ8u/wXb8a3u3p/HGYgtJaGNxgUK7EzZGA
	 C0iFBgb42ajkklP9XYA/1uQ8YQcRlWBXsIILmwNbzv3hitHm37ccckmTp0cAclv96W
	 HLBhPPh2E1Tbw==
Message-ID: <61575061427a7f607de3b67bb125d2b5@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc2
Date: Fri, 06 Mar 2026 16:56:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc2

for you to fetch changes up to 3b46d61890632c8f8b117147b6923bff4b42ccb7:

  spi: spi-dw-dma: fix print error log when wait finish transaction (2026-03-02 22:33:32 +0000)

----------------------------------------------------------------
spi: Fix for v7.0

One device specific fix here, it was possible we might end up trying to
dereference an invalid pointer while reporting a transfer timeout on
DesignWare controllers.

----------------------------------------------------------------
Vladimir Yakovlev (1):
      spi: spi-dw-dma: fix print error log when wait finish transaction

 drivers/spi/spi-dw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
