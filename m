Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H69dHvKH"
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BD10C
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 16:19:17 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e2cfece112so11800167b3.2
        for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702513156; x=1703117956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrLd2F+/MsaeKRGUaAfFVP8pa0yNcQOUMwc1iB1Wr8I=;
        b=H69dHvKH0e5m7hgm0/xCZ4a38VG0f7AHmgm6zCdfFrhWTBXYoy+hZAmyBJGjwJG2yv
         l56vfVk983Y3EiszCzlxLUrkLsGT34Q5lzh0rbeT2NhWR58BJlLnzrox5/A02r9Hfchc
         Lz7JqLQG5675qOQqYWQgtfpyobvKuABRUMi319KHSMteOGYK0kK+70BjTQ+eb4KdIRDA
         yVUKSyxhp0Ud8i4vr3ax6JvzCC2G/EKlPliqF4WpTGshHrny9UPV71LSkpoHqF3gjexB
         6nnAsu9+W9CrG24N/NnYAFor2jpViSnPLJl9ipY8nAHTenLVoLJownZ3roFt7bGDgFt4
         O7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513156; x=1703117956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrLd2F+/MsaeKRGUaAfFVP8pa0yNcQOUMwc1iB1Wr8I=;
        b=fGJb7g2xK9ljxbsg2aL4ujjW2rl9+870QnxiurMEPzpF5NIbLoqv+yt1SHa3X6b3Bq
         k7/yB/mCCkeWuCJ8pNfg6c0ielPMO9nRu/Wk0Zi6YQfLCRoluzq/HC+UKnnzsOjQnccf
         zql3qUJsB5236Yjy+iL8+NGSdMwH6Qb5Ra5JTWNmEWrbSu/O8zTKpK7dtu7nRGaqup4N
         NAsF2fnJFey/tWP7LqJIrUGlnqMBvPdj4jV76JN1xoxvfq1Sz56cVaGIMA/B8FpCnX6Q
         ZLivh035wno9cvdu9p8U/rgRBQYQBtuMKTNujaPwIboE9XhXTFpcdkC6lJTg4sr4IHcj
         ijVQ==
X-Gm-Message-State: AOJu0YxwzVsFE/0xalNUTaAw5JPz+Z5Y2T26tFpwHrmqPZacZcPrJpNk
	npH2ZdIotheh0w1ICdTnZIAR8SRVgo0I2lxr9YlYof0WkqwORDcI
X-Google-Smtp-Source: AGHT+IHkBrOOm0OxhUGeHAnruxTJYyZUsskOzy4MDxQRuSPBZVQt33fsHoa11qnb0EEJGixFevSwFLVx5w/B6bJjHUE=
X-Received: by 2002:a0d:dc81:0:b0:5d1:430e:4b6f with SMTP id
 f123-20020a0ddc81000000b005d1430e4b6fmr6592283ywe.9.1702513156546; Wed, 13
 Dec 2023 16:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701274975.git.namcao@linutronix.de> <ae1940abd6ff6a9e77b4373cff60007c641a0c6c.1701274975.git.namcao@linutronix.de>
In-Reply-To: <ae1940abd6ff6a9e77b4373cff60007c641a0c6c.1701274975.git.namcao@linutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Dec 2023 01:19:04 +0100
Message-ID: <CACRpkdZfuKmg8gY1J+prF0L0=S7PSW+0ZuqM3HhNrB1sXcNG5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spl022: switch to use default spi_transfer_one_message()
To: Nam Cao <namcao@linutronix.de>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> Except for polling mode, this driver's transfer_one_message() makes use
> of interrupt handler and tasklet. This is problematic because
> spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
> and tasklet. This causes the following warning:
> BUG: sleeping function called from invalid context at drivers/spi/spi.c:1=
428
>
> Switch to use the default spi_transfer_one_message() instead, which
> calls spi_transfer_delay_exec() appropriately.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Tested with polling mode and interrupt mode, NOT with DMA mode.
> Support with testing very appreciated!

FWIW I tested this now on a device using DMA for the transfers
and everything works fine like before.

Yours,
Linus Walleij
