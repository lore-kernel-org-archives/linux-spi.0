Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3B3A873B
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757684; cv=none; b=qsVaoeO/EDHGzVCHsk96SLXQpmkUW7s7vyHkhd92WqC7Yhsok0sKS0E4O8xnWBIz6OL0R9mVgW8wlX7bpyYQu1L8q4GXb3snjc7MtwClWqJnSLFZ+XeHDSs+ZokiPk6oRW9COQ9LVbTY0DU8d8KDggjsB6qbcn7H8WfAeWUWHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757684; c=relaxed/simple;
	bh=XlJj6+XtRnLs033bhaxlmEjesLS+qafeUVhuDo8ItlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVfv2CEFzUr2ixi75lFTO1OTgSt20UIJ3yXWWrIZfJhgRFd06kz/dcrVttBK86iiAGWgjzSITIXyMgUV7dWIWvMPq/KMDlfnPEsrgj5wLcr38R8nyNwdxnrFhnOfJUxwvyaShcySNE0vRoD2ZpLksbWiICi0EPNQ9Us/8e+QNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bG2zxRXQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bG2zxRXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=XlJj
	6+XtRnLs033bhaxlmEjesLS+qafeUVhuDo8ItlA=; b=bG2zxRXQ9Fu9bCPjNpx3
	P7wgiIDoMXLCFMRPPmDltjPAhFzrIRxLaSxIF85pzMhW3YyHuUmEPHx4tFc4UUho
	Wo06erk7gncW5uU46/3R7WWSOx6aUij0lMRTitWmNhEITS6dBlW5FTJQJ9Lann3s
	dlppwJoBzJT5UfzY5GRapN/vktmt/GFIZqfQ7PYY1fBvA6Tbh+0RN0wBNuR0C9Z/
	Xyd1b5tVvedLvdm7mrVbuvLIWeLiCjAeTKnuo2FG1hjxzOQTRhAzR5B4ebBzP+t3
	vgcwphcy28vVhUjbhXw+mZaFWm3+CISUtLErtDSyofA6mcDgcyIeFO1eGKVh/IO/
	FQ==
Received: (qmail 312797 invoked from network); 17 Mar 2026 15:27:57 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 15:27:57 +0100
X-UD-Smtp-Session: l3s3148p1@LnJGJDlN/LM+XdJ7
Date: Tue, 17 Mar 2026 15:27:52 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <ablk6O2XMUc1EKK0@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <abkCPU3rxHI49N4_@shikoro>
 <abkD-VLprcbbEbB1@ashevche-desk.local>
 <abkF0GO01sMcOhvb@shikoro>
 <abkLEgrZbdb03VWg@ashevche-desk.local>
 <abkLY4AAQuFlTRC7@ashevche-desk.local>
 <abkT_jpjIki6pvX1@shikoro>
 <abkqEni3phP8dqqw@ashevche-desk.local>
 <abkuNpwmYGa6qJPZ@shikoro>
 <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=_HW7i8-emNdTtw_0Kjqri8qTehHvms52u-w7jqG6bQ@mail.gmail.com>


> I don't recall using any lock for this purpose.

In that case:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

counts as an ack for i2c, too, of course.

