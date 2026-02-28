Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B512FA0DF
	for <linux-spi@vger.kernel.org>; Sat, 28 Feb 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772286950; cv=none; b=JCsj5YCoZpT5pcnjx0AC2uHgSnxKaicOmDHUXopJcJhM/XBdwrnN7r4pMRKdGVs6eOj2wBaRyGFSQSCRVfQ5fTFRFm11xQ0/dePflbCS5FVudUHglBmdr7EKho3heVF+VDDdSchTluYHwYpafRGOfQH5NJ4iiBnPY/Aj0X1qioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772286950; c=relaxed/simple;
	bh=GK1SVW9AlNeb9NGevBys4Kqa9uLvCZOpmZbF2RRU3yQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tQqXqJ5p6LDaZvPM25W56FfceIVSnvaPNU81stE+NrhTHqMKLJDT0jW/zP2DguTNCU3z71Qn6mAlbJOM17qknuuTAG3kp6z3thue1iFEL3zkM+QtfQ0L5IfLsu+LB5DD2cfNc5MIg3LyWulDT5h3+4CgJkjzNsQoaoTTEal5J2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cFfl+wIF; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cFfl+wIF"
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id w4wMvUMWhCxrGwKlov48cX; Sat, 28 Feb 2026 13:54:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wKlnv4DjySqlVwKlnvdacc; Sat, 28 Feb 2026 13:54:11 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=69a2f384
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=CuOhmx-iD_6PtcpuGrYA:9 a=QEXdDO2ut3YA:10 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=e7fGm3rlqqBh8bEJU/FtF+W1O3paUmUitYP2rC8rbU8=; b=cFfl+wIFzP3nGb7qqa1VcsSGba
	qTgqOvdBgIvuYJtkP/UwO7pT/p3pw6CYBfwtWDis/FF7VSbqVFLAi6JI7KL1DRZiLYuSMSBXTUUZD
	X8+IngR+RWDpu0YN/fhAlpcVgO0IE2SMMCbcEZz2s4df9qDCBp7A4einrh31taiFRoIHWPFojED7q
	YgiAS6bg2f35HmtP5X7Ra2zx6QcfX6r5yQ59hNtYJLbRrt7pclxBiBRzFsoF0u5Zag4SOq/6jNeaR
	QuZyLLy/oNcGfoy5EAcu1r1rvrJ9TsnIPmLbYtsMIowuO4Ur9N3qnpEG0z7TSF5FGRU4gF7BvmGgL
	okvQ6WfA==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:55288 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vwKlm-000000025Ug-08N7;
	Sat, 28 Feb 2026 06:54:10 -0700
Message-ID: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
Date: Sat, 28 Feb 2026 05:54:06 -0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: miquel.raynal@bootlin.com, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: wsa+renesas@sang-engineering.com, Mark Brown <broonie@kernel.org>
From: Ron Economos <re@w6rz.net>
Subject: spi: Regression with v7.0-rc1 on VisionFive 2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vwKlm-000000025Ug-08N7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:55288
X-Source-Auth: re@w6rz.net
X-Email-Count: 5
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDKe47L3II6kaivAIFJT6APKo2z9PVYPLRpi8TzaoBmGui15dWM1jV9HEJ0WmBydAQpPFNA9Tb4PC4YCy/NNnYEgZtyfyoOalUn04JgUmccVaepesbz5
 4Tihifk3xEoPHu0hw4SVOWLFaD35aqGLIg5vKC4RuFsaBknmu1CyLBmXmzl9iTmbcn+Wk9/zkEDzfRke7JTURdX7nicWY2/TIc0=

I'm getting an SPI failure with Linux v7.0-rc1 on the VisionFive 2 RISC-V board.

Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: detected FIFO depth (1) different from config (256)
Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
Feb 28 00:29:33 visionfive kernel: cadence-qspi 13010000.spi: QSPI is still busy after 500ms timeout.
Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: operation failed with -110
Feb 28 00:29:33 visionfive kernel: spi-nor spi1.0: probe with driver spi-nor failed with error -110

I've bisected it to commit "spi: cadence-qspi: Kill cqspi_jh7110_clk_init" 324ecc7788c2e21d0d9197a8c015ff75382122d9

Here's the bisect log.

git bisect start
# status: waiting for both good and bad commits
# bad: [e86dda7bde8801d32ffe7d1570fe173cab14d1ba] Merge tag 'spi-v6.20' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
git bisect bad e86dda7bde8801d32ffe7d1570fe173cab14d1ba
# status: waiting for good commit(s), bad commit known
# good: [f6c42489fedfa42ba79bd17c49cf81c69ff39f8a] Merge tag 'regulator-v6.20' of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect good f6c42489fedfa42ba79bd17c49cf81c69ff39f8a
# good: [19a4505a7a5d4eea70f1a42d601c25d730922fdf] spi: microchip-core: use XOR instead of ANDNOT to fix the logic
git bisect good 19a4505a7a5d4eea70f1a42d601c25d730922fdf
# good: [aac733a9663682387013350b4470a81344960f5d] spi: cadence-qspi: Fix style and improve readability
git bisect good aac733a9663682387013350b4470a81344960f5d
# good: [8ea39d960c9f890e9213cdcfcbe4b3f281acd12f] spi: add multi-lane support
git bisect good 8ea39d960c9f890e9213cdcfcbe4b3f281acd12f
# good: [6516169fa7f6110ce42a5958c921255f2d0968bc] spi: geni-qcom: Add target abort support
git bisect good 6516169fa7f6110ce42a5958c921255f2d0968bc
# bad: [a40236feb62ccbf2b36d288550a483122b3205e5] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
git bisect bad a40236feb62ccbf2b36d288550a483122b3205e5
# bad: [324ecc7788c2e21d0d9197a8c015ff75382122d9] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
git bisect bad 324ecc7788c2e21d0d9197a8c015ff75382122d9
# good: [2b97f5cd1a956a9ac948ec57775600158988dadd] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
git bisect good 2b97f5cd1a956a9ac948ec57775600158988dadd
# first bad commit: [324ecc7788c2e21d0d9197a8c015ff75382122d9] spi: cadence-qspi: Kill cqspi_jh7110_clk_init

