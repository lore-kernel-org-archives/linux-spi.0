Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B352E42589D
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199113; cv=none; b=Ls5RLo+T2IYc8rKCa5O/B/0nFVVB4fRbxU7IUbvjsmSxC1qav+7y3ZJd+vG5zzEhzHC+eVL25+Hro/bW7PXdDUEi0HX/KmYnzVUReR/OZwIW8A1DfUZ0IypfbkUMXJ4Sk0YIR8fm2oOu8h577sX9UlYlfSgGImxpRQb7YW6TT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199113; c=relaxed/simple;
	bh=5SAVxGmg7GnelrcPsgVtt3W2kFmCd8Tt9b2GZLTh4zY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q0UJX2NrWDnzaj3B+PX5dJrweuAHZisuRKm58VEIZFGFJgMHtocZ945qy2H0KklP3/mTvP1IrAKpWXqWseRreL9VvhfjDvKr3W1QXnZt/aFmOqNnq4WpSRmPwZ+YgOu2wM13kKfUGouxgUgHdrvjjiHs1N6PQfEdLADIHzaJ+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPpwm0xb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPpwm0xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31A41F00898;
	Wed, 23 Sep 2026 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790199112;
	bh=5SAVxGmg7GnelrcPsgVtt3W2kFmCd8Tt9b2GZLTh4zY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=SPpwm0xb1OFWXZbgT1XqZpP8hPRLAULNnQ8bMxSm6KAoIrb+QlMTHBH5t98nnyItY
	 7mmpjOBFsdT8laCJ9ODbhaenJ/pkU17XGxfFo8obpIhpdh8e8yeTN/WK/KAF/M8RWt
	 MxxZN4QP52uVFhJcz18fZpwHbeGeMOA1LZ6qGkLAu3M+jVxM5TC0RZRoE650xSzhjO
	 4vPsRNK9d3a+PkvxalyPnx+eAlRrQQnl7IsMGlmDAc0NCdHY5ofUGYDcCIY96NtLnQ
	 9ktlakXwjvOivb9/29XT9Fw1pyWWyYa6N/f2ZplvpqShsJzuI6Ijvq20kWL9mNihHU
	 WSbAYSkDQcpXA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 18D991980059;
	Wed, 23 Sep 2026 17:31:50 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 23 Sep 2026 17:31:50 -0400
X-ME-Sender: <xms:Q0W0aqgh93mvqMIz3Y4uAkRvcFCMlSrZJvQLJNS7bPVxk3BwqtGw6Q>
    <xme:Q0W0al0Y5YiwqMZgHtmMwm84QKmHbvGj-nO-rK_go5KYC5df5DmtZZPq6X2YcRPsp
    ETeCwEl9OTwP4CNXkEpyJX1Obt0gdOG2A3OBjnagcgh1jFZMAsG0ujt>
X-ME-Proxy-Cause: dmFkZTGpc2w2ufMjmJ0kap8IYjs9DfPrMkSQFlAOzp0sPrwE/vrB6G6LACcNgsecPhcLyl
    /g20MmAILQDVu0ZlSW7Lo9cigxl3519OTOgyM8UAyR1qlsSJMvP2OLuBuCYEy8vwV9/bNQ
    WQh7FLbGr62pkxIMcPm4sXkf+skT0hS8S8/4fyusGJg9XxMo6tfZoxf/yeVuvn1UVSKtK+
    yjpDxHjNgfv6GXN8E2hYbkrxiDycjOFqxFyHgKgVwyw2yLOS7dg0qc1A0/3PCZ0TVcW9qF
    a8vS5CuOnbW9yqpETq/JNukDtE0dez70dGFdfo8YR4EcapOfSiMdt0JJhH/CoQYunZXEkx
    4y7dbz0FO1BNf2ZSmwjaC1o72nLr4BOeYMmL5fn/EJxQkBS8ykwEjFHn3vNe6FqNtH7zih
    4Qo6NHaODC5piVE+bwEL1bQ/GGvg5rPtcRTTRPeIGoCiRmmv4LJIk6tRJVtMquknDVezHJ
    vWQbLQgtDaQvlrTFNM2YyIStqkeNju5IKd4OSczUWM7kL87z7nG7Z+zbUwMIv7rlagqy1v
    /jnU8At4jogCsmDlfPrvmrtUXUie/We54VcYHwH0jNEnOLdUNAej1KTGMPyThdfDPqpXE9
    L6tBNGaVbNgPTadl+LKcwDhKPMUp35itFGnikWAMDTXsn5WTXQrxO+n6zalA
X-ME-Proxy: <xmx:RkW0atFaMfzn3umDR1s9bs-Kk3MkgaNPoyM6LolyQEp-hCjgS5FgNA>
    <xmx:RkW0arEMcEzOzSkta4DLZ7mtyUwSqEAIzP5_zYGHmpBP5xNdZhf89Q>
    <xmx:RkW0at2M57JbrSZQWBwlJEfJ3-I2xW3WcKTqGPE7WInrBOK5vBEe-g>
    <xmx:RkW0alcf_Bhjxlov46iFTQW11wgGbri_oCK0uu0iVIKNEl4uzXKfgQ>
    <xmx:RkW0anJBbBkol_rpPInw8zj5v303xcyAaRVcunZlrAoMOBChhJT4Rxg4>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3BD3932A0087; Wed, 23 Sep 2026 17:31:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AZl98to-mMhc
Date: Wed, 23 Sep 2026 23:31:25 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Greg Ungerer" <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, "Wei Fang" <wei.fang@nxp.com>,
 "Frank Li" <frank.li@nxp.com>, "Shenwei Wang" <shenwei.wang@nxp.com>,
 imx@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 "Nicolas Pitre" <nico@fluxnic.net>, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, "Vladimir Oltean" <olteanv@gmail.com>,
 andrew+netdev@lunn.ch, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <b6135a85-1f05-4ec4-a283-60e8dbcf0437@app.fastmail.com>
In-Reply-To: <20260907134037.1855408-3-gerg@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-3-gerg@linux-m68k.org>
Subject: Re: [PATCHv3 2/3] net: smc91x: do not use readw()/writew() on ColdFire
 platforms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 7, 2026, at 15:37, Greg Ungerer wrote:
> Modify the access macros and functions used to access the smsc hardware
> registers when used on ColdFire SoC platforms so they do not use readw()
> or writew(), or derived functions like ioread16be() and iowrite16be().
>
> The current set of readX()/writeX() access methods for ColdFire have
> historically been non-standard, in that they mostly access memory
> big-endian instead of the expected little-endian. Before fixing the
> ColdFire readX() and writeX() supporting code to properly work with
> little-endian data existing driver uses need to be fixed. Convert the
> smsc driver ColdFire uses of these to use the raw access macros - which
> are well defined to be (native) big-endian on ColdFire. This change
> requires some byte swapping at time of access to retain existing correct
> behavior.
>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
