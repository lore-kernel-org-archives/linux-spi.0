Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D03D171F
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478953; cv=none; b=kxqkfZfvFpU53lq+mNgWETczMqnl7SQ1XWuo0wwf0HzC3DOaBIMBCymPwxDzJA/Acp1xGlJWU4jcZ4E6lN3Aq+guFTrQV7A10WCdDlF/ca0ogFb3MGW8wg4tGjw/x7HK2lEfnJ5fXHMwVMdxv3hS10FDx8h02zN9N97P/iA56hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478953; c=relaxed/simple;
	bh=b0FwIuZ5pDLAhzbYxcTxm/lAPKiEu/hDBMREzsHSOvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ft1njq82C5kTU9iflqxjCSGGCRczkjaWnRxoi1X2DIa6TfUhQCqHUdJHCdEKyLK33aohGn0+JByOH0+P/42kuaYEFdqrCCdKUcXAlyy6eFLmpG+oL78Wy7PQpK+2uqHRoPkNfMAsFbl27TuFBCzFQW/8P4WO0xzk14FU8EgUNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dkz9MkDz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkz9MkDz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84229481d44so1580311b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780478950; x=1781083750; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0FwIuZ5pDLAhzbYxcTxm/lAPKiEu/hDBMREzsHSOvE=;
        b=Dkz9MkDzV8gIFNHcIMILa1pFiIoo+peVWML210SizsPzQTAyUERBvIM2xd1Wpg3wP3
         MKWe0ckiaiHD11pBDoG8PprfXkwePzJo83LqTG8dY4ewLgOv5Jqb+OprOVajNH784lim
         743YtLvWL9QCxx3zuYgO40BnByOROoMxQHlJVB8Kr94AqmzFqWxvju0W8TiX1lUEdfJe
         +3W7JM8T90xB/p5eM1UxiNSTL3+8rl+02Mhef1/wasDmfalC+aAf4SYZXXB17cr/rFVW
         06usqO/v0nbhBB2kia83S8f6y3h/6eNir8iYErEFqDI66cxxoAjYS45i1QWeo3wo7yZi
         hWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780478950; x=1781083750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0FwIuZ5pDLAhzbYxcTxm/lAPKiEu/hDBMREzsHSOvE=;
        b=DO66Wb/zGtA/Q+pSwyqYkG4J1FqKvfQEtqNb7nTX8egzwxB6f6CAy7pKiNbblp1BTk
         +AhJmHHHKb39Isid3dqQBObrSDH/0tA+RxZ0ezceJmEWB06oIHBs/vQps1UOyRcWdglL
         V+/r3ar7EGLpzOBjCD9hnriGrjobkJe1JtPowbqx2O4CROrYFyC6deSwX+JQSvrz6aQT
         QH1khQwmFu60LLfrUYy4QU8pwPqqYvGTQUEwgUHn1J+SdmCOjECgZyWbtbaCLnt6duRB
         FNTPERa89NqzezHxDyoUEYF/fqNf6QrsBFNYyhOdKR2GqOjzMw27E6nQiTD/YNkTJQAc
         Rprw==
X-Forwarded-Encrypted: i=1; AFNElJ8wo27AAUdhpuILfnnPOZON7dhD5PUApIhEue+Xvm0r3n7EYUc4qZtVElizvdJ872p97xdGaRuufKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsYu92Hn0HUvALxcVXamMhpdFCyJ/SLfY1Vc/nN1le8PVX/EIz
	uMbbvoZ50CQR0ZtFAoccbwwvIrzdE5YddThbPmUFHfSBMPWf8qh19Qoi
X-Gm-Gg: Acq92OFzx2CxRBtCAtwh1LlowAx3P9Sg5IAkNYRw3HZqlvAmYbQUJQZ3WQYFSBMvluo
	anlFfRJlI25Oc3WBeAkDrjWP/LNM13yUwO2goQMCdT9lqpaZlY0va2N0ubE4hVmPKthZmFWY7rr
	7jBUA0AF8pv39TpzzwZJa4E8xYShzeSd5zrHGkiWsGV7X5VcpSF2lQpPC7kbgnmYYjmgtX620Qc
	wORQo3zG62fmsz+7yKjfNALK62a5hPApuKyjRZbKL1nddm/IfBk1qbk85GcQcyqkE0K+EB2LEiz
	9bsi6NYQb5lc1RYhz9GkvP6J5Xp1KeMFkfNKZxNSxZrFATlANYW+hSqZOESMH1t2WtuUm+aiGwA
	/xPJMxSDsEN0PV3DfP1angmzB2J0I43Ta2cOiMuvdfubnXtEovfCxCsjw4HG0ttyxXGCLiFh+ju
	bvReWEWdlyCZBoRQUTzeli66F4p9jbhw/ZZ/MfhYlC4JBNO9p0O86KmnvbIS6phjpecjG3w+0tR
	G0ewOpP2n5IAA==
X-Received: by 2002:a05:6a00:27a1:b0:82f:38df:681c with SMTP id d2e1a72fcca58-84284e3636fmr2479696b3a.6.1780478950133;
        Wed, 03 Jun 2026 02:29:10 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288002asm2370530b3a.31.2026.06.03.02.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 02:29:09 -0700 (PDT)
Message-ID: <a9417d76-eb10-4e33-98b6-4cce7bc3e190@gmail.com>
Date: Wed, 3 Jun 2026 17:29:06 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI
 Controller
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-2-cwweng.linux@gmail.com>
 <bc0f42c0-b85c-4239-93a4-429193338f99@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <bc0f42c0-b85c-4239-93a4-429193338f99@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,

Thanks, I will fix the subject lines in the next version.

Chi-Wen Weng


Mark Brown 於 2026/6/3 下午 05:04 寫道:
> On Wed, Jun 03, 2026 at 12:35:50PM +0800, Chi-Wen Weng wrote:
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
