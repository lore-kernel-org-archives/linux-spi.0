Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288479;
	b=ipZ6im+ZyduPZ4jwgEj/wtnYayBa0MVP0ttRT8H2tdGgA6f79OqfH+LwiMvLiY4rPKeK
	 U6nxDGYa928aNn3SbOUatuTc31vc+pXsQnW8e2R9ft03bzEYylfl3ErlDe/uIAF627U39
	 4yPTRF6tS2oWOMmCp9cY5JmmQiS4Qxw4N/SPN+NZqacaN11OwdfFo1qWBGJT963llmEAT
	 K3zD7KDPo9kZXszCKs6Y5PGiTEG6jcPz1/eczfVdaYK3OLJBedjGL/uVeIm3q36JJ+oa+
	 m5n7//N+lGlhxUqkUxWZ0Il3UCUxsrX+s503BH6q+WS/CruMj8kpnCOU8mXvxpgcRaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288479;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=MULgIcdDa+23UjZouNXMgK61rNWvfTFsSz6rh34rJ5o=;
	b=a5LFRaAP89FT/9X933Wy8SFRgThVFAtvKTiqgBo49/9funM7BtRmFajdmLcFmuze8aVa
	 bWkGuxBT/IuCa00MqAlyLuZTPYHae+9nRweMojYLukPSPQuXvQNZ4NBr8XMEzYWGUrGEC
	 O1+CXNfTSeEySPoPlbdrLXVvjqZ1RAupCO8+sRd770+hrFfnmqXIxLsfz38AmL0rAgXJi
	 eC7q2SFbecfmcIkMkRGPeu4a/yDtEO3RDwMJHzFxzSJCc2fBR+B4PRHBPfBJfyCCSrzK9
	 7ZBjwc9YrzIu9bpejkLEkBaKwdN+aT/H4rx6sGUAnAj8qQtAuSyZ1UAiOQm0HzSG70w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIlCbh+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EB2606A321;
	Tue, 10 Nov 2026 05:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIlCbh+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4401F0089F;
	Tue, 10 Nov 2026 05:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288479;
	bh=MULgIcdDa+23UjZouNXMgK61rNWvfTFsSz6rh34rJ5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIlCbh+7m82chHKPR1qIbXi8+sJMQGUvKoISyrirsvBpGa3mKf5X7JL7gbHLqoX1J
	 wmTnbnL/nWCVRXEqcWRmN1c/1HAOEZzFqIYixmbdi6ybjs66aXLmZr2NUPcLwQ4CY3
	 l19OooSZBubyc5wq+SDXJVmKUffIueP8MQNx5xRzG9d+PJNCkIQ5MEP+A+H4pCMvIM
	 ybmTkVp6ZaNZL1jn/gJwRNcnXzx4CX6OOTeUS/wlVZ1lfjhBHlgyf1L0DG4eGqJrIe
	 6hPbBtd8tFd1mv3z8OyjPge2kb8dwUnhUTG1aDLMFw4KG2Q3KKDvF+8Xoz6Di2YbuI
	 xmRF+sGIz4EQQ==
Date: Tue, 10 Nov 2026 13:07:47 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH 5/5] spi: cadence-xspi: Add workaround for old Marvell
 firmwares
Message-ID: <avKmo_zDj3DoUrJo@xhacker>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
 <20261104100643.162694-6-paul.cercueil@bootlin.com>
 <au8lyXiMUSvcdPWx@xhacker>
 <0260a1943c59cdda431bb216438d49c3955d93b0.camel@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0260a1943c59cdda431bb216438d49c3955d93b0.camel@bootlin.com>

On Mon, Nov 09, 2026 at 05:34:55PM +0100, Paul Cercueil wrote:
> Hi Mark,
> 
> Le samedi 07 novembre 2026 à 21:21 +0800, Jisheng Zhang a écrit :
> > On Wed, Nov 04, 2026 at 11:06:43AM +0100, Paul Cercueil wrote:
> > > From: Tanmay Jagdale <tanmay@marvell.com>
> > > 
> > > Older firmwares from Marvell used the cdns,xspi-nor compatible string
> > > for the Marvell-specific xSPI IP, which is incompatible.
> > > 
> > > Add a workaround to support this by assuming that if the "xfer" resource
> > > is found, it means that a Marvell IP is used.
> > > S> 
> > > Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> > > Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
> > > Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
> > > ---
> > >  drivers/spi/spi-cadence-xspi.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
> > > index 48a109f3fcdb..d326589a6ca3 100644
> > > --- a/drivers/spi/spi-cadence-xspi.c
> > > +++ b/drivers/spi/spi-cadence-xspi.c
> > > @@ -1301,11 +1301,21 @@ static int cdns_xspi_probe(struct platform_device
> > > *pdev)
> > >  	}
> > >  
> > >  #ifdef CONFIG_64BIT
> > > -	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
> > > -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > "xfer");
> > > -		if (!res)
> > > -			res = platform_get_resource(pdev, IORESOURCE_MEM,
> > > 3);
> > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
> > > +	if (!res)
> > > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
> > 
> > This moves the mrvl specific code to all users, so I believe this
> > needs dt-binding update.
> 
> I actually disagree here. The binding says that "xfer" is only provided with

It's not only "xfer". The code falls back to 4th MEM resoure when "xfer"
failed.

> Marvell-specific compatible strings, and that's correct. The fact that some
> firmwares don't respect this spec is not a problem of the spec itself.
> 
> > From another side, this assumes other users doesn't have 4th resource
> > but what about if they have? they will get "Marvell-specific xfer
> > resource passed, but ..." warning below, this confuse the users.
> > I don't think this workaround can be added to all users.
> 
> Yes, I thought about that and I can understand that you don't like it...
> 
> I originally thought that it was fine because the dt-binding states that the 4th
> resource is only for Marvell compatibles; but the binding can change, so it's a
> bit wobbly.
> 
> I will come up with a better mechanism in the v2.
> 
> > Lastly, does the "firmware" mean dtb? But per my grep, I didn't
> > find any mrvl dts(i) uses "cdns,xspi-nor" compatible string, so
> > this means the dtb is outside upstream, then can the firmware
> > be fixed instead?
> 
> It is dtb and also ACPI. The firmware can and will be fixed, the idea here is to
> make sure that the driver still works on older firmwares that haven't been
> updated yet, because they are out there.

If firmware is dtb, the dtb is out of tree, why mainline driver needs to
workaroud its bug?
If firmwre is acpi, the commit msg says "used the cdns,xspi-nor
compatible string", I'm not sure how does ACPI use dt compatbile string? 
