Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0E3C73C9
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566027; cv=pass; b=GYAnC4OJQqG6B+Xnk32lqQVGK7FG+2Htrq8QQ0UI40L+nj1XDeHLURUOnQdTVkyQQTNwpdudQMbS2gdFCgBqIaHfBz0DXgzOLJIFetwNc9J7ft79dsaTeVDZy1eFpBTPgPrUzEU5eJxKG6M2aV2K2m2BfwzfeOMmP26waC/HKY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566027; c=relaxed/simple;
	bh=47gdQDFWf8dlWju6MuB5759dpExz8o7voslUXT7xk+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD+SeTNqGpc/Np6fNBxJ0YH2HXIyNz72C3MFr69UIYArMzvy1/xw70VH+Uf1dDXZZfSoS6CtjSab2hVYa+iPa/gJG4aa+BrctJfKnNvREaR9oGNHztn3QhYvOjrAHaRsU+BG6yCb94CiZWcsqLwar3tvfXjO5XBhxsnDTcvrXlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTJAzKk2; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTJAzKk2"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533972e0cccso44630531cf.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 10:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791566024; cv=none;
        d=google.com; s=arc-20260327;
        b=m49vXEYlq6c4JzzCKnrQHDNVfiI+KYrzvsKr72koN5Z19FMXMOhtWrKUg+8IjF9ATv
         dsYFbfrXAgTaQ8Pn61+Fv6+30oihXv7TYW3p2meacEI9usA3c+1KxCD+kR1eACcfPJ+p
         LktspviJviemz3sMo4QUIkmn3VpP+lcGboV/jzHDe9gLq/mw03EA6oj7D8o9/aYutnLE
         53pZhr9oGGdD4DM4Ft6U5g0s/9g/CuY2lSv3QCs1w5yMqH1s5cMjN4X1adULEexMXZBg
         zQ/gGWrPdYbzWUgGMfUyZDL1gBp5tKYh/PQXTjzNUVmoAtJUMVppcclJfJzVZ83dwVPo
         lFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=47gdQDFWf8dlWju6MuB5759dpExz8o7voslUXT7xk+E=;
        fh=3R4XQJdBufzSxeso5MglfNNBIkgMD4idvk8fkpIc1Yg=;
        b=qQ2aTe3OdbQqvO6lGCHiIypeRqcNUMwZQFJZywhPE3N5skFOiHxsnOF37wFPyZpHrQ
         PTdDn4Fdt6qyCBJ1QXoIG4hC2sUphgqESvCxD0Lub3ZZfLYV//7uU1zI1BDJ/mpGrTQp
         lA5qGGPmvdspp4X1vzrFbiFbUZ9r2XaVZ3g9qF4P6+t4MHmRZkxV7ffp44oRoHEVl6V1
         wBlRCkaQKwQ1YmmsELE+cWNr+G2ubKsrw7aRgrqphQBFNq8ngIPG4K9HJUXT2d5OgTyT
         A+Blyp4Cj/ooiubxN/t6TwFeoj0MJ7OHI69SD5RNJdR12kci1FIfVfJKSWhoa1QHTX5y
         cvgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791566024; x=1792170824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=47gdQDFWf8dlWju6MuB5759dpExz8o7voslUXT7xk+E=;
        b=DTJAzKk2ijwAOcWlAEBQzd3p4A4bxIyFKy/Ttnn2R5uKRaBV5H2kqB2h2R2uW/zsPr
         bO40shjkrnObSFR5p4b2TIINvH+Mo71kq8frjYHnF6XWUrAThFqmnxql4m0r5pscJAvo
         E3T9CQ62vwQ9JdByt6i7KL1Uc06jcjgtkUZ8eAuKcXykAYS8TsXz7W3zUJqv6Kd83sOP
         QACOju6Rpllc6lRaHvd4n4ksG1waP6CUZnAWsXg/8yDMMnEf3kPF/An2Delo66qLnKaZ
         9A5Sw0uwFmZRYDp5iYvyR8LLpArAUMyQai2EDRiQjRMZkATMNQvZxFCAR4B4WmCgxIzs
         9ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566024; x=1792170824;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47gdQDFWf8dlWju6MuB5759dpExz8o7voslUXT7xk+E=;
        b=hRW3hXnsHrg7g/OJlpW6TnOApLjbIfSmSdfAecwGNTuXqLAtRDz8/QNhVev2pAsumW
         5OaFg9TZMgWRGyWFpwt3OKznwakMXUrfsjja7lRZSuZpG9ji6nhcNiJ8JAi/XVOf2I7U
         2G+ji2ngIdghnDrWBQrGch0ugL3C/97VsseOP3uWmdeLa2v18EunpE44+7eqjWZUy48w
         8tMwjKq/uwPAPk7aSvkfzsbFeNHeVPnVQ0A2wj65ZD/BsDWZugmZSPTMdTgeq3rPzdcW
         LNcEVR0vwYODeIcCeTngdyriRpFNHieHv0ONleQQdBvtyMoRFaVwu5EgYxLs1NOLz4mo
         UUcg==
