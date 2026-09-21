Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE7EADC;
	Mon, 21 Sep 2026 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966036; cv=none; b=T33AIuSKtHN1rTLDh/vccqfyd8Lss4tH53lNPhiT/36KbxBg4T8N22bsrvI92sid0x4+QHm6qaWb95+zKwpjZLvVf1FtvX5z6AktumhQ+Fet2m2KdbI9ntI5ycjdmWZiVkfLUcriPU2GISeziIlUP7rZj56dDLJ4uO7xW/Xf7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966036; c=relaxed/simple;
	bh=XxDwmfdIUDWyqlVI5hhxchI2Wk/tPHFBEBCwiSDUKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4/RazeR30+QIOrxuqrj+uyY4BcmVlb6FVDA2v86WUqAy1yNP7oAA+LntFV3JdtD9rsIswefQ+JJrs7VuA7rc02R5XKViibJgGW0P9f6Barcrr+/An2B3bfRdL22jYu3LwO2spYq+4L3dNEzwdA3xJb4FDkWoNXDxHeuwiebhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gv/nPdSb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gv/nPdSb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KxGvnw/5xU3OxeieYRGDVKgC69SCDP3MG6RmVEXPs3A=; b=gv/nPdSbWJpVS1k/WouW0dZdvz
	p0aYqKIVfHYj3DMowZ5udCEnGQuJbJx/T2hjIetsxfVZfhEjtf1gFZO/MzhBcvVmeAwUc2OE8YMux
	8ddC09uj2L00s8bEVc0OySz+iW33wwFqcnc98saiUG6unXX6v40psUu80jt6eg86SbbwXQybDcIhL
	SYAA7LSyVoGniuhkRRD4b5fBQR9rjZ1zKHzGII3K+ULtQwY7wFpmb5RP2q5a/hFPSjbTH8cMHWttc
	E+2kdVaNhYfh4kEnTgtNaLUpDDSFV+eiLq5z0KsiREd3HFBWjRcH2+uEkXCsqyuCYEB4yklAlsvhf
	QHQ4cZXw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Vvu-00000000r2z-1991;
	Mon, 21 Sep 2026 04:47:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vishwaroop A <va@nvidia.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH] docs: spi: spi-master: use literal blocks for commands
Date: Sun, 20 Sep 2026 21:47:13 -0700
Message-ID: <20260921044713.93122-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use literal blocks for console I/O to separate it from the
surrounding text. Otherwise the lines run together, without any
clear break before or after the commands.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Vishwaroop A <va@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/testing/sysfs-class-spi-master |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20260918.orig/Documentation/ABI/testing/sysfs-class-spi-master
+++ linux-next-20260918/Documentation/ABI/testing/sysfs-class-spi-master
@@ -17,7 +17,8 @@ Description:	(WO) Instantiate a new SPI
 		with delete_device; platform and DT devices are not
 		affected.
 
-		Example:
+		Example::
+
 		# echo spidev 0 > /sys/class/spi_master/spi0/new_device
 		# echo spidev 0 10000000 > /sys/class/spi_master/spi0/new_device
 		# echo spidev 0 10000000 3 > /sys/class/spi_master/spi0/new_device
@@ -30,5 +31,6 @@ Description:	(WO) Remove a SPI device pr
 		new_device. Takes a single parameter: the chip select
 		number of the device to remove.
 
-		Example:
+		Example::
+
 		# echo 0 > /sys/class/spi_master/spi0/delete_device
