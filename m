Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696356;
	b=Kk4BGaxnwXBb2eQXv6/x06vD+LZ8V8d9LdcD3wHywiLil5nZknfGHW/506EtGWaHF6SD
	 J4V9VJeg+CRnZz4sbKbbfz5Ui6xOs4ZE+uVW1vi523mg9d6R9EXpYW6Jpeb3Xi8ieUChM
	 kUiQRFJ4coP51ESOcUyaGt8QJy1zKRAyjvcyWYuGnaMvgQONFBQPNN1RjLaMXxI8MOVxj
	 jzuj1d9xMx//6LA96aNpRb+fZ+sPOwqxPIIu77KyQUy9Ag9gwWdmB6CXNFserwIphdvgC
	 IhI27ekWkyivb2Sf16EKkzz1Y0NybvPGQi5GhkDp1mVb4b0DSMMU4itbBgSyybDpsQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696356;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=sjIaL3huVNTCRZS1ks1XsAWR+FBn0x7cBoONz7zPZJ8=;
	b=MdR+OLP5s84sZ+vG5iTgDkyIqC3BLqEX2qPvdO580+6Yd7fkfkLV63xdWwDjwdleAwF+
	 ORp//xyjBRqq40/voPxU9sydpRhhIdGnGPQM0rlx2OrnSuVpoOcI0cgq+1ojgCiBrRMSR
	 grBu12gn1d9iRWYIcHgYIqw8W0hD8rrAEfgVfjJYmTvtFT6PY3SK5k3X13aRP3Awr+X+d
	 8mNjrmsgGVuI6OgKQLgak+rye2qJ7LdK6MCpYZC5HjPL8k22ShaGfJ1MLCrJOyGXLu8Wk
	 8K2j7y5x1CcDQppHd8uv5ZxlclkUuNeDUFWFU5kF/92bDz1FgEFEcqXedF/pXM1+s1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kEA/jBuv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2E606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEA/jBuv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6081F00A02;
	Tue,  3 Nov 2026 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793696356;
	bh=sjIaL3huVNTCRZS1ks1XsAWR+FBn0x7cBoONz7zPZJ8=;
	h=Subject:From:Date:To;
	b=kEA/jBuvZHA+8bw2aaoi8NYe2SCLS7ojKDFOyTNUBApwWw2KD6yvGHZvgkHh8bMBM
	 NIRfSfoCmMfz5Fu+teHyPFFrj+9rxlwk2plNaXJ+2XNBbyF9kdXREpvLhpqTxXkdEh
	 z9AjbTbr/GKp3adtfnkS3+SLicrVIH95dC8wiLNtiPWyhKUbFWpy9Y50d9Pi1q/rGP
	 /Guj4BoN8claH/3yy6m+w+B16tiE0Rta92FW1Om2bgGYEjvcv5dnNO4NwklQ6fBJC2
	 Si46JmC89ZBvrWLOGKw43Mxo1NFvJE++hZBuwMBerJLutWEQ0IpDHB5FRERpI7GUxl
	 qgMn6jopYAVMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0317A38068DA;
	Tue,  3 Nov 2026 08:59:16 +0000 (UTC)
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
 <179369635461.957346.13373826100576674744.git-patchwork-housekeeping@kernel.org>
Date: Tue, 03 Nov 2026 08:59:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pic32-sqi: guard against empty BD list in pic32_sqi_one_message() (2026-11-03T08:47:07)
  Superseding: [v1] spi: pic32-sqi: guard against empty BD list in pic32_sqi_one_message() (2026-10-26T11:52:19):
    spi: pic32-sqi: guard against empty BD list in pic32_sqi_one_message()

Checked 192 series in 3.71 seconds.
This project currently has 16881 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

