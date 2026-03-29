Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B41B155C97
	for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774812528; cv=none; b=bDNXswV7Q4h8WltQqK76hZIS1g4Y4LKSSf/GiDae36B5GCM71aB/fOGJDaBfJiLUkWmwWatZ55xEgqHB97e7HRknMWOSkHj06xyK0rdZ+yn37qYfwVsDGaLznwt/8T9y8QXzflZCQuZ203dygjlp5mVsh7/RQTnWMUTkN/bgFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774812528; c=relaxed/simple;
	bh=NjuKmT1rD2P2/214E8VWFswe48eV4wmBn9JXiJPRRWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDw05V2UBmsQ15xyfDWzpzpvlVzKUxJWDvseU2hlwtjvFLQWeANXJZO/Ib4/sxGLlWMzliar47vxlfu2aQTCOYkADC2HStKLAVj8poAsqm8aNyj5gPKPxeIvAemvKq5fq/sjH2m6cg4YjSrOP7RoIueBvTgkYlydVCGJw1Lvl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6fMH8D3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6fMH8D3"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so2772441e0c.0
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774812526; x=1775417326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cEFaoM+MCqllWgYPhLL4ay9uUe2dTNIHTT8HMRQwTjY=;
        b=g6fMH8D3vHbTeBTwWsQzqbcVQFMLmrnZaOsSivuJNEZL2wo7yvhK3SuI7hE0txMc8l
         ODEKkM+ADB2V2peNpdscI2piVQukwtPVizubEqtcODKfdHCmEmnmRrZd+oWLRXWpE4xB
         mE4V1vP+wo6/D0vhOQ1anHuxIyTJkGir8/HdopsBl1an5BJWLf0blRoOmEQxlpNT5sD6
         maNOgLlpOP2OlrEn8LPlhAwfXA261ta5PL0l9z2g96JEcs3RgyK1WUMGcgMEVTUgw4j6
         cqFzMx+c/NXn8tD+dvQltLd1nJsZQtM0LnHgJ6o030w/vGDKwHFOPzjlfTB1ErH5oh6v
         lkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774812526; x=1775417326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEFaoM+MCqllWgYPhLL4ay9uUe2dTNIHTT8HMRQwTjY=;
        b=Jji/6Zrcml+tXJ3/w3XuJ5UyQQAdY2IxbBsAcrFbgerjk0shl/f3iyLigWOJQc49rX
         4m15+MmHPM/XdTylB7vuv9LPdi9fxh3kepcz9+KYDRaEPs87N9irZAsk8bOLdl4tDV5B
         vPbQibX2Y8ICdd7h6lB40LfxUwX0TUvkI1irjF9fXBhgNonGWANEs/FCnNkROaODAZZX
         WyIGcfrMPl6zShKBpk27pOMppU2M9iQ8i+bIxFGzMI7Bw5YzeALvRLNZjGYE57jTgTPq
         fal2dZAWVBylGmonjdCgxY4z27MsRNnjFE/79pkHVFb4T1q3RgWfxB0DS4kM1VfE8c4s
         typA==
X-Forwarded-Encrypted: i=1; AJvYcCVuZJ6rto8KzyLIgXdLhk46vQ1FnVwLU7+h8A3yaBqHmeBOiTVzem2sv6XOGsXjWOS2+8Fim53EU0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFykO5HKCdR+uuhl7ZZmu7XKQUHxOZHDMN5MW5WczgOiT1yP/b
	sbCA3fPKrVqZnrRvmoHTpZBhIQcR9Jvsb+WpGsW7kXoNyGgpy1KmQ4mD
