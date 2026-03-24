Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3574E3624B5;
	Tue, 24 Mar 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340631; cv=none; b=fzRmSDktxFYavkn3NqvsUQu43Y5Tvf+hTMMTC4RDzv2mbBubHjcsZnP/Ke7lZtdBM4VqZYAGIDmsQDBV7il0GtAfUzokwqgFhYPGiSY1SCDvWQ50HwG2lS5pMosEHwJ8uZvyr+IdgK/QQaKqp8VGrGGDtGTv5+K5JMeVl6SaC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340631; c=relaxed/simple;
	bh=ymPnpJsVFo3CicYiLXV3ENheGIM04MlI6vzIzQPMAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2JDGuxkQuA9KXLVdPim/tuyKB7HLsY8ACWRfkw/qkyP2oShL6oUQX3eaWVW9QZSv18tvAWm22hPP6UvZHDICkSxVez4I7w8B4UVz+Lrj1iUm75PlarjLcl+DGm5a8svfpWjD2yflSMrvW/pV2IaNewpcCrfoBc9EM2fi/xL49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht2nh3XG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht2nh3XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88579C2BCB2;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340630;
	bh=ymPnpJsVFo3CicYiLXV3ENheGIM04MlI6vzIzQPMAp0=;
	h=From:To:Cc:Subject:Date:From;
	b=Ht2nh3XGcp0z9Hi+N2ecjAE9yL88scqhTyg6mCcZvxvloHu7jffMJXiu2Qk/Ie/8m
	 P08kmc6xyBCmTCm0dkCpLVWlT6X7YbiF2dHhOcIF1FigE1k6oqP6vkF36zsWqYV7PR
	 H15ux8iXpvDgR42PsxETNmA2sa718q76wK4fHutCPdFI1F3qKgCEfSTDHPAcDi+lLM
	 AZbKgC82HW1oop+qVApVKPnzbjYQqe3UzYpIDHtzNRNxmuVKx3ppGf0HxN497DftFF
	 kL4+KeHW2edzY5U0Xq2pMVNlJHP4gQ8z1qmrbox5+WdfwKAWngZb8hsQQtBgv37BhD
	 rGvc2fuy1AdMQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4x3E-00000003mQA-1D2K;
	Tue, 24 Mar 2026 09:23:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/5] spi: imx: fix use-after-free on unbind
Date: Tue, 24 Mar 2026 09:23:21 +0100
Message-ID: <20260324082326.901043-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI subsystem frees the controller and any subsystem allocated
driver data as part of deregistration (unless the allocation is device
managed).

This series fixes the IMX driver that got this wrong and then converts
it to use device managed allocation.

Included are also a (preparatory) deregistration fix for the rockchip
driver and related cleanups for the tegre20-slink and rockchip drivers
that both take a controller reference during unbind.

Johan


Changes in v2
 - add stable tag to rockchip fix
 - move rockchip fix before the cleanups


Johan Hovold (5):
  spi: imx: fix use-after-free on unbind
  spi: rockchip: fix controller deregistration
  spi: imx: switch to managed controller allocation
  spi: tegra20-slink: switch to managed controller allocation
  spi: rockchip: switch to managed controller allocation

 drivers/spi/spi-imx.c           | 41 +++++++++++----------------------
 drivers/spi/spi-rockchip.c      | 40 +++++++++++++-------------------
 drivers/spi/spi-tegra20-slink.c | 26 ++++++++-------------
 3 files changed, 40 insertions(+), 67 deletions(-)

-- 
2.52.0

