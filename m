Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2E387588
	for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2026 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608784; cv=none; b=Ly+nuAPsQlJnVuupq3vYfNkEJb5SWvQC+59k1QsWaS7pvdSgn0wvO/9iEZ0apJ6e4MS5EPclIjBbQdw0HKfha5K7wrUy/PVr6PEV74aSa9vLc7cyjqbKyFLD7EnUms9ehuyqyY0V7VI+5sFUrgW7RKL5m4Sa8/prH+n89IujLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608784; c=relaxed/simple;
	bh=RLFiKybwqiRfaIacMSYfLnz5IphLQABbZGpGEz+/ci8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0p1ZeIKhUA7CjpV43ugeWFBEaH+2B4oshrBss9eaBVAVyUVdeiYBV4xDlM8ruIe/iuGrc6RhJFpILFud/E0Y4zzSH/cUfzV1Qq1QdzpBw2Br03jvwl2ZScM80kCUel9qmRPuapLWjo6gWTg41fEouef0R/tfqch1k0Fx2TzIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOCpibnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOCpibnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E511F0155A
	for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608783;
	bh=RLFiKybwqiRfaIacMSYfLnz5IphLQABbZGpGEz+/ci8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KOCpibnwJNr0pX6GIp9E3X+/iOBqx9F1pCZJI6OaagHNDwKy1xMMScFEsrVe4i3r/
	 TSyXlS4h0PI9poDU1ciINrkFk+vYmY+9c+ub2tBxLg4Bek4TSxqSsrziQYR+4kC4B6
	 LtU8gcqWbWfXXCpJCDxd3d6tp3i8Xk7Krr6IlMouVrY7PChVV6niqRiy1EBY8ZFB8n
	 rptzn6Rst3W9YsAV9gyXtwmeeYW090WG8gjTfj1D0deGJtvH6ZO7jGv/GqSCmZpMcV
	 1+VPa9NxcNHrBo8ICBDQ91ulJhS0PvP04UDtW3HVXW3R6R+dO8pVU4m6oauD/y63LG
	 YEmkeCEVuUjzg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeba1a36dfso2036298e87.2
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2026 07:53:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpr7kY0x+FRF/87AeHuOT+w0AK0fphcstjHmAxEFVWf8/aEaBOtJwAY1JRj+IhtwArhVQn+MDUx5QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kkVPAZ7d3HrLzEpq4/ttW9EhwHAzbt9rI24AmbAZHwUB6M1K
	gcJUF3R3NkfUlzHHNKyrheqxycqR/iGFPmKmXpw4jJvbsXtpBw/uB4WXbB96ygk/n0HNDYmaF+j
	joSNHyNd0zKkKbeZPCEXHjV6piG2OTC4=
X-Received: by 2002:a05:6512:1418:b0:5ae:bce4:b696 with SMTP id
 2adb3069b0e04-5b011457496mr1654043e87.15.1783608781260; Thu, 09 Jul 2026
 07:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
 <CAJZ5v0i4Zc4HNUdgJ_2=4=wv7vRDTugo71qsWnZxVRRqV+W8mw@mail.gmail.com>
 <9d271393-c500-46a9-8795-f1371585445c@sirena.org.uk> <CAJZ5v0g9AxpqUQUQ-vwG2LN3pfT3qXi3_S=So42=VdVtzg-=Dw@mail.gmail.com>
 <f6532e0f-a0b3-490d-8313-d6f5b72e8236@sirena.org.uk>
In-Reply-To: <f6532e0f-a0b3-490d-8313-d6f5b72e8236@sirena.org.uk>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 16:52:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jp6kds4tCPYgSSXUR8gY6RZeduDo4KT_C4SDe1LkO1vg@mail.gmail.com>
X-Gm-Features: AUfX_mx_i-Ak0IpYfFQhE7YA2IxINgGGdh6jGUVBYlO8uF8CkL_5A8zDw-EN5zc
Message-ID: <CAJZ5v0jp6kds4tCPYgSSXUR8gY6RZeduDo4KT_C4SDe1LkO1vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
To: Mark Brown <broonie@kernel.org>, Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, 
	Girish Mahadevan <girishm@codeaurora.org>, Alok Chauhan <alokc@codeaurora.org>, 
	bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 7:30=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Jul 06, 2026 at 04:10:34PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Jul 6, 2026 at 3:21=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
>
> > > I've got a bunch of other stuff in flight for that driver - I'll need=
 to
> > > check but just in case perhaps a tag I could pull in?
>
> > I'm wondering though if the patches in the series really depend on each=
 other.
>
> > There doesn't appear to be any code dependency between them.
>
> That would also work, a bit annoying for any bisects possibly but so
> long as we land both in the same release we should be good.

So I've applied the first patch only as 7.3 material.

If you need it to be exposed on an immutable branch, please let me know.

Thanks!
