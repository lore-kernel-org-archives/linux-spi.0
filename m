Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36C72882B7;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=Iezwo2Z2Nn6N3WzECd7YFc+Ly17m2SNFw9J8wofoePeKpqWsnTq7QZ4H1Z/pOp+foWgQjnGUkKcCCn11EXxT2GUv7LxyxxCIHLTxmtXrhOvF+mQlDGUoURkkBdsrkFBhzd+P+0eSuap87ohPwEW5JOvnZLuuoFa/PWRM6zzLVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=Wr/+Ug45FiNEA/eT9UEEkMTsKWcdgGxlwYNSza0gXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l0Ihozm5wytna+XuwDC7UgJW+1TDbzTkrn5QEiRyZRiO8J+WpN8BHaqt56cfzNsHEwa87+sAQn2wPxgQzK79um96TtA9AFQ5KehKpdT924I7pTOL1lRHGK302o0ydFfikVr4i4DcQoQJSGgZ2qiHb5NkwYfb6gG1ZMBMPZa5kbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY0it5y0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY0it5y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A382EC2BCF5;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=Wr/+Ug45FiNEA/eT9UEEkMTsKWcdgGxlwYNSza0gXLc=;
	h=From:To:Cc:Subject:Date:From;
	b=AY0it5y0cDLitNOG0SV6lDF6oZRvblxLsW9TKJL+r7DEQEk3EEwRimuHvAGW4JUm3
	 py6kjqgkdV80mZsfBeVmMmRsoe/GRqR1BxXyUWZ4VT8eJ6VhqvolIk4H+FFrfDP43X
	 1D7UepZnDRWYOZcfqgl94xF143Rudn6eUunnfHQIK1PLu4/F9hDzEyuPdcJWwYUATb
	 gn51sXks+b9CmYKHYqBx9/HGwfgSzP7qhUJmF6DIP9gjP9V5VCHhXvBqXJafngh194
	 ABR1XucfjXT0YVBcE/MsEySceaxDrLictc83ypS5BQ5svhM75d5JsyGZb7o3YxJFFR
	 K//tJcnhaiWUA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L82-1qfY;
	Mon, 11 May 2026 17:04:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>,
	Yang Shen <shenyang39@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/12] spi: switch to managed controller allocation (part 3/3)
Date: Mon, 11 May 2026 17:03:56 +0200
Message-ID: <20260511150408.796155-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for fixing the SPI controller API so that it no longer
drops a reference when deregistering (non-managed) controllers (cf.
[1]), this series converts drivers using managed registration to also
use managed allocation.

Included is also a related cleanup of a lp8841-rtc.

This leaves us with 18 drivers using non-managed allocation, which is
few enough to be able to fix the API in tree-wide change.

Johan


[1] https://lore.kernel.org/lkml/20260325145319.1132072-1-johan@kernel.org/


Johan Hovold (12):
  spi: altera-platform: switch to managed controller allocation
  spi: armada-3700: switch to managed controller allocation
  spi: clps711x: switch to managed controller allocation
  spi: falcon: switch to managed controller allocation
  spi: fsi: switch to managed controller allocation
  spi: hisi-sfc-v3xx: switch to managed controller allocation
  spi: jcore: switch to managed controller allocation
  spi: lp8841-rtc: switch to managed controller allocation
  spi: lp8841-rtc: drop unused ifdef
  spi: meson-spifc: switch to managed controller allocation
  spi: mux: switch to managed controller allocation
  spi: xlp: switch to managed controller allocation

 drivers/spi/spi-altera-platform.c | 27 +++++++------------
 drivers/spi/spi-armada-3700.c     | 44 ++++++++++---------------------
 drivers/spi/spi-clps711x.c        | 31 +++++++---------------
 drivers/spi/spi-falcon.c          |  8 ++----
 drivers/spi/spi-fsi.c             |  8 +++---
 drivers/spi/spi-hisi-sfc-v3xx.c   | 20 +++++---------
 drivers/spi/spi-jcore.c           | 23 +++++-----------
 drivers/spi/spi-lp8841-rtc.c      | 16 +++--------
 drivers/spi/spi-meson-spifc.c     | 22 ++++++----------
 drivers/spi/spi-mux.c             | 19 +++----------
 drivers/spi/spi-xlp.c             |  3 +--
 11 files changed, 68 insertions(+), 153 deletions(-)

-- 
2.53.0

