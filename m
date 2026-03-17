Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5A38E11C
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732427; cv=none; b=ag33XHJmhsSVRzU6EGT+Wo1C13Vbz+uJH/Ebe4zlqrrxBJ/RNJUFpAt2NNzpPGNI5PCkYSSB5aNOz/fmIr+ffeNlgGooDKuxKcak0mR7elR2EkkpxUhJqvvEFG0ifPFQsseNao2xSF2R+PfEzbWZAOFl0S4eTdh1g1j4b06shds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732427; c=relaxed/simple;
	bh=uK/yatnqUfTvDqI7YxNLRspu58OylQogpc14FiQPe68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsPYwh3+mz0TZ4FTvJ/N/AP68azgzh4aK74/3rtaIxECV40PkvNsLJqLkgdO6UzrGhNAMT4Q0JvpgVmCGcnXVtjfzUB40bc/ypKYCHtjK58bGdr6W8gjlOW9mbZQvwlqdXdzpOSFqezYmtjsOVLzWnosAamMYbgWvVlwtYPjcaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G1SOiayi; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G1SOiayi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=+E5J
	ExlH1gsTbrfMSDrOrCsvoCvNuc0M7joRkI7q/a0=; b=G1SOiayi7IoPrStzYmkA
	vE7X7q92XlvwYuEl9Qq+m43cNpJ1xkkG+3XSjgJJ6u1gQUoFRCQaWvd0ltaIwWz/
	HONuSZqyrenHqXgFemBvGilKgGqmEuKXcnp8Z15LGRMALDs51AhRCugiRG2ZV4Px
	7B8PLtMebupyzkbYa1PW8sHAh8ZqVD5/mREnBxYk3r9vU+BvmA5PxdwAF0in6ofA
	GidGANePhLce/03m5Xss1p3CFf+7JesvhB182Kx4jRpvr5t72lro76lUMfRTZflS
	96CCkOxwe23kNqh//4oAvR+2RX1AQZM5LMQLBymy9yiVdMAaxP+s1rKPe3u/WBsI
	nA==
Received: (qmail 162337 invoked from network); 17 Mar 2026 08:26:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Mar 2026 08:26:53 +0100
X-UD-Smtp-Session: l3s3148p1@khhxQjNNeKhSwmvS
Date: Tue, 17 Mar 2026 08:26:53 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
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
Message-ID: <abkCPU3rxHI49N4_@shikoro>
References: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316154159.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>

Hi Doug,

thanks for tackling this issue! I agree it should be fixed, just
wondered about one thing:

> While flags are often modified while under the "fwnode_link_lock",
> this is not universally true.

Is it a possibility to use the lock in all code paths instead?
Because...

>  	struct list_head consumers;
> -	u8 flags;
> +	unsigned long flags;

... this change costs some memory on every system. Maybe it can be
avoided?

Happy hacking,

   Wolfram

