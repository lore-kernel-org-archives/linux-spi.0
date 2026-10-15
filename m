Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2F3EAC75;
	Thu, 15 Oct 2026 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056988; cv=none; b=UZyT1+T60861Wj9KiBNV9hBWazgHDA84Cs4lClWmf/lXuHSi3yBXrczcwwUiOMQV6tUflggC1x/jNIRBHNqPz/xTWwOqxCeW71pc7SZjRjOgBonI/2dHrIi6oP3/pv4iU+myQjbIWXkp9nKva2DfdVShFTAmuyGswQXbm7ujjfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056988; c=relaxed/simple;
	bh=KZ3tKWoYd+b83BSrn3nNAl2Cx91bKE3xIIc8OLsFydU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ8EYUUXiUM5AUc70UZ5ZBq/2dMzdDE1lk+QMJ1s9g6nXU5o/LaCgoDgqKKyO+rCdYFuqqHQuxlADOXicJncJAwkAohi7ezTxGBLOhUjKNqxJbpexBg26oso9fY2eTZChjkfb/Hb7YDEHXZTL2rf1oZ7AfMPDlnjbvRYpgPIyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgioQlEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgioQlEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF481F000C5;
	Thu, 15 Oct 2026 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792056987;
	bh=JpPOpgYOuMni0Gc6Ie2yYsK6sobe7hS6YKBMvD+JxTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VgioQlErxcQgeRGnfPHcuqWr3lnI0paTj8c3C/F2GmTbhB3XBgPlc2Z/sTGHLxKme
	 EpaRiAwTDBXFlcoqvChYUQzcuVUHnaAKEuJgHBrEY2Y+xucyHQgaZwgSjtjW7yN23D
	 2VjTg5+sJJ2YSo1Qjyx4bf2y/Xn++xgeYkqTgwdOo18R86zc7A7C4HwbN4bva0otja
	 evpsTeGzLA5c2eUgpfcBvrvl9Onsr9q576XOWVJenbzEQR7bCHlh14MOlqYoCIByGN
	 P0l/YjpeW2ip4watTTmyue4U8aJoGXX1rwa1N/5uXoQTVpfaFiGdQBh2lcb4bxoFYp
	 Du1s4gplgAoCQ==
Date: Thu, 15 Oct 2026 11:36:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, 
	stefandoesinger@gmail.com, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash
 controller binding
Message-ID: <20261015-fluorescent-sympathetic-coati-c64a01@quoll>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>

On Wed, Oct 14, 2026 at 08:20:59AM +0100, Navid Ghahremani wrote:
> Add Device Tree binding for the ZTE ZX family SPI flash controller,
> supporting both ZX29 and ZX279128S SoCs.
> 
> Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
> ---

half of your patches carry redundant binding, half not...

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Best regards,
Krzysztof

