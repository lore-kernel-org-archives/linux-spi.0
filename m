Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78307471439
	for <linux-spi@vger.kernel.org>; Tue, 29 Sep 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665162; cv=none; b=Bb3pnhJBy4LFsDttavgJ3bsB47+AcWrW5bRQnU+l2ehbjcrd6lKdL/I7+4qzWxcuNnXolOLFSRV+Ad78yxT31LTpBbAcLmsQDnF+kVmLm1HltVmR7KWoQso7AwFRzebcAitJGBldIlTilOFhio8sGUycypdzf8MjhimpWfW4TFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665162; c=relaxed/simple;
	bh=Z6GhDijrH+4Lc1Jx05zYmUef3IMMWo568WjMlmcepq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GX9y5FFFeGMzAbDCjh65NSMR012gUlMte5h32yvBnNrxPHs7a/IRjnMSR/aQBtqqaxkGvSa0OI2ty70WVqSiPtivbLRc5UJ9amDVgxgEIMUuDQG5fDuKSzc1LTIr+rw/vFNKbUEJ1v2QMU+adtCf7JK2uxVXmZhixCL8hfy+51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U85BE1fg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U85BE1fg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D8C1F000FF;
	Tue, 29 Sep 2026 06:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665160;
	bh=Fh53nDDukwCiN2OrgMKw4MJDd+pA3dEkB+FM6gxdUAQ=;
	h=Subject:From:Date:To;
	b=U85BE1fgTTFtfdbMDTNEcRLzXRPQpr8JKTxATHudBqGwKYeOhMMX98HHHKGBhr4AW
	 wXNuFBZ/VE+vH/cyPxzA85mYDC36p7jUcTB7RjOHcsCdiyearAn/S0MvuhBQSRAHUe
	 hoHs+OWR1xcoQ9MUB1FJgmq+EjEfZwswSj6b8ZEPfKkEbp/cio/0oJWvq7ktd0/WH2
	 amZbMnQOTa+VsmK2A6yOkGxRdvqJ2N35dG1OmJ0w2RqalWo3Bvkd91Jqwm9v4dAaDM
	 a3wijEopZwkqIid/PtRO9Exvi0XJbv+aFwp8RMY5QBmMBQA/3gJ/wRDFDZxLaC49Hm
	 6qBtBPLWOAtmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15DD39253FD;
	Tue, 29 Sep 2026 06:59:19 +0000 (UTC)
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
 <179066515842.309752.2936924715516931989.git-patchwork-housekeeping@kernel.org>
Date: Tue, 29 Sep 2026 06:59:18 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v10] spi: cadence-quadspi: add PHY tuning support (2026-09-29T06:35:10)
  Superseding: [v9] spi: cadence-quadspi: add PHY tuning support (2026-08-25T17:17:22):
    [v9,01/18] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v9,02/18] spi: dt-bindings: add spi-phy-pattern-partition property
    [v9,03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v9,04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v9,05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v9,06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v9,07/18] spi: cadence-quadspi: add DQS support to read data capture
    [v9,08/18] spi: cadence-quadspi: add PHY tuning support
    [v9,09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v9,10/18] spi: cadence-quadspi: refactor direct read path for PHY support
    [v9,11/18] spi: cadence-quadspi: enable PHY for direct reads
    [v9,12/18] spi: cadence-quadspi: enable PHY for indirect writes
    [v9,13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v9,14/18] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
    [v9,15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v9,16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v9,17/18] mtd: spi-nor: extract read op template construction into helper
    [v9,18/18] mtd: spi-nor: run controller optimization before dirmap creation

Checked 178 series in 6.44 seconds.
This project currently has 16642 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

