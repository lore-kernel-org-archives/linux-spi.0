Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B132AAA8
	for <linux-spi@vger.kernel.org>; Tue, 26 May 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779829884; cv=none; b=Sn7djFD6WBffIC0KlPpBL4ukVdJ5FwZJrqbAKWSJPWRHsvzQJ1FigIF98ZJIItvJm5ATr8ah86RVExYlvuYrGkaSyjKv65m5a/numdpSvpsezSd1gWb2u+gHdCbbdThJT3bpMqV2lFe2MYt4WFZtExPjw+tlw5GvSxUcIgT/jhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779829884; c=relaxed/simple;
	bh=QrpkJY3b47FNejLoGeW8po2+n/nNjoJvB+QAfsPv79c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kw4oAUIJ2UTBRWFACMaayaWImZ2ySVf2toPMXfHNbAB7fSVjiIWHcqYHYAawkaqbzyN6qc9YQzVjnwI3EW/7oh4lpadpexFtRbzHBUP7nfKYeMhYDWYK/R84RMud/8vNmxxoEsOjKLoUFXSPyzgEVrIBBxIfyhLEtlFc2O9c60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhMWHHkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhMWHHkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E51F000E9;
	Tue, 26 May 2026 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779829883;
	bh=s5nImzJ6M7Wz0GArXLfTolUAKMSXpzPhOlGBtlUeTKY=;
	h=Subject:From:Date:To;
	b=lhMWHHkTDfSkJpHwoZCWQ8tUKkC8ynUzmWn5eKki1k31JqsEXwddhlI1loxT8ihbt
	 U0qF1nGoivAoghZFdP/H2ma/fIp6xuT0O3fFLcdKAONopkBI2aUX9c9xEVDm6J5+3U
	 14F9ESrmvORURBAgI30uKfV9MLpQwr6JgOgSIPz1Nry5wknHWuiIY8UNpKzyUGokdH
	 BS5d8VfWFcw8PI+F2m+77GxjBZnjM3Z4hl/jZnG7fItMb1B7UDXH4SG/Hgcg5k9hca
	 t0dr0ap6ZI2LJwb5qoL7iRCR/4uSEsFDs/8q7gAyCuid3twwqseoL5TSTpIgA2Qjha
	 xsXT0IwKZpfpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C6CC380CEEC;
	Tue, 26 May 2026 21:11:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177982988869.3974649.8523556212038117953.git-patchwork-summary@kernel.org>
Date: Tue, 26 May 2026 21:11:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [GIT,PULL] SPI fixes for v7.1-rc4
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1099547
  Lore link: https://lore.kernel.org/r/c3dfa0ed3041398d4443c1331c7334b7@kernel.org

Patch: spi: amd: Set correct bus number in ACPI probe path
  Submitter: M, Krishnamoorthi <krishnamoorthi.m@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1091216
  Lore link: https://lore.kernel.org/r/20260507180051.4158674-1-krishnamoorthi.m@amd.com

Series: Enable QPIC-SPI-NAND controller for ipq5210
  Submitter: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1094613
  Lore link: https://lore.kernel.org/r/20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com
    Patches: [1/2] spi: dt-bindings: spi-qpic-snand: Add ipq5210 compatible


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


