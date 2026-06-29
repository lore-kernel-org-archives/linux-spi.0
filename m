Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2214035A393
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729175; cv=none; b=RpdIcYcpcUXqrxXGuwhjvfCnsZTsXQG81U3TQEPUhrTHazpvS8VfvVRN6AoqxewE94ZBqlYYDt7fUmCaUn95V+oA/Bz9RSoSJFffTalkiohVnyLP0zM5+lFPNoHpImIqKREBWHTk6Lhy+fOuMRAgOuxcwtYdHLiVbSc3LUTHiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729175; c=relaxed/simple;
	bh=GAVPGmMNqMrJOmIH4YyvjVq5OzbZxpEO5nPWtCNJWMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTOZ1ygLDwO43z3fhTL/SpizEVfP+8K1a74vu3SMeZHQUSqSGdGSl0FXVN1lXg9Hb86diOUnp4XIzHQpwx4+mBcG9SbslxQc+ZaFgBMVLFjTUiR863sbg2rp0LyzzgnMutEfL13nuWjx5SzQh4n0xc6LruveCCNSE8/1EpBCiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iZBxETln; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iZBxETln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=GAVP
	GmMNqMrJOmIH4YyvjVq5OzbZxpEO5nPWtCNJWMQ=; b=iZBxETln74865akYcKUM
	uabt6k+6PCBb3v+VuIk307KJ4a4uPMYywdn/6637ik2h58L8lkMrTLSADy3O6oHc
	cPGTozlgkdIaS/UQ6GmorywUhQhh7pk3GWNmFeEaTyWZ1MLFZiH+hOskx7UeWgqf
	SvaIUPRG99mpoMqirXWAhvVb0NTn9W/MXa+/tNZz+qG8moWYOSPlL55Ymknid0Eg
	CcFwHm9jHICT4/Kdf4b4EKdeX3zeeIggCUHrtZwZnmewewZjZGPPyjfmQnXL59se
	jR4bm008PDa+GLtjYYqrzxp/cQra9TDChXpp/6KSDkGK/+B4gCv6EHetc90B/ku5
	xA==
Received: (qmail 339816 invoked from network); 29 Jun 2026 12:32:52 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2026 12:32:52 +0200
X-UD-Smtp-Session: l3s3148p1@ovYF+2FVpqwujntC
Date: Mon, 29 Jun 2026 12:32:51 +0200
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Felix Gu <ustc.gu@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: rzv2h-rspi: Fix DMA transfer error handling for
 signal interruption
Message-ID: <akJJ09zjt_dXp1jS@ninjato>
References: <20260627-rspi-v1-1-170c93ee14da@gmail.com>
 <aj6sEE5y62SOVsRb@ninjato>
 <TYRPR01MB156197735CBABA1699843B9B085E82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYRPR01MB156197735CBABA1699843B9B085E82@TYRPR01MB15619.jpnprd01.prod.outlook.com>


> I also think the patch is correct and should be accepted for now.

To bring a broken state into a less but still broken state? I don't
agree.

