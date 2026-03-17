Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E113A6F0C
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743677; cv=none; b=p63pQxYfpscP5Zyj0O7X+cAW2dQPakIAKSTKbbXiMMu2qfxxkigk+jqwrNSyS0d3+uwkmBmXmeBWsnjSZ1A8z2PVsIdTCCApHPvLNyU+wmqO6mym7cWfabiG8p3Xdv5KR//2Ngcl5HeSz+KdaGSupfMxCJh6pDQI2OU6GNRAh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743677; c=relaxed/simple;
	bh=FlGrEkibMU7jAxa/nAeVCmJI/B374Ki2x5uFqqjET4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAFFHmGJ2rdLIg32oHAQXO+UC3kZen1mXli3JIZ/kxZ2Eh30WBCIF6ZR/y6t50ckfsdsrmhFaoqIFSBdKm7BrB/SoLRAuhZfmBeGV6dPZhRR51+9CauJH+H7u4K3G+Snh55aHT6mzB5H5G6YFm9Vxz0tEkAjRRYgNGAmelUaDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eFh0XkAG; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eFh0XkAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=FlGr
	EkibMU7jAxa/nAeVCmJI/B374Ki2x5uFqqjET4Q=; b=eFh0XkAGzMPNjtcmbgff
	QOZPMTGhym26jBZOfBrQp5jdXXOXo7UUlMfNPmPoWR8Dxu7QTbJLJ6CzfclOrJ7N
	5pAJufP17U/rg1k57+UhxOkrGs3RKsZLMRDmmhRWfZAznOWUisF92lPnxuozG5Q8
	YCnIWrCduQMe+FABVERNeM8QN85Sby1Y4DRnhpRJ1T/wzRhpZFth+STBXAJpK7LD
	RDtZgOlUxY0GXh+SiBHs6/pv7JDSeDyxsUCSD7HC+zgXPumwIsWLe14e5/TIKZcg
	fkFC8tf3AZXbE2owx+TISJ6/NRNPs36iNKMwuQmFeYGCAWxM9hkc04XQIfij//Ds
	QA==
Received: (qmail 235590 invoked from network); 17 Mar 2026 11:34:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 11:34:30 +0100
X-UD-Smtp-Session: l3s3148p1@pjNn4TVNpshSwmvS
Date: Tue, 17 Mar 2026 11:34:30 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
	Mark Brown <broonie@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
	driver-core@lists.linux.dev, imx@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] device property: Make modifications of fwnode "flags"
 thread safe
Message-ID: <abkuNpwmYGa6qJPZ@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro>
 <abkLEgrZbdb03VWg@ashevche-desk.local>
 <abkLY4AAQuFlTRC7@ashevche-desk.local>
 <abkT_jpjIki6pvX1@shikoro>
 <abkqEni3phP8dqqw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkqEni3phP8dqqw@ashevche-desk.local>


> Like Danilo I am also not sure what lock protects fwnode accesses.

This is basically the question I asked to Doug. If he also don't see
one, let's take this patch as is.

