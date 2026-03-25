Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F933E3149
	for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450625; cv=none; b=Y5J8zOrVc99uancPE59cPM0Gtn18LRKUy/AO1MA9IiOt5wcOA6mtuAKHpNZy/KUDq1xRJ4uAURms2cbQoqfDjHiHFFt+9RzdAGOg7ungsl+2CY2OJChUrhew58GsMJXdamY0xZNtrJByIq6n+WPZgqFtDA6VyhIsuiP+E9yaGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450625; c=relaxed/simple;
	bh=C2kbDuVqLVzbyIC7bBO7XZeiD6u8NcB/09XWPH73g3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TOyWBz2RJ5P5RDb20ku8E3dxZn+PzzyAtmLsOeayERb/awcHRuZluzPbXf21Jxd3KHUgYpxevfb1CnbBX7z1IoS9tVEf5Lq8q40SAjz1poM2NDbC0wPrkSU4C5kaZoDwGT8ixUUl8mO6DdduH0MK23Zfdh3xoXmjqrPHDfszp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTChLLNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTChLLNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B58C4CEF7;
	Wed, 25 Mar 2026 14:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774450624;
	bh=C2kbDuVqLVzbyIC7bBO7XZeiD6u8NcB/09XWPH73g3g=;
	h=Subject:From:Date:To:From;
	b=sTChLLNSjJsROcfl5HPyIbjOHLKUlRy/FtRrbZXE7yeq9IFlraO2c650ButSpgp4J
	 zxVhrlUD0aMgMB9V3W+jSFWqb4TWNRVFkVL/xchGR+tAJjmOyUqZw6pVYg/UJwQ0dF
	 T64BFEgaz0o7W4Jsf8aJQN+SEXfSwweLlec4MsZUPDd5MVEe389Untk/T3+tcMqJ7T
	 F5ORZTGtza2M0VviSmyLuoiWbfCk0X962feZKTvLywtzZbKYGXqP6TC4cze+FcSd+D
	 E9879zJIuHTSAsAU7m6WxqZhWhy4a1uon/s9oYr3BXs1g/NOC2uEwQZzsEfC5mNWI1
	 5pb5kWhgE/PfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF4C3808205;
	Wed, 25 Mar 2026 14:56:53 +0000 (UTC)
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
 <177445061183.1665755.8902212080584416706.git-patchwork-housekeeping@kernel.org>
Date: Wed, 25 Mar 2026 14:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] lan966x pci device: Add support for SFPs (2026-03-25T14:35:27)
  Superseding: [v5] lan966x pci device: Add support for SFPs (2026-02-27T13:53:57):
    [v5,01/28] Revert "treewide: Fix probing of devices in DT overlays"
    [v5,02/28] driver core: Rename get_dev_from_fwnode() wrapper to get_device_from_fwnode()
    [v5,03/28] of: dynamic: Fix overlayed devices not probing because of fw_devlink
    [v5,04/28] driver core: Avoid warning when removing a device while its supplier is unbinding
    [v5,05/28] bus: simple-pm-bus: Remove child devices when the bus is unbound
    [v5,06/28] bus: simple-pm-bus: Populate child nodes at probe
    [v5,07/28] driver core: fw_devlink: Introduce fw_devlink_set_device()
    [v5,08/28] drivers: core: Use fw_devlink_set_device()
    [v5,09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
    [v5,10/28] cxl/test: Use device_set_node()
    [v5,11/28] cxl/test: Use fw_devlink_set_device()
    [v5,12/28] PCI: of: Use fw_devlink_set_device()
    [v5,13/28] PCI: of: Set fwnode device of newly created PCI device nodes
    [v5,14/28] PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node
    [v5,15/28] i2c: core: Introduce i2c_get_adapter_physdev()
    [v5,16/28] i2c: mux: Set adapter physical device
    [v5,17/28] i2c: mux: Create missing devlink between mux and adapter physical device
    [v5,18/28] of: property: Allow fw_devlink device-tree on x86
    [v5,19/28] clk: lan966x: Add MCHP_LAN966X_PCI dependency
    [v5,20/28] i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
    [v5,21/28] misc: lan966x_pci: Fix dtso nodes ordering
    [v5,22/28] misc: lan966x_pci: Split dtso in dtsi/dtso
    [v5,23/28] misc: lan966x_pci: Rename lan966x_pci.dtso to lan966x_evb_lan9662_nic.dtso
    [v5,24/28] PCI: Add Microchip LAN9662 PCI Device ID
    [v5,25/28] misc: lan966x_pci: Introduce board specific data
    [v5,26/28] misc: lan966x_pci: Add dtsi/dtso nodes in order to support SFPs
    [v5,27/28] misc: lan966x_pci: Sort the drivers list in Kconfig help
    [v5,28/28] misc: lan966x_pci: Add drivers needed to support SFPs in Kconfig help


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

