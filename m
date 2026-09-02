Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540B36C5A9
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343168; cv=none; b=Wjp9VaVDuHFDz+9JlFBsq/C3frYX2+/M/4XBzw6HZd7ekJHj5BQAUPZmXIXHh7DF+jvBKnzfrnuI2iMDjTrDcKy3x0n3j9uQ8ICw0cUs/Wp+tLOcU0dYq0F2GKYAJz3Bio8yzzSECXFaN2TCWZx9yxV+/RcRnIBr9McX7P1c7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343168; c=relaxed/simple;
	bh=QnMktl+K7Bm/cx05+hunmJnrVPjuvjtqSGSWuM0G2bU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=X0uACW0AO3b/qBVbCfTeoqshhs+uF5xCDQQ5es+oxlqByVXaG04TAgwOU7basyfn9B0Dv9UVmsVRclEqLGWBU27On3AdY3bQNez5PYTRmkbvzUvZhpP0cApWn7QrNZOmxRm42zQUdTeXaTh3tPMGeVHKsviDKYxHH78wPmQudpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwpmjGCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwpmjGCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7381F000E9;
	Wed,  2 Sep 2026 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343166;
	bh=8NmsSTzS2uSQRgiBF7JsAeEr6j2jIdLgb/5KqnmLQpw=;
	h=Subject:From:Date:To;
	b=GwpmjGClQTEA/yNAbrOnrZ2CqcZcQLWrejiSMie2fafOf2aupZM1IleZ5wYC53rf0
	 Q66v9Z558cAoh7zCf9x64qRVJxjjFU72yKWivwirMoY+r2737m2ajKLgUgbTASfnhm
	 aPz1fLM1aYQiu81yK66QrrLr7hF2sQu3FCCtSyd244p9ntLWb31ffyXZoXYBto6Pfl
	 JNbb4/cGYrz6uyaVAssHOvZDmlhNE+0NnCeqAzvCXULbXyRJKGE65p6aYJcqm8qeV2
	 g3kcgcyq0q3rqZmeP1KAyLdKsS8WQ5psvROk8feta4YJABty7CY4Njvf0hr4pa22c3
	 CI4kq6ioSreJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EA3926381;
	Wed,  2 Sep 2026 09:58:29 +0000 (UTC)
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
 <178834310851.2186072.5116519412580780983.git-patchwork-housekeeping@kernel.org>
Date: Wed, 02 Sep 2026 09:58:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v11] iio: dac: Add support for AD5529R DAC (2026-09-02T09:26:15)
  Superseding: [v10] iio: dac: Add support for AD5529R DAC (2026-08-27T07:34:46):
    [v10,1/3] spi: dt-bindings: Add spi-device-addr peripheral property
    [v10,2/3] dt-bindings: iio: dac: Add AD5529R
    [v10,3/3] iio: dac: Add AD5529R DAC driver support

Checked 167 series in 4.04 seconds.
This project currently has 16433 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