X-Gm-Gg: ATEYQzx32c9ag2Cy3roxBWJgEBCjSvRuUH3rT2CIOw3gHsxpRj8JN4GmOXTbmSVE/Oi
	12cCTeLOHf+zFhRJgKkAQ8GyHEHt/9LQFHi2dULta6X5XY/Ote6GuRgilGucWp84OnDBypk1Y7U
	Rvcdp5sBflWg/2CflMkrS2SApFHNvLbHBpNBJoRmEev9TB/XXIcIa/UsyhKP6BAQaglxH0Wm42K
	zqeMZNIepCQaUR4UZSbQs+7MFfH/N4gIbLzauAyO7XSoGPA/uK5MQhzWHMnvyyV19LRrxMyXBsA
	pa5bJAoxoDd2asV/v6aXv9htvt4qaHJuniFSf1+LuWjkCU6qBXPIIgd9bkib3Ovh8gnDSW1Q2jr
	ylcthQD3IDO1ij4bEfYtKMHi8TH9QxXBxUe6C3mGOzsJCH7UfTo9+5VyTfh/yuicuU7DCuE0nFe
	6N80qFSyMC6wX2D1V84HvQ1h9X/uhCZ64=
X-Received: by 2002:a05:6122:4887:b0:566:ec03:4683 with SMTP id 71dfb90a1353d-56d4b58c6abmr3871735e0c.2.1774812526546;
        Sun, 29 Mar 2026 12:28:46 -0700 (PDT)
Received: from localhost ([2804:30c:979:9b00:9cc3:5a7a:e884:2060])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm5855856e0c.17.2026.03.29.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 12:28:44 -0700 (PDT)
Date: Sun, 29 Mar 2026 16:29:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Couret Charles-Antoine <charles-antoine.couret@mind.be>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] spi: add SPI_MOSI_IDLE_LOW support from device
 tree
Message-ID: <acl9lhyuDdugUSSP@debian-BULLSEYE-live-builder-AMD64>
References: <20260329125725.2984756-1-charles-antoine.couret@mind.be>
 <ack2dPiLpO0uE2VE@debian-BULLSEYE-live-builder-AMD64>
 <3a9dc8f9-0588-44ee-97ba-3a248d4f65dd@mind.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a9dc8f9-0588-44ee-97ba-3a248d4f65dd@mind.be>

On 03/29, Couret Charles-Antoine wrote:
> Le 29/03/26 à 16:25, Marcelo Schmitt a écrit :
> > Hello Charles-Antoine,
> > 
> > On 03/29, charles-antoine.couret@mind.be wrote:
> > > From: Charles-Antoine Couret <charles-antoine.couret@mind.be>
> > > 
> > > This flag was introduced but was not added as device tree property which is
> > > limiting the possibility to use this flag on real devices.
> > I'm not seeing why a device tree property is needed for SPI idle modes. For
> > idling high, the configuration is requested through spi_setup(). It should
> > work in similar way for idling low. See spi-summary.rst. If believe a dt
> > property is needed despite the spi_setup() interface, can you elaborate on why?
> 
> Hi Marcelo,
> 
> You're right that for a compliant SPI device, this devicetree option is not
> really relevant and this must be in the driver itself. However, I think the
> purpose of this mode is itself not designed for compliant SPI devices.
> 
> It's not unusual to use Linux SPI subsystem for devices which are not fully
> compliant with SPI in embedded context and where both options (idle low or
> idle high) can make sense based on hardware design around the device or the
> feature that you want. So having this property in device tree is documenting
> the hardware then giving more flexibility.

I agree that having an spi-mosi-idle property in dt can make the hw description
more complete. I'm not seeing how that would provide more flexibility to device
configuration. Do the controller or anything else needs to check whether a
peripheral needs a particular MOSI idle mode before the peripheral driver probes
the device itself?

> For example we used that to communicate with TI DAC161P997 device, where
> "IDLE low" setting can be used to detect when the device is really powered
> or not. But this is an optional setting, this option does not affect the
> rest of the driver.

Can't that be done with the existing support for idle modes? E.g.
		spi->mode |= SPI_MOSI_IDLE_LOW;
		ret = spi_setup(spi);
		if (ret < 0) {
			/* No controller MOSI idle low support. */
			/* Can't verify device is powered on. Return or do something else. */
		}
		/* MOSI idle low support. Verify the device is powered on. */

> I can understand this is a corner case and you don't want to support it at
> all, I thought this can be interesting to provide it anyway. If you want to
> reject it, I understand.
> 
Not rejecting neither accepting. I just don't see benefit of having an
spi-idle-mode prop from the mentioned use case. 
