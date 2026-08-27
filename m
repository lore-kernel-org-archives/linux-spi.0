Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9D353A64;
	Thu, 27 Aug 2026 02:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798789; cv=none; b=OHzG0omPVzNN8t9zJgHBohp0NnshQGi6gJzh1FLwhpMWe2GcbJFeupke8LeLPP3hGY+/zmV33klcvgG6Qm2F1NlrlMfh/dLDQoU9VxIoo9uNHXhpwfluj/3mpzgeLnlgGNeepk+yi+SbLSxRiMOMIcG56VWIWUOkm97NDPOd8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798789; c=relaxed/simple;
	bh=0dXjWTo19D2E3ml75KHH0Al/zvpUFf+k4OwGb0ydw4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuAlLiq05LaOPqG3L2HS091SbbnWDAmjKGbmsEU6+WvV6aZLm5jkC/GDE8r+MkwRU0s+gNjfszzDp6OWl9/UNHNqsqaplLoVU+iJuqPOdx7QYVcEV+YXk3mhrUZL0hdcHFteq73WT2X1g55Kp/5z9hlH5fqeGQA9lkGrtzamemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=amLerCpJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="amLerCpJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=04LV//Qqu8AJccIRCStGRzmejSwdi5G60bO+SIOXoKQ=; b=amLerCpJ/Smpy9mCR2c6EZPLHv
	8uYNlnRnUKBmnI/Ik/B6ExblrZ0E0hP0t5flRLXUxlTF+bCL+0zEb7IaU7FHed2bHZoyz+yMLx5pW
	CubhHcNuReLflxAQkihRVcoCssPUMZXohqnEYx3yVGuyPYmb/jXd+dpuk9HAujgNRRX0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzQ7t-001arp-R8; Thu, 27 Aug 2026 04:46:01 +0200
Date: Thu, 27 Aug 2026 04:46:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jia Wang <wangjia@ultrarisc.com>
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
Subject: Re: [PATCH 11/12] riscv: dts: ultrarisc: Add Shenzhen Rongda M0
 board device tree
Message-ID: <db174bcd-3b21-464f-ab56-439d65e2a064@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-11-61ab7aebe9e5@ultrarisc.com>
 <d93868e7-00c7-4251-9b23-8b3ed0535185@lunn.ch>
 <178779718359.1423015.16616466921659081322.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178779718359.1423015.16616466921659081322.b4-reply@b4>

On Thu, Aug 27, 2026 at 10:19:43AM +0800, Jia Wang wrote:
> On 2026-08-24 15:02 +0200, Andrew Lunn wrote:
> > > +&ethernet {
> > > +	phy-handle = <&phy0>;
> > > +	/*
> > > +	 * YT8531 RGMII timing on this board requires no PHY internal delays.
> > 
> > Please extend this sentence with an explanation why it needs no delay?
> > 
> > There are times this is correct, but it is also mostly wrong. Without
> > an explanation, i cannot say if this is correct or not.
> > 
> 
> Thanks for the review.
> 
> The DP1000 SoC integration provides the required TX and RX RGMII clock
> skew, so enabling the YT8531 internal delays would apply the delay twice.

Please take a read of

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

You need to make the MAC driver do the correct thing:

# There are a small number of cases where the MAC has hard coded
# delays which cannot be disabled. The 'phy-mode' only describes the
# PCB.  The inability to disable the delays in the MAC does not change
# the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
# 'rgmii' is now invalid, it cannot be supported, since both the PCB
# and the MAC and PHY adding delays cannot result in a functional
# link. Thus the MAC should report a fatal error for any modes which
# cannot be supported. When the MAC implements the delay, it must
# ensure that the PHY does not also implement the same delay. So it
# must modify the phy-mode it passes to the PHY, removing the delay it
# has added. Failure to remove the delay will result in a
# non-functioning link.

    Andrew
