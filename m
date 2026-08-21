Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4A3769ED;
	Fri, 21 Aug 2026 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309749; cv=none; b=GHUq8/sTuK117sLRVXWIDHLq6AGv0I9bkXXKKHuuNhQUZ71PS0oDH1hn1OaLtcZpiMPiF0flJ6Ch7TRr1K4L0Sn8nOTbudGexY/S2hxnRJ1DJdEL/WN95ml7wt6ZtTw28h1ngUZ5kazzmH7b0HhTpZtzuK+oeLtLUf4KZpyCpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309749; c=relaxed/simple;
	bh=p5QoISF27qYNKSvf8Vh8Q+7r9EBNLy7o/ec7V+AHq7Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AO3Kbb3kmde3Z9oIvtZP98ybQUI8czJDWtulSa9gI9+DXuFK+RKjF+dDKwJ3ajKYswbiQRuMxhI/4cAdTvjcOdtNtNCIYAeyphhkiUUj7b+M62/1vp0rMQVDuvkjFrDTvsg5La5IMSVvYY8VJTVEY4Xf7bG7H/a74u4RLT43Bcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7ij6gTF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7ij6gTF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787309748; x=1818845748;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p5QoISF27qYNKSvf8Vh8Q+7r9EBNLy7o/ec7V+AHq7Q=;
  b=j7ij6gTF+Z+/Bb+TNBhDdeenCrKtRDLhcNAsFKJISsfJ2Bx/tDtWIN+v
   bzArMp9AoDyhNi6EQmqTkFVxhwXL6uMAgZWMqvKwW1eVgq+1Dzx1gkH9S
   SDzy3L2bxek1M2nadDHPHVdDfAAkWptYxwcJBRdDWxJ1xs0qmqMcyUJhI
   tF6FgkcTcUEJckMBlZNPH6Y/UNcPByWOJgNcp+ELu7EWT3tzbVuPb5nMc
   vqSVSl00TDuTybz/UxirfFkl8016oLex9WFUDiKWfeG8T7IWMq2/NF6pM
   NrkDeHJouy9M4Cmejw6el/pr2Fyri5X2yYvVaVl/8rpAOqm7cTcw41Gns
   A==;
X-CSE-ConnectionGUID: yNd+fQpKRTWIcOkA5u7DGg==
X-CSE-MsgGUID: Yn5pE1+zTQmmIaLdnrzIxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="88060544"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88060544"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 03:55:47 -0700
X-CSE-ConnectionGUID: cm9+mZgRTUSXOrpb1yz39A==
X-CSE-MsgGUID: hT1LnDniST6wPnOqAktctQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289841514"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2026 03:55:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 136E399; Fri, 21 Aug 2026 12:55:44 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: Kconfig cleanups
Date: Fri, 21 Aug 2026 12:54:51 +0200
Message-ID: <20260821105541.1432348-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With time the section order is diverged, put it back into order.

Andy Shevchenko (3):
  spi: Fix tab and space mixture in Kconfig
  spi: Drop redundant dependency on SPI_MASTER
  spi: Fix the section ordering in accordance with the comment

 drivers/spi/Kconfig | 364 ++++++++++++++++++++++----------------------
 1 file changed, 179 insertions(+), 185 deletions(-)

-- 
2.50.1

