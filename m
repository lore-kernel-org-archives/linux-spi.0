Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE9E423EB9
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116720; cv=none; b=loZAfkUYjgRy8rtl8nKIRVYjA4BObNjvVpBkQeon5k8WcHWyUXtomMsQygCYXc4+qBjQO29/NbFmIGKo8xRRbEjy/5qgjfxSedcg35ZYUiDt8HPGOZK7Npw8HiU0optDuFH9qSnP2soCIF5QnhbkTD0JSddMUEFRAhsfpcUIYvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116720; c=relaxed/simple;
	bh=Hyr1ZiaJFwjOC9GBCSFywrkv6bhCCuJu+PZg8X5deCQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CDW7c9/qNk9lh3uZ/2XnaLoZrxZh/eiVNGIpgQ6FWpQuljRM19QfTUTnvbIjIVm9/ogCMI87O9QZ1yfDiGPUKnJqZbUt80PwcgRntAhNuoe/gHJMbmuhnO/KLnvESAUySpMWl1VqGH7M+LwxYKVu28+2d+7EoTRVyIRYe1YWdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI9upufc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI9upufc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667801F000E9;
	Wed, 15 Jul 2026 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784116719;
	bh=bjmT0H/TsVtgKJqUhe9iSV2N3To8mH+3hRXFwu5uCGs=;
	h=Subject:From:Date:To;
	b=ZI9upufcyVLUMQdeXdmmgL/d6uWnkcIbuv/qFCRun0ztaSVYrDtcaUNqIvxaWHPGn
	 s2A3HKdscXZPDO2myePrpGrmpOHf0R/VMDeUlC1kIXElsSMzkqJlgQCitxvzyaNygd
	 pTRj0qgsNHdLhp3aUYl9q1XZytPNtU9Th8RQg6z4wX7B3+liS3VGmf+kynw62XnsYv
	 zMZxg1g9GDwAyvlMRLLCnPqLssxqQ/E8rNQhOqsC5Gpac7eeaBHRwtaSe0+KYCzLAw
	 NbI/ZQRNj2PcuzZCs3YjfdyEopIwHk4eIBGbQd+D7HfI9Ju0WXyas/6YIHro514X6g
	 0hQlF4rX/tQ7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A333939F0E;
	Wed, 15 Jul 2026 11:58:14 +0000 (UTC)
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
 <178411669315.4034869.3819789263990456809.git-patchwork-housekeeping@kernel.org>
Date: Wed, 15 Jul 2026 11:58:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] iio: dac: Add support for AD5529R DAC (2026-07-15T11:41:04)
  Superseding: [v5] iio: dac: Add support for AD5529R DAC (2026-07-01T06:40:38):
    [v5,1/3] dt-bindings: spi: Add spi,device-addr peripheral property
    [v5,2/3] dt-bindings: iio: dac: Add AD5529R
    [v5,3/3] iio: dac: Add AD5529R DAC driver support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

