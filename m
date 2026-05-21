Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2204F2F3632
	for <linux-spi@vger.kernel.org>; Thu, 21 May 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403819; cv=none; b=FU9GwgbsBt/p1ol+eURmU2WDhWmcJNrmxSt/K5LN0EeQksbudp8jSJIVcN3b9JtIaouAN2XGN3NqrrnzU4s5kYmGcT+2sFNKHELoAERsyB1l5DYB5fpTRsNfN9DOco1aqxv1WBLezbQqrrlOZEDe8zEmNtGXGVtgMLiIfeB98N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403819; c=relaxed/simple;
	bh=PPiaHGy1DwGIleXcRpwmSsAwXduDFHOwvYbMD7xKbqY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=lM6B4ruJMOnBjkVIOxs/yvProPAZi8VxhwoGMkeBze0SOELFPA8x7PgUImL6x/eKawUcP65JQqNI4pKGm4aMS/H8qTzesj4+RZTMwm4OriYRgllFbeDtsyrBxwj5SYnQKPrVORSgRve6vXuJywXM0tjiPhemBlhMH5nSPDOsIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHJcgNgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHJcgNgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6B21F000E9;
	Thu, 21 May 2026 22:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779403817;
	bh=EQ76MdEe+pzRP1oAJh3GXsXs68xtf3lS2yDAc0i5oXk=;
	h=Subject:From:Date:To;
	b=VHJcgNgX/481IzBlFwc2Uu0zxJIWM07VL2V0HTFBLBvFTZmHcXQF8s2NWvbQlPHwX
	 tIBG9ZITVA5PN31q54e5wzEIlPVb0RChKLVSmwy6Q8wsToRBbh4n6RbMetNFp6emc8
	 pYI1QMA7nj0+nFoFHH0HkJ8h/L4ASfthy+rbxAPUGk+v0NkAXfwxtzKmVhBEYsz6mh
	 +kAY3qqYK/7FuGan9X+1meBl5QMthunQQKL2Idg7eZja5d9j6FPy25Z+nTFZuiIoFK
	 F4L5Z+p3Ltu4zpllyh8UUNoSivKTqMJjFp272WA4c6pbyfCc0Aa3XmaNRnT1xVgQI4
	 GiuiAeEEDzGFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 965543930E3C;
	Thu, 21 May 2026 22:50:28 +0000 (UTC)
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
 <177940382730.542836.10157807400773351626.git-patchwork-summary@kernel.org>
Date: Thu, 21 May 2026 22:50:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: fix controller registration API inconsistency
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1098520
  Lore link: https://lore.kernel.org/r/20260521073816.766596-1-johan@kernel.org

Series: arm64: Add LECARC ACPI IDs for DesignWare GPIO, SPI, I2C
  Submitter: Thomas Lin <thomas_lin@lecomputing.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1097836
  Lore link: https://lore.kernel.org/r/20260520081140.637637-1-thomas_lin@lecomputing.com
    Patches: [v4,1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
             [v4,2/3] spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs

Series: Subject: [PATCH v5 0/2] arm64: Add LECARC ACPI IDs for DesignWare GPIO, SPI
  Submitter: Thomas Lin <thomas_lin@lecomputing.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1098400
  Lore link: https://lore.kernel.org/r/20260521-lecarc-acpi-ids-v1-0-ae0ae90b2817@lecomputing.com
    Patches: [1/2] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
             [2/2] spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs

Patch: spi: Drop redundant 'cs' variable declaration in __spi_add_device()
  Submitter: Prabhakar <prabhakar.csengg@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1097872
  Lore link: https://lore.kernel.org/r/20260520091342.68029-1-prabhakar.mahadev-lad.rj@bp.renesas.com


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


