Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073E43F8C7
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111012; cv=none; b=A+lTvKEg9McfDzXX6HkCQj1SI2tGKKN08Vjpc1F0xaoSW8NyzKINs+mxzPGgH6KzE+GFNokWzvxTsECViyoZfjZ2jYvuC7nvy6IN97wW4ZqH9vynL1T4FSrBZL2mMnRdtg/59UumUQPEt5g6Nu4oQ3VY5Y/59JiUfJoy0NC3rSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111012; c=relaxed/simple;
	bh=tVx28F6hzoOhbxDz4C05Ygp3dFA76JoEKAIrhVmFN28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4IRFPIHGmYVb537P6EkEAhaDQ+V49EOd3gBbHQmKRMOG64K3C0CUv89vW0MWsR49EVi7NxIdV6cANHSl5CzsKp4Z00ymzSgw9rd/tDKnlWaBsSmx8aWW3vMARSgfERFlb9Rr8tX9kOhkotw8v9BIiHjhdBK8Qf+NxQIijLWKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGUwnrCj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGUwnrCj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2419939f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784111009; x=1784715809; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B70rc+Igx6pk+vBVTwVmpa02tU3sIWbZStONfDPUzW8=;
        b=YGUwnrCj0h/G7LQSkiFui/M0qee6CZO5BYwO3yMnB8CyV2vWn9DEFohxQ0ejrXiM4L
         zLclqf1ZGyHawpgQUJyzXsJeNRiM6nKgkb9H9wkrSHNT+loeZNqAwayNeXdGvFSC9bnM
         pvzecG1xkGQj4gt4gkP/dY+naxr9mDGcPGmf4W84alL+9hU5ek52MkZWg/JjT4slg0u6
         AOxTxvcp/vZUHanU1pfNajzfZ/37SL4bDq9mF35k7kQU26OvLI8kWNE2ZybnKuXwixUW
         SfmcmGvf9yE0OqtALtc/mKT/I8xpch5SB78i9cWP+7qdCtS5NRjWxT2QM3QebNP9OrcI
         FYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784111009; x=1784715809;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B70rc+Igx6pk+vBVTwVmpa02tU3sIWbZStONfDPUzW8=;
        b=kug1rCCBF3EGdKxfNmXI5PEb/C73pDv8pNR3s5OzYa0ij9CIJyrRWaufUzIGZoaMgU
         qFvr1Cj6xczI3GlzmDDJKsFz1LtqipjCF9KJE069rw0HDiwz7Eop7Z6IJl1VHqtvkQHB
         vstxh03+681kJKf5DjSC/sCqRAI0Bd4WwwLrHuZ4zGAFvJRgNwlMTOEf1uJuiD7Fyozq
         xbKNRhdPRiT+/G6gUpgzCokxitrveik+zi5UaJrfu7/yhos/YEO9oKmZtO/XKpF4ai6+
         7s+R3jybJZrWV+IKad5yTLgF49ZTFYpbEvHqXjbwUvF7mQ1NIPi03hW3mnJmtiNC8YLK
         Nm0A==
X-Forwarded-Encrypted: i=1; AHgh+RqZFLAyD7fpO9lN2USJi5lRB+Hzi7rBYgjbsn2OATOz31G6cZlSxkrIezos6C04SjDKkcsHGK5F8Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQK/DvTFFUD68ohABhqmagFcuoPScmvFAQt3SAkTRQmnUV3uB8
	ODexfxbpfiVmAJ4LiN9P63GREZQI9JaO0a2SHjVvWy2CRU84m8V6X6j7CNYb0gHiDU0=
