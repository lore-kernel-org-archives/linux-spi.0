Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83541C5D44
	for <linux-spi@vger.kernel.org>; Fri, 13 Feb 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994622; cv=none; b=hqIZmF5HhIJuXocrLQ4bjmb4klLE/10W8bJYr4Yk5MOu5fGWQzS2Ws/otsYwr5luFqn+GINP5OWvKFG0dbkwP/bhJkpvBrSzwuvd7rES71XSQZlJQsK5gc6Y2I0YbNKz2nhoeAjMf8+7BT06qMWKt7SX8kiGdtonfrqqbsvQWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994622; c=relaxed/simple;
	bh=bMnDmf2iJDQdZJpVLMlE5Jg7YjP3e2ocaMhDdmORlag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IpS8y/GzWzRiOWkf7LUAMBzLEPr6wCP087F/lcwhXAtvfGlJYvmUSHMKk5aHW1jFAITHpQTGZaTsIAdO4C4ODn83SR2x+N6a5ApGCj6KR9Dwp2xNJAi//IBQPT+6dN8EWDhqQNIXt9zfLUu/LV4yuIrwheK5I0uEoKRQEUdAbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7+j2Uee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7+j2Uee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72996C116C6;
	Fri, 13 Feb 2026 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770994622;
	bh=bMnDmf2iJDQdZJpVLMlE5Jg7YjP3e2ocaMhDdmORlag=;
	h=Subject:From:Date:To:From;
	b=b7+j2Uee0PnvpQ2ftQNiMP+4zEEgzEgfSI/N+D93cVdA6kpeXvuT4ytKl0B08+2qy
	 ApWAxCBsYSbOZM75130SYLPHyryu8eN7Z14d7CEqkIoY8BeR81tHbkkFu8M+eENk9v
	 evGGKiqDPXpUTmXOMXa1GVlc/8bo9qYrcyhwkI2GOO/C8tcXN4jpi6eNt5B+coQl+w
	 Zgm1HhG5KJ4I1gIjv9d831EQ0WHdr12WXQLlklCEiDYeaDaX9JG3gNyUwYYB0/4zIM
	 8MveZeBiazs2AR7IX7LxRslsQO936Lxre9qpu4ncp88NnBu3pSq2QDVfMdDNjwIg/n
	 f6MKBDmjbZSmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8510D3931093;
	Fri, 13 Feb 2026 14:56:57 +0000 (UTC)
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
 <177099461614.2032958.11030180521275636061.git-patchwork-housekeeping@kernel.org>
Date: Fri, 13 Feb 2026 14:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] iio: adc: ad4080: add support for AD4880 dual-channel ADC (2026-02-13T14:47:32)
  Superseding: [v2] iio: adc: ad4080: add support for AD4880 dual-channel ADC (2026-02-06T16:07:12):
    [v2,1/4] spi: allow ancillary devices to share parent's chip selects
    [v2,2/4] iio: backend: add devm_iio_backend_get_by_index()
    [v2,3/4] dt-bindings: iio: adc: ad4080: add AD4880 support
    [v2,4/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

