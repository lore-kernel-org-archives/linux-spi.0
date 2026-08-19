Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591E391E4C
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174594; cv=none; b=VXfRcArFKO+WchbKLVkEBbvcvL4qX6KS/YVRj0OhFQBltHRhxGBc6XIjLkOBbQozmNvvI0bwzLzwuV4GnkyQ3WqMyOKOxRGUZVp5GT+bAmfeJEH8m5v9qjncqVZlt04G1JosKki5ibzy9beK3UQoyR2K58TOT43+jCHsrtr9Kqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174594; c=relaxed/simple;
	bh=e86+tyxRdQKzE4t52ZefcteM0bRE88sbIL68NZYIiAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=areqlSJ3qUPQFFV8x2GetHd5SvSM55h7ypQTwcHdLsUNuHobb/u9C7JWY49Q3/LYTyMBKULbKfXT2venwrz0eFyCqAc8zABet3anss4LPcB4lD8gLn1oQRHKz6jofJl89Wb9fvNFgsdZPnfoZN/RAJwyrkvMEK6TpMOaaBJN/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDV4nx5+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDV4nx5+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
	b=WDV4nx5+PLOwIzrIQxoQ6LLCzzqU3/+keFXokh9Pryo0QEUVlRmboSpm5fd0azh/DSbf/p
	3boOmdCIV57EmyvbiXw7jtwbCryXG2i0h5/f9hXKXq9ay6AB7rOZG232kfYlnmeOg3mLq9
	NABj8Dx/ejWZLPrEtwsWXCfnL1qkA7w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-k4Dd6d0vMwiCz3xWjNXqzw-1; Wed, 19 Aug 2026 17:23:06 -0400
X-MC-Unique: k4Dd6d0vMwiCz3xWjNXqzw-1
X-Mimecast-MFC-AGG-ID: k4Dd6d0vMwiCz3xWjNXqzw_1787174586
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907c59bd73bso27648006d6.3
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174586; x=1787779386;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
        b=IsHjLasRTVC2xQ1MriM/daYHMNkF+aSPaUtbLbnH2RkaqKrvINITxFFFss6I29+YZt
         z6Vn1C51z+TJ6H6JegVkWppMRR2exWtYRypSLfp8so4c4ahdBeKawN+i4CrVkHxvNUoc
         KI4ugOtfDYq8jClmPnVTNnbmI8rbpu542Nr7sVaWgleyjhWJq80LGWt3Gln2QSPBjfDF
         ocnX5FVo8LNGMI1lJE+LriB9HrynOgYMvUghohiYP3HFTkEKRvVCfnlSWvF4ETjzEN0e
         wm2hiVEYXjI/b42JXa/zqsV/dSYeMBZmFMYVhD74Krpqb1cznqJ/qamIfCO3cdAZJV1Z
         kDbg==
X-Forwarded-Encrypted: i=1; AHgh+RoDa39GDbrM5XFnOfDx/6g5ZNtBS5EDwa7TsHn6URZO0tqQ4OVemRoXDaLhyJ4CPdE+PBR4w0Ldk9I=@vger.kernel.org
X-Gm-Message-State: AFuF++nO7gj3jfo4rFjjMLAs//UxDzIs/0njalaIxiyFlJY4Uv8Q2+Iv
	gBrM/7AqyL5KIapaAJwLyfkfYL4z76KPjJ3+lK+pVZOCEwd3xf15cKPHlJFlcdwVosBEJeqySzT
	NO7n0tem9y8z/ncfPgye6fkPAMpsNMdzLEY1SqJEGL+CtuW4zGBdE5Zoc6UlEZA==
X-Gm-Gg: AR+sD12WLI0HcyjLqEN8D5aEjSbHtLA0EvUgkh0vlL8hTRZcGhqkSQXWAFWnw5FgE3x
	VX5OM/YcaG868s8iAGdHsvPKhTFwRvtuC7LsYpP+KpEM1MTLpsc1obuNujtjmbokd+BYI87V07h
	zp7ce1buHdNRCYl3Rru3xUCOVG1Q2G5vF8TfeQy8eQhPJWK8Dn9gYLyItlhVkkkUuNQvI18qHn9
	w75YlMZbbaAaiVNpWcX8DAEZWoYe40MddFrNLawlAkGCN71JHvoJBfQPY1AJX6nFvfqraYk4LbK
	LBqoyVzbhgpCGhZkZ8VkK0ObbM1vtpTzHEwZUXw2STU+S7pshqMJrJXzAsYv3In1LDN/wDmd3J6
	a2EdLiPuOpj1Y4R10cerkNrB0rP6q5LgKh/Y=
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665836d6.32.1787174585762;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665056d6.32.1787174585342;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a1139sm23455876d6.34.2026.08.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:23:04 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:23:02 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 5/5] spi: amlogic-spisg: Make sure clk_init_data
 is fully initialized
Message-ID: <aoYetnpb5fu2M9u6@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yszw4Eucaw0nWgUKd1O6mVMjePWDxzz0MMlJG79J0YE_1787174586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 09:05:19PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> aml_spisg_clk_init() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cef9991e04aed330 ("spi: Add Amlogic SPISG driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

