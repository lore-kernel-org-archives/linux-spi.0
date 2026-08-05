Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE519D065;
	Wed,  5 Aug 2026 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890562; cv=none; b=Qq/6i7cOSpYcu6oYUqwUDk5jnbaixMT8octsd0D6QDla3b+OMwxrFihhH+gFhGshnOCZ1mujf5kvb6CEb8ZcXOZIjKZG0FKpu6XUIlOQIJvZZfvz8pB0Rmx9KPxZelIh8I3jcWu8wnvTWsDyJvaCqxXaYKYf1NomOau6NDxA7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890562; c=relaxed/simple;
	bh=oF+pMqKRVfoHbj0aKmhSJyXoon4yiMyJ+CZtPLw2efU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pbm7l9Nz+iX/cUwXhFa9SEkUPoHbct9keG9fMC2A8SWkjk8W0OhdcRkMJ9yNGydWHyoczry3DK4kS5DMwJr90B5SN06hf90ETSq9ctBNyX/o6YSjWtUM37T/Jc21ou1nempvph1nQohsMuFCov+nd3SMcsLp5dOL9SVJ5dgyTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=c51MoOa0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="c51MoOa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785890557;
	bh=oF+pMqKRVfoHbj0aKmhSJyXoon4yiMyJ+CZtPLw2efU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c51MoOa0qnaW3TduSdx06EE6rJuShhuxXVETYm2f1U2ukoI0+XhZOrLuGUJ8nphU3
	 97nskKjuXTQHfWVza+H5DxU68zAYrb+h5sRgO5vYvhIfDCguZV3bM3EDAnsa7AmzZw
	 mck/Me0g6012NuTdXFokiaJWE/3vwGMLaMRuODe9MNIJisqZzoxFCGd9Q32IYr7vJy
	 jzjBHZq5lZyRyKTJFNFemv2H1nopyQjavdGlsiKfXOVbB7GKx6eRt4d80VeUn+HxuM
	 7QRJQ1NvLnsm24lO1B71uU+7UXX/a8EOJ+qTUVWqEr6Gvgcz0B/+N5csdmLqtIjU2a
	 l6lhOZ6hkoLLg==
Received: from [192.168.68.117] (unknown [180.150.113.112])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DAD4166B55;
	Wed,  5 Aug 2026 08:42:35 +0800 (AWST)
Message-ID: <83210c6e2a7b203bd5913b455ea45cfddf3d29ec.camel@codeconstruct.com.au>
Subject: Re: [RFC PATCH 0/4] espi: introduce eSPI bus framework
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Greg KH <gregkh@linuxfoundation.org>, Krishnamoorthi M
	 <krishnamoorthi.m@amd.com>, aspeedyh <yh_chung@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-spi@vger.kernel.org, 	akshata.mukundshetty@amd.com,
 bleung@chromium.org, groeck@chromium.org, 	chrome-platform@lists.linux.dev,
 corbet@lwn.net, linux-doc@vger.kernel.org, 	skhan@linuxfoundation.org,
 linux-aspeed@lists.ozlabs.org, 	openbmc@lists.ozlabs.org
Date: Wed, 05 Aug 2026 10:12:34 +0930
In-Reply-To: <2026080416-lagoon-delirium-8e84@gregkh>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
	 <2026080416-lagoon-delirium-8e84@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg, Krishnamoorthi,

YH Chung has been working on eSPI support for ASPEED's BMC SoCs, so
I've included them in the To line.

On Tue, 2026-08-04 at 14:18 +0200, Greg KH wrote:
> On Tue, Aug 04, 2026 at 05:22:55PM +0530, Krishnamoorthi M wrote:
> > Feedback Requested
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > =C2=A0 1. We chose a dedicated bus_type for the reasons described above
> > =C2=A0=C2=A0=C2=A0=C2=A0 (capability negotiation, four independent chan=
nels, asynchronous
> > =C2=A0=C2=A0=C2=A0=C2=A0 ALERT#). Does the community agree this is the =
right direction, or
> > =C2=A0=C2=A0=C2=A0=C2=A0 is there a strong preference to extend the SPI=
 subsystem instead?
>=20
> That's up to the SPI maintainers and developers...

There's concurrent discussion from YH regarding device-side eSPI
support in the thread ending here:

https://lore.kernel.org/all/KL1PR0601MB4276FA2C6347192CC45826E490ED2@KL1PR0=
601MB4276.apcprd06.prod.outlook.com/

So far it's arrived at a matching proposal for drivers/espi.

>=20
> > =C2=A0 3. Any concerns with the ops table design or the -EOPNOTSUPP fal=
lback?
> > =C2=A0 4. Naming and structure of the public API in include/linux/espi/=
espi.h.
>=20
> What specifically are you asking for for this?=C2=A0 Do you have userspac=
e
> code you want to integrate, if so, does it work with this?=C2=A0 And wher=
e
> does it live?

I've seen your follow-up realisation Greg, however, regarding
userspace, the thread above suggests that we should be able to back
existing subsystems (GPIO for VW, MCTP for OOB, MTD for some flash
functionality) onto eSPI to minimise eSPI-specific interfaces:

https://lore.kernel.org/all/KL1PR0601MB4276B5BE3B96C18E3A66AD709049A@KL1PR0=
601MB4276.apcprd06.prod.outlook.com/

That doesn't cover the peripheral channel, as that's dealt with in
hardware on the device side, but for the purpose of the controller the
devices on the peripheral channel should all be driven by the kernel
anyway.

Andrew
