Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDAD37CD24;
	Mon, 11 May 2026 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470595; cv=none; b=pdQE55HfNtOZCEyfvld4nuQ2Ci3VSxdCWIfeeeecKsdYhtH+UCx/Cuml4T+b8bxj6N9DYrQiHIuLzF2nRym1uoeSO3LCAVWp5nvAAHQm/0qjWUQSpdVZycE2sRig+LEKhqj+ELF/53F2Hk00wad0pQdvJuJXA4LDPXsOYm67bAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470595; c=relaxed/simple;
	bh=PDuSWE7qzQOvLajdInCixxnQ7EDXBslmZRk+je0auLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQAXBbxwNdf3LL/582neOWg8U8xvHUow6+TmJZMhDfSWCZ9iEXovWl61aRb5SMZVMwbr+8dINUAv03Fa16rYBUZXZOBenTMxLeD20vc/DTYX3kiElKdZrBcDzgHexADO7ySmhR2jrE7M6W/pKGctXSTNeH9bJxHTGygG7shFDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsjUmZ8G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsjUmZ8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EA2C2BCC7;
	Mon, 11 May 2026 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778470594;
	bh=PDuSWE7qzQOvLajdInCixxnQ7EDXBslmZRk+je0auLI=;
	h=From:To:Cc:Subject:Date:From;
	b=rsjUmZ8G+AyhyhZX1RfrGWqJ2eSE0dX3qelAkf6X7/BH0KcHLKYGz1JZAkbId3kRi
	 xnHY7xV0ucsGk2P5XF5NFWjiax7/rm9ON1H77qZEYFg8F/4Ct019eWmdo/qwAuPgUl
	 +rp2pBfERZ6mQzman/2tUk2Kvy8Jd2Uw/Y5Nt8AKnehOulNXNkz90O692NRkxgzhrm
	 49SupSfhdEt13I23hmHzzRCIld5pXA23R9T7r2U8PzfU/idEhsxToWb1SQGiG6dUSh
	 sDBuS1I6zB/nk5wh/zoJ3ps0EHCcBzlYbMfDZSy6o5YLpv9uCnPrNzGuet0flihFQi
	 yZx+QYUu6q9Yw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: cadence-xspi: support 4bytes sdma-io-width
Date: Mon, 11 May 2026 11:17:30 +0800
Message-ID: <20260511031732.3199-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdns xspi controller SDMA data port may support wider I/O width.
Wider I/O width can benefit performance. A simple test with QSPI nor
flash on one arm64 platform:

1 byte io width (default):
 # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
 1000+0 records in
 1000+0 records out
 8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s

4 bytes io width:
 # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
 1000+0 records in
 1000+0 records out
 8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s

Improved by 26.3%!


Jisheng Zhang (2):
  spi: dt-bindings: cdns,xspi: add sdma-io-width
  spi: cadence-xspi: support 4bytes sdma-io-width

 .../devicetree/bindings/spi/cdns,xspi.yaml    |  6 +++
 drivers/spi/spi-cadence-xspi.c                | 43 +++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.53.0

