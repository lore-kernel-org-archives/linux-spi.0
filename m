Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C043F0B9;
	Mon, 19 Oct 2026 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399558; cv=none; b=tkis8+IosUvUBQBiLGKEwa30zKwZEah6gAJ3mCvIyoZHXjwvIc7TvNMHMZlj66JxkmhtGDJB0PPIqps0HQgArpRbxUi53jzwBp4MWFRLGX7r9WP4b+muQpmmkcLQvUEfs5PJuwnQnYgn535b95jQNdpOq7Ge+LnMH3OjzasyYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399558; c=relaxed/simple;
	bh=kKlrkFuAUxfvTKMppFChJ0Sca8cHI+LswahOB3weEYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNp6PQYcqCCFodSroudNgjBmoJl1gZgrClKJWK3z69zVHWcIELeL8QD6pEd2ZfGC/9mnZmoStpm0/vTmwHgl2zuYJUwUvcjQFt+QoKOBBngNcfB3D8TFV8T+dcBuPzkSvDriWddpLwtxfNd+o9ztBqzbEYsy4+gVv2YO5h6FeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m5hFG6uQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m5hFG6uQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Dq
	JahHfr1UsBLx8USbl6IZSZVQjmiL0holT7orMb9uo=; b=m5hFG6uQBjs3cbTEJI
	KMaz73vJMwPOM48mwB1dsGl5UTJhJC72PhMibf/BXSNFfh9vzg7P3RwsA0mplte+
	GYBwpwR0MVyybP1nTXxEjugGFCEmH7iGNVxxZ1uh663YRXNyzcZtcn44nit+7WsC
	vCAjggFCa7CpGKjwMsrqULQYI=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnaJF82NVqrQQEAw--.30772S2;
	Mon, 19 Oct 2026 16:44:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Atsushi Nemoto <atsushi.nemoto@sord.co.jp>,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/2] spi: handle runtime resume failures
Date: Mon, 19 Oct 2026 16:44:41 +0800
Message-Id: <20261019084443.1824122-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnaJF82NVqrQQEAw--.30772S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr4UAr13XF47Zw1rGryxuFg_yoW3ZFg_Gw
	4kCF97X3WjkF9Yya42vFs3ZFyj9FWUuw17ta4qy3ZxJF12qFs8Cw1UZrsrC3WDZwsIk3Z5
	Kr42vFWxJr9xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRM9a93UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8B1ln2rV2H3F-wAA33

The STM32 OSPI remove path and the TI QSPI clock setup helper ignore
pm_runtime_resume_and_get() failures. A failed runtime resume leaves the
controller unavailable, so following register accesses are unsafe and a
later runtime PM put can be unmatched.

Keep OSPI resource teardown on a failed resume while skipping the
controller register write and its matching put. Return the error from the
QSPI clock setup helper and propagate it before either caller touches the
controller registers.

Jiale Yao (2):
  spi: stm32-ospi: handle runtime resume failure in remove
  spi: ti-qspi: handle setup clock runtime resume failure

 drivers/spi/spi-stm32-ospi.c | 12 ++++++++----
 drivers/spi/spi-ti-qspi.c    | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.34.1

