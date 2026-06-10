Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26633260B;
	Wed, 10 Jun 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075985; cv=none; b=K2iBvAM3BrhuDo3quKks/B6kwfjlaj1XtSpYsLMZ+fkADU8vA3xR5+rrFy1iN1RCaaWI0ozG/okUy4tWlw+R5HbBM4djyWPTv9E62L5+8fnhdbElYyvx5vxi1lZY70/6A5Z4SdWpmFmovlWntnut7RiwWinRmVtgEydO/urlh4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075985; c=relaxed/simple;
	bh=W5luPWqOrGgE7JxgsPfCflorPiUjO5p4FQ1ISx7zmKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1hwF+eEnhKfUl9MQOcW3rOkQWx5zIiSbu2Xjkn8+YG1s7l2duv3tjxJ85YBgGVtAdSvHE6/wBG8IwskXH71ojqBG0FJcsfNQtDhM6+6IkpSL9D7Df27JUehhxHPl8OHUUfcsw16wNacxUFAo6JVd55fpml4XwLEO/vmNcdL25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjR92Mzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjR92Mzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893601F00893;
	Wed, 10 Jun 2026 07:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781075983;
	bh=rjwFTRdNvLxvPPDpr+jTY+IlrAUHfWKYH4EjDiBodsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OjR92MzzJWslYuE6T0shpgjS7wJOOfv03jGQhmaxottEXFvfl0Jbo3EVz4f/W96Ad
	 PF+mdEoZCpRmhYbfIC9TRY58HTXViD0cW+9qGQg6hSL70QznoymlLAGy/2TYEnVT4h
	 iN/GytwXF9t0Yf9Bbe9WW0EGMAncaCwo3Ltas+dq58NfOceesfEJDsjrRXMAKSJ8fh
	 ImJEXAOaHuH3dRTwilKN5pKJl2h7N/8NpC2ncKWRJvQVmreMk66HRKkrm5WL///lmP
	 vhbbmXZC3JPh4m4Q/ekCuaYOM32pgdpRQyNzol+BcxgvJRO9WfhEbNUrVg48IcvFva
	 2zma4BN31YwQg==
Date: Wed, 10 Jun 2026 09:19:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com, yuenn@google.com, 
	benjaminfair@google.com
Subject: Re: [PATCH v4 2/3] arm: dts: nuvoton: npcm7xx: Drop redundant FIU
 clock-names
Message-ID: <20260610-ethereal-warping-beluga-e499b8@quoll>
References: <20260609163919.3321228-1-tmaimon77@gmail.com>
 <20260609163919.3321228-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609163919.3321228-3-tmaimon77@gmail.com>

On Tue, Jun 09, 2026 at 07:39:18PM +0300, Tomer Maimon wrote:
> The NPCM7xx FIU controller driver gets its single clock with
> devm_clk_get_enabled(dev, NULL) and does not perform a named
> clock lookup. Drop the redundant clock-names properties from the
> FIU controller nodes so the DTS describes only the resources the
> driver actually uses.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

