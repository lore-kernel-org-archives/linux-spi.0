Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A42773F7
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184317; cv=none; b=kn7cqZqfwJowkzI/Oco7dVcHx1KPKkY+cDUJvLSac9SQWtvP5fGs0RQySTFVI4DhLzK2tscnfK6exNAmS/JHxINGTJ0/H27X1wNQ6qU5Vd/QS+AVhyGN2UIr/z2SvHaBs0r4Ed6dljpdgVg0z80hPEbKgeaJl4ZEASFjBUT1Ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184317; c=relaxed/simple;
	bh=/pFp4X/hldirns2lGaAGHkc9PX48E6Sgf6deTPdoPPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kGwinbl08qF7Ox7aTPdj0GKTSTTfZNUXTY+d/Y4eyFFpsnyJRnqp60iM5RfTnF6m1xxtiCvT1HVI919sFOfhMk3uY6rBekPzu0qb3RpKeH6k7gQmPAwa0UHonmef3XnJEtAwhsFjjVwhV5t8heORodxWbYh7OUUILSXdDoiiKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grr1l360; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grr1l360"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7CFC19425;
	Tue, 14 Apr 2026 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776184316;
	bh=/pFp4X/hldirns2lGaAGHkc9PX48E6Sgf6deTPdoPPo=;
	h=Subject:From:Date:To:From;
	b=grr1l360DmuRkWe7Jgrd2LrcHR78MFEWZRZ/V/aoULh7PT1tDczsAUbE32iUC1exF
	 Ona97clM6MnkF5EIEZfqGHrBg2wB8yGU/hUhisEu6HX60CEvGOgoZ/bO15Q+p65pbW
	 3Up5kCHI0to+I4t/JUCIDxMT3sSFiqe2zWG5157zkbdm7L7GH1v/FQJFP5DoTErtIP
	 Fimvqz19BmYr1k21872SdNgV4NSNgWCASisJ2B6FSSqIVkpvm+ONUtSywryJBWU80C
	 yoIbVkboHe+2Pv1Ol+2Nejol5QffKH29YadSc8CnF7kSO1G0h+wn9ywQGZ6IRjH76m
	 +BylQR8TpadzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42E873809A07;
	Tue, 14 Apr 2026 16:31:28 +0000 (UTC)
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
 <177618428673.1367635.764231938135442190.git-patchwork-summary@kernel.org>
Date: Tue, 14 Apr 2026 16:31:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: MAINTAINERS: update Socionext SPI maintainer addresses
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079631
  Lore link: https://lore.kernel.org/r/20260410083423.504695-1-johan@kernel.org
    Patches: [1/2] MAINTAINERS: update Socionext SPI maintainer address
             [2/2] MAINTAINERS: update second Socionext SPI maintainer address

Patch: spi: dt-bindings: fsl: Correct GPIO flags in the example
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1080595
  Lore link: https://lore.kernel.org/r/20260413085947.51047-2-krzysztof.kozlowski@oss.qualcomm.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


