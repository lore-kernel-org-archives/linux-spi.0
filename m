Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A841D11F
	for <linux-spi@vger.kernel.org>; Thu,  1 Oct 2026 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837661; cv=none; b=InIRt7j6D3QDuObEwP1P8VAwl0edfA2eHuMh0JRKYTX/Wgn2Abe9L8s+b9f4FuRJzojy2q+cvgHrjIAlcyT1SaIe+d/TPD8LzB+8LDILIa4UOEo3q8F6dstQjB1nS7XTSHT1mvCizb8+6Hd6MwQCMLqk8bVPjVTGo7LGlFuDiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837661; c=relaxed/simple;
	bh=OQGFboAIgaxsHZXP29Wd9s2vQCVrfmH798k2j+zX9Gs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNcAxXhS3QOQVa+soYkM2F2UJtqzDhcEFf4H8bQrUT+olm8aEqzDUwW1+4TbPmZKcf6h0fVTK948o18AscQflHl6CCyoRjQo6r/BVFISXagZyBYbV+z4eB1JLmCIuBC9g49y9OuB6OpoIssqIJvm99DtkkM3svOO9+wUY5jMfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxtEQIrP; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxtEQIrP"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b08452cafso373894f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 23:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790837658; x=1791442458; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dQM3nzcaHIpaT+Z8HPZx7VZW+Ub3Nz7sGdgKg0hJno4=;
        b=HxtEQIrPevPbWFEGyq415CdLzCbBgdicvRTVqcjxdTmACiTBZFSvXiehx8qwTGcEME
         wdw1RWJA1tfBWOTEn5lIpqr/McFl2pTIH1mUb996L4mDsvol2XmBsOjnz1Qm7mEfnRkS
         V+hsScH9cWAWNS2/ISRy/jse4foUpTnsvFYSt0CChnnx19KiOKvdYmm3gYh2JtZ1xWaZ
         ICXe2LIESM5oHhnblNqp3a5ulURqW+HU7GiHYaOZ87ItXLqk6rAbneIdw2ZgCYsUbAQs
         tAN8nkJOSyNkic9oT7TXgHdb/VjVPmM6n1MFPXnKMuXeKSnPTu8a+0hoIjjq8WmMnk94
         khRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837658; x=1791442458;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dQM3nzcaHIpaT+Z8HPZx7VZW+Ub3Nz7sGdgKg0hJno4=;
        b=rMMhkwKl98KOwRb79FSnpfXGZhjGk2yPZMmMIx75QM4I58ZtnaruXg3lbI+Ko8ZyTG
         rDCnrluiFMzhBVvpeNTgA2091dqfat3mDyM+siSOQliXR5s8fViAxpQZALtF2YdBHraE
         SVRAPjiHtKYg15AIT+KeZ76hAnW85Boar9gy/sM0D1tuGap1WXLhXjOS/KEG0/PNZO8T
         hG/qhDH6INYDndwYtDsm1nmgbX3G8e4F2eANnFnzaSr/SmykLrIKZhe1cOcfVL/wTAEk
         23IZPEeHcWe+BjcyaNCaoxPhR1nwdY+3uNWvrQxTx+YShIuddP07u/CKsKL/EAjkaENV
         SnWg==
X-Forwarded-Encrypted: i=1; AKwUvBy1Mgvo836YvSBOykVm6lokbkXhhBvJB5eQEb5WEstJPkZuWag9MY0QTWSVnz1HLVK7TenrWu/Y3gQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTqujqtcVEB0SRuQ2i7+FNBss/VwXZKVDvRseFUV4chbPXkeDK
	EvrLtzkPA1hvCm6wNjvO0U4A+hGuSLNzChcPqIGItyCCZgph3vVimZiexU42yA==
X-Gm-Gg: AYBFou3akRxs2gNYL/ff+qJIrWY/W5HvTECWuO5O7bnUIo3CLgP/NpHjsPhhvSS5Ntv
	O0eAZmUqiyWGOYXaVti5oZj3lRBSikV13DpSF+bguwhoJeq5zfm9BzccoS0tTWvUHzBGzmvQ10v
	EQpfxR80Xl2zZ2egxNjw5JWQtZCdFNF7Lwg7ql5Qo2Y5EagQK3s2UjCBiKxroC6nXZ7MvB349JF
	DkISL9ax7TIy/NdcK9rs4GRAKJAYEtzu5TtxwWVl9mUzjDDyMHJ2G73XQSNs0kp/Vk7GNw+OjWg
	ROl8AhcUb1V9eb5n6tcWNzqbNTXF6taNkmAFe+Q0Wvh94f5aAyu7M0x2Y31X1E7WIKnrns4CGgt
	ESq68A8nXHmY9KDmPDLGCAkj+cU33YhuO5A0/A23OuiSZGODQdjYyCBZumosLx9G6JNZsD+X5wI
	PQfr6Ywnss6dlGK/IvGzH40dVZpx39A6pL/q36Pm5xAtvwUbvsMyKHwONCcpL22ihvj83E9JEQg
	2FfMi8TxEXpzauMDHil9F+1XeK5f6Dd21anCOBAcBfIzhtv+MSwSQM9ny+xJ35O/BOT315s00Nz
	sqB4RA==
X-Received: by 2002:a5d:5e0f:0:b0:486:e9ab:2b88 with SMTP id ffacd0b85a97d-48b02a9f53bmr3865955f8f.24.1790837657921;
        Wed, 30 Sep 2026 23:54:17 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b068bc944sm4283186f8f.3.2026.09.30.23.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:54:17 -0700 (PDT)
Message-ID: <a1fb38b1aef69d344d31235fbb4bb55d75aaa1d4.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] spi: axi-spi-engine: fix stale SYNC IRQ pending
 in trigger_enable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Santos
	 <Jonathan.Santos@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	jonath4nns@gmail.com, andriy.shevchenko@intel.com
Date: Thu, 01 Oct 2026 07:55:45 +0100
In-Reply-To: <8ba05b99-36ac-4a76-ac11-e6ad92c631d4@sirena.org.uk>
References: <cover.1790731588.git.Jonathan.Santos@analog.com>
	 <b1573f16b8e30f22877677026bc2296420a0c527.1790731588.git.Jonathan.Santos@analog.com>
	 <8ba05b99-36ac-4a76-ac11-e6ad92c631d4@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-30 at 14:09 +0100, Mark Brown wrote:
> On Tue, Sep 29, 2026 at 11:17:45PM -0300, Jonathan Santos wrote:
> > spi_engine_trigger_enable() sends SYNC(1) and polls SYNC_ID, it never
> > clears the INT_PENDING[SYNC] bit afterward. This leaves a stale pending
> > interrupt that can fire spuriously when INT_SYNC is later enabled.
>=20
> > +
> > +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ i=
s
> > later enabled */
> > +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base +
> > SPI_ENGINE_REG_INT_PENDING);
> > +
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
>=20
> I'm not seeing anything here for the issue with ensuring posted writes
> are completed before we drop the lock?=C2=A0 The write may not be visible=
 on
> enother CPU, we need a read from the controller or something.

Just for my understanding, why would it be an issue? The trigger register s=
eems to
only be accessible from the trigger callbacks which are protected by a lock=
 where we
have implied barriers. Im sure I'm missing what can go wrong here :)

- Nuno S=C3=A1
