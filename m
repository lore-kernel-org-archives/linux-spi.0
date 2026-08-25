Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5223D9DC1
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680740; cv=none; b=d5hSVOVva99o/tAVg7PB1t27ElLPHpgVDsygrKuRILqVxOHjASAwr/+f8N4ZLnq2Z0WB70H8UD3SYihkoWObeEm0N18WLZUVZl2L2YInYZ2tnVP4MKEA7DNXnJAXZpKb5Ccx2OSXyRoOqehQeGEGr+IL9JWH80MYzUHtF8XwcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680740; c=relaxed/simple;
	bh=WEE8IHONKsDQ5kgdAA92Pquap+M2tHqBASQUaZ6T1+M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=b42gN4dBc72y+4FyUtW+dTV+vHCBVZqeNca4r2p/UB5kp+7WTaKvUlVS1weptu0oYjnInmWpD2hAYOt2O88zCDIN5qS6QMEpwa/Gi7xKrKAegCnzr9ZH+ZLoukw9rlPnRTEgCdMZnE21FfOYd314XDK6US3g4O+5pX795mZ5oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPlstvhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPlstvhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B81F000E9;
	Tue, 25 Aug 2026 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787680738;
	bh=sAYAo2Q38QJhD99rhFZSrKgL2dRbMx98ONzmKR9hMm0=;
	h=Subject:From:Date:To;
	b=cPlstvhZFvvcJ+aDPHaVqamRxNhNDlRzWjjOxrnrhDJUy6t8c+T01PMBXadViZmHe
	 N0afTrQ8unwBHzX5lIwBoZg4LzWaVS0O/GSyn2LDBU0ma7dPGotBw26HN87qrfdfZO
	 jcBuLob4T+T1Aw3bJgSlerfZtEMAikGr570RBS0peT9av05YQk03rKAlXFCq0Y3PYq
	 6Lb8GZLGqSMC9RZJbpuaik1MpzXPn9ISyamygJlbNMcfJIxMmYjmT0RMuzUx1nx0eq
	 W6BsT8y1wLwK69SBPTNF9mqUAJ1n0R4zTty4hC5UvzdShYEaS/atJ2nA4RG9EcGxKF
	 e47mg3G0NUMCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098539253CB;
	Tue, 25 Aug 2026 17:58:06 +0000 (UTC)
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
 <178768068534.3990699.11044046925119786349.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Aug 2026 17:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] spi: cadence-quadspi: add PHY tuning support (2026-08-25T17:17:22)
  Superseding: [v8] spi: cadence-quadspi: add PHY tuning support (2026-08-21T11:48:04):
    [v8,01/18] spi: dt-bindings: add spi-max-post-config-frequency-hz property
    [v8,02/18] spi: dt-bindings: add spi-phy-pattern-partition property
    [v8,03/18] spi: parse spi-max-post-config-frequency-hz into post_config_max_speed_hz
    [v8,04/18] spi: spi-mem: teach spi_mem_adjust_op_freq() about post-config ops
    [v8,05/18] spi: spi-mem: add execute_tuning callback and spi_mem_execute_tuning()
    [v8,06/18] spi: cadence-quadspi: move cqspi_readdata_capture earlier
    [v8,07/18] spi: cadence-quadspi: add DQS support to read data capture
    [v8,08/18] spi: cadence-quadspi: add PHY tuning support
    [v8,09/18] spi: cadence-quadspi: skip DDR PHY tuning for 2-byte-address ops (i2383)
    [v8,10/18] spi: cadence-quadspi: refactor direct read path for PHY support
    [v8,11/18] spi: cadence-quadspi: enable PHY for direct reads
    [v8,12/18] spi: cadence-quadspi: enable PHY for indirect writes
    [v8,13/18] spi: cadence-quadspi: reprogram CS timing on every chip-select switch
    [v8,14/18] spi: cadence-quadspi: reprogram PHY DLL on runtime resume
    [v8,15/18] mtd: spinand: extract variant ranking logic into spinand_op_find_best_variant()
    [v8,16/18] mtd: spinand: negotiate optimal controller operating point before dirmap creation
    [v8,17/18] mtd: spi-nor: extract read op template construction into helper
    [v8,18/18] mtd: spi-nor: run controller optimization before dirmap creation

Checked 161 series in 5.05 seconds.
This project currently has 16393 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

