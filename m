Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008841E6C5;
	Mon, 24 Aug 2026 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576585; cv=none; b=p325RQsek/TtCzYndq5lYPhKJSeKjsBB7a8u+Er/pVCBHn1UzQJx9yMIXMApMENa/MIz1xklXjZg+n6D30XSS9/RW6XvqIp0k36UI9PMUWnNptcmrb910i3l+qD6MwviGBVk52hW8GBpQFapl7y/SBJ6DydOQjMXPA4nqOOXH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576585; c=relaxed/simple;
	bh=rISoIGcu3acgHcr6u7ATXSnlDoqloOptU3VnGEGcGZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/BAq2B46Ye7rGEbZ1bQSqTjHU5DakMA7Y2oiknZZ/gRVsX2P6K+/4e/AbORSiQC4bUHcihQqMBHwxxQlX/q+8JFwQD64d3TnIByM1TweNBHrBLWkeN2YWXEa2fScVq3QgAuvDQG89DL5avsO3h5m8Js01dAuwvthIs8YyIhjNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lsPC+KZc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lsPC+KZc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ct6506Qb0sPYJHueF+mC3+i6CnJwRsT9BxuFgK8Ljg=; b=lsPC+KZcrkWtq8gMhRbGTgoNAI
	kleVUabpmWsgOIq1Jwv2A8PwZJBW62DsUJVBQaCB5XEKQLWKEMi21Tn9q0F1yMcSDa89PyDKzCLSf
	RoLqks98BL8ePQk2JTnnzAx6++qHOGYl9KGqsMds/wkIei86ik3W4WZUH+9riybmlh4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wyUJy-001EfO-OB; Mon, 24 Aug 2026 15:02:38 +0200
Date: Mon, 24 Aug 2026 15:02:38 +0200
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
Subject: Re: [PATCH 11/12] riscv: dts: ultrarisc: Add Shenzhen Rongda M0
 board device tree
Message-ID: <d93868e7-00c7-4251-9b23-8b3ed0535185@lunn.ch>
References: <20260824-ultrarisc-dts-v1-0-61ab7aebe9e5@ultrarisc.com>
 <20260824-ultrarisc-dts-v1-11-61ab7aebe9e5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-ultrarisc-dts-v1-11-61ab7aebe9e5@ultrarisc.com>

> +&ethernet {
> +	phy-handle = <&phy0>;
> +	/*
> +	 * YT8531 RGMII timing on this board requires no PHY internal delays.

Please extend this sentence with an explanation why it needs no delay?

There are times this is correct, but it is also mostly wrong. Without
an explanation, i cannot say if this is correct or not.

   Andrew
