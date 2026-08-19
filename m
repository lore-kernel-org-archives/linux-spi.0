Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4C391E51
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174478; cv=none; b=WggqzVa8i19cMt9yhKiSBTlsECPAVPjPYRyUKTWougHbiam+/IB3ManuzT+ohwAGn+wNUJR/Jo6JtqVWME+QhLzO1dTk57rga9P7e/H/zh40UhbmGdo37wBZhgA0ree0v1XO0xkSc7Keh7108wfZozM1PdsWAXwmQF/4ACdGXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174478; c=relaxed/simple;
	bh=1sm5DJvN9JZq6zFJ3rudO9ha47L7zEKKAdXSC02I0m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EdOjD0+8bI4jh/qTzlXtWCVDf+ZHsx86qR2jq0MUR09TU5URvGwYRL4jkkuIwwo2V05PGczhNYpKzIo3rUNe/A3MykJY3DKxwsnXkqkzs3ZJPWz9xoyLOQKIMgmyfYQ6GyotnmzKrkr/LKGcl5f3JnLI/ObKmXaSLlGj/1rN5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyUESM8u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyUESM8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CqgpeVGn0RSIV25AilpufRbxuFATmlWL+zdwTTPB/B0=;
	b=RyUESM8u83N4Gef6W+yb7TbofuZTXRA7uTmGz9ouQxFEz2o/WgCdsBCm9Aj+Ca3uh71j+q
	V4ps0vrRiH+WGXh8wqtVF2TJHxgov4WmdrxF/uKsIPdfHZUusOBbkwxzyz/JmUa8w1fB48
	cHit2fPzc9ZVGMegmZVdulP9H8kCBbw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-sGvbiJEAO9qG4FMSkIG-lQ-1; Wed, 19 Aug 2026 17:21:14 -0400
X-MC-Unique: sGvbiJEAO9qG4FMSkIG-lQ-1
X-Mimecast-MFC-AGG-ID: sGvbiJEAO9qG4FMSkIG-lQ_1787174474
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936aa34873bso139254585a.3
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174474; x=1787779274;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqgpeVGn0RSIV25AilpufRbxuFATmlWL+zdwTTPB/B0=;
        b=YqwxjPPjtUeVqBl/OAsHNY0mbSaHjOv09xS89CmpLv9d3w8OtG2h0W0RrylTRz7spK
         spzV2e+V8NruYXx2E/biSK1//0a2i0cd3+WR44kluHFWyapAgIddgluxz4ED3GIF3MYb
         R5eA7xcycCmTSFg3gxAkWsbLjuc1uWlnTw5INMnzkA3KuvaOvNztfDwHHGJzVbOKD2I6
         +JsG0mOyHinVN/8YItOh6+BC75JB6CHfLvnOuLKFFjSTWO4fyzpd+CMHUbEFDIU0PfRy
         nHHSirZ4wAGfflIBwkBaqXc/LKlTnn0Wm8VVNKJT7CTeM0fB+pbRrJZLrRoS5EuGRrPv
         R8hQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXyY5U0XCUA2ih2fYjDeMT0ZkcuZuvzVWhikAh36nZSmiklBx/K8TXhtR5wNxQOu5BSV2tzEZb0Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPt1R3VPV9tUSty0gAPLQCX3ya7A+bgC6jC5GpR5cbka4rkI29
	qybsViQKBWZ75QKAhyPUABBGhY3pN+8SCtG4+xy/tTYoPsSDZR93W9viDZz5I9WwwJ4JFhAeDFe
	1g1d24CSGbNy28vXkqhqogRA7mm/TXTV+3wZMmnMGdkGN9bKmlm2A/Efc0H80aA==
X-Gm-Gg: AR+sD122W0b4lj2GXWj+o9/zElPvUdCpGGiI+oKl1THRNZz6vRHN0nu7Pm24N8qoipK
	Yxz8scXEQNidTEQ4mN+OKm6fmON75Gj0gTUZ38YIipjYjaSEp5+C1ATGijfGz7uwlla5mCNDMzC
	bk/1dsZ6wef76J0FdKJHhj8lUnWHVLrtxfcFKDk/D0H9cbBmF2uAZM4FMiQRfu3WbgyxT1ITDs6
	uO5BAVKmbCVJcT6BRPLwlSTPTNRGC1qdci+Gxi16txABHvzw7PCiEkf1MRGTIMyyIXHAXaWP8lo
	3b3o4BkMLLlxqg3wk5+eMGHeALO36Az8qfgPdWb1sAvft5iexzfOmqbRSu4ezs/WQhcRPEtI6yv
	/Y5YylFCpoPTg49daRigTqUQ5EKtXwKDOonU=
X-Received: by 2002:a05:620a:6010:b0:937:139d:592c with SMTP id af79cd13be357-9371e67ddfemr822212585a.38.1787174473982;
        Wed, 19 Aug 2026 14:21:13 -0700 (PDT)
X-Received: by 2002:a05:620a:6010:b0:937:139d:592c with SMTP id af79cd13be357-9371e67ddfemr822206085a.38.1787174473413;
        Wed, 19 Aug 2026 14:21:13 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720582980sm222991885a.33.2026.08.19.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:21:12 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:21:10 -0400
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
Subject: Re: [PATCH treewide 1/5] clk: ti: Make sure clk_init_data is fully
 initialized
Message-ID: <aoYeRqwY3SSZ2xDX@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mltyScX8BRS8SkFvmpyc6sCrUy9QtgDz-9zhk4Uj6mw_1787174474
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 09:05:15PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> _register_mux() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 667f420c09f1417c ("clk: ti: mux: resolve parent clocks by DT index, not by name")
> Closes: https://lore.kernel.org/CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

