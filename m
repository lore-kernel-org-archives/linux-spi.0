Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A530C63A
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296349; cv=none; b=oldvu/zOwt7Wbv8VwERUpYkLfvhr9qoV9xhCKaJOx6F4kLGOApmdePvLgJmSbwlv2Zk/fhqkYAXT/7RR1LnGmBBXy+GaqEouMjNzTfNR8vDPl9XkrJ/6fy7oEjuJ218x/hvXH0K9Z3cXsNu84ZfjNxKraQsQP9oNC4zuR55W0jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296349; c=relaxed/simple;
	bh=YNdudccxgF0GNeZMVRI+WGS9EJ7qAu7VHHOEJlJmZlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fubN2lzvxlEBYjFTmoIvbWmx005TI3flnQwdtkjgoz21HVd6S3C23ZPOe5zb9NRXSUY57AsQ/ZVVc1T3PUvkk1JdIn3/jtRTnIv+hvJGnVd8LgQ/gfQnZysrYm/3k/98nOxc+AzQn1LbJDY5mMp8flMvxYwANMGdVoIHXTn6j24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHCTH/ci; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHCTH/ci"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f45e20cdso46087675e9.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296346; x=1784901146; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aL2gd+WxGuY6Bl16wWSEIS9/aMLXAhdRbeLUUN3ab9g=;
        b=UHCTH/cicWaaigvH5YGRT1CK7H/et6c/VQGalUXh9iJVTrNl+t8YMOcDpkaLy9RhjH
         G94yF2PHO1ZTDEzqTD//sXtQglgiWGCN3/yBClXm/gDBCVhOoS+agY4dnfGvyLZKz/YJ
         JYdDzJ9HIJDjAgWykhIfqbbt5FR6/WbapDO/tGmf66U68VNdC8Xnw9PFac69yg++gXOy
         +P57ytzFhNE/YP9jP21a4R0q5M731q2eublSMJa52qIYT1zc85+WR959IGHGiVmK7WP4
         7KKrDmUWVkZ5wRgm6yLyvlES0deodwpjayUVNqqaXS10VM1i845RBJDwAN2o7iNpkte8
         tgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296346; x=1784901146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aL2gd+WxGuY6Bl16wWSEIS9/aMLXAhdRbeLUUN3ab9g=;
        b=nDk3U6+28tCvMFa3CIRfOzXEIUGKwD5FABzn+lTTBeHv8gS1nWnFtNlP026J6DBKiI
         HFAC1d3hPW9r1LrONd6YjkKrrY2E6aSmWxiXr4ePz13NtEZPqm33+memZOeqaTHQjhcq
         91S5gaqxmb1a2ocj6NeLYNJN/BLZVU8v0npAdEwfq9/Uji938bNIdzjdKS93k+Qt336q
         If5NK4du6VMP5ALq1moQ3WSuexH175U2Lj4T4UhzLeAiR8QD0NKLswOE2YNXWr3kKzUr
         WFliiAG3tO7NmMFikT/8cCshwFo2+po/4D9MSj7ZdKi7BFRTq0ddxsDWxoywoBndAUz1
         Vncg==
X-Forwarded-Encrypted: i=1; AHgh+RrqXq3Qk6zBQWJdn0mqG3Au01Ff2I0la0krIbNvpKUJKubpn/n6kaTuyElUDluigShSlP182OdmR2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWaIlWh4j3Ax8C29OZx/4gFIUQg6o01VDpRIbhMhfKdg77Ol1S
	g8CIZ1ZO7+fhaMwpz5766duqOUgD0xUdB1KLZsKyv4gSohG98HU/pouC
X-Gm-Gg: AfdE7ckkLItrIhvCDnMW5J9fCisRqba9p9lL8XnwjX8APp6JlBsMrsxGBeOPPKgef0z
	UJt6NRQGJh8d0z6mLoE9dpV07Yj6+hLL/fLaqoR1VjXiR0qdOBNYPnebpRiH0qKGjXIayt5SNqv
	ivyKL554mDCMaSngcMj/GNMcPfR+0N52KxEU6sky26sTASopqpNUkrVd2Z31ch3XvuFO9/9+b6U
	sHNSw8HX+CwXaoxsvzjfin1YH4Um7XrLRdd9RXGGUSfxHVO0MwbNhJ6iiMwVyr7B82AOc3BPVH1
	bNu9s45tOEpXtz5T5A4H4WJn2qRtTF8qti1wgSg0G64et4i2Zi23luh7jW6yklSuXNC8UPziTy1
	hJqN/VVK/XFKw2HyAqguV+2+AbqinLEGet/Zmm3Xab1ge12Umg8JuePPCJj9n9CaTfT1MT+gqUM
	zaDA/qZnfDWJU6hJgyUxhEbLj1Z6U=
X-Received: by 2002:a05:600c:304a:b0:493:af56:8e64 with SMTP id 5b1f17b1804b1-4954a40ff61mr24483915e9.32.1784296345884;
        Fri, 17 Jul 2026 06:52:25 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52673sm4424709f8f.15.2026.07.17.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:52:25 -0700 (PDT)
Date: Fri, 17 Jul 2026 15:52:01 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, 
	Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Marius Cristea <marius.cristea@microchip.com>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <zeooo2jqsp7rkovhdxtra6qjlzjsppyppe3nqojrskcv2sc2x3@2npaf56m66p7>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
 <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
 <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
 <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>
 <20260716-stole-copious-7cdaacb6cef6@spud>
 <27746e91-ab2b-40a0-822b-6d3a8997cefc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27746e91-ab2b-40a0-822b-6d3a8997cefc@sirena.org.uk>

On Fri, Jul 17, 2026 at 12:51:53PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2026 at 06:06:13PM +0100, Conor Dooley wrote:
> > On Thu, Jul 16, 2026 at 01:28:15PM +0100, Mark Brown wrote:
> 
> > > Oh, isn't that just multi-pin chip selects then:
> 
> > >    https://patch.msgid.link/cover.1783729282.git.Jonathan.Santos@analog.com
> 
> > No, I think that's something different.
> 
> > In this case, there is one chip select that all instances of the device
> > share. Both the ADI and Microchip devices then use the upper bits of the
> > first/address byte during reads and write to access individual devices.
> > In the microchip case that I'm familiar with, what upper bits the device
> > responds to are set by fuses in the factory. They also share the same MOSI
> > and MISO.
> 
> I'm struggling to identify a way in which this is functionally different
> to a multi-pin chip select.
> 
> > The SPI core already supports two of these devices from Microchip, since
> > it just modifies the contents of tx_buf in a spi_transfer.
> 
> When I said we'd have to modify the bitstream I was told that wasn't the
> case and this was just asserting more pins along with the "chip select".

Oh sorry,

Likely I was not clear. The part as some ID pins which are just
configuration! So they are two pins and depending on how they are set
(low/high) each chip can have four possible addresses! Now all of the chips
(to a max of 4) are connected to same CS of the controller so just one CS get's
asserted.

Of course the above will assert on all devices on that same CS but only
the one where the ID pins combo match the spi xfer high bits (part of
the address) will reply.

Hopefully the above makes it clear.

- Nuno Sá
