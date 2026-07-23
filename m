Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954B23ED5E
	for <linux-spi@vger.kernel.org>; Thu, 23 Jul 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818750; cv=none; b=EQo3dB9z518boeS+hPYZiseTRY5MQrKNwAjxncNriAvahRDJ2nGclMC/TXoR6nVZ9Lx4bLj0QWKe4Mu6sKkVbi2ejFurCj+aaQ31Tvs7q/LICnOiChc0n5aaDQdviQOS3QOHyZtkU5A0pM8JQPp3c8q40gZ6isn2ykU/ov/VNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818750; c=relaxed/simple;
	bh=t9hK1hoTzLlvmeoIlYVw0rJuHb9yd+P63M8v+b2dzo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZxEjeETqLPW9FUWJ5Bbc4wJm2s6tUXsa5FCqkXPBbj/ap5hZ4bkBsuQJ6ik9JlyuTPi0y+Wm/PFsBr7ePp0U7zPCMhYivaPnRu5glMPGYaPUwoRd7bDPAAGUIb6z/sMzpMZaBQMT3SLbZXGwbKK5HOZlrtD406Woqy3IyhscsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEEF1F00A3A;
	Thu, 23 Jul 2026 14:59:09 +0000 (UTC)
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BB138111E3;
	Thu, 23 Jul 2026 14:58:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178481871743.2305185.17205369059672265098.git-patchwork-housekeeping@kernel.org>
Date: Thu, 23 Jul 2026 14:58:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: cadence-quadspi: add PHY tuning support (2026-07-23T11:02:02)
  Superseding: [v5] spi: cadence-quadspi: add PHY tuning support (2026-07-17T18:50:59):
    [v5,01/17] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v5,02/17] spi: dt-bindings: add spi-phy-pattern-partition property
    [v5,03/17] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v5,04/17] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v5,05/17] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v5,06/17] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v5,07/17] spi: cadence-quadspi: add DQS support to read data capture
    [v5,08/17] spi: cadence-quadspi: add PHY tuning support
    [v5,09/17] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v5,10/17] spi: cadence-quadspi: refactor direct read path for PHY support
    [v5,11/17] spi: cadence-quadspi: enable PHY for direct reads
    [v5,12/17] spi: cadence-quadspi: enable PHY for indirect writes
    [v5,13/17] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v5,14/17] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v5,15/17] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v5,16/17] mtd: spi-nor: extract read op template construction into helper
    [v5,17/17] mtd: spi-nor: run controller optimization before dirmap creation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

