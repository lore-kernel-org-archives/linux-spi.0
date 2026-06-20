Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4541FD4;
	Sat, 20 Jun 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944995; cv=none; b=Z2YBX5oKrSO1Uf0ljHIuOi0XbFUqoLFa6sPvYPVMFDJXt1w+gYLycuqnN0VZBpvIrJeJFXu533dN2XLXT1jCtpD3q+aXhsXaLAXV71TyAMOMOHAWeKGKuwFtDSDrWaMfCsV7aL1DUJjplPl6td62TFLwDVbAV2b9p4hACdEeipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944995; c=relaxed/simple;
	bh=1U9pYI0wSSG6JAEWKnYQlEWp99ffWxGo1xOGv0W4NII=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pq0s1a2KGmRy+oXVqZzKp1+cwWGVIylpK6LsukcykzVMBEAAwUboGA9+diESh7g1mqGBtEanb/mSuxwdbMuMODCZR6V/DUuhARs3lOxsL7t59AG1r77cpoMYMKBO+/YUmSpd6yd8cyST3wGjFBNjz6R+t9up2VqPQGy83kKkFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ytcJh4vJ; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ytcJh4vJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781944989; bh=DSpD8SrbGJSSt47g+ep/HUhaAmDAdDice/9Pn7cUpNg=;
	h=From:To:Cc:Subject:Date;
	b=ytcJh4vJ40rGAgVoR5OOEdhz+6ev5yCcrvaf6sbMUsOcNinONN6vzFRJBhHzp7gxP
	 okT1pya47K1jefpfKdy5F+3uAvaoIBFRwvWXmEXvU+lUmqb1yuAZ4V4QGfETSLqZzk
	 j+VDBPGYG7TM7LDREMyeApmNTZkPHCJ+f2jqwl7Y=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 9E3A1AF0; Sat, 20 Jun 2026 16:39:35 +0800
X-QQ-mid: xmsmtpt1781944775ti7z7fdcv
Message-ID: <tencent_5169A5493D56510D24B06E86D31960E0AF06@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJxg2POt1M8rOE/F0jF6WoYwRM2fNOQEiTuWLToIkRC+gTp4Mr3W
	 jJxouHgRpdMgSNyIPYbfq4fvQmMpqM9GMdRB6R9p61aIW0MVRlfvPPmk9zHMfgh8/RLcH37CXZe+
	 ygT0BrECpmuVpiBaFacYbGUocBgeCpL8PxRlcdq2VD27/cdjMy5itlJRlPfhxf36TaTTAK6e6rPf
	 Bj5urCQYj22UwVA6bfMd1m3NPlbRdns5b5yaEyhmjMqsmQBJWJtUcJCSumo2wuRkiDHE68HvPDmU
	 Bd5quvZeWihBUhxuxahdVdknkVZW0cwprd83LYmQu7FoI9vCy1AbafCNTwnQRzcYLZoY824fCDbr
	 P7/oeQqnjlXEQhPO5k5v3+cdLltQ4TeWnkCyqI+vG+NQAgetfulk2rUbmKc4XBRzq72VzwEKeiKh
	 b2+gRWpgWWd44yuGTh3zeQrYy5kK5ycBtTDceOcdUipwqlXhRxPbh5E1BlINE0tBJQJ5+qNPyeH/
	 GclEnQhBl7kCg/3ExGJPvNIy54RZFFOQWKQy+UJqQbjCEC9/cCJ7dA1+LY13VjtaPwQxS2DKn77R
	 AOvox2u8iWqezI5fOmyXMrV+5X7v/p1fFECKHRPnvH4suML4yzf5C102uzbt2z9E1k+VZyo3nhkf
	 O8H8RJVABEmVIohrGsCJ2P/ugLRwmALeV0QnoGBs5wupUanB8xk/0BQSj1E6qx+t1wEz1JszTLyd
	 iarubmxWSNqxXnvJ2n5hkDCRSot6OzVjMr1XDZIaqdpruP6SC5JpFVzDu0+UgvDsOz5sbL2svaSa
	 RsbDJRQYp1Nw2axWB9j80+/keDcaewzuNyOWF9U3TDKPX9aQInM9vQZm7A5pd2SDXBDOuXuQ4kIn
	 RIo7yFhEWBRKrb+gH5fh772fFsMi5MwA2w6YhbDPHsO8Xsx885LemIxxaJswkBYwXnmEwiD1x6xS
	 7t1UtTpBKxllTvFQcYgGzW3VXPuHpjE9M8897EKypvaFujwkKSbUvbXzbX9pJp4cd8Rn7eMnoxTi
	 bEGOWA0TKn47V5DMY6a/76XJDq4+5OFlNcCG95dg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jiawen Liu <1298662399@qq.com>
To: broonie@kernel.org
Cc: cl634@andestech.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	anand.gore@broadcom.com,
	f.fainelli@gmail.com,
	rafal@milecki.pl,
	olteanv@gmail.com,
	han.xu@nxp.com,
	haibo.chen@nxp.com,
	yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH 0/4] spi: fix PM error handling in several drivers
Date: Sat, 20 Jun 2026 12:39:27 +0400
X-OQ-MSGID: <20260620083931.1120616-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes several SPI PM error paths where drivers continued
tearing down or reported success after a controller suspend or runtime PM
operation failed.

The patches are independent and only touch the local error paths in each
driver.

Jiawen Liu (4):
  spi: atcspi200: return error from failed controller suspend
  spi: bcmbca-hsspi: return error from failed controller suspend
  spi: fsl-dspi: clean up after failed suspend and resume
  spi: nxp-fspi: disable runtime PM on probe failures

 drivers/spi/spi-atcspi200.c    |  5 ++++-
 drivers/spi/spi-bcmbca-hsspi.c |  6 +++++-
 drivers/spi/spi-fsl-dspi.c     | 21 ++++++++++++++++++---
 drivers/spi/spi-nxp-fspi.c     | 31 ++++++++++++++++++++++---------
 4 files changed, 49 insertions(+), 14 deletions(-)


base-commit: 9e7e6633458362db72427b48effad8d759131c35
-- 
2.34.1

