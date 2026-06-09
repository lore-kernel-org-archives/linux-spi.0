Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353B2DB798
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985716; cv=none; b=FVsNBPojCLH1vVEbUzUvHp2IQbJI0tsgsOCq7LcxPuFPJ29CchkkPHmZm1NRd4M3TEqPDmSqY9fFdjdb2b8MVfoWUtElhVAos7oMeIY8ocji8Vwyn9SidpajkRjLnxzqhQZeotuDHC3iG9S6j4cWLnwLbxlcb0A+5YNW2AavgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985716; c=relaxed/simple;
	bh=BlfHt/EcnceYK964c8b6bJMPVkoV83ARrVpSfVvjqCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2HJq7MVUD70jQmijnEbCS/5Hzn8tNLli+7MHmnYBa/ATOvNHHCM6wX2u6Z2Rhf3wxKFIIaIMr5TuS62NPiLRE/5B/w8gD+3pD3zrBo7tx9p0do4+oXxt1XBGPL7WkW+nFIX0uGPPVp9ODnwA+H37IeUKcKPPAkjGnn+3kGDgMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kQ+kUgOr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kQ+kUgOr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780985712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i2jpIDCVnNVhXSYDVvdDiQ1s+6wApppzolFVa3ePcBA=;
	b=kQ+kUgOrV6W6Jc16Kii3uxt27H6tnGH4ZT13H/tGloTnC2pxAr0+1e0lN87mGDlSsCwwUT
	byRLJdWy+OF38KcDXWI7VaMSELJjoswljJztiskoxvxrLRlYswbpJIeHHZA8qm2XiuHT4d
	nSyAaMFF4R+0aR7kWu7ve4uMSn0m2lc=
From: Kaitao Cheng <kaitao.cheng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Waiman Long <longman@redhat.com>,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Kaitao Cheng <kaitao.cheng@linux.dev>,
	Kaito Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH v2 00/14] list: Prepare entry iterators to cache cursor state
Date: Tue,  9 Jun 2026 14:13:33 +0800
Message-ID: <20260609061347.93688-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kaito Cheng <chengkaitao@kylinos.cn>

This series prepares for, and then updates, the list_for_each_entry()
family so the common entry iterators cache their next or previous cursor
before the loop body runs.

The first 13 patches open-code loops that intentionally depend on the
old "derive the next entry from the current cursor at the end of the
iteration" behaviour.  These loops append work to the list being walked,
restart traversal after dropping a lock, skip an entry consumed by the
current iteration, or otherwise adjust the cursor in the loop body.

The final patch changes include/linux/list.h to keep a private cursor in
the common entry iterators while preserving the public macro interface.
The safe variants remain available when callers need the temporary
cursor explicitly or have stronger mutation requirements.

Changes in v2 (Muchun Song, Andy Shevchenko):
 - Drop the list_for_each_entry_mutable*() helpers from v1 and make the
   cursor change directly in the existing list_for_each_entry*() helpers.
 - Open-code special list walks that rely on updating the loop cursor in
   the body, preserving their existing traversal semantics.

Link to v1:
https://lore.kernel.org/all/20260529082149.76764-1-kaitao.cheng@linux.dev/

Kaitao Cheng (14):
  drbd: Open-code transfer log list walk
  firewire: core: Open-code topology list walk
  drm/bridge: Open-code bridge chain list walks
  drm/i915/gt: Open-code active timeline walk
  drm/i915: Open-code DFS dependency list walk
  drm/ttm: Open-code reservation list walk
  spi: fsi: Open-code message transfer walk
  spi: stm32-ospi: Open-code message transfer walk
  spi: stm32-qspi: Open-code message transfer walk
  spi: tegra210-quad: Open-code message transfer walk
  locking/locktorture: Open-code ww mutex list walk
  locking/ww_mutex: Open-code stress reorder list walk
  ASoC: dapm: Open-code widget invalidation walk
  list: Cache cursors in entry iterators

 drivers/block/drbd/drbd_debugfs.c      |  4 ++-
 drivers/firewire/core-topology.c       |  4 ++-
 drivers/gpu/drm/drm_bridge.c           |  7 ++--
 drivers/gpu/drm/i915/gt/intel_reset.c  |  4 ++-
 drivers/gpu/drm/i915/i915_scheduler.c  |  4 ++-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c |  4 ++-
 drivers/spi/spi-fsi.c                  |  5 ++-
 drivers/spi/spi-stm32-ospi.c           |  4 ++-
 drivers/spi/spi-stm32-qspi.c           |  5 ++-
 drivers/spi/spi-tegra210-quad.c        |  4 ++-
 include/linux/list.h                   | 46 ++++++++++++++++++++------
 kernel/locking/locktorture.c           |  4 ++-
 kernel/locking/test-ww_mutex.c         |  4 ++-
 sound/soc/soc-dapm.c                   |  4 ++-
 14 files changed, 78 insertions(+), 25 deletions(-)

-- 
2.43.0

