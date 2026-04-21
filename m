Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCFB3B8D4B;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776537; cv=none; b=YrqrivUCbWl1Dwq7wEqCUyNPBiELcOgMKdeVTCu+Sg27LJc1y29+vedMTUKBlJrQoJTyY9PTvxt11YSfJOrsXMZG7pqONfHZP+bj+MwI90tz3JFZXFyqvXw8eVrrkvsZNwpDJ3mu7JpHm8NH47FPv4b09EhDOB0MfUmzPWtNx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776537; c=relaxed/simple;
	bh=1rFutabN1MV1cLhiuiDZd4O5eiDtayQHUpxY1SbujAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LrbSh/Ar9Saf9jLEwDlL7AUNX+jK1KZpSlJ9S32HUfk/tW/HW2U/d8xgCJCYYclQV8RP8yGZyTsr8ReUov1qNNk+GKGz8HVQ/iSZFkvkXC1X1vgdWfeGhihcshWDmwS64rZUl33CPOUWbB1f1+JNVmm2OQkH4aKcZWF2L2N+SwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLxiPWza; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLxiPWza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C69C2BCB8;
	Tue, 21 Apr 2026 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776537;
	bh=1rFutabN1MV1cLhiuiDZd4O5eiDtayQHUpxY1SbujAs=;
	h=From:To:Cc:Subject:Date:From;
	b=MLxiPWzarzMRcmaSFO0TvUcCdAonh8QKCDp+SeZFAARWlPgp2nIuwort/XBNs2jWK
	 YpW0XZVjzwDGSSiTm3kbhv7nfeDRQIrJvAUVLtWBE1gpIyBPn/1YO+XgTi7H1qDQ7B
	 yD8SC46S4EyJXzdxE31nMdMjhFzWYQzf9nsDS8O5Xb/T4DPXv3e2eGvpXvovR2WD+V
	 e0OcIJkFN8uuOAWki0gKa/JxOEeoASYPOjWfAE62kggwmtZxbP2h9A4rBlTbBqkmK7
	 Cp9GXhNnwIH207L+yoQyvbXH0wQ7UoVXjSpoz5UXhpN2yIJ6X4m/Jd9joFXT+7aov5
	 C9FR04u9HwhAA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAk3-00000006S0p-2h6y;
	Tue, 21 Apr 2026 15:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] spi: orion: runtime PM fixes
Date: Tue, 21 Apr 2026 15:02:08 +0200
Message-ID: <20260421130211.1537628-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes some runtime PM related issues in the orion driver.

Included is also a related clean up.

Johan


Johan Hovold (3):
  spi: orion: fix runtime pm leak on unbind
  spi: orion: fix clock imbalance on registration failure
  spi: orion: clean up probe return value

 drivers/spi/spi-orion.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.52.0

