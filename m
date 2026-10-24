Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803580;
	b=D8f/tD90k/fl3IxLKpDCetY75cCH5zRSrru7PnPTvnrNKZAVVVldiJJWQ+P1cgjhLmv0
	 CebrwiGOKDMH/B2zW5dmHp/MXodrfGzuTrpIPSVqVGlU+N0sh5VaqP1fYDMSaTl9PG0jr
	 5ki4Y1NI++R8xB5sFn8JiBA1mt+9eGkfHWS/vz9vyFI8Ys1FDlu7nT8Z7w9Q0wlk+rclM
	 9hnAwYqFrqEIjiUxQ4c+xusWL0IDpq6TK4kJHS0BpJsGNEhpRcQrgRsTJqffrSIb9VpaC
	 lcoNUcm9mpG/r8BJWkEWBCHklry8YUPKK4Lox38uOSl7IYsN+5qGI3DLDWUZVegVi3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803580;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=VexWDS1fKosoUJAk2qHiwjRsT4d5UNpl8t3uJG4YgRg=;
	b=UNe9aL8Q3a4LD7IHJxk0RmYxPgBVcdnJvCO7LXLsVvGYP8XbczWKwKMc9v+xByqyjPqp
	 Zmxoo5IJ8BxZ9cdvvjJmeZKYA4BLhjlwmkFA5kWeybc4dpfRtF3fNcorO0DrvJUspkskc
	 TxFuzhnsR+ZqQpfQa0x9dNi20m+MJBdSllgH/LScg5cHi+ixOSW0v+AuQxAgMvtMBnbwT
	 cdaoWBfen+QctnFxzS8TaAcmKlKPeQaf5zNPAwWqTbP91uzUa9fU+Rs/zhouLQ8CfF/wW
	 v62FcSKEATVAGkAajjMjTTKhAr1JySUWnKUzLIzrIUkMBOKAa4OHu7sfC2h3fm4kXDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCf1LBSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481D606A31B
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCf1LBSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BCE1F01828;
	Sat, 24 Oct 2026 00:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792803579;
	bh=VexWDS1fKosoUJAk2qHiwjRsT4d5UNpl8t3uJG4YgRg=;
	h=Subject:From:Date:To;
	b=bCf1LBSyxjET/LS3YwHK2+d/IsRuOLwC8rlH+mFFGdiyeQA1Pi8+zuxLp3lGZJf4D
	 UIF573O6AdhDR6bjls7nHyxyLEFPzqcyd12C3UuhoIdeniEepSkm3cGdshnys7i0Jh
	 k52gh9RuD2P5YtE6YUWM7199hefOtMhJhnicpmQvfKWRMuDnm8imYlRyfaE2Hb6lQo
	 eoaIJHhxI+Z1jIySnzRIS+fxjJzDRLsXdxONTveR0g9bSECZS9pIOSSQGvEl4ovy8d
	 eE9B0S8pvVGEqUgM6J8IbFgg1a6uJK1Lwyque28qk1ye3u2391RrO2fr4xehlYCkWo
	 f1763hgsgW3zA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815D7391B16E;
	Sat, 24 Oct 2026 00:59:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179280357821.1381157.10456221629651456857.git-patchwork-housekeeping@kernel.org>
Date: Sat, 24 Oct 2026 00:59:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add spi-hid transport driver (2026-10-24T00:51:34)
  Superseding: [v6] Add spi-hid transport driver (2026-10-19T19:01:12):
    [v6,01/11] Documentation: Correction in HID output_report callback description.
    [v6,02/11] HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
    [v6,03/11] HID: spi-hid: add transport driver skeleton for HID over SPI bus
    [v6,04/11] HID: spi-hid: add spi-hid driver HID layer
    [v6,05/11] HID: spi-hid: add HID SPI protocol implementation
    [v6,06/11] HID: spi-hid: add spi_hid traces
    [v6,07/11] HID: spi-hid: add ACPI support for HID over SPI
    [v6,08/11] dt-bindings: input: Document hid-over-spi DT schema
    [v6,09/11] HID: spi-hid: add device tree support for HID over SPI
    [v6,10/11] HID: spi-hid: add power management implementation
    [v6,11/11] HID: spi-hid: add panel follower support

Checked 203 series in 5.84 seconds.
This project currently has 16820 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

