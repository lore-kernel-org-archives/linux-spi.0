Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CA818A93F;
	Wed,  2 Sep 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788311751; cv=none; b=j7VdYQNzKUKKLb3S7xR3XwE2uWCdnt3RnDlYkPhuLRx3ZUXkIqYO0AWFfmQPzmPTVyJR5g/Dkz5xuYjzZz/r8RWCE32LkPZuPA/KNivo+dnDkbwR1BIx2Coa4dcgPEv2qSwhHgKUPfH4yM7+DeOimNUEBQPrvl+u7xstn4BdQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788311751; c=relaxed/simple;
	bh=/stUtJz0D72UJAVnz4OF5L+lg2VALphXiPvBfpOFQjQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tjCZWqHUWns2Z/QnnepzPHou0p9fCXvhMVR7fcvPZtRztnoB7CBaW5DKNaYNBmaR6Gn+WmzxdFOOOU4yOUp1HqCqrozNLwIiysSoGlETeXQz3/UFqvl/wcinwQoHIE7j9EylOS562AzmngBiPniNMq7g6Ac1CH7FeK61mxNs2/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHGxhsBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHGxhsBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54F11F000E9;
	Wed,  2 Sep 2026 01:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788311749;
	bh=zkIqO04UB6m3GxxrUtR47PTw99N26Fi59GY1OPoGbkI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=eHGxhsBrOfmPhd1MGSaCsZkDW0687840MC1GU6Qsm6pRNN4e3zRCnFYAW64AmUGKF
	 cq7cn4bG78Ilc5TaKPKwEdJw7Q4GDKCpGtcZ2wypRNRnUfnwMDPib4Fs52KhYrxfu9
	 7XHW7gBGok92gHSYF/TLwUfXQ6q9DZrOD/v/3C7xIn5c9QMb8qd1dxT9PlpKOjDOMY
	 m1Z/aLzi7N8ZYhBH4IFCFtiHLNqxEFzZ+Mokskss8A8FBOoQMe4PluNgVXs87otbms
	 wsUmlWHIEYnraIjDZaElIXfbXg0Am2SvFyBzQR2X7OVFhA1+JSNfLZG/XF79reei8Q
	 3aeZKqx7e7c+Q==
Date: Tue, 1 Sep 2026 19:15:45 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Conor Dooley <conor@kernel.org>
cc: wangjia@ultrarisc.com, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, 
    Daniel Lezcano <daniel.lezcano@kernel.org>, 
    Thomas Gleixner <tglx@kernel.org>, 
    Samuel Holland <samuel.holland@sifive.com>, 
    Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
    Andi Shyti <andi.shyti@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
    Jose Abreu <joabreu@synopsys.com>, 
    Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
    Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@sifive.com>, devicetree@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org, 
    netdev@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: riscv: cpus: Fix yamllint style
 issues
In-Reply-To: <20260824-outpost-mandarin-532989726b7d@spud>
Message-ID: <96962a7c-3ab7-abc1-60f2-48bed0eeae55@kernel.org>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com> <20260824-ultrarisc-dts-v1-1-61ab7aebe9e5@ultrarisc.com> <20260824-outpost-mandarin-532989726b7d@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, Conor Dooley wrote:

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
> 
> Or I can take it if needs be.

Thanks, I picked it up for v7.3-rc.


- Paul
