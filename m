Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF43CEB96
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334485; cv=pass; b=HNIf7GwFOqNPbGtYGIIushIqRIE9YFdBfEh3HN8OeHQLU+ZnllcrsnCroUQzvvJpnXBKsOXAT1t6w8u3tpt0OePP//ndd0Z+d/Pae+QRWwyzc1zmD1m3NouYIRE+QzsjTjrmqHL0lzA5wV4mm59HBAjzOrq+74e6C3Y6itVIca4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334485; c=relaxed/simple;
	bh=0ivvtg/7i339ZQR+9yPgWn9tEIiWD5JfW0IrpKNu4D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3YCi91R+5bAnc3pO4T1k1sqdm2NvLO7xWR2id8mjQfOVChpkFBZjo/iyIetrF3ldqR6pSvKuFUVO4njV3V4HC7pljs3R89lS8XGpV6/+piZ5MEZX9iFdQeT9lZ4rMBLQEHdH6PKoFAK/IVXgY711K9FeSEBJZpdua7B9HBljtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFrQITnb; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFrQITnb"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1dd9c842so316913a91.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 09:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773334483; cv=none;
        d=google.com; s=arc-20240605;
        b=RBVAA1dqY1iIdGqEVFmqUw+Anq22uegnukO9VCr0nRUiS3Gdlqa1GhcTP3JWhABs3V
         022Ql09jQ5pB0RGYMV84+48vG25+eJbxBOIwVoe/0oV33uD4yyaaSOg6DjeF1UawSEIX
         /hYENxni8GPnaxLtSZPmnfsWscnYrr+yghWMAu2bwZYl+lwk5EVnMUGFwfUzJMCD2UB1
         1CkSGs7KsMLJbBmCPIJxo7JE9YyHUNJA/y31TVYsW8UKE0mRk4vRefZUwp3akzvmKZVY
         DyPKyGno9ZJ/bVBGP0dHxtGnODcnz1R8kg9TJ4FFBquBg1rR6UzlBJBjgM5aaZY5m1C0
         kEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        fh=L6zJXCTypxEbpgKeRm72AOWT1Dzt4aa5Qa/zmFxzZzg=;
        b=dTXM6hhMFawy/UL35rg18Bh7gZGaba2UD48Czd8jbukd0VDU40+62lPIqqnZ64XPJy
         IHnyrljA30FjO1fw6c4PayaJDTfX+wmCRfhjreFAhZr7gDmjZ/yq+WoD5vciVAkNdgPH
         G2CdiEQz5a+WdHLTT3qHLWjlRnq0GvCwO9xK6LXuMVo45Nxcm/YuhIOS8l4iF6lE3u3s
         mSwp+IeUcFncmcJzu/TC24KJCV88Los+Lqs7AT/EIRdBuJO6xdjf6Ds8RqJzTj3kqZU5
         uzGtbCwZrNzJWJt7m8XuN7Wee3lpUlIDZ9YVzmvDoHMVJCA9pjr/e0tf1u5XOnszB5NT
         Zxgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334483; x=1773939283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        b=kFrQITnbSdq6fGGAo1Qs91MmVTz356ySgdYWMhoXz+qDA2sI5h/kKKPobud1lef9Qq
         Vnjg2VUjWxY13G90CmzMMLIGG1mhAwthMdOZYeJon+O+0g87Kr6AJ417GKQwYBg4ntGg
         crbqh1wylitW5W3iDY0c9cFEY7XSz1kk+X6ijp5ETi+DfQfNFfcOE0+jm8SyHkpkeZCH
         z7cnWY15WdETUtxAXisuTIbTwonAFvkgAQR0r46HDiAaLCOdaFl6hAZomSDbAEI+l/d2
         UjnUvLY2rcGWyZPKGUWcqGXGW+Udo+G6jXAxvhMluPCc79Lf1wiRS3jOdfepdDepHnRM
         dA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334483; x=1773939283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+kWy5KRAZzJ0k+gfnUe4+KiD3cukw8nZMNARL7dWDnQ=;
        b=c6xUfgtUf3wnPyJ5aTrln9L5ba6foVyHNasfEtS3dui79HZ7C+cRS2ITb1ClRbHPse
         Rr1K6OoyJHd1PSMaOZ4tPzGSEYRJpnpjwcRP04dTBhkMhd+pSLnSBSokORGnQvOZ6rN1
         ba2paeADgUb1sP4gVqJTJtB04uq8KKjEV0pVU9ygvFYUmtecHwY51qNqoWtH6m6v8qmY
         dwtHAlWKaV9mqx3CdzfJgGBRhIwAy7BdCzE23+Rd7lXjwvHVOpDprhQdACz94VEC9eNJ
         6wVbH30PMYRsMKxHcyG3tREOjJ50ZPJ3IWG93+5Z1W6jkqUNSCvcfGs7YfqVf7mXsG2v
         H+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUmKTwxHEHFARWyGt02e/m5Vtq+oMcNMxp/Q0oKOl+x5iq+ePmE3jM5jMTd5WCOkeMOO0whJDGcxpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1Z6j4OY+SqaTwHTTW2/G7daGPkmZgxhkRavt2Lyv6RUAjXPo
	NrUfMSb83bERF8MHeyYnXOsEd+jcSqqnNsGxjV7SvcceaIpPN3GFai2yGAyMUgAyaKkqx0gfCQH
	7FkhsR10TXhDyFLDdkTxJ1JNUYPKjFTM=