X-Forwarded-Encrypted: i=1; AKwUvByZEHs7n+5938Sn/ZcPPvKZXqD80q2chr/lWwO/k3h6AQTdgtgLTB5RAQSvVdGQHMULX1OtunxNlag=@vger.kernel.org
X-Gm-Message-State: AFuF++kWXRvkA4Tnv5usuflKe4L28axzypuYOytjfIlSikUeBjEyoQIE
	TiOW4zaOEYPQzNSeJHwCsxC8GhL2xx9emjPacLob8YHsBuEjRN1yDw7Z7RWv8a5s0jkIwhz3DBW
	YhE/dyGBTrtA5IrIB+nJQZ+XBO239iua9UPCEpaiWqg==
X-Gm-Gg: AYBFou2OGFvOuup50VGqL/U7i0rTVu1MKfFnlI0x01s6cu6QmNbQRSeQa/jIzYqKAse
	85E72BG60X5kLHMh6XH6+KtGgYvnAVBrrksyDYobFYSy6VrWV1bfZElcfYwxlx6v++utaRyYC6X
	JdOChhhd/Ry5QeTqcinrjhXhdIjwBM3uTGNJetKm6NIW9QWmfmjD++Jr1ijSF+UM0FKyvl/9LqN
	4+VzGKuxIzUyxZ31qlXf1eGWSr+s4IbI/wz/2W2JyMEa88vCXnRR0IYDhFjt6TYbPHb7UiyYao1
	6vyRQkHLngXEnh6k5wKcYrGlMLz2Acs/4MM3rsaxdBtW5uJkXPQx9vk=
X-Received: by 2002:a05:622a:1c16:b0:535:2447:3d03 with SMTP id
 d75a77b69052e-5359fb5c03amr34252771cf.35.1791566024366; Fri, 09 Oct 2026
 10:13:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009133609.579046-1-code@aayushk.dev> <20261009133609.579046-3-code@aayushk.dev>
 <20261009152832.4dd56def@pumpkin>
In-Reply-To: <20261009152832.4dd56def@pumpkin>
From: Aayush Kumar <aayushkmx@gmail.com>
Date: Fri, 9 Oct 2026 22:43:31 +0530
X-Gm-Features: AclHuK8Cf_pTAReQN4C_uRO6oWVAIIlKzzjvwsi3ymyeQXQQLnif9HVikKVivDs
Message-ID: <CABXOLKfQnuzGK81g1MP_BZaR=TJ2hTY5QQaMee034rQxMS1ipg@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: lm70llp: Use strscpy() instead of strcpy()
To: David Laight <david.laight.linux@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 7:58=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> So strcpy() is arguably better.

Fair point, I'll drop both the strscpy patches in v2. Thanks
