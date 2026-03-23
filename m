Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2B37F729
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302603; cv=none; b=q3pOJLnVlTYkL/EEdBfkUscXGvcE2NsbTei84l9pUvhbPiPxFfQVfmE1aXhE27Dk6YlWOBxykxyyvUX7tEUfJiWgrv8pcuoeVTIaw4ukmoHrmOCAHzGcRe/ZzUX+uOOiR8Gl+7K/8ObzRdQa8m/9H5fyTvdNwfZhahJLuYPbjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302603; c=relaxed/simple;
	bh=y+Gt1L0qys08x2UG0gqY30qV3m6tEiIOwvQdKXqzRZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rag4GA8cXD181NVtXUrD4MtuIG1RMffIvLVVn6T6EXhLHz1FuhKSbUXZ2lCO37DDnCmbn4keAG7DFS1CQ8tvR42aJs+MmUrWFFdFKwkKHt7u8r3NodG7X35DHpmIJZRSPHsd046cE6XhN5+FlC9DtP09viV/H+cMkzqm0Ex+kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ye/iSsS6; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ye/iSsS6"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c107ef474fso1408724eec.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774302601; x=1774907401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+m0/AdxnnWyHs/Fd93ISLCpoYSuqRajs8ccdfR5letY=;
        b=Ye/iSsS6G/oVmcr4bmXbRRIwAuOp406pGIaJb7oZeVO4lOol2st7EqJYsGmqJ/rEl3
         8Bvops2VAZCCZ9itxieJIDdF4p1Qn8/hoWrfHhAFdQta9KYY//q1PbyQP/1Q+EkjQ+Oj
         ie3t697OsijWGD3l1ah2Sw7T8ubTxYZTEjmsUu0YrJbe9zuPMBwWB4x1ofRvtQ1FRqtE
         Bm4rFtw17MoowomGLKursWhmzzyEtsaeUcnk1apyeCoztGfsxmnH67avx6EZ3mye9Qq8
         pQgjm5DUDWwuXSx+jT2mcQhzZUPrztVdywYvr2zWLv7HGQGHC3Y/my5CsySlwFqyEiRV
         a03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774302601; x=1774907401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+m0/AdxnnWyHs/Fd93ISLCpoYSuqRajs8ccdfR5letY=;
        b=X4hQes0t71nFY2hd+Hpd0pLDbVvirz/Bc/UtjEECPobCe32wT5uhyzPwXhXhvoIfq/
         ca5PpJSCioD2zy70JXFliAXHE2+/GFpzJ3/HLgXPXP+E4HU9lkb3yrHjw95IPLzQy3uz
         OI0HLyn9dEw2lZJ8xSHU6593j3fzUwXV/z0v+YA2Z4P2HG0kU0fD/7Kzz4vF10lzdR9l
         8plZd06fCWybW49WSeOFIYMa11k5M+26S9JXk+MVlsxdIcTpD7tSRLytysV5OWK5Xd8Q
         rLsOYpLWLPCZAijXdbitZ4IJnj0a4V0wuuirF44n+3zMpelADwoh23WQgNyS59396Qkd
         s8qA==
X-Forwarded-Encrypted: i=1; AJvYcCWqakZyMS8MaZHdQZqxQqDXMymwwYthnahgE7zZgdzC80mtt1AA/K4uMF0vn0IrCNFPkFNRGEmmous=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2aQuPSvueXui43gq5jEX+ha7nBLdoQl5EJcy3ZFTlXHLeo0LM
	4UrtRy0oarK5MaYbvY0X8nHQTtuo+z6vHoStqZE4lxh31k76wK3YUWlG
X-Gm-Gg: ATEYQzz/H8v2wZsYMrzCtXWofQkbRVdCWSlViFG/MfSv7u5hGsSpvHWGcrXL8dawSi8
	KQa6imaLyOLu/Sf71wy8lSqf8tSp9sSmFCydXCApkwez4e5YZKlj+63ygmexGjaEIhwqKDgka/2
	cMTF1bqxpF/+YYf1Hc/YnVkIN6h2bJuFhfeKvgT1r7FSudl1R+hDckbxN+sgxDUmPsUF/v7NWf+
	NS/ZwCbECq+pfyO0PIApE1iehY8O55QeLInhsUsZxhM2zdAZ2oP8S54X+ZVlqcWaE/ekVQeT7FY
	dkAMMk2VCzTEvR3im8AttQ4OqqeI3ZS03/6fVPIJ3b6qEApgHfj3hEdRIGhjUCJrsi8p2h8mUcY
	XG6jJwpZYaiSoXnXeQqDlZ7qtWfjLyLcXdTD3+joKnDRzn+paKX0D6Fj92+G+7kJ2Ah9FIANHrS
	q5R+OyId81cYKHoMuEQjbl7gjpM2tjWlkx+pFLZHotUf9Yxbh6MmWUlnQQIuYLDsgF
X-Received: by 2002:a05:7300:72c7:b0:2b7:1e86:3604 with SMTP id 5a478bee46e88-2c1095e6a9fmr7621666eec.6.1774302601091;
        Mon, 23 Mar 2026 14:50:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b31ebd5sm13412438eec.27.2026.03.23.14.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:50:00 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:49:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Rosin <peda@axentia.se>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next 07/10] net: phy: switch to using
 class_find_device_by_fwnode()
Message-ID: <acG1JNGVBJ2Mf7jC@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-7-b72eb22a1215@gmail.com>
 <32679fc0-c388-4cd7-a030-5f5ed5abab78@lunn.ch>
 <acDLzK8vpptTUMf1@google.com>
 <acEBCBgMV3RrGKiU@shell.armlinux.org.uk>
 <acGGWTmSMuc5h3Od@google.com>
 <acGI4PI3MHML9Pce@shell.armlinux.org.uk>
 <f37684ff-57af-425a-bb18-bd5e8de3bba3@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f37684ff-57af-425a-bb18-bd5e8de3bba3@lunn.ch>

On Mon, Mar 23, 2026 at 09:15:11PM +0100, Andrew Lunn wrote:
> > This is not "foreign territory" - ACPI in general doesn't want to
> > describe e.g. the individual components of a network card, unlike
> > DT.
> 
> It has also been suggested that the MDIO bus should be added to the
> ACPI specification as a first class bus, similar to I2C, SPI,
> etc. This would make it different to the DT. So we don't want to
> encourage developers to use the networking DT concepts in ACPI, it
> will just cause problems if the ACPI spec every actually covers the
> use cases of networking.

BTW, why would not we want to push for the unified binding? They are the
same pieces of hardware...

-- 
Dmitry
