Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86B9382384
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304877; cv=none; b=mOE8YUq78jbiPz6nwpxieU7lzLfj0cg3x92A9CQeCjMADV2USpKwpmtUa9iwHknDZpFvXqRGtoCXKdDA0qCmHUg0XADQLPykHOlE96CLjp/ZkThIz1U5qkX6s8L4L81Pqt6on9PdY3s3e6e3SANcLj0X/TIvh70ffzX1G90pE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304877; c=relaxed/simple;
	bh=t3DRPPEFmGvn6CLbNxf/rnOA0bdk4BEKupzcqZRYTk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eK5uofQ77LLclifxCz2ljTjBkMQGIGEV091MM0AIu5aNO3BTkxYuESf2bE9DZgCLp2vj6t7paFGxn2hvFEwzs2AUDbzw6azZ55kVm32r+TXvLj/T4emX8vuWkKWS2Oxy3nW+iIKPWGhhPi9y7mQAoD2J1tI0zXlEspoPHW1C6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXwiLEqp; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXwiLEqp"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so894753eec.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 15:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774304875; x=1774909675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEJ8II5Mq/xurnYxGbenRnl9vYWDBkm+Mx+1ug12uRY=;
        b=KXwiLEqppMPL+0YiNEsTHlixOZ4HNETs2No9NvHXpOtYnk7u0a/FWbqsWbAL4EdFRB
         EYbvEcKYUtiKXjm3Z+Tpxius3qtVX41SlPiWXYoCmym1raFmzmkCHknW8vBAbwZ5CRl7
         X+OPFsH7si8sMvPhn5GGOoKn7wNv7bfJrwLbQx1AJrKzmoZoJc2jS4MbIFLORjQMmwXC
         OfDZUb0oBi8CdWtyFhsDs2W0baJ8WAh0oYlc+detsjuOOK4n2tV78JyL6a42IM+rhS89
         WGUurGG/WsRiCRZ7BIyWzGN/CPqMov7HvLi3dKSqO/clWHOAmiPnH52DSPD0FinqBE4J
         Qk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774304875; x=1774909675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEJ8II5Mq/xurnYxGbenRnl9vYWDBkm+Mx+1ug12uRY=;
        b=nhI1k2AvUFc7z/eGmuhEhNrOzQk1jm2/uM6p78lY0zCS9vpNzr5yFw25y1Cl0FdK72
         dYt22edKtSEHfMnZw3b97ozU4L3eXdIEFIY9n+Pm/uNs2Np99rIuHQYLqmQoj0iZMa6u
         kBZFsl9/1E/f431MImoi34Z6mIrbsTPEDpQ7nH1WslvCLWt/0kCGDcB8dyz2uEVMhqGV
         h0T6ZiKPkQSa3RN7Jst3wSptIeN6khSLfDX4LQHlzLahToalLWD31dffhxx9d/SjBFOz
         34a0esgUV720+GxaVGmOx2tQ04j0LWkwPvpfep12Q7r5VUhQoTHqCB677WRNqMwceW/4
         mwQg==
X-Forwarded-Encrypted: i=1; AJvYcCXhNta5mJL6MpVpLsDhh6FK+7UK+3699PFeUXaN9emR6I7RSDiC6RsaAk5C4lHXQ/FSu4zaFHIwKt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweY7N+eEgvGtJzmG4O6QW2PVZNVGGnAdM5msGMWCL5Bbmy6c+d
	WxtU896M+H52HWZe/GBGpTtbOteFhABYY5peSrXmrtSxWz5GgyEqtOh3
X-Gm-Gg: ATEYQzw8xVDqB42iF66FiJCPHLdC0PCIksbB9uzBGaXHIt5kj4+ogMyd1VkQQ6uExdI
	OCKPu6G1rMI8+ebPkFeHSUFROSr1lBQXsNkywMUrBs1E0BQuWkneSWayBet1tu31VHQ88RuPLI/
	94T7MmJSSSqT60swx9qY98Z1SyqovxJYLDRWMx4uhmRYX0LJR6Vv5PfO06xsKd8+5JkAk/mrVHY
	CShN2EG1VmTaCve5RJijNme7ndRWYvUXqX5QAM/+wfsZ53MmW/1VQlp0zSOBAniumVl7yYaTdo1
	AVZWVUZZir38m7pMetOFiUZl/8Ly0Takp0RkXFp2GiE5WVxRA+JY4qtpDC9KYy9SYJyDCXz06EF
	JqNnlC/aB5kJ1HuAfzv7v9G5vPnDK27zxIFLwR3h6RckdpK7YakUMTVXWNb7CBZ3vtgyYGcAY4F
	E3ed3GhqaroxUHYBELb/yd67z3o//mZ+qt1xsPEF32tDHE2pBz7V9kVYtfbCfOQSXV
X-Received: by 2002:a05:7301:4198:b0:2c0:c775:a46b with SMTP id 5a478bee46e88-2c10961ef1bmr7002696eec.8.1774304874980;
        Mon, 23 Mar 2026 15:27:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm13226951eec.22.2026.03.23.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:27:53 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:27:50 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acG9BPkFr_De-ulu@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
 <cf92122d-6b15-458a-bf89-189a0a6874f7@lunn.ch>
 <193e194a-498f-464f-b22c-c283c16db6c1@sirena.org.uk>
 <acGzJV3vKhuty3nd@google.com>
 <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09072374-65e7-4792-af7e-97d7df93f9bd@lunn.ch>

On Mon, Mar 23, 2026 at 11:11:58PM +0100, Andrew Lunn wrote:
> On Mon, Mar 23, 2026 at 02:41:03PM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 09:36:07PM +0000, Mark Brown wrote:
> > > On Mon, Mar 23, 2026 at 09:01:47PM +0100, Andrew Lunn wrote:
> > > 
> > > > How do you handle deprecated OF properties? This is a problem i've run
> > > > into before. A developer needs an ACPI binding, so they blindly
> > > > convert from of_ to device_ without engaging brain. As a result, they
> > > > bring all the deprecated OF properties we want to die into the brand
> > > > new ACPI bindings.
> > > 
> > > Honestly that one hasn't really come up much for me - not too many
> > > deprecated properties.
> > 
> > Given that we position properties as an ABI even if they are deprecated
> > we supposed to handle them forever. Newer properties usually offer
> > benefits over old ones and that is how users get moved over.
> 
> ~/linux/Documentation/devicetree/bindings/net$ grep -r deprecated * | wc
>      75     361    4195
> 
> So networking has ~ 75 of them.
> 
> Within the OF world, they are ABI and we need to keep them. But we
> don't want them in ACPI or any other firmware. Any code looking for
> properties needs to know what is underneath so it can decide if it
> should look for the deprecated, OF only property, or not.

If there is a deprecated property you can do:

	error = device_property_read_u32(dev, "prop", &val);
	if (error == -ENOENT)
		error = device_property_read_u32(dev, "deprecated-prop", &val);

You do not need much more than that... Checking node type only
complicates the code, especially when a device can be used on both ACPI
and DT systems.

Thanks.

-- 
Dmitry
