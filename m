Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C327456;
	Mon, 24 Aug 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576827; cv=none; b=aIycM3uR12Sl0Tt1q/awVAyN2IGh2WYUDp6etVa5VOm94DIC0tHLUnUg2eTZLwJfllG9sJ/2iQ0q0BAXXovqZ7krR+F7aJnlvTux2dWmSNGGqelqJC38IrhRVdrZ/oKU4j/UcvvN4pWynaK7rr+Hoiu3E4Tr0M0DUJ3U51FlSB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576827; c=relaxed/simple;
	bh=nHPhXiSkktmIjZtqvT4NSVrblmXHSIXsEt7s4o5pTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXO5ks918SfDAumjfmdbv/IpxuVyRwbQIHlE1967kqjberfEyHbq3tXvNl/I7Y1Km2rL5yGZAlWxBsKwI5quMlqaTlDniat25TW9zoGBmm8RFWv9niWox+DVfBiTckqt7tdoTFCUWvBEWyhYacjt0OnK5++8wxbzOrzoaM9ygEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZYMGhMg6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZYMGhMg6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G20m0dlWZFuFMp97M72WP7j3a4Nl0NQXlbLAsz70gvA=; b=ZYMGhMg69/rBZukUYCl5FP3b+b
	ewTm5vpm6xXhbXfsRqKdzEAWA8KDuIC3yvT5SNwfvA8O3MpcPMrzGVUho/Z+otwUbntU/WaWDjNMj
	e/rYIGzOoAwq3wkQx8/KH9B+LCiY8bbPT6FSoWFhFHeKDv5yPQCOr+3+Zem9dq2fQo3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyUNy-001Ehe-02; Mon, 24 Aug 2026 15:06:46 +0200
Date: Mon, 24 Aug 2026 15:06:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH 12/12] riscv: dts: ultrarisc: Add Milk-V Titan board
 device tree
Message-ID: <26430c94-95ee-42a1-bfda-89e0ce24f194@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-12-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-12-61ab7aebe9e5@ultrarisc.com>

> +&ethernet {
> +	phy-handle = <&phy0>;
> +	/*
> +	 * RTL8211F: board timing uses PHY strap delays; keep plain "rgmii".
> +	 * Enabling PHY internal delays via "rgmii-id" breaks Ethernet traffic.

This actually indicates something is wrong.

When passed PHY_INTERFACE_MODE_RGMII, the PHY driver should change the
PHY to not add delays, overriding the strapping.

Given my previous comment, you need to spend some time understanding
what is going on here. Something is not correct.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

	Andrew
