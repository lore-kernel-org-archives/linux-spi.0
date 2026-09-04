Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11CE253B42;
	Fri,  4 Sep 2026 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491640; cv=none; b=GenaHdRXEy5N2LhkBHXiH1E/exZuEzWphrpU5aoJdXi4dI19qDRfpe7hIHuXK5tciiT+8PIxGCZhh1RUebIgNGvIu5v1nMITU4m+Jedf1AHYNyc4BJoOKpzgXli7lS3LCWcNmE9w+0+v9bJxS0U5wn1cQ+aLa2QgfCzHSsjsQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491640; c=relaxed/simple;
	bh=fg2bsL2pyLeKWO4ca9K3vU48m47qLXISWTiyTOg57hQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VHXGpNt0ytuG+nD50xYtEISEP3LSY7+jxK0B6zPOf/4m3TRIJUtXBlRr9BNBsrqVe16O3hEtRHskm188ziB0z9KRKAbgdAvtCOjRD6yjTB3edJ5KJZyCO/AqvYWCuubp+bEbHidqB+0YQ8k/fFnlCikCkBfnyJpgbaBfD/wzX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F0U1/avG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F0U1/avG"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6843CqdfE4114200, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788491572; bh=+3dQ4EXCJkdc+MbQXCx9yljD58LDbDwzPzubxY8NvWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=F0U1/avGNFsH8gJptrdkod8ybG6hWdmsu8sj94EQpTsl5DZcFjW5u1+bX/xbFt3Gz
	 G74xqQGYqIG5B+TmNaXbpgcu3W79akvVOUD/l9sEUzkUGykIk6YKKWXD3U46hox6vV
	 S7VOcmESUdU4Vh5XpQYLVyLzFD8htsCvxf7UvoT3osHwYXzzvveFLBqLfa6qYcTPsZ
	 MiuFDTG7Whzamb4RaV603kFrtJQy5gm8GTxxb01DOPy+RgbqsN6KegcSR2VDE3WlBk
	 EWk34d9SdIv2cIDgOUM2w+FUM3PeKO60GUfFkjH0yMrIMgVNZdmDACO30sV9OgqIxn
	 XUUxX2hhCMHiQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6843CqdfE4114200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 11:12:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 4 Sep 2026 11:12:52 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Fri, 4 Sep 2026 11:12:52 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <afaerber@suse.com>
CC: <bartosz.golaszewski@oss.qualcomm.com>, <james.tai@realtek.com>,
	<cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>, <jyanchou@realtek.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-realtek-soc@lists.infradead.org>
Subject: [PATCH 0/3] spi: realtek: Add support for RTD1625 SPI Flash Controller
Date: Fri, 4 Sep 2026 11:12:49 +0800
Message-ID: <20260904031252.244280-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

This patch series introduces support for the Realtek RTD1625 SPI Flash
controller. 

Please note, this series depends on the RTD1625 clock driver patch series,
which is currently under review.

Link: https://lore.kernel.org/lkml/20260901072446.2563145-1-eleanor.lin@realtek.com/

Thansk,
Yu-Chun

Jyan Chou (2):
  dt-bindings: spi: Add Realtek RTD1625 SPI support
  spi: spi-mem: Add Realtek SPI flash controller driver

Yu-Chun Lin (1):
  arm64: dts: realtek: Add SPI NOR flash node for RTD1625

 .../bindings/spi/realtek,rtd1625-nor.yaml     |  68 ++
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi |  16 +
 arch/arm64/boot/dts/realtek/kent.dtsi         |  26 +
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rtk-nor.c                     | 637 ++++++++++++++++++
 7 files changed, 764 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 arch/arm64/boot/dts/realtek/kent-pinctrl.dtsi
 create mode 100644 drivers/spi/spi-rtk-nor.c

-- 
2.43.0

