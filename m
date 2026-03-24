Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579A401493
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364183; cv=none; b=MMNFbRNY2JOM350qcTZV74ASxRNDYfO4U73VWobOa5iv1h65qKNcRmBYjvjtwzKAymLobq5dGZBCjWlvhmiTGC4Urgv8uUM1gknT0G0Nxf/YchAmrGY96waIx4dlm7o50SvAUmCgL623DZF7ajeHzQbF/KyJ16Ij5Bfukbxh/80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364183; c=relaxed/simple;
	bh=Bwrq0gb8/yR+srwxT1tUhL+MbcNcm8n+1HAzCx3FxPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kssqd2zEV9LuZn2wUMjd9POfmonUaoY4NCsLxht//f+ls6FqZF3wx998JzLjFzklSsYyq/Zo40N9FeWe4LYrlwOnrK4CwsAgj2+D0jsrk3sSgoh6HWXYh1SQQz7/JuhHmlqZ7Szop2+uHoV71SSeFYSl9M1j9I3UEjasjqgD/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWdHLgA7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWdHLgA7"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adff872068so18751145ad.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364182; x=1774968982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HHibtnmiK9oJAgymjSpcI+L0uHNFarSU3Q1Wq/KbvI=;
        b=kWdHLgA7ucW1sBw3Y+na3Vpr+qGlBrQdEjItitJJSJgs5oU6Kal5n9EMxyiUKS0rSG
         bCs1ONyNUdaUuKjpfepX3njbctpy28BmqSGOgs7mmZILijmHQMas1Pazc9rd4pSW3O3S
         5599SXpjcbDNf1QxsheaUHF+W6il+xybtTJN06gOuwEzgwbODEer9VL0uGueXyr02Loc
         OVyVgbj1Tz4I69wsduoWcwOnG3YU7E+fiTEVVpqdcWYMXIcCMkoVXS6oAyuHTMBSuuEf
         BEuyKhZX005cPE/2QGhbgDSeKXwsLGzPRfT32a69f1g+mRt5RsSPXj7mLh8RKG6zbc6g
         dlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364182; x=1774968982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8HHibtnmiK9oJAgymjSpcI+L0uHNFarSU3Q1Wq/KbvI=;
        b=YE9LwrH9NmgRweD1zbiUQmi9ZSFbr8F23mrjzXOh2ddtj9eQx5OHIZ6CCa3Rchg3Z9
         gON+iOo3p4LkbRn2BuOFzPhLSI2QmJ6hsfRlPKBEAYs/01OhltYTiGL5Lc4I6AI2COzA
         fMIWsyflM9aQ3G2c11Qy55Z/qo6JTExwGFgUolhBVZJhMnD68w4p18OKxnY9rtfc0gbX
         mzG9XnvxD6BnDuzGyVQUyHbiPmbhUQzqdfbJpeshGdX9MUGBcdu0/L+4H/vkFii3VcVU
         ZreVZpdltuzEYTeR/1YyK+n7XPBFqEUlK3vfA1K6g+lSdP5O6hdsXtcUDmQChoS7lneA
         sLxw==
X-Gm-Message-State: AOJu0YzGSEjmabcoT+wNJHKmuxKsfqP7zRN8URhsfvqsiBis7Hf34ZQn
	pWS1jTPtWkumkSHMKclZGdNwkMIPTsaXnD1HIUBX9fgntTc6OwOxyR48
X-Gm-Gg: ATEYQzySSfw46AfhCzPscPJzlzlBuxHjYLoriVCOMDwBsQVTd04VYYv9HM2vpPp5cjx
	VXz7hd7D8hjlnrnI0t/psY4NebawcnEqsUFY3PBtr/kyuVLmhJMwtB0ko/HeYz6GHba7j2ZMVlU
	dW/Oa44FwTlQqWS4J8eNk+cyaUstmM45H29JXUpQqMjWPJluMjr4MUmQfqksqMd12cVWUa0T+LE
	5Rc3i746F3LVFl08teSR9KJ1eaICmpD2q4tf8YRmQMIsBt8R8qubmVBy4zsmDoZk9aCnaIuuOal
	M74eYXdCxyuEN4jW6IBs8Yh6/flSIRXl4Cj+QnreHjHzuB1Rp8DSSOpAUr386FGXERCVlGtWx+F
	x+3ptMmJ7BTyp1Z8amxjHQ5w0SmBPdSv93L0KxfaX9DUNqnB8YwTYdQREeK5TtxwUbDN3k5x/IE
	iDmMxZnwm6eQVYFfgtTHzzylQHhlg3uGSTew==
X-Received: by 2002:a17:902:da84:b0:2ae:c67c:3b05 with SMTP id d9443c01a7336-2b0826d82fcmr169631255ad.10.1774364179268;
        Tue, 24 Mar 2026 07:56:19 -0700 (PDT)
Received: from localhost.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655474sm191851225ad.48.2026.03.24.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:56:18 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v1 1/1] spi: Simplify devm_spi_*_controller()
Date: Tue, 24 Mar 2026 22:55:48 +0800
Message-ID: <20260324145548.139952-1-ustc.gu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
References: <176797260995.67850.318976521283878747.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>  /**
> @@ -3398,22 +3395,14 @@ static void devm_spi_unregister(struct device *dev, void *res)
>  int devm_spi_register_controller(struct device *dev,
>  				 struct spi_controller *ctlr)
>  {
> -	struct spi_controller **ptr;
>  	int ret;
>  
> -	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
> -	if (!ptr)
> -		return -ENOMEM;
> -
>  	ret = spi_register_controller(ctlr);
> -	if (!ret) {
> -		*ptr = ctlr;
> -		devres_add(dev, ptr);
> -	} else {
> -		devres_free(ptr);
> -	}
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_spi_unregister_controller, ctlr);
>  
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(devm_spi_register_controller);
Hi Andy and Mark,
It seems has a potential corner case in this commit.

The issue is that devm_add_action_or_reset() triggers its callback 
immediately if the internal devres allocation fails. This creates the 
following sequence:
1. spi_register_controller(ctlr) succeeds.
2. devm_add_action_or_reset() is called but fails.
3. The "reset" triggers devm_spi_unregister_controller(ctlr) immediately.
4. This calls spi_unregister_controller(ctlr).
5. For controllers allocated via spi_alloc_host() (where 
   ctlr->devm_allocated is false), spi_unregister_controller() calls 
   put_device(&ctlr->dev).
6. This drops the reference count to zero and frees the ctlr structure.

However, the driver still holds the ctlr pointer and will typically 
attempt its own cleanup, leading to a use-after-free or double-free.

What are your thoughts on this? Does this analysis seem correct, or am
I missing a detail in how the refcounting is handled here?

Best regards,
Felix
