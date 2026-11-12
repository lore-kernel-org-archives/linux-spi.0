Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495524;
	b=NYH1uOAF4asYBiBizAPlOymMAoXoTL9YNtZp9o38rsMDjigiRUJM/EyJkrbUo7jnAFuP
	 JX3gE95jJf1+oZYhKYGfUmPs0aCU3busCDp49oZ83gm8xnXRXL/z7xPR+V8aQ6k6NHcvm
	 xQrzkz/W+G+Ii7FGZplTNdQomQKk41pAsVi/x1SSY8BBcVRFXs+pSURUHH6guNqb6I2YM
	 E5xEbQaRO/w7owrgf4oj1ZatsEz42b6TYzqH7FJVwPcsNWTvRNCFqToYwKVC7CiZ4qYJ7
	 lBx31rKlPW1wjvpVlsNQGLHms3mhZOEGmcP27iYS/OkFcEdtmT4Taws3l0kAepuDceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495524;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=mPFvitclL9Yp27dtXMub9WoET2PJsHRYuWhTE/oKg6o=;
	b=TKna71eTUB/G+i6FwOHkZUKtZ5QgW5Tb9Heb7L6CWaJwoSFposW2Fdkjai2BQEjBuK2X
	 cznwLaQPHVqs6WxJWNqNKYEGPHeMqyy7nUbjkUCKDqB22XFT5w5kVeB+fNC25ZuCiUfj2
	 BbBjpzIFUXNy3p+g5T49HP6IaZjRSVyY2iRg/L2WHqxPkE6UaE7hbRaXbTbnJT1lF7abC
	 +UXAUSd+SgSg41XDdT0RvLmOyOZEq3WOLFiRGrwVPjAQaI38Sgsrx13iRTur19s8K8yUE
	 8wsdMM+fSWjFTSjtZ8sKxv+4rU/HXoWKzPG96wfjM7azhbL5J3VmMPeXetM+bd4ftPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX5+zxQy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64A606A31C
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX5+zxQy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47B81F00A05;
	Thu, 12 Nov 2026 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495523;
	bh=mPFvitclL9Yp27dtXMub9WoET2PJsHRYuWhTE/oKg6o=;
	h=Subject:From:Date:To;
	b=KX5+zxQyWvh0QsMkJvMDmDzX6SS8hNzEcPxZ5Vt/zAbf3hizYfk6QmO7rWfXXaZcy
	 A6WrNVDCFiil6dX2jrRSQv+GEAjGm2WAuMWzFvPX8k/Ibo8cFYY1yvc2Gsuh8rtzG7
	 wsQW7vnjLPQIivXY30Qu0Fq1XLUJKXETNXfXHSQngl6G4Y1wOb8ZfdoDleHbRcUmaz
	 uac+444iteGTaOhy5/388ywx4HpmDTrxxzCqzx/osV5sx6Q6Tawdiow6TeU3AHBQJd
	 IFwY0zDkRJVArFHwl4DpNAU8Sgob9iPdGuQBFNe+17VCiaqwRqlmXFWTzuAzJYVcdr
	 mPbBC7yPJmt+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B39B3808210;
	Thu, 12 Nov 2026 14:58:43 +0000 (UTC)
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
 <179449552242.2178045.9056220906423890765.git-patchwork-housekeeping@kernel.org>
Date: Thu, 12 Nov 2026 14:58:42 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: cadence-xspi: Fixes and ACPI changes (2026-11-12T14:30:45)
  Superseding: [v2] spi: cadence-xspi: Fixes and ACPI changes (2026-11-11T10:35:36):
    [v2,1/6] spi: cadence-xspi: Properly handle errors in .transfer_one_message
    [v2,2/6] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
    [v2,3/6] spi: cadence-xspi: Inform SPI core about size transferred
    [v2,4/6] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
    [v2,5/6] spi: cadence-xspi: Rework resource discovery
    [v2,6/6] spi: cadence-xspi: Add workaround for old Marvell firmwares

Checked 216 series in 4.22 seconds.
This project currently has 17036 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

