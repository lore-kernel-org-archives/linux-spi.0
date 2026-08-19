Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D183B9D95
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174573; cv=none; b=AxJeTZPawxk4iMJi1l1NYGe+ZGoPL5BpFD8iZdTAvCPolf1PQC/XiDH1nDQHWLj7xCoG88RL/zuTVa3qop/8WRrHvE45fI2w+hRSLeRmd8emI9nArXRoNMUZnnBNSsOfIyXNemfS64xtaP2mm0y07oxn/imE+V0yiI1NdY5qMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174573; c=relaxed/simple;
	bh=SzUr6zig9u+8VJEkLvWpenZdKF09X36HV3SolVfmfk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZC6hA+jt0pLAGY/8U4VJ8KJtIVi0YO0GLgC1IyAe9oCVAowaFE3QZGSD1JCXfI5N1Iye0X5lServjgZgn/5h48k/yny4y4OWfTRUPEApfVUXiRg5Ly9wM2NmTTOE9YFtPqR7z6j51rjkVpr0GEy7/9fQY7Fg1UjHx0KKbdyny9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvuNhPZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvuNhPZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
	b=FvuNhPZTAZ2PK28rYi8GxEQfyEKF0XI1qEUvdUQXbGT4vGPnWyxOxCJTq3st7qU6ez8wBL
	Hnln3RsYuhExec2GI9L8GVKKpx/JWuZrcHYgDyjH0HTTNnq5FIUM9RTti6SkZZ798JqbnQ
	m1QZhgcU/W9olbrWcXVkV4pZhLgHlug=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-ULOw9TgIObG9FeuzUTlhCw-1; Wed, 19 Aug 2026 17:22:45 -0400
X-MC-Unique: ULOw9TgIObG9FeuzUTlhCw-1
X-Mimecast-MFC-AGG-ID: ULOw9TgIObG9FeuzUTlhCw_1787174564
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-907ca5abf1bso11604176d6.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174564; x=1787779364;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rj/mRgeCj8M3kWXn8y1lXKamZftjeOSlfCZmQd+Kztk=;
        b=AAHSs9GJhB5optBCh4OKh/4Bdm2TmUxAot7TQuxlLEfppxbIer2wYcsZh8rErmOZD/
         1WHoB1kJGxyhuZqJ1s9gww5iXpvomPT5G+rWQXo2SNU40pFAzVUsFGrLM11NFeWuuNAl
         nIW3ZJufODjdJR2WvCoUl/wK3Cs3rJ0YHIit1Mv+Xbj/HGdxNoUqEohUhLvNBYEjLf+n
         zV/mpzGmrbmGWADegQAf1j3LZrl1dw+TF9mQpbYsuVAfFEhL6z2+c5iGWkGeInS7fg66
         AkLR4IL9Y92doi/sFFi1thaSvRg1zKnI9Ymxy5IbwY20Mv/ZDg9Kaa8uAxvkSW09rsfq
         BKtg==
X-Forwarded-Encrypted: i=1; AHgh+RpMSOMsMS8HaotBsc7FjA42/Q+qn4dikC9UiQ1Wtz2ZAAD/c3uVbi+GKDGhPBi3DbSwai2eBZd5pq8=@vger.kernel.org
X-Gm-Message-State: AFuF++m+IX/8xDBqr7NKfQ3u7/pYdLIhDIgqwqyA06Fy9M9prgJ8rxZi
	e3j7b/6DKV+VHQyO/DlF5A6f2CrXWgLuCVOJKA4JmMhKK1C3f3Kqk2jNZUnajNL93WWBgvivXSN
	OnzykEnG51Na8BrnrGLvMDJpydQJabeDyrgoUBBYNyZHKF5c0wVSXwZTCEhKzgw==
X-Gm-Gg: AR+sD11XzFmJ7m86UIQhjcUWqsREGzdg6FcAvqw7s+vfTgwnmp0cIDhcMhyynwzF1fJ
	RwxhohLqCPbtza5RBSjp5G+4GhVijJmQH3JKQiHfD736DfrwuSUshpm8hi5Cd45pyVimUd2dtEs
	HmPnif5JacFSi9U2Ug60QeWJO1CnXtuQvRyaubgiI2NAlwGpyJxIezgQWg9vjiAQC3YE63yiKZp
	As3+JmUrLUov7rRfxXkEbrwS+LQ0KP3GK2+4FEF+1GhdiMgnMklWVI9DCYdNI1lTeBcH7caNvZ5
	tqEQOQb+3ChUEd+VvXvVh8mup0gCMCuo3oqwzRJPIIqOYJuI6uKKtGRSn7T8wxfJtSXh6PtQiSX
	VUv8ycvFweptCufsFU2PFfvShiAtM8evU82Q=
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79736496d6.23.1787174564252;
        Wed, 19 Aug 2026 14:22:44 -0700 (PDT)
X-Received: by 2002:ad4:5dcd:0:b0:8c4:edb4:a44a with SMTP id 6a1803df08f44-90c5eaabae3mr79735276d6.23.1787174563736;
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee16e0sm23636866d6.17.2026.08.19.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:22:43 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:22:41 -0400
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
Subject: Re: [PATCH treewide 4/5] iio: frequency: adf4377: Make sure
 clk_init_data is fully initialized
Message-ID: <aoYeoSnvf5-l69lE@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <302584628c4c0699239a0218376fe1c11cdc8944.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EajLH6wCTxPh2YB3reCE8fAB77ZmHBQzQ5olrAwK82I_1787174564
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2026 at 09:05:18PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> adf4377_clk_register() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: 60e5448ddbec2dc2 ("iio: frequency: adf4377: add clk provider support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