X-Gm-Gg: ATEYQzyqY7iVGGbsZyx5RAo/IWpuJev+33je05/L0HFej2KmJWMKWOuPjbfm4dpzYmH
	8+x/GGb1eggEnMYDqwxVSvCnDB3lpkoV+96kynjyOYuQmEdhwmBwEaX4RLpAEXsKdQlriBunsp5
	skGTnZfC+Sx5hvJUb36rzxAateqNfXBaF3lkN7z3EzV597v9PinLGhyrOTtUKPBwy3Li+HRITkI
	uWHwnMVf+wzbCsctIxnzdKYB0aZPJ2mkLqz4iEcwEnQe6l+W6LLtd8aHloTYlcHVH+SEdso1avd
	kYDA2kWgztqvdc8ny5vSrMs=
X-Received: by 2002:a17:90b:288e:b0:359:8d0d:5905 with SMTP id
 98e67ed59e1d1-35a21eba194mr250522a91.9.1773334483388; Thu, 12 Mar 2026
 09:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
In-Reply-To: <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:54:29 -0700
X-Gm-Features: AaiRm51tg7oVvkVGab0X55k0oYxIuUltKNvtNsrbO-Cw57of2y67mwv1ziUvJS0
Message-ID: <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
	Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:15=E2=80=AFAM Vineeth Remanan Pillai
<vineeth@bitbyteword.org> wrote:
>
> On Thu, Mar 12, 2026 at 11:49=E2=80=AFAM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > On 2026-03-12 11:40, Steven Rostedt wrote:
> > > On Thu, 12 Mar 2026 11:28:07 -0400
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >
> > >>> Note, Vineeth came up with the naming. I would have done "do" but w=
hen I
> > >>> saw "invoke" I thought it sounded better.
> > >>
> > >> It works as long as you don't have a tracing subsystem called
> > >> "invoke", then you get into identifier clash territory.
> > >
> > > True. Perhaps we should do the double underscore trick.
> > >
> > > Instead of:  trace_invoke_foo()
> > >
> > > use:  trace_invoke__foo()
> > >
> > >
> > > Which will make it more visible to what the trace event is.
> > >
> > > Hmm, we probably should have used: trace__foo() for all tracepoints, =
as
> > > there's still functions that are called trace_foo() that are not
> > > tracepoints :-p
> >
> > One certain way to eliminate identifier clash would be to go for a
> > prefix to "trace_", e.g.
> >
> > do_trace_foo()
> > call_trace_foo()
>
> This was the initial idea, but it had conflict in the existing source:
> call_trace_sched_update_nr_running. do_trace_##name also had
> collisions when I checked. So, went with trace_invoke_##name. Did not
> check rest of the suggestions here though.
>
> Thanks,
> Vineeth
>
> > emit_trace_foo()
> > __trace_foo()

this seems like the best approach, IMO. double-underscored variants
are usually used for some specialized/internal version of a function
when we know that some conditions are correct (e.g., lock is already
taken, or something like that). Which fits here: trace_xxx() will
check if tracepoint is enabled, while __trace_xxx() will not check and
just invoke the tracepoint? It's short, it's distinct, and it says "I
know what I am doing".

> > invoke_trace_foo()
> > dispatch_trace_foo()
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > https://www.efficios.com
>