X-Gm-Gg: AfdE7cn2KFLSuEzu1vU7xBatsgTyGrYRqLV6dBXKb6Nufl2qtDiK0tXo21LklpOSLC+
	ksTb8PuL629c1Dgg5eZ1DpdMwnTl2H2Uq+xCFsmKb0v6JLtELUQmiL99RXOxwBMP4ZKkVfErS/D
	m0EZTkyVh20BvbgkWi858C2uauKkT/kHZtPxgE/hiTB7dvJK+7DY63W2YKUckXsu95qseM+biSl
	DuFELMM8Rb1UCN317thdB8x0jIrHx1a0PdvcmaHKt9C0giUw5OKHOLK9WvY6guZPfoIuqwCvK9U
	rmhMUXqD4peac8GsoT8sFyccJgZ+YT0DH7xR/eR/m921M9SCCtAOZH/gmBc6WKy6fSbltA6kLFD
	THnptH3OvQZplPes7LjXBlLnal0fl+UW4oJzQJqtsKJ5fOEFaskayNAs5n1bFCF58mjMZcQZaKm
	z5QjckBJ9mtaIZfEXhyEfIgSo7e98=
X-Received: by 2002:a05:6000:178e:b0:47d:ee23:f15e with SMTP id ffacd0b85a97d-47f4fc99a5amr2601165f8f.5.1784111008723;
        Wed, 15 Jul 2026 03:23:28 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f47688f29sm13278106f8f.21.2026.07.15.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:23:28 -0700 (PDT)
Date: Wed, 15 Jul 2026 12:23:25 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com, 
	marcelo.schmitt1@gmail.com, andy@kernel.org
Subject: Re: [PATCH 5/6] spi: add rx and tx lane mask to spi_transfer struct
Message-ID: <xck7dmzeyhhfnn6nhp3cgikginpotsslpofabmezor7lwqbt2l@ztqhwysdcjxe>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
 <234f8ff8-ae3a-4563-93cf-49989f29a642@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <234f8ff8-ae3a-4563-93cf-49989f29a642@baylibre.com>

On Tue, Jul 14, 2026 at 10:18:37AM -0500, David Lechner wrote:
> On 7/14/26 12:56 AM, Jonathan Santos wrote:
> > In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
> > available lanes, but some use cases require operating over a subset of
> > lanes per transfer.
> > 
> > Enable dynamic lane selection for tx and rx by adding new fields to the
> > spi_transfer struct. Controllers that support multi-lane selection must
> > parse the transfer struct to update the rx and tx mask lane-wise.
> > 
> > Peripherals need to set values to the new fields only if multi_lane_mode
> > is set to SPI_MULTI_LANE_MODE_STRIPE and they need to enable at least one
> > lane, not necessary for enabling all lanes.
> 
> As I mentioned in my response to the cover letter, I would hope that we can
> avoid adding this. The idea behind the mutli-lane support when I added it
> was to have a higher-level API so that peripheral drivers don't have to
> figure out which lanes to set when.
> 
> So if the alternate solution I proposed doesn't work, I would like to
> know more about the specific use case before accepting this.

I already acked this one but if we can agree (and from your diagram it
seems we can) on the relation between data lanes and CS lines, I think
what you proposed makes more sense and keeps things much easier and high
level for peripherals. But just my 2 cents, Jonathan has the system
knowledge and usecases so he can better reason about this.

- Nuno Sá

> 
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  include/linux/spi/spi.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index a9988db3fe2f..f4473d53b6b5 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -986,6 +986,12 @@ struct spi_res {
> >   *      (SPI_NBITS_SINGLE) is used.
> >   * @multi_lane_mode: How to serialize data on multiple lanes. One of the
> >   *      SPI_MULTI_LANE_MODE_* values.
> > + * @rx_lane_mask: Bitmask of lanes to use for receive in
> > + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> > + *      lane. If 0 all available lanes are used.
> > + * @tx_lane_mask: Bitmask of lanes to use for transmit in
> > + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> > + *      lane. If 0 all available lanes are used.
> >   * @len: size of rx and tx buffers (in bytes)
> >   * @speed_hz: Select a speed other than the device default for this
> >   *      transfer. If 0 the default (from @spi_device) is used.
> > @@ -1131,6 +1137,8 @@ struct spi_transfer {
> >  #define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
> >  #define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
> >  	unsigned	multi_lane_mode: 2;
> > +	unsigned	rx_lane_mask: 8;
> > +	unsigned	tx_lane_mask: 8;
> 
> Just make it u8 instead of using bitfield.
> 
> >  
> >  	unsigned	timestamped:1;
> >  	bool		dtr_mode;
> 
