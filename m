Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F745C716
	for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2026 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986433; cv=none; b=RVGLxFZGjE88kAfwbIOFjb4MtJvA7rsvZSDJJ3TbZc5VM7B3y9wfWRImNCy2lr36Fhjk1MiUimhzluBKqZ5m6QpxI5XJcst0fiTBi1Sr6upw3g0AoleijYM3A1BhQB8DS2pjekI7OD59JwSddN/MCscE4KjtYgxA9Litdn8T7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986433; c=relaxed/simple;
	bh=hDGy2gP2ArkikwAAkPSbUL0LeX94iax09cfRWXp/lMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oVKO8n3AKKkbPFas/aTc8glN9HU4WWquigN1eCkMWhMXFECkqb76i6qGgWxOe/lUoKpZT30698/6ZSzbcDFUn9KjBQT/byLRRx9In0J/d6WejYDIT3jng2qpI6Du7DwOoAXWFuk0daoo09jxquLcysBpCLDcnlV3X251v+wntAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9dE+kc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9dE+kc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B401F000E9;
	Mon, 17 Aug 2026 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786986432;
	bh=ZCThlYx4bS63REgTU2nSbMlf+sTsb82RGtaKy4W3WmM=;
	h=Subject:From:Date:To;
	b=D9dE+kc6ZCGAj6z32nVrCWR/te5K/5VeXnWPfWLZcOFPyQujwGO3vlIz8ZO3aAHSt
	 XmqGJtDPo5ruY89JQFAryUliIAvhBkphMo81MWFMhe7QdT7OHP9euXcE0tNTil3Csf
	 X8GWugVVBYJiK2fFQeqfXP4Bwq26+6Vc5YfT1eXQ64FlzCbEcN0UWfXwG5YnxKs2G1
	 Vir/pyU+9gUqKMrlyJMVMYYQSiaWb9FzEhyJugkVOgAMqgD7tBKtHOWFjhfpWTa9EY
	 03EzDxFQI2D688jpD98AZF3oQ60SKXLYP2PnpDIz/uLzF+UE9w0n/9uY+FrGlcuIvO
	 7d10/DqL5L4SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939B63926244;
	Mon, 17 Aug 2026 17:06:25 +0000 (UTC)
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
 <178698638415.1225534.14159090472054260458.git-patchwork-housekeeping@kernel.org>
Date: Mon, 17 Aug 2026 17:06:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-17T16:16:51)
  Superseding: [v1] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-06T10:13:43):
    [1/2] dt-bindings: spi: qcom-geni: Document device-gpios property
    [2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

