Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20D3CCFB4
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294925; cv=none; b=qSxNpHcLUxBBKMkvawE3jitZZxJooMbOEAevGq/YT6ekn2dvUMfw8/jfF4ClZQbcve4Sc5YGf4mLfvdwPz198dvdM3walXnsx+sSvHWOQHEkkYASmtZzduoQnJsdSrlzvzyaEBEItevZEGybBWT7zPZz0ceznc+3huhqMuVihoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294925; c=relaxed/simple;
	bh=2SF6pvs2emzV/AhRbggyg1HdfzHcesbv4DvPDEr78n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqVCZ3c156QBOSEonxgRQ/RgNK31aD5lIgQiMVlo6FNqxOUCfDRLqKrahjFZDM7tEo/+0I6AenR1XuLxC7DPNcQyQtzepDQSc4o7Wbof8v/udJYMJ1CnaF9lOkbwWHr2TGuttVFVx0mekSe3JdIWBUIYVz1RXrlPspZ7xdroG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpuq/cLd; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpuq/cLd"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12a80c36350so1830573c88.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774294924; x=1774899724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdMs/q66h1+QBJjH+XkkqQHaHRaGP3OKtdQi49odTsU=;
        b=mpuq/cLda6pGx/tUb9lDgqEk1TmEAKbObTl2RQBeIQ7TfcopAZW6vT0jewqombymsa
         ffggOe2XuFf6d+ef7o4qVGt+fx4IpCgBt2qkMgJOQCi+uczeYEF6rIesjdsKrEL3M5VN
         CcYRglXwvZNqQZHopCW8GXfwLre3jBZ2qBrCP9NxR6MVZ0e4KhdAyK5d8fGJ+PYRrg10
         D9RJFirOLY1Wh595juUGg0DnPynppjDk3nEcSuWQ+SN++zEEZoNuzRhxsDEAn9cMWXlJ
         k5oSqN6udr9CgxHTJycW3gT0+cJeHTNiRaTAEiYb/tLjm2z6ObcvoWtWz1zkHGgHDNEl
         zSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294924; x=1774899724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdMs/q66h1+QBJjH+XkkqQHaHRaGP3OKtdQi49odTsU=;
        b=RCl+UcF332Yw/EFbUu96YD6wox1jzk/umppW9MJzW80VNB7iq5zYmP5eurhhZrFzLZ
         pZPrlQC8OPcKJUy5QfkpIOGwyjLs7XGE7zmyB46Uw6pkymRJbHXLYg7A+9D5s92i1fCa
         Ab2BGEhB4K3TksHQJkCLdT71CyrP6icArfJFiYyFqsSN89yr2icPLdvxGrRKBhCv5bbp
         QzdA7J7ko111425377NcxETD6CXd7ht1KeK1zB6BL/E4fH0Yv0SvueorHgslfUwe30yo
         GmHHD23b9ceDTAsPldIyusWSas5HxWSb4hX43H/OmmtJPkjY1pd5oY8WWuhHU/67P1ku
         7LjA==
X-Forwarded-Encrypted: i=1; AJvYcCXOEo1V3UY05aguSWGgjMasb3oXDvndTWAFa06LN6SdDSRpfVX3AciUH+ib95S7wYz6x9BqEBV2bCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDrcO+qGGClC0+obMfmhhI+Gwv9wvVZOf9RnDxcvhiHKNI65d
	ci417V/nRUjYY/ZdXWNgymGlKfQR2cFQC3X8jL2/QrwRlSkAcj1JdIzX
X-Gm-Gg: ATEYQzzbr6b3e5MWFwhG8boFwG/SvFdDca+06GXvbaEO7XPL8X1kbzisJfOVSTB4EG1
	9y15wHTYhK3GGKkhI9kjrEGDc2mGXVk/8hpy/CEVUVSnAGj1Ryp2AHV37e9B8jkvsUvovMng54D
	sosDBqRqObQjE9qnBytdemaVmjeDyf6Joc8vIQvjAgJyrRkr8tO/doK49LNtC1Ly+D7hy/CV+yI
	DNbXL9LLCEDc+szTrf5IemFSdjlcGc4+ucUDT+ylNJd3l+f/nLf3f4HeVB5GrJAP1DhjFSf6QcD
	dIMB7BrGyP/nEJuc/Z0EbEsXW37RLeSRfVnszSv8WAilysfkNPJQEnUnc2ZMuuG5rqgPRxmfVwo
	SekUIN7P/E8qftwrmNhlnPYbfw+s2cbVEDnrZCs04NNTLUcrSpMmF/TYhtfDF1ho6Fji911GARJ
	EvF2/RFE/pWg1mhWjkWawQaK+HOmBR23SpsLvOzKff1mI6DWo6cX2Pq7XRpnDD8fP3
X-Received: by 2002:a05:7022:6713:b0:128:d1c9:3633 with SMTP id a92af1059eb24-12a7265f60dmr5533874c88.13.1774294923678;
        Mon, 23 Mar 2026 12:42:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a296:1211:5ab0:bc95])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm18088976eec.9.2026.03.23.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:42:03 -0700 (PDT)
Date: Mon, 23 Mar 2026 12:41:59 -0700
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
Message-ID: <acGWJf1AGXT1xduM@google.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
 <20260322-remove-device-find-by-of-node-v1-4-b72eb22a1215@gmail.com>
 <360a8b4a-6507-417a-9fc1-c53b14868657@sirena.org.uk>
 <acGFksyx3SA0kJ5b@google.com>
 <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d46803e-b285-4e9c-8856-10100fa0ea85@sirena.org.uk>

On Mon, Mar 23, 2026 at 07:05:13PM +0000, Mark Brown wrote:
> On Mon, Mar 23, 2026 at 11:28:27AM -0700, Dmitry Torokhov wrote:
> > On Mon, Mar 23, 2026 at 02:00:43PM +0000, Mark Brown wrote:
> 
> > > The regulator API is very deliberately specifically using the OF APIs,
> > > not the ACPI APIs, since ACPI really doesn't want to model regulators.
> 
> > For now? We also have software nodes and maybe we come up with something
> > else in the future...
> 
> > I think we should use firmware-agnostic APIs as much as possible, and
> > only use OF- or ACPI-specific ones when there is no generic equivalent.
> > This makes the code most flexible.
> 
> I think this is a worrying idea for core code like this, we have
> specific firmware bindings for specific firmware interfaces with the
> different interfaces having very different ideas of how things should be
> modelled.  The chances that firmware agnostic code is going to do the
> right thing seem low, and encouraging the use of generic APIs that might
> happen to run OK raises the risk that we'll get firmware vendors relying
> on them and leaving us with a conceptual mishmash to sort through.
> 
> Software nodes are already a bit of a concern here TBH.

Firmware vendors can introduce incompatible DT bindings and have them in
their devices too and we have to deal with that... 

I think if this pushes closer ACPI and OF schemas for at least some
subsystems closer to each other it would not be a bad thing.

Thanks.

-- 
Dmitry
