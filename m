Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A63BED01
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290517; cv=none; b=BSorjHPoCQEMqfrldD1G17bW7WWKhx0t4vUgxo88lOozmMTwdCPaX8WSczMqB4wylq2WyjEHf9MbILtnsq5txMeyDOzM/wwySy/uTyYKwBAWOt1wAKS+kwqFZXy18D/17lF6YIhLhC4+EysakTvtQaTQEPgRj6IR9LYmjW6ZkqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290517; c=relaxed/simple;
	bh=t8uGoOmn69GTvslBxUEc5eTMB7ZiO+nrKn47M9Cp8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVADsOtcr6gzl25FlhEsb7VEMXh+jxfYe6EBpxNdjEZhLUynN9QIsqk8iePwH0k/1CaaQu6GdqjGcACjMxoVVG0Rj32cPoqM5RNnvuVJBdo62vUxsE1sEUjf7hVlrCgEzSeokyITEh+L3pBBcicn1sb3olWAO8/AIOADU0M/nCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU4LxGOf; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU4LxGOf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so3065600eec.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290512; x=1774895312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=nU4LxGOfPs3QZ3q1BOHY3xW1BsasEVECfsn054gvduGccyJOdGSSriZyQel7ZZuODl
         ND8rPtQjMEovixdtNdNPwz4OydDcycp5pWW/3m1fgC5jMQKNUFPH7NGtKsQK1IfKfrh9
         Rqidd+o/bKJ8/7fAi7cuedl4la/kRsdBnWlhvXPhFzz0J2hgto+9uB1E+I8bK+rQylJi
         lSKxKrIbr7b/Jb/WJJy2Mj5pzoj2OD079F/dp9rrMqkSgsYnMnG4IjOOa44gvtMGJhqv
         B9oDuQ493ayNmc/UX1pJrrIqdmYW1NQWAO9Q0QIVybo3KKDYoESuZZMQdAQSGs8k+uO7
         teDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290512; x=1774895312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDXVXDlTyWriMoHabs2g4jaDjhygWMksayJaNvHtSE8=;
        b=svPFRWdAnUtjEHO6xRNiOPssNhUz4nHWm2JYWise6fCfTaXSsPg5/4DUW5+YrMNLUW
         Co1NrBaxn40C2M6ZiIIyY41e/0Cm1Q3a8fuByP/LI/R/q+qTteZXpibI7razBy1y9qfp
         KYtxlag400S+vJZqB+7XlpLPb6MvI0JAoV2RIYu0gYIyPVjSO9b5CD+6N9tJ1WQCSOCs
         fsieFPwTcw2odp6b26jsP111A9i5arbVVwVrAyZ2nsGdBkc/ZWIvizOSxSnYqaBoHJQL
         GnG8NdvyUf/YE11B4ZEMg68yRWjrgx+qyI9SbZxMFPI58bN1J1FxZgaoP0Lup2zLLPwT
         ldKw==
X-Forwarded-Encrypted: i=1; AJvYcCXPMg6413yA1vLjNw4JI6ajOlkFjHzX2QDO4nz1tc35s2UAnEQMfjNHeXlCAZfJOwREKTPb3KGrvWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtu46Sxk3dvx94lKO3/I3yiXDZtw7qVP7INa89W59+EWeaVFy
	3mHGjFLfTHlSlCyK+ZGTkCYWL1NIE6JzV0dE1OsXge40OEBWzgtUENH7
X-Gm-Gg: ATEYQzxHplcGGFo6LfxvoMWxpZ4PtK8QG0Z8Gt2Se18xGk2JAC3NIU0sh3rki2g2DT4
	g86Qc8eaB3yVAUWJ11Xu989io9+IoDKvWVTPaSSm7yt2JSHEpjDz8KeUtKRkIU6nAfC3/6BIIzb
	LCss7luXitxG5a1CrqKwZno+CRGCoEQ/QgXRvV6eYEOTRfg+wVuQD61v2P1o6raUPFq++adJ6bA
	g1tyxqdqOlGW9gLSbJBb0FhsFUYQbSN8bS3gpAzTUSavlyEmSRovf2KM33+4QhX+mZLexBg9Uhy
	MYWKDe2we+WJalUoTfDp5/uXkkX1sxFkWf1TqFdVSBTaZ5lTUTlCW6DS4O3q2F34KYdNCzppQCs
	9HjSuYEs2ebgHDGnYpJczeS2U2kuoM2F5luuBZ2H3uPKMVyn1j83BuMm2TAUStPdUqbjkuzQakt
	tcdk177X8NRcAcrbYrkiAjGBAWx8hecLPYp3plrM4TDwhjHdVL2MAWd71aCTZY7o7S
X-Received: by 2002:a05:693c:2b06:b0:2c0:ad52:e657 with SMTP id 5a478bee46e88-2c109712cedmr6434030eec.21.1774290511733;
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm17872306eec.9.2026.03.23.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:31 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:28:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-spi@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-fpga@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH 04/10] regulator: of: switch to using
 class_find_device_by_fwnode()
Message-ID: <acGFksyx3SA0kJ5b@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>

On Mon, Mar 23, 2026 at 02:00:43PM +0000, Mark Brown wrote:
> On Sun, Mar 22, 2026 at 06:54:22PM -0700, Dmitry Torokhov wrote:
> > In preparation to class_find_device_by_of_node() going away switch to
> > using class_find_device_by_fwnode().
> 
> >  	struct device *dev;
> >  
> > -	dev = class_find_device_by_of_node(&regulator_class, np);
> > +	dev = class_find_device_by_fwnode(&regulator_class, of_fwnode_handle(np));
> 
> The regulator API is very deliberately specifically using the OF APIs,
> not the ACPI APIs, since ACPI really doesn't want to model regulators.

For now? We also have software nodes and maybe we come up with something
else in the future...

I think we should use firmware-agnostic APIs as much as possible, and
only use OF- or ACPI-specific ones when there is no generic equivalent.
This makes the code most flexible.

Anyway, I am not proposing to change all of the regulator code, just
clean up driver core APIs.

Thanks.

-- 
Dmitry
