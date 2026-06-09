Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0800231832
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981100; cv=none; b=nNIYKr5A+NL0Cji+AsOtzqayW+9PrkZ/ql+sqT748UMgz1kMHKnIeyEQltIITtvrrLEXP61Okn80L5d2LGLCm+PQYgNgu+PZbCut06eHuhkiT0KEbWGlYlnAxF8htVLE4Wr17MF4H1uJcHI6EzwCa4o43TS1AO2X+fJi2SGHj2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981100; c=relaxed/simple;
	bh=HSwKKQh7g/T9T0Rj76Oc3nC7/TFP7x3PvAsbH4v2SOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RkqtQbUWBHBEpxKZ1S3d7+we3aN4siwPYm2HuoCj3zqY2SnmKHm+wm4KLX4gz5PTfdv0lxlNmzxsgJQy5y48ygcu+GKqc7fHjCGysGu69APYZe3x8GNO2wyPPjCPhhSfbniRHE22DnOazLO+b6H50Lzo+fxVXlTgpz+8d3tSRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izzdmeud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izzdmeud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466D41F00893;
	Tue,  9 Jun 2026 04:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981099;
	bh=8AZ+KXX0LVEW4jU5cwqaO3K6b0GuCAZFk80dqCHZxs0=;
	h=Subject:From:Date:To;
	b=IzzdmeudQCKWJ/zS2ORm6o5u5ThBuaYm7y2nQDaesfucxrtI8estNIbrftzMZJqXL
	 KCJKRoaNsiofXP9u22YSQ/mNat812uDb8JbkRdijeVwAAJrlcNmaMzSQ/Bw6JdFZ2O
	 s0IBahzdKff3U7g5C0wOd774rN5vSPeT/0BFc7LOuBLLE9KXiPJiBLJL4HaL82VouC
	 fzGreAUkgDMfXI5evj6gTOcvMLVQBc11J4+RC0tIapjtt8CKpza1bcAQTc+T2W1JY7
	 c7l8NH1+FhKRC3QFGq5I1+6udZQaCVqSvdeuAJBZxjaKVQECWVQcnGfW76Rzue3KhG
	 qjiM7sAHP9lYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199423822D56;
	Tue,  9 Jun 2026 04:58:19 +0000 (UTC)
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
 <178098109780.1799634.7403815353595176589.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jun 2026 04:58:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add spi-hid transport driver (2026-06-09T04:40:52)
  Superseding: [v3] Add spi-hid transport driver (2026-04-02T01:59:37):
    [v3,01/11] Documentation: Correction in HID output_report callback description.
    [v3,02/11] HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
    [v3,03/11] HID: spi-hid: add transport driver skeleton for HID over SPI bus
    [v3,04/11] HID: spi-hid: add spi-hid driver HID layer
    [v3,05/11] HID: spi-hid: add HID SPI protocol implementation
    [v3,06/11] HID: spi_hid: add spi_hid traces
    [v3,07/11] HID: spi_hid: add ACPI support for SPI over HID
    [v3,08/11] HID: spi_hid: add device tree support for SPI over HID
    [v3,09/11] dt-bindings: input: Document hid-over-spi DT schema
    [v3,10/11] HID: spi-hid: add power management implementation
    [v3,11/11] HID: spi-hid: add panel follower support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

