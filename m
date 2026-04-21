Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F763D16F4;
	Tue, 21 Apr 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774994; cv=none; b=oyLecUgxrMVT/bzedOsc1CcxeBejg2gspdTWPQcE2eO9sYQqUVqmybKP9uie2g6UDwxYihPi6dMLamjl3wAEA+LoNXx7sN3pfUOC8hfqlvCMFrvlt9AU8cYZn36baYsyM67OwYNwIAM7T+ND3QZJbROoDHtTAPPC5wHzDbw1H58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774994; c=relaxed/simple;
	bh=mX9Fqo4W9kPdb0numsxHVFq3zBIttcVHGnUrql9aPKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGUagYuVIOczoKWrD4vVAwiynsx2kIZ855nO+swB+Xdjd8FyQK8Xfwg3Xc4Q7KlOgE/a2gaSr2pE7E+X/fVxTQXcfyOhk3OZvDr444KsGhw6b4S0K4ZrMR8vGZV+aRCcn1Ur11faFJVI/rt8OtAEmNWxNQG8Qp1JOTfA1ab8KCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDHiVY0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDHiVY0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28CEC2BCC6;
	Tue, 21 Apr 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774993;
	bh=mX9Fqo4W9kPdb0numsxHVFq3zBIttcVHGnUrql9aPKM=;
	h=From:To:Cc:Subject:Date:From;
	b=NDHiVY0zwRyqznRjUf9bmyWHObgCTbE+WbHcgabqvKFjnHpsklpMjSeyoTz8XnnxL
	 2/PIi8SKRayDUfIuc1V3tv2TqQuSEZxRjgRpGO5/41aA9X8t8qWxGASP9/3BLqoV5m
	 g1Ei/Lc3SEpUEVqwqfKyY1fTR9/F/W4wEuMAHOWwYYSlDaZk7GSu1aF3qqxNswjcnN
	 Ygg4kAPmGS1Gl4hYB1OM+DOY/EcmhmSGLP3Tb2tehR5w5hFS9EbI+vQ8M1icrSfrVJ
	 If1mObVMj42MzZflfYky3HqiV+XkCwyq9QTIoM5oZrNMnDYxxH0b+Jk4u+pVT9mNwG
	 pu+SRrK2cA2KQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wFAL9-00000006QyB-2FJY;
	Tue, 21 Apr 2026 14:36:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] spi: cadence: runtime PM fixes
Date: Tue, 21 Apr 2026 14:36:11 +0200
Message-ID: <20260421123615.1533617-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes some runtime PM related issues in the cadence driver.

Included is also a couple of related cleanups.

Johan



Johan Hovold (4):
  spi: cadence: fix unclocked access on unbind
  spi: cadence: fix clock imbalance on probe failure
  spi: cadence: rename probe error labels
  spi: cadence: clean up probe return value

 drivers/spi/spi-cadence.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

-- 
2.52.0

