Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEE28751B
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774335439; cv=none; b=I0yR5A3/IbNnQq+LyM5KeTtNFYSheXdXYfr8Q1TmEkYs61hTnAm4RRznMNsO195PLtdjcQCrdPyjyVNprR7rCSbZK+IVX6hVSI5c0N+uYsPOK+wmF0xgClhF/1TKAaNK3X5jGc1YMcJHAdwJUOQwGCrIsyOs87ThB2eOyfu3x78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774335439; c=relaxed/simple;
	bh=elBEOM+MANnIy/06BTL+UE3SApdegp+gIDe+sZtpdnE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ncfofktrO1fRIr5VbztP3YxWw8TXfD8Gmtjf0RiNMEq7iSSY54UWbdzjav49p9sVPBL2sr7ZKDDhGk0jMga1NB0HwnT6QF56YzdSSGvx8pND+nqvhqQmwAkP7YuJyWXGzEiXegkjldXIF0vhOqgpD6i9VI9onVZ+u6dJoEPC6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SodgiuqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SodgiuqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3400FC19424;
	Tue, 24 Mar 2026 06:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774335438;
	bh=elBEOM+MANnIy/06BTL+UE3SApdegp+gIDe+sZtpdnE=;
	h=Subject:From:Date:To:From;
	b=SodgiuqONT/FNwSxbBnRIQQGkS3LxnaoUffa7plarsN8JMdj6i8AIYLdp6PQr2LR8
	 jq9Mspm0kQu0lgzJhx5L8sOs81KpfIFErPVUP7+R0/dwWVyKX1tr3ftVeQT/qhXSn9
	 ej82LnaHG6nhxXQDI9U+usBSnzeYwT2KgjNXlqUcDY9Q4w1MZ6oS2KYwNinZ5OiX63
	 FKSP6ks09GOXDwMNqMuzhnT0LqBIJAbuZXJ2O11PuEQqpcsAFClvv2NU6sAgU19g5H
	 kKuVkYL0WB0pyKYUFppULK2n9ggLGyh+TKeaEX+ODXKnkWy18qT7NGWaMo3eGP5WWh
	 7y+H0H6GQ5t0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF543808200;
	Tue, 24 Mar 2026 06:57:07 +0000 (UTC)
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
 <177433542612.530904.4541944264007054838.git-patchwork-housekeeping@kernel.org>
Date: Tue, 24 Mar 2026 06:57:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add spi-hid transport driver (2026-03-24T06:39:33)
  Superseding: [v1] Add spi-hid transport driver (2026-03-03T06:12:53):
    [01/12] Documentation: Correction in HID output_report callback description.
    [02/12] HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
    [03/12] HID: spi-hid: add transport driver skeleton for HID over SPI bus
    [04/12] HID: spi-hid: add spi-hid driver HID layer
    [05/12] HID: spi-hid: add HID SPI protocol implementation
    [06/12] HID: spi_hid: add spi_hid traces
    [07/12] HID: spi_hid: add ACPI support for SPI over HID
    [08/12] HID: spi_hid: add device tree support for SPI over HID
    [09/12] dt-bindings: input: Document hid-over-spi DT schema
    [10/12] HID: spi-hid: add power management implementation
    [11/12] HID: spi-hid: add panel follower support
    [12/12] HID: spi-hid: add quirkis to support mode switch for Ilitek touch


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

