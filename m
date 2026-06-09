Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE52E3D88FA;
	Tue,  9 Jun 2026 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989222; cv=none; b=Xd+HhE6R6zhXZRY5f6kgLKR4Hf3B/jiIHO3T7tfVgff7tbYnN5PQ4JS7W8n0E7/DRFDNJzdXvqCg6i76rWhqRzaZr5HJTecIul7Y3F3gHROJ48iSsrAY80wCQmLcB+FN1qL20NrpbS79+2QbrwEckB8+ajpfeJ8niHBt9P1Vk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989222; c=relaxed/simple;
	bh=cotxYSfe04gbaqevssF5kYsQsBjRl6Porlqf1cmDAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaqV+I0/4mpzHI8dYQDPFJPAHgA2e0BrAqbF1G5d24Uq4XsAoCnuQy7trC2JuFXJquVFGjFWV7+AB9L1TBTdWDF3noQvqOPz1KFZ6R25WOWgp1b2Rj/9AR79WyFqwa0WEPNE1Tose/xDmtLjg4NupmsHeNDNF5bZUPA/5yp8iSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjxcx0sB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjxcx0sB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D341F00893;
	Tue,  9 Jun 2026 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780989221;
	bh=xpvqltnPyHaKeLXzA9Xq8lTFZuFUY8y5YG012UOsqCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rjxcx0sBgDiEMRzB/7X8XkxLuCVjsO7TGrmnDfdnehXL9KI9qfxXwIJvseL1RwT0x
	 gJzwPNXoDsWIwK8j72/iv0G+SPQcKO2l0t4LNadxY7JYN56Z1PJwFkxzedWXHNhx4g
	 t6nDooNTkEIxmd/kBELBlOMadB9VpZQiIrlrYQqa7As/HHTX1df7zVa8ydlJsOKsr8
	 3/Xd3+m2QzWoRasoQ3mAtG5KFss1UjF0u8UDsAKGz+B9Inq9384bYHa9y7T5NlbLM5
	 IQ3M/80ubT7AlkRBtDeMvI5c2sHKXo1oKpxCoyBHK8BMRq3wBlXf0f6UgXmcsJRyRa
	 kNHdlmDtKOVWQ==
Date: Tue, 9 Jun 2026 09:13:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com
Subject: Re: [PATCH v2 1/2] arm: dts: nuvoton: npcm7xx: Drop bogus FIU memory
 reg-names
Message-ID: <20260609-tidy-defiant-kestrel-cd813e@quoll>
References: <20260608175418.1936892-1-tmaimon77@gmail.com>
 <20260608175418.1936892-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608175418.1936892-2-tmaimon77@gmail.com>

On Mon, Jun 08, 2026 at 08:54:17PM +0300, Tomer Maimon wrote:
> The NPCM7xx FIU controller nodes only describe the control register block,
> but they still advertise a second "memory" entry in reg-names. Drop the
> bogus name so the DTS matches the resources actually present in each node.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

