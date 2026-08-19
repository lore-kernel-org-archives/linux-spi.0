Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68123B5820
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174548; cv=none; b=IBL1Q7j27y7UtjRDQ/ERSlzXR3rqXoYBof+/80GbNV9RzaA71HDqHJiwmj8Usm/ldcr8lANpvC1voSdmuVwUct+cD4VtOxKhOWZEgT1LmpXomKJ9Wt7m6WThi5nXeQOK6yoXEYp47XygN22Ezjc0HWQdmwH5KC5brV1sICNcBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174548; c=relaxed/simple;
	bh=ZzdoD++VvHeUKmBu7FDDxPK5u0C7i3uGZGCaEX/ePk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MVQE35seTAYtQrRun2x9nPVNapSClgRgMZBFC+jaNcNz9BQOibt8TYHqB01MaD8oGRxgO46qUlyg/3a1bsYRr8A16WJYeBAioZSebQiPoN2XNNlQHF3SyvI5x0+PXteqwi2/W8eoDhODBbV4f3d5BtE/R3nf8l0JeK+3Te7dsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGbtxflr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGbtxflr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/BxA7XcUttIdzHWbOyyyGM4mWiq1VkGr6i1wmE/8c1I=;
	b=YGbtxflrEAiN5u53REcAnLty3/aygblrS+je+E6lnhIrujhP1jZEKjttJ2C20LlJdyJKPF
	43JDxQO4m5ubCS1TR2QJEJZPWhxzE/P8sHLcjwKH2IFlaTp9K3R3EPhN7zlMnhIcV78PDu
	mPr89cx5lG/Ith+ZFo6lVsVAC+8jHJc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-lvt0egC1P3mgPpYBwSh-EA-1; Wed, 19 Aug 2026 17:22:20 -0400
X-MC-Unique: lvt0egC1P3mgPpYBwSh-EA-1
X-Mimecast-MFC-AGG-ID: lvt0egC1P3mgPpYBwSh-EA_1787174540
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8db414c7so20881721cf.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174540; x=1787779340;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/BxA7XcUttIdzHWbOyyyGM4mWiq1VkGr6i1wmE/8c1I=;
        b=elrIdCTM6G/HmpV/lo6vsfrXNqukZcgCsLnd4mVVPxTiSOWlJKdCG/kmMz0bu6Lz5c
         GC1cW8HSAXgB3sXhplN6ly68GhmUXGCZ8olXu/usUEjsxwdXgLZA6m/T1PlIWMWpotHJ
         p6xgbzTqa9I6sTrw72p5G8EhPcR0dPxCrMJxHTwgMEdAzLPZNekoRwbIPkJrUoYzHwN2
         4QODeJNlKIRzVoTuDS++O8AINVtBWtkzZikiSRxunZJ2QRM7kq7tZ6ucI2YbbjbGdKyK
         I17HkBmcYxyHl83cdCXuLi9Ag0SwsFr0VlW5vetyfc6z5hhE9ykTCSkxtvy7HMjLBJ70
         teaw==
X-Forwarded-Encrypted: i=1; AHgh+RpHhXMq0GW9XLHU7pl1fk/YY9S7V0vaFa4o17Wb/F0yfYabsjNVct9JMVBTJTmnyITTK7PiWXgcwdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/mQBTZb4xHqCSyAhx+00zoYpgK/pGp7abB1Lbiw8ILknUyx9
	tiN/QONAYpVNuZeJ0RV5xqq3/qLZn7Rd6tqppmIjsCaAonANSpo542nqGMV9OFoA8FbPBEhxFlE
	7Yns0RioH09zPxS7NZxto0mQeYXfM91gpZ/0m9XEy7eecaKhynU+xJRROa3rMdg==
X-Gm-Gg: AR+sD117VlmVKL01Y1fLZ3tyKcV4Y/RMvUuqRtKCsS61Ae/ysV1xO0BlKV5WuGONF1t
	+JqjMbE0BWm9Tr/XcIP6hX+xgpZs/w7qvw5dXnTphzugxkkjbDnWDf4pdm8/iLO7cn8QeBj8mjD
	GliROtFc+JIsRmEGLVb6/UVQs1Nmj6qRxjBNIG9I83eypiEyaNpKndrdDL4l2dEKKvXGg8vVJxM
	B34H9dcfSlD0kPvyFY6yJjlzGI4YaIleGAXCklLUimU5nuT7Zks/T21AWhw4oKjcdzZYUMnKkKg
	ET4v5VoRQPJSFIQmYKXBETgCcq58wVIWgkBqn4b9cMbRupI3VYCEpLWm8lEMc4s59hQt5aU8DaA
	6FS1eH5nIKXy7P874agPXWbhOVM4wW14d5HE=
X-Received: by 2002:ac8:5d04:0:b0:516:e249:e30f with SMTP id d75a77b69052e-52dd5e05a70mr71525131cf.42.1787174540425;
        Wed, 19 Aug 2026 14:22:20 -0700 (PDT)
X-Received: by 2002:ac8:5d04:0:b0:516:e249:e30f with SMTP id d75a77b69052e-52dd5e05a70mr71524431cf.42.1787174539914;
        Wed, 19 Aug 2026 14:22:19 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b36fsm18734791cf.5.2026.08.19.14.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:22:19 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:22:17 -0400
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
Subject: Re: [PATCH treewide 3/5] hwmon: (ltc4282) Make sure clk_init_data is
 fully initialized
Message-ID: <aoYeifWtRNoksCoR@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8ec3c5cbd2df675a938f090470f5da5f22008517.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NSjeppIE2GgxEMf7l6GXAFa4kPN8gILGRQ4BcpYuifk_1787174540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 09:05:17PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> ltc428_clk_provider_setup() does not fill in any parent clocks, and
> assumes that init.num_parents is NULL.  However, the latter in
> uninitialized, and thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cbc29538dbf7d740 ("hwmon: Add driver for LTC4282")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

