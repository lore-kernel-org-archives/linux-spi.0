Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2639B483
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736965; cv=none; b=LhcBMr3xfnjw8HIqqV6u8LALlKWohCLnYLEPZ5hDynO7aUiFNWRwmz4l81LuVsC0+W2SfXobMdkth1jMo5I342mbOnMIpSS2lDUeqK6ESKEfq3XyYHTdDZs5uNd4gFuhALKlAm+aghx1KPcDGg+JcLEW4LodyYpEpw8NHvbnP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736965; c=relaxed/simple;
	bh=We4kyAVpef1yVQMi+y0N9ah2Tt3KgAFYTyFZ0cU4WdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giCyhVYrDhv5Gn/1GRaDueN2i+vcfvxnELe09LB3rlVxFtZiJimIukgYB7McaGuj6i9yhiKwlNtonAP7+uIM7CbMmTr2vsmf+qlfXJU55dDr8qODwH8xbezjdTJUjRTu0kxYUWV7d8GVnzB3JYN3xhed4rvm6mM0U9PnJ6UcBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=JkTPL8Qa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="JkTPL8Qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=irzt
	fqdefDjxQXcIA83sbW0ur9PPGeP0t0NSrtgsi4s=; b=JkTPL8Qa9lTezefnVa6i
	PuYCxImKQCA7y+YErvUuovrsTDP4lQ8/PbcRoOO+H227ulh0TCzmz92MT4WGbqnm
	gtzhzsyqq/usEM+njAVl6Ta70MEaZ99nvIxLnlXqsAmQwno9VfN3R6Gu8SqvG6zT
	1+efsUaKoaaQKySH4J7r8j2pWizdLDHaXluauufhjIxnxU5B2wjQ+zeZ+4bfm6ND
	Nfhf5jo5AWZbwlhYHEYbtJJ0jDxp/LSpcc1R2ia2HSyf37lZiJ0rS+7oS1HGjWKQ
	MWVM2QCBt6kUATI0QRa2cnXhsD7zsgMr2oUr6HJLJ/rEFm8WZweSEjfIASNyHNtj
	KA==
Received: (qmail 187280 invoked from network); 17 Mar 2026 09:42:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 09:42:38 +0100
X-UD-Smtp-Session: l3s3148p1@e79TUTRNPMFSwmvS
Date: Tue, 17 Mar 2026 09:42:38 +0100
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
Message-ID: <abkT_jpjIki6pvX1@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro>
 <abkLEgrZbdb03VWg@ashevche-desk.local>
 <abkLY4AAQuFlTRC7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abkLY4AAQuFlTRC7@ashevche-desk.local>


> > What's the alignment for the u8 member in your SoC? 4 bytes or 8 bytes?
> > (I assume it's 64-bit SoC.)
> 
> FWIW, with the given change it will be still inside 64-byte data structure
> which most likely occupies a single cache line (before this patch and after
> as well).

I consider this directon of the discussion irrelevant. If the number is
(maybe? That's to be discussed!) needlessly bigger than 0, then it
doesn't matter how big the number is.

Why don't you like the idea of taking the lock?

