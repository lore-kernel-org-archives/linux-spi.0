Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAD3BB69D
	for <linux-spi@vger.kernel.org>; Thu,  3 Sep 2026 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425962; cv=none; b=Fq0dt0QPP6xI7FgKd4yZawsYI0bExMot17/rHYwOvy6c6yc4nNTyLEH4BTYtHz1m22hEU6mLHQhUPc0C6CrKA56B0M/3BiTX7Z32Bo5psPmYIQNj3ATIxaVl8Xzwg3UZbd2gF6hDXez5uHQB7LGufbxGZc+cOHjlTfk2/IAoHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425962; c=relaxed/simple;
	bh=dM2aRCq36pWI7iwGVCE+8cqzMU2r8e7vq2UZeo3cnJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UAylloFRngrv862qO7RlE7DzQ6N6Td0FVAevMtJ00ews9GyYet20DbFHeTOs/OvAwMzkN8HCRB+Cg6xXC0yIB/ho4kvDHeumE/ngXkhDfMBFDbhdProDYgTura3KX15QUX7BFYHB5Xl/h4JnbPBcafBVj1k2Izz/4XZ4ez+Pm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeSqpfL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeSqpfL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259421F000E9;
	Thu,  3 Sep 2026 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425961;
	bh=NT8W3s+FQNb129S/+gDGH9DfSUsA/WYJm/u/1PqPYc8=;
	h=Subject:From:Date:To;
	b=AeSqpfL/WpAfHkaWtrBLq2o6CEZmQKeqZVB8fY5iS5xlAVcugLihQ2JcCeT1J/Dik
	 OsVrqCs6eOnapofmo+XYM9kDtsLPVaKei6z/QzDomlA8nzSqPwAHsrzziEPqBz9Yws
	 SyVS1frVBV9AoGC+mXwuZQWo9aJ4AnsdZFWcSr0w6x5VlcDULmLnUGxit9wBMkadrJ
	 oR3YKCtkjNF7OnZh4mCrGgWSWu74F732OYKyGgUGQWE0QB3xgOVjsDJLHah6GIiin2
	 RP9UBOTEGt05BHubD97EFTI1SmeG3exdSjaP4rX2U1fgISkvds1aKnLwwWtoawGBOG
	 e4QWduS3V+FcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A0F381195D;
	Thu,  3 Sep 2026 08:58:23 +0000 (UTC)
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
 <178842590229.3206159.12347279055096900096.git-patchwork-housekeeping@kernel.org>
Date: Thu, 03 Sep 2026 08:58:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk (2026-09-03T08:09:32)
  Superseding: [v1] spi: spi-mtk-nor: Get clocks from devicetree in bulk (2026-08-21T09:00:22):
    spi: spi-mtk-nor: Get clocks from devicetree in bulk
  Superseding: [v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk (2026-09-03T07:56:28):
    [v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk
  Superseding: [v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk (2026-09-03T08:07:09):
    [v2] spi: spi-mtk-nor: Get clocks from devicetree in bulk

Checked 168 series in 3.84 seconds.
This project currently has 16442 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

