Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80BF1E2614
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774272589; cv=none; b=ondY6MKOtD2YATurSzrFb71g+nHb/DWer0AcjdWYrLZmXiSawSev2YHOlCjEY0oQd3dzc35jQDrIURENha4RmiHcMoOwrpb0Ap7ewl6KgPWdPVN9zCPZQUW4GPBX3t9ULbMNaju4zp0euPmmeXeQVCq5ABYgXItu5is6lkhUdHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774272589; c=relaxed/simple;
	bh=4ALTHeR/nNtas+TDhmepd92xZJjPlPAcg1f9T5Oy/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQNshR0yxoW2RB424ko1hVO9tYbSkZwwGRvvdi6PnsoDnmi9aFhFYLHFOQuQ64umVK6RHw1QIdjgv7NOkLiuKDG4PebSBb7+m7Vyyv2fFyl2cfiKMstDoezkTEzrAvukF/KSNHMYR8VdXwc7Ixrfxb2LwLvO0otc/wI8ZAmRDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbLaED3C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbLaED3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C1FC4CEF7
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774272589;
	bh=4ALTHeR/nNtas+TDhmepd92xZJjPlPAcg1f9T5Oy/uk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BbLaED3CAjWVtLICPIXk7HRfAOzZMYev+4Fa67GGJwgDZUSnf2h7plQi2hxda3A7T
	 EokkWtXxAJXS9FqEd2y7KVt42JoG9xy5lhq7vJovoRSluYicA6Rub2MW2u4izAbdFO
	 MQEN3WySzN4LsB7x1pPikZXom4Ye2MBnM+y8ocsZpMmU9w9YxMx+nc1vS+EffMyL4+
	 32Rkmi4s/6Rlcm44DpRmNcb27ie4AfKcgCNfBtwU25uK6scWTuhl+s0kvEVId0yDvc
	 jpd0VUCbanej6ji5XvOQtqmxzTCgdAvv3LoAFJz1glK8UyVAPjXttCJASIdfu9WtLi
	 rfbZz5LTnKhsg==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64eb84d1e37so1576090d50.2
        for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 06:29:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgTth8rMLwCOZN2dqgThR19v2WcvsqpyV2F3AhyfJ/AMrIOWfW9gquRRieMFKBJFKLVHjiPZXRBs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJvloJ3YbrazCEeFZkj5k1hYAAm0p4uO9UquBPOfROTvCnqVk
	yy/q1Ns7CJaWinK6Y+0hFdlANxDzZQb/ATI9mYRMyayk8QxognCuudLHbvmYJtyJr+gBbYtWKe+
	0z5XvkASeb/8zz0Idtbc3jeECwHbI8Yk=
X-Received: by 2002:a53:b465:0:b0:64c:cfc8:6baf with SMTP id
 956f58d0204a3-64eaa6a1fe0mr8465672d50.4.1774272588715; Mon, 23 Mar 2026
 06:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 23 Mar 2026 14:29:37 +0100
X-Gmail-Original-Message-ID: <CAD++jLn9MTbJjLh27U37w_Jj_GEZkaEztdPTk8T0y8ZQxqJ+aw@mail.gmail.com>
X-Gm-Features: AQROBzA1Eb81EhPJamujnyXMjjtWiy-G55hD9WEFMzQ9Pozas-rkYtdPkHd9Eag
Message-ID: <CAD++jLn9MTbJjLh27U37w_Jj_GEZkaEztdPTk8T0y8ZQxqJ+aw@mail.gmail.com>
Subject: Re: [PATCH] spi: pl022: update outdated references to pump_transfers()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg, 
	ratnadiraw@smu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:00=E2=80=AFPM Kexin Sun <kexinsun@smail.nju.edu.=
cn> wrote:

> The pump_transfers tasklet was removed when the driver
> switched to the SPI core message processing loop in commit
> 9b2ef250b31d ("spi: spl022: switch to use default
> spi_transfer_one_message()").  The kdoc of
> pl022_interrupt_handler() still describes the old flow: scheduling
> the pump_transfers tasklet, calling giveback(), and flagging
> STATE_ERROR =E2=80=94 none of which exist in the current code.  Rewrite
> the kdoc to reflect the current paths, which flag errors via
> SPI_TRANS_FAIL_IO and call spi_finalize_current_transfer()
> directly.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>

Impressive use of AI and impeccably correctly tagged,
this is exactly how I want AI-assisted submissions to look.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
