Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9F3C457D;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776046; cv=none; b=khjAOegcWnKUFChHlCdCus+fRO90npzp8j451UYvOEBkrHOv5jvqVTH26O3swpywv6+vRRFtEwiO8Y8bJXYGvW7wwXlXswloYB8iXFkdkbxtCzHOS3AzmEuvrJmwA3ni/RrjkbwJUrn5/ufyvLeUnBJGT7u2cYq2brOhv7bvD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776046; c=relaxed/simple;
	bh=4lWjIZz48ASdxsIe5kIe8MiqCuodoY9h19Epz7FNgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsfMmjGlkQ/7h/IHPN4/BIuSYqKQtfrcBZEUtskFEzZkgqNu5QxuGXpVLO0LT1frgkPIGxPYV/DRCROhJKh0DsaWPr4n0X8AGJBplC57Oa0ajk9uUA5V+tLmPhTpq+R3GKD4xCwO8FA3JHmuCOD51KQ7dG0C2O9wKcGptWJLvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQqsMWy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQqsMWy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F2C2BCB8;
	Tue, 21 Apr 2026 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776046;
	bh=4lWjIZz48ASdxsIe5kIe8MiqCuodoY9h19Epz7FNgtU=;
	h=From:To:Cc:Subject:Date:From;
	b=PQqsMWy1DynjMLWjLwoyQBUWnlnX49qMzwdBF9wdBi1OwFgutXukCMhdezzrmAHNV
	 sNqFQn0eSWT88RmvItRclZ1jTVDooAsJ1Dun+1Q6RuUaNfD1Itzf1TiEHtBA8Udxkv
	 CPLb6X+y/EhCuahogad3pR2hx+vTyRt7pJ3HHVYYdKHkDkLZA/TR35IMWPgHLy+mc4
	 4v6lsbDnbdYL5q8UIq7Bs2CUsn/9y365iPGgUNw3iVUhGnPqdBBdV/kLSCnfo/KLUU
	 4es0hIP1ZCYrza2iMCZt0E5RpTmQ6pO0w0U+uDH0m9QVTa/9ICTJR1I+M1WbJAy+fn
	 th47oHatf3Iag==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAc7-00000006RIM-3lWZ;
	Tue, 21 Apr 2026 14:54:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Anurag Dutta <a-dutta@ti.com>,
	Apurva Nandan <a-nandan@ti.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/6] spi: cadence-quadspi: runtime PM fixes
Date: Tue, 21 Apr 2026 14:53:48 +0200
Message-ID: <20260421125354.1534871-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes some runtime PM related issues in the cadence-quadspi
driver.

Included is also a couple of related cleanups.

Johan


Johan Hovold (6):
  spi: cadence-quadspi: fix runtime pm disable imbalance on probe
    failure
  spi: cadence-quadspi: fix clock imbalance on probe failure
  spi: cadence-quadspi: fix unclocked access on unbind
  spi: cadence-quadspi: fix runtime pm and clock imbalance on unbind
  spi: cadence-quadspi: clean up disable runtime pm quirk
  spi: cadence-quadspi: drop redundant match data lookup

 drivers/spi/spi-cadence-quadspi.c | 66 +++++++++++++------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

-- 
2.52.0

