Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794769347;
	b=O46ei1Dc1ZVJXO2Z+JqjC+B96nl8pNl65XhrbwRCAahY+EDhZaEDrg5ms1AWRuYu1TcE
	 PQd6QXqIZC9wVQL6miBbz+zOjF8G2Ag/RVUx3mMwwfAXwAi0Qf6TFT98G3m5eAbdbShDo
	 lb6Y4kdyt2epeM9RBJUyu8+PF+iiEy38PRZTloG+3cOeav4q5EikADO95yioTf8LdhAOk
	 fhifoCMx/72voQSppIpoFgkqk/rMQ3ho9/X7quDzH2+TGFPhCrxfwuTZiFuUGTr/e1kCQ
	 LiwMSrSmjto8mY308r86WLrf6gdi3C7TFKy4xlrQvg113GVEz5W7jDeG0Gor6t4vPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794769347;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=71suhnOQ187ewHE/PuoqWfe+otthECsrCZEY2F7KU/s=;
	b=at18+fwP3Y1d4fg6uqzddyzGtI84JUFdWgV12+/vjncZS9IUgzzH5+oDnMn2+L0AWy6v
	 BD7GHjhg8OQ/VGzTbLIpKaJ6I3rgpTld8rEihrBpoDPaiLtPAVCPk2B485r3FnmddoVJp
	 1JymX/0Dgw7/PijU8HJoykjLV0Dc2fV6iMCI6dwGe0KzHWFCrbLGmR+WGDK2Q5KufK5SS
	 DR/kp84xIBVPi+9jJiAYC7wbZBS+jtBgXy4MfO2UAy6j2YDrUbhu80aR3WwCYFLd74pdi
	 YQ8gKnzelVNRcVxU4XkfGY/mgCiTiEMyPOd4GKETkZyYyT4TgpIyxdxoFCL5F/WsyBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blDNmVKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71761606A31F;
	Sun, 15 Nov 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=blDNmVKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47521F000C5;
	Sun, 15 Nov 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794769347;
	bh=71suhnOQ187ewHE/PuoqWfe+otthECsrCZEY2F7KU/s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=blDNmVKoT+2L6E3h1NQY0dK0VShq2C3snAqOuMXWvOPSKTqiYf2DCSQcltZ8XTSOg
	 J+yvoRW4WweMJZyqVfcdSU481T8OISjMYTpxy3oO1DKhlUOL6o3P8o11/uHtN4+Ibj
	 9Q3FWbldUzWWQCaui3pQy9F/xSVhgef8g9BhTUnbVb4XOarT722a00w+R8lnQ/1jJ+
	 Zr1qtR6edrofnHAvO2UdT2t/6X370u/WxpjJFnA2j2THam0ygzbfedALxuEgEiN2sy
	 tw+FnV6GiTUHPC0HQFHgspqBSexJ66751ep20GyduEO7fCWARASc0tZTRWBFnbYnlS
	 MKaU9DV3P+f3w==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 440533438C02;
	Sun, 15 Nov 2026 19:02:22 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 08/19] spi: cadence-quadspi: add PHY tuning support
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
 vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org, 
 takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, praneeth@ti.com, sebin.francis@ti.com, 
 u-kumar1@ti.com, srikanth.boyapally@amd.com, m-shah@ti.com
In-Reply-To: <20261105105832.2134313-9-s-k6@ti.com>
References: <20261105105832.2134313-1-s-k6@ti.com>
 <20261105105832.2134313-9-s-k6@ti.com>
Date: Sun, 15 Nov 2026 19:02:20 +0000
Message-Id: <179476934046.140154.1891166104571142429.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hQT5utl8foco5MPE7XQ4r4AsB6YHll0nIcrWwSLcj/A=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+Me5LlHOY03L3y7n/kzT2q71MnDqn+dbf5kMRpmxZX
 Vvdv8x801HKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJiGxmZHhnckp9cxazigWX
 6nv1t3NkmRjfxf878bpq5smWhvi5LicZ/mk5lCb8PdjNtDH+bDdvC3vR0f/fks4H7HgrOKlLvfL
 dXk4A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> The Cadence QSPI controller supports a delay-line PHY for high-speed
> operation. Without calibration the PHY is unused and read capture relies
> on a fixed delay, limiting throughput at frequencies above the base
> operating speed.

> +static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
> +					   struct spi_mem_op *read_op,
> +					   struct spi_mem_op *write_op)
> +{

> +	f_pdata->phy_read_op.max_freq = mem->spi->post_config_max_speed_hz;

Do we need to validate with the reference clock here?  AIUI in PHY mode
we bypass the divider we set in cqspi_configure() so we might be
overclocking things.  There's also an awful lot of Sashiko reports on
this, some of which looked plausible.

> @@ -1587,9 +3308,15 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
>  		return -ENXIO;
>  	}
>  
> -	if (of_property_read_u32(np, "spi-max-frequency", &f_pdata->clk_rate)) {
> -		dev_err(&pdev->dev, "couldn't determine spi-max-frequency\n");
> -		return -ENXIO;

This is a bit surprising?

-- 
Mark Brown <broonie@kernel.org>
