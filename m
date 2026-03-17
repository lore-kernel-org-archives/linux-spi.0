Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCD246BC6;
	Tue, 17 Mar 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764459; cv=none; b=qX9kp40zmpemQqZW2PyQaT96F5T0eRXHgntyDLP9LY8n/kSMsdJuZ1VS7qyCjwqGjwYk6GUmr5bRTpPz6Czi6CTkNN+HcmH8lnFtv0w9fedg5VZHWcyLze8huwbYDMnHw8N1fXSmiG9o2Zg4GsmM3CdFMNiUeasJznRSb8z27Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764459; c=relaxed/simple;
	bh=e0BPQ1p0UdfRCxCsTaN9DCxBuEgVgdYt0iMgNM1/M1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lM6F9T6KjNSF8AEUBkVzYqrsemHZ1PxYuN2/jTdip5ent0NDgyWaIq37SNaIiHpdSf7APqytHVunhINr8GonVg6fIfGTEqHaOKSmWGBrBxwBi252MrMPTyj+ib7o3ZIikPeiFVCwlHFHDkyH543ZgYUl9IFMJ+KNd4sDfRgRS2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWwY5lgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWwY5lgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775A7C4CEF7;
	Tue, 17 Mar 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773764458;
	bh=e0BPQ1p0UdfRCxCsTaN9DCxBuEgVgdYt0iMgNM1/M1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWwY5lgxEUOSMGbdv+aQWxJp08HLMO7z3TQgBQ1a0RAkOkA+HhoC66RreUnEdoqVv
	 f/Cj0g3xYmLRHrgQZGCWbPRlyy12meMkzl61LsRz54Zu073r6Ct7QpcsIhxHEwwEYd
	 tpszZOw4aqVoCCSO8A1hDIi7Cx2lQ1cniaOFqORXExZjrvwcId9xfPi9od081znGp0
	 j3AlD3Vxh84yMQGKBBsYSIgnfRb2FPxk0OmYjc2c+6MctKviHVjF5wfUby36SiQxnP
	 zVQJz5jotHJhQosIBbAGv0xdxeJq969llKUbN+YrfDoOUB7H3IvqF6IK1UiyqIqhT+
	 ThoDGXHmVugpA==
Message-ID: <0f92ab73-5996-4977-9ada-e8a26957110c@kernel.org>
Date: Tue, 17 Mar 2026 17:20:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn
 <andrew@lunn.ch>, Daniel Scally <djrscally@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Saravana Kannan <saravanak@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, devicetree@vger.kernel.org,
 driver-core@lists.linux.dev, imx@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, netdev@vger.kernel.org
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
 <CAJZ5v0hwO16=mP_vB=wi7x8CjROAw_Nd_Tq-hEohrDW3C58RbA@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAJZ5v0hwO16=mP_vB=wi7x8CjROAw_Nd_Tq-hEohrDW3C58RbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/17/2026 5:11 PM, Rafael J. Wysocki wrote:
> On Tue, Mar 17, 2026 at 5:04 PM Douglas Anderson <dianders@chromium.org> wrote:
>>
>> In various places in the kernel, we modify the fwnode "flags" member
>> by doing either:
>>   fwnode->flags |= SOME_FLAG;
>>   fwnode->flags &= ~SOME_FLAG;
>>
>> This type of modification is not thread-safe. If two threads are both
>> mucking with the flags at the same time then one can clobber the
>> other.
>>
>> While flags are often modified while under the "fwnode_link_lock",
>> this is not universally true.
>>
>> Create some accessor functions for setting, clearing, and testing the
>> FWNODE flags and move all users to these accessor functions. New
>> accessor functions use set_bit() and clear_bit(), which are
>> thread-safe.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Rafael J. Wysocki (Intel) <rafael@kernel.org>

ACK or RB?
