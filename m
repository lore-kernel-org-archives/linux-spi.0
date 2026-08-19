Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23E3B47E0
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174499; cv=none; b=k0eRYqzbIyljkJAPsUYh+mKu/iC7tLsLLGLTQoGxb9mFDdBQ8hEIxkJQQQvB4c9DQasZyvKuvMK+xaldtxmWMzUFXErBLOWAHMJHo46q6QPQTnpgQXvq/dq9kXVL2mGQy596MJxa8CQT93RUu1oekIZJq7l+I6tGWLu1EkPmviw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174499; c=relaxed/simple;
	bh=iHrHqCAXnU6w0OS7DQt+y8wUDDdgUtnC3rGRDaExFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pxLMwuTkQCZixLGbvZdYVWGCIWxdtr62xTZ9UqFu6kUNWDk+Urg+ZP9HSQUAT3SzaXeqJVc8tQYsdkoMoDOZac0lzos7RyVK8kWLWxrvpwGsJVM6gwUSFtNUXEqY98ihS2i6/b//F8hjshCT8SasJpXPtZfsz+jb1EjTj7lkJFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WV2fS3CB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WV2fS3CB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
	b=WV2fS3CB4G7fdcaRJK3HNMHXeV8qUynL0axsnx57Fv5n4CxxBcT3krzdfJPdTZ5Y1TBAsW
	pNKffPe78HKm0KbDNznLSoxq7iOqn5nnIfOxgWkk1/Ygo1LTTmeXmuZJ/cd10nmy+RGIzu
	gEYWQmkCVFxIo/sn4XJZSUMncd6J6B8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-jFuTS1fWPHCcn93IDzYosQ-1; Wed, 19 Aug 2026 17:21:33 -0400
X-MC-Unique: jFuTS1fWPHCcn93IDzYosQ-1
X-Mimecast-MFC-AGG-ID: jFuTS1fWPHCcn93IDzYosQ_1787174493
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1d7886cdso27007351cf.1
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174493; x=1787779293;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVGzn/bp+HeoWhJcAlXzRJysNeFi8GSJbP12rbQe8Y4=;
        b=qHHk83aYPsepfqFTQCnCUnEwXFVzyd4AgqUQM5yOyy9H6Pwuk54y3IPACEMA2tWpGE
         Muxx8YqOQuE6anHW31nRua/TlsaB+pvb+hoM56b39U8DxGtgtNbu9DCFxj7dXwpVW8hC
         L+qnnhR5777woJj7at2q4vVFXF7Up3AqDVsKuXYvG96ChfzUN2lVYIPCKRratnft2qla
         Ck0gLxOkXU+lstC5lpn9NEckc0pwDiTCg2/ry3IGtfJkjXZdpaHQrb2lQQl1KtVP1EpJ
         qkg/rvP2XiXR52pZyoGMjFEgYLtP+1QpFu7DfEauBcMW1mE5CQCff39S+UDoOOxD4aoe
         I0Qg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2FQbcJlETE1faL5GmgMdc5lDwoN8FtobmXHOiN6gUCGoFwy6Q7GNDnw44CBKYYkJV8TfHiW0hjPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtOeuPXaoKqvXKaA8HwhMYFvKn8Fz9IomQOVLS/tuYdHjXY6k
	JsbRbxmHGWWeZW04r8Eru0pub9dljjif+BUvjuxKadJEkNY7gH5Rc8Hb+bgk+ZYj0TUAEUoxryy
	2pcAKgbX1PjF/4lV1qM08rHv0h/wm0aoHraW1RilOx2Ytbth0LKzDZvYNXyHQvw==
X-Gm-Gg: AR+sD139MJb9LPs6OOOUFfcDNiXjofeSKO3YHuQGopFkEHO/RU1uVFsVN+OaL6M93Vs
	pr8PttBeOQbmmJFLMgej6QvZgNkakGfoZDRKZy5lj3G/q+tIph1cB2tWwIjUjEkkynfqkTV6lGT
	n3IMzI8tQ09HlLTl/1xIQTiWhRRjJjLWrB0rie1E2CaeKtPM5Ed8ZoUtEhFWzQ7PjlYxq6MAlz2
	s8xHYJPrQoZ0nwfa4OC3sN98BzFqpYj/oipgtSw3TYdQEXWxysN3OZ0dOEkhEy2AM/NiLFOSVZW
	FIv2GpF/WZ1vIdh+8dxP0c80S4Bf36eR7J9O1oFT9TZaUiNfXO+/zbNXS/oV0MGwYHXyiaCxspy
	JDchaqP10qUvxfPrZhp+kM2pG49HngW1+lm0=
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425491cf.40.1787174492950;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
X-Received: by 2002:ac8:5cd3:0:b0:51c:f8f:13e with SMTP id d75a77b69052e-52dd5cf792bmr79425061cf.40.1787174492580;
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd8598adcsm18745871cf.9.2026.08.19.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:21:32 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:21:29 -0400
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
Subject: Re: [PATCH treewide 2/5] clk: visconti: Make sure clk_init_data is
 fully initialized
Message-ID: <aoYeWR6H3q-d3yd3@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42dd7be99acbbea1343e2fcc0ba4ffb91f8517ca.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _56VZfZO0AQpoYs8HoxYn4mbBYpaXgri4c3-n5FT-5w_1787174493
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 09:05:16PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> visconti_clk_register_gate() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: b4cbe606dc3674b2 ("clk: visconti: Add support common clock driver and reset driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

