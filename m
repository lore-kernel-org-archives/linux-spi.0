Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3413EBF02;
	Wed, 18 Feb 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771400824; cv=none; b=XryVULgF5gXlqjfuaFIO6j3owQMstxp901VqP5QwpNrd8BbZdywm6HMVIhZzrdw+xvNpyLWI2Yr3RZMD6JtI/GRt3oHD7AL2Jddu9vn0mBXuFdYR4edOcoRbAWxjQhPkXOxxqugQSaOOrH3kAgqWTg/m9xMxLWeaWJDVYdwp/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771400824; c=relaxed/simple;
	bh=x3uMMgrQz5LgkjVbNCzGY+sKvBJr5F05qUWXDzQChdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT/XQH8cLIN0aeA+LNip0qOb7Rzz26kIvyKWa0AOPURYlfOSl7WGyEFQS7IHJWXcZymsOLjKcITL1GMfzyXJJSOxaJNelXq0cPvSpj+TvX9XIyAPDHI/j0IyHs+5EkwT2FFDFuZHmZlviXvhVzqBjqUxrkNojddMMI/eQ6lSM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VupicOOc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VupicOOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20721C19421;
	Wed, 18 Feb 2026 07:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771400823;
	bh=x3uMMgrQz5LgkjVbNCzGY+sKvBJr5F05qUWXDzQChdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VupicOOcDLjE7thhBzdPmlHxO/R7scUlUGDRMXtpFCbWNXWP+5TYIRpJp0bI35Sm/
	 uOa3Z9yNWow3EcHs2Z8goxqS0zRpAknz0GmTEryr8asmZGGAAW1najVGzuF4wjGeSC
	 FZRf+dtY6EE+T2i/u9K5wrjlct4zJ+ljZu4uh40zTsvs/jPKGldeHqyvQVp9SykNBy
	 qB5A0GSY8yNrgcx55sRjbut41Ekd51LdEkwYY+SRtAdAhLDXNSoyrlZbLQ5ML7+B5I
	 DRwp6amOS1Eds89CXF6MyTvOqZLJHBxJwg/RcOlyQVDC1XnzH9GU4eHsUHnU+02pDY
	 OddIM5djHWwqQ==
Date: Wed, 18 Feb 2026 08:47:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org, 
	biju.das.jz@bp.renesas.com, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/5] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas
 property
Message-ID: <20260218-handsome-wakeful-swift-7be541@quoll>
References: <cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
 <ea6ed3b82c5a326732adfc0fcdb2922bfcad2591.1771344527.git.tommaso.merciai.xr@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea6ed3b82c5a326732adfc0fcdb2922bfcad2591.1771344527.git.tommaso.merciai.xr@bp.renesas.com>

On Tue, Feb 17, 2026 at 05:23:46PM +0100, Tommaso Merciai wrote:
> Document the dmas property to state it must be specified as TX/RX DMA
> specifier pairs.
> This clarifies the expected ordering and improves binding readability
> without changing behavior.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
>  - This patch depend up on [0]
>  - [0] https://lore.kernel.org/all/20260128215132.1353381-2-cosmin-gabriel.tanislav.xa@renesas.com/

So just squash it there....

Why are you adding comment to correct code which is in-flight, not
applied? Just REVIEW the other!

Best regards,
Krzysztof

