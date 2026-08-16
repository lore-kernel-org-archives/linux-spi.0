Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4532A3DAAA4
	for <linux-spi@vger.kernel.org>; Sun, 16 Aug 2026 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786921128; cv=none; b=GoNJZmoISB9DHHGpS/wdDjh/AFkN72zq+c3FkbdJ4vrzBFIc//LHRVdeDyFd2Tj2w4l1z2nwSDbSTX8L3A403A478FFOb7wusuTWEhcCcSRwxO30hLGa+lM8HBMWFmPW3LooG0ULA9PrLELrOTFKI222vXWRtO8GO4i+wTBpEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786921128; c=relaxed/simple;
	bh=APCcJzP7cQt4kfEJvJhUG8SOrMcqbLlhmGoCsK3aOkM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gqwp5ZewrgkBdwFmYcR4KseCFVCSQ39B4HHqVfEfMZuwwCOcIbEj7yt4IHj/RfVpD8J9M66fSlQw+itP87MeL4/aqdB85026quGckFkD6daY5Si1rf4AP0B/TAR6K/wblXUugfuM9gArLdmSQhLheoulDZupTjZxYsL2pKrlHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXJDyIct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXJDyIct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D31F000E9;
	Sun, 16 Aug 2026 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786921126;
	bh=tj+dIwgnAR4R9z/hTgHKpbdnuwRZAaLqe+ooBxAbKV4=;
	h=Subject:From:Date:To;
	b=OXJDyIctOe6nBgUFztGnY6CbpPK1OwP03wH7N3a3Jwq1+f1yLgQd9qHsyFcrb+l/t
	 U93FpkqV2UHDRJGVPr70TC3BNnYID+h87w+8ggr/0K/6s3Lie6kBFTJxRjijWZPzzj
	 +IBN54Dwq0F0pFjUahUXqz4Dc61y/t9XbcXz8/73t136KRbCtZb+scX8OAoq2Vn3kh
	 okX8LX7lHrk1pV0ft1DMefmaVpzWHe7ujsb1W/Pz+L6M+MXgalZx9njg1WtXrVbBjw
	 4c+7VGHjMG/+W7E4j4xPQA4sWB2KaAVdmiJ+OM6Sw5Kk8ofIGghDWMyX97Co9wChMO
	 D4H4Rrt8vFihw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 592B53924FDD;
	Sun, 16 Aug 2026 22:58:00 +0000 (UTC)
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
 <178692107884.411653.12081155153400773883.git-patchwork-housekeeping@kernel.org>
Date: Sun, 16 Aug 2026 22:57:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: davinci: Convert bindings to DT schema and clean up DTS (2026-08-16T21:55:24)
  Superseding: [v2] spi: davinci: Convert bindings to DT schema and clean up DTS (2026-08-15T22:23:05):
    [v2,1/2] ARM: dts: ti: keystone-k2l: Rename ti,davinci-spi-num-cs to num-cs
    [v2,2/2] dt-bindings: spi: ti,davinci-spi: convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

